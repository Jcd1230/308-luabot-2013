	#ifndef DASHBOARDCLIENT_H
#define DASHBOARDCLIENT_H
#include "Commands/Subsystem.h"
#include "WPILib.h"
#include "sockLib.h"
#include "hostLib.h"
#include "netdb.h"
#include <algorithm>
#include <sstream>
#include <string>
#define BUFFER_SIZE 256

/**
 *
 *
 * @author team308
 */
class DashboardClient {
private:
	char* dashIP;
	char* luaDataCallback;
	const static u_short dashPort = 1735;
	const static char hEOT = 4;
	
	int n;
	int dashSocket;
	std::stringstream converter;
	std::string buffer;
	char tempbuff[BUFFER_SIZE];
	bool angleRequested;
	
	//Sync'd data
	float dataAngle;

	void BlockReceived(size_t);
public:
	DashboardClient(char* IP = "10.3.8.5", char* luaCallback = "dashDataReceived");
	void SendDataLua(char header, char* data);
	void PeriodicUpdate();
	void ConnectToDash();
	void DataReceived(char, std::string);
	float GetAngle();
};

#endif
