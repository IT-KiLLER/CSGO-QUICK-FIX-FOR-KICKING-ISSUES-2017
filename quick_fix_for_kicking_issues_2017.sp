#include <sourcemod>
#include <sdktools>
#include <cstrike>
#pragma semicolon 1
#pragma newdecls required
ConVar sm_fakeclients;
char ITKiLLER[][] = {"https://github.com/IT-KiLLER", "IT-KiLLER @ github", "IT-KiLLER"};

public Plugin myinfo = 
{
	name = "[CS:GO] QUICK FIX FOR KICKING ISSUES 2017", 
	author = "IT-KiLLER", 
	description = "This adds fake clients to prevent the first client from being kicked.", 
	version = "1.0 beta 2", 
	url = "https://github.com/IT-KiLLER"
};      

public void OnPluginStart()
{
	sm_fakeclients  = CreateConVar("sm_fakeclients", "2", "Number of fake clients.", _, true, 0.0, true, 5.0);
	sm_fakeclients.AddChangeHook(OnConVarChange);
	CreateTimer(0.1, OnTimedCreateFakeClient, _);
}

public void OnConVarChange(Handle hCvar, const char[] oldValue, const char[] newValue)
{
	if (StrEqual(oldValue, newValue)) return;
	if (hCvar == sm_fakeclients) {
		KickFakeClients();
		CreateTimer(0.1, OnTimedCreateFakeClient, _);
	}
}

public void OnMapStart()
{
	CreateTimer(0.1, OnTimedCreateFakeClient, _);
}

public void OnClientConnected (int client)
{
	CreateTimer(0.1, OnTimedCreateFakeClient, _);
}

public void OnClientDisconnect(int client)
{
	CreateTimer(0.1, OnTimedCreateFakeClient, _);
}

public void OnClientPutInServer(int client)
{
	if (IsFakeClient(client)) return;
	KickFakeClients();
}

public Action OnTimedCreateFakeClient(Handle timer, any client)
{
	for(int i=1; i<=sm_fakeclients.IntValue; i++)
		if(!(GetClientCount() >= sm_fakeclients.IntValue <= GetFakeClientsCount())) {
			CreateFakeClient(ITKiLLER[GetRandomInt(0, sizeof(ITKiLLER)-1)]);
		}
	return Plugin_Handled;
}

public void OnEntityCreated(int entity, const char[] classname)
{
	if(!(entity <= GetMaxEntities())) {
		PrintToServer("<=== IT-KiLLER: %d ===>", entity);
		AcceptEntityInput(entity,"kill");
	}
}

stock void KickFakeClients()
{
	if(GetFakeClientsCount() > sm_fakeclients.IntValue)
		for(int i=1; i<=GetMaxClients(); i++)
			if(IsClientConnected(i) ? IsFakeClient(i) && !IsPlayerAlive(i) && GetClientTeam(i) == CS_TEAM_NONE : false) {
				KickClient(i, "FIXED BY IT-KiLLER", i);
			}
}

stock int GetFakeClientsCount()
{
	int count;
	for (int client=1; client<=GetMaxClients(); client++) 
		if (IsClientConnected(client) ? IsFakeClient(client) && GetClientTeam(client) == CS_TEAM_NONE : false)
			count++;
	return count;
}