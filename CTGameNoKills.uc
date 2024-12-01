//=======================================
Class CTGameNoKills extends CTGameInfoSP;
//=======================================

// Simple sub gamemode to check player kills
// Made for "Can you beat Republic Commando without killing anyone" challenge

function PostBeginPlay()
{
	local int i;

	//Log("CTGameInfoSP::PostBeginPlay -- spawning teams");
	GameReplicationInfo.CreateTeam(0, class'TeamNeutral');
	for (i=1; i <= 2; ++i){ //teams 1 to 3 are player friendly
		GameReplicationInfo.CreateTeam(i, class'TeamPlayer');
	}
	GameReplicationInfo.CreateTeam(3, class'TeamWookiee');
	GameReplicationInfo.CreateTeam(4, class'TeamAttachedScav');
	GameReplicationInfo.CreateTeam(5, class'TeamHostile');	
	for (i=6; i <= 8; ++i){ //teams 6 to 8 are hostile to every other team
		GameReplicationInfo.CreateTeam(i, class'TeamMP');
	}
	GameReplicationInfo.CreateTeam(9, class'TeamBerserker');
	//Log("CTGameInfoSP::PostBeginPlay -- finished spawning teams");
	super.PostBeginPlay();
	
	Log("=== START ===");
}

function ScoreKill(Controller Killer, Controller Victim)
{
	Super.ScoreKill(Killer, Victim);
	
	if(Killer != None)
	{
		if(Killer.IsA('PlayerController'))
		{
			Log("=======================================");
			Log("=== KILL FOUND, CHALLENGE FAILED!!! ===");
			Log("=======================================");
			Killer.bGodMode = false;
			Killer.Pawn.BleedOut();
		}
	}
}