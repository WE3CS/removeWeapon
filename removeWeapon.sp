#include <sourcemod>
#include <cstrike>
#include <sdktools>
#include <sdkhooks>


public Plugin myinfo = 
{
	name = "removeWeapon",
	author = "neko",
	description = "caonima"
	
};

public void OnPluginStart()
{
	
}

public OnClientPutInServer(client)
{
    SDKHook(client, SDKHook_WeaponDropPost, Event_WeaponDrop);
}

public Event_WeaponDrop(client, weapon)
{
	if(GameRules_GetProp("m_bWarmupPeriod")){
		CreateTimer(0.1, removeWeapon, EntIndexToEntRef(weapon), TIMER_FLAG_NO_MAPCHANGE);
	}
}

public Action:removeWeapon(Handle:hTimer, any:iWeaponRef)
{
    static weapon;
    weapon = EntRefToEntIndex(iWeaponRef);
    
    if(iWeaponRef == INVALID_ENT_REFERENCE || !IsValidEntity(weapon))
        return ;
    AcceptEntityInput(weapon, "kill");
    
}

public Action:CS_OnBuyCommand(int client, const char[] weapon)
{	
	
	if(GameRules_GetProp("m_bWarmupPeriod")){
		SetEntProp(client, Prop_Send, "m_iAccount", 16000);
	}
}
