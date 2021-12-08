#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "nesi"
#define PLUGIN_VERSION "0.01"

#include <sourcemod>
#include <sdktools>
#include <cstrike>

EngineVersion g_Game;

public Plugin myinfo = 
{
	name = "Block cl_lagcompensation 0",
	author = PLUGIN_AUTHOR,
	description = "Bloqueia cl_lagcompensation 0",
	version = PLUGIN_VERSION,
	url = "nesi.dev"
};


public Action TIMER_RECHECK(Handle timer)
{
	for (new i = 1; i <= MaxClients; i++) {
    	if (IsValidClient(i))
    	{
        	QueryClientConVar(i, "cl_lagcompensation", CheckCvar);
        	
    	}
	}	 
	
	return Plugin_Continue;
}

public void OnPluginStart()
{
	g_Game = GetEngineVersion();
	if(g_Game != Engine_CSGO && g_Game != Engine_CSS)
	{
		SetFailState("This plugin is for CSGO/CSS only.");	
	}
	
	CreateTimer(1.0, TIMER_RECHECK, _, TIMER_REPEAT);
}


IsValidClient(client) 
{
	if (!( 1 <= client <= MaxClients ) || !IsPlayerAlive(client) || !IsClientInGame(client) && !IsFakeClient(client)){
		return false; 
	}
	return true; 
}

public CheckCvar(QueryCookie cookie, client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue)
{
	if(!StrEqual(cvarValue,"1")){
		PrintToChat(client, "[ANTI-AX] Não é permitido usar cl_lagcompensation diferente de 1");
		ForcePlayerSuicide(client);
	}
	
}
