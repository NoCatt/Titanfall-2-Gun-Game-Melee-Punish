global function Neinguar_Melee_gg_init
string modeTemp = GetConVarString("ModeList")
array < string > Modes

void function Neinguar_Melee_gg_init() {
    AddCallback_OnPlayerKilled( OnPlayerKilled )
    foreach (string mode in split(ModeTemp, ",")) {
        Modes.append(strip(mode))
    }
}

void function OnPlayerKilled (entity victim, entity attacker, var damageInfo) {
    if (Modes.find("gg")==-1 )
        return
    if ( DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.melee_pilot_emptyhanded )
    {
        DeRank( attacker )
    }

}

void function DeRank( entity player )
{
	Sv_GGEarnMeter_SetPercentage( player, 0.0 )

	if ( GameRules_GetTeamScore( player.GetTeam() ) != 0 )
	{
		AddTeamScore( player.GetTeam(), -1 ) // get absolutely fucking destroyed lol
		player.AddToPlayerGameStat( PGS_ASSAULT_SCORE, -1 )
		UpdateLoadout( player )
	}
}