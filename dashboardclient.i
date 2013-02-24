/*
DashboardClient lua interface
*/

%module dashclient
%include "std_string.i"

%{
#include "DashboardClient.h"
%}

class DashboardClient {
public:
	DashboardClient(char*,char* luaCallback);
	void SendDataLua(char header, char* data);
	void PeriodicUpdate();
	void ConnectToDash();
	void DataReceived(char, std::string);
	float GetAngle();
};
