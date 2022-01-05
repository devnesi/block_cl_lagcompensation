#pragma semicolon 1
 
#define DEBUG
 
#define PLUGIN_AUTHOR "nesi"
#define PLUGIN_VERSION "0.04"
 
#include <sourcemod>
#include <sdktools>
#include <cstrike>
 
public Plugin myinfo = 
{
    name = "Block cl_lagcompensation 0",
    author = PLUGIN_AUTHOR,
    description = "Bloqueia cl_lagcompensation 0",
    version = PLUGIN_VERSION,
    url = "nesi.dev"
};
 
public void OnPluginStart()
{
    EngineVersion engine = GetEngineVersion();
    if(engine != Engine_CSGO && engine != Engine_CSS)
    {
        SetFailState("This plugin is for CSGO/CSS only.");  
    }
 
    CreateTimer(1.0, TIMER_RECHECK, _, TIMER_REPEAT);
}
 
public Action TIMER_RECHECK(Handle timer)
{
    for (int i = 1; i <= MaxClients; i++) {
        if (IsValidClient(i))
        {
            QueryClientConVar(i, "cl_lagcompensation", CheckCvar);
        }
    }
    return Plugin_Continue;
}
 
public void CheckCvar(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue) {
    if (client && IsClientInGame(client)) {
        if (result == ConVarQuery_Okay) {
            int value = StringToInt(cvarValue);
            if (value != 1) {
                PrintToChat(client, "[ANTI-AX] Não é permitido usar cl_lagcompensation diferente de 1");
                ForcePlayerSuicide(client);
            }
        } else {
            PrintToChat(client, "[ANTI-AX] Não é permitido usar cl_lagcompensation diferente de 1");
            ForcePlayerSuicide(client);
        }
    }
}
 
bool IsValidClient(int client) 
{
    return (IsClientInGame(client) && IsPlayerAlive(client) && !IsFakeClient(client)); 
}
