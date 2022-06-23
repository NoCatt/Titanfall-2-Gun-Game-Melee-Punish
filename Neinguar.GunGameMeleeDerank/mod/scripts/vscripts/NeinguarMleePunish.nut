global function Neinguar_Melee_gg_init

void function Neinguar_Melee_gg_init() {
    AddCallback_OnPlayerKilled( OnPlayerKilled )
}

void function OnPlayerKilled (entity victim, entity attacker, var damageInfo) {
    if (mode != "gg")
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