#include "DashboardClient.h"

DashboardClient::DashboardClient(char* IP, char* luaCallback) {
	dashIP = IP;
	luaDataCallback = luaCallback;
	dashSocket = -1;
	n = 1;
	angleRequested = false;
	dataAngle = -1;
}

void DashboardClient::ConnectToDash() {
	struct sockaddr_in sa;
	struct hostent *hp;
	int s;
	if ((hp = gethostbyname(dashIP)) == NULL) {
		errno = ECONNREFUSED;
		//error
		return;
	}
	memset(&sa, 0, sizeof(sa));
	memcpy((char*) &sa.sin_addr, hp->h_addr, hp->h_length); /*set address */
	sa.sin_family = hp->h_addrtype;
	sa.sin_port = dashPort;
	if ((s = socket(hp->h_addrtype, SOCK_STREAM, 0)) < 0) {
		//error
		return;
	}
	if (connect(s, (struct sockaddr*) &sa, sizeof(sa)) < 0) {
		close(s);
		//error
		return;
	}
	int nonblocking = 1;
	if (ioctl(s, FIONBIO, (int)(&nonblocking)) < 0) { 
		//error
	}
	dashSocket = (s);
	printf("Connected with socket ID: %d\n", dashSocket);
}

void DashboardClient::PeriodicUpdate() {
	if (dashSocket > 0) {
		int size = read(dashSocket, tempbuff, BUFFER_SIZE);
		if (size > 0) {
			printf("Got %d bytes\n", size);
			std::string data(tempbuff, tempbuff + size);
			buffer.append(data);
			std::size_t EOTPos = buffer.find_first_of(hEOT);
			if (EOTPos == std::string::npos)
			{
				printf("Could not find EOT in:\n");
				for (unsigned int i=1;i<buffer.length();i++)
				{
					printf("%d ", buffer[i]);
				}
				printf("\n");
			}
			if (EOTPos != std::string::npos) {
				BlockReceived(EOTPos);
			}
		}
	}
}

void DashboardClient::SendDataLua(char header, char* data) {
	lua_getglobal(L, luaDataCallback);
	lua_pushfstring("%c",header);
	lua_pushfstring(data);
	
	//	pcall	LuaState, #params, #returns, *errcallback
	if (lua_pcall(L, 2, 0, 0) != 0) 
	{
		printf("Received data, but lua callback failed\n");
        lua_Lerror("DashboardClient::SendDataLua failed to call %s\n", luaDataCallback);
	}
}


void DashboardClient::DataReceived(char header, std::string data) {
	converter.clear();
	printf("Got data in C\n");
	SendDataLua(header, data.c_str());
	/*switch (header) {
	case 'a':
		converter << data;
		float fAngle;
		//std::cout<<data;
		converter >> fAngle;
		printf("Angle: %.4f\n", fAngle);
		DriverStationLCD::GetInstance()->PrintfLine(DriverStationLCD::kUser_Line3,"Angle:%f",fAngle);
		break;
	default:
		printf("\tHeader: %c\nData: ", header);
		for (unsigned int i=0;i<data.length();i++)
		{
			printf("%c", data[i]);
		}
		printf("\n");
		break;
	}*/
}

void DashboardClient::BlockReceived(size_t pos) {
	printf("Block recieved");
	std::string data(buffer);
	buffer = data.substr(pos);
	buffer.erase(buffer.begin());
	data.resize(pos);
	char header = data[0];
	data.erase(data.begin());
	DataReceived(header, data);
	pos = buffer.find_first_of(hEOT);

	if (pos != std::string::npos) {
		BlockReceived(pos);
	}
}

float DashboardClient::GetAngle() {
	return dataAngle;
}
