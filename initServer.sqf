call compile preprocessfile "SHK_pos\shk_pos_init.sqf";

if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
	[] execVM "tfarsettings.sqf";
};

//island config
call compile preprocessFile "islandConfig.sqf";
ISWOODLAND = (ISLAND_CONFIG select (ISLANDS find worldName)) select 0;
MAPSTARTPOS = (ISLAND_CONFIG select (ISLANDS find worldName)) select 1;
publicVariable "ISWOODLAND";
publicVariable "MAPSTARTPOS";

//Parameters
WEATHER_SETTING = "WeatherSetting" call BIS_fnc_getParamValue;
TIME_OF_DAY = "TimeOfDay" call BIS_fnc_getParamValue;
SOLORESPAWNTIME = "SoloRespawnTime" call BIS_fnc_getParamValue;
TEAMRESPAWNTIME = "TeamRespawnTime" call BIS_fnc_getParamValue;
KILLSFORWIN = "KillsForWin" call BIS_fnc_getParamValue;
GAMEMODE = "GameMode" call BIS_fnc_getParamValue;
CAMPTIME = "CampProtection" call BIS_fnc_getParamValue;
RANDOMTEAMS = ("RandomTeams" call BIS_fnc_getParamValue) == 1;
TEAMSIZE = "TeamSize" call BIS_fnc_getParamValue;
SAMEALTCHANNEL = ("SameAltChannel" call BIS_fnc_getParamValue) == 1;

//Settings
PLAYAREAMINSIZE = 100;
PLAYAREAMAXSIZE = 2000;
MUZZLEATTACHMENTPROB = 40;
SCOPESPROB = 60;
SPAWNGROUPMINDIST = 50;
STARTDISTTOLEADER = 30;
SPAWNDISTTOLEADER = [50,100];
VOTINGTIME = 60;
SCORETHRESHOLD = 5;

VOTINGDONE = false;
GAMEENDED = false;

//Broadcast
publicVariable "WEATHER_SETTING";
publicVariable "TIME_OF_DAY";
publicVariable "SOLORESPAWNTIME";
publicVariable "TEAMRESPAWNTIME";
publicVariable "KILLSFORWIN";
publicVariable "GAMEMODE";
publicVariable "CAMPTIME";
publicVariable "RANDOMTEAMS";
publicVariable "TEAMSIZE";
publicVariable "SAMEALTCHANNEL";
publicVariable "PLAYAREAMINSIZE";
publicVariable "PLAYAREAMAXSIZE";
publicVariable "MUZZLEATTACHMENTPROB";
publicVariable "SPAWNGROUPMINDIST";
publicVariable "STARTDISTTOLEADER";
publicVariable "SPAWNDISTTOLEADER";
publicVariable "VOTINGTIME";
publicVariable "SCORETHRESHOLD";
publicVariable "VOTINGDONE";
publicVariable "GAMEENDED";

//Setup
[] execVM "customMap\customMapInit.sqf";
[] execVM "server\setup\setTime.sqf";
[] execVM "server\setup\setWeather.sqf";
[] execVM "server\setup\voteSystemInit.sqf";
[] execVM "server\setup\playAreaSetup.sqf";
[] execVM "server\setup\chooseWeapons.sqf";
[] execVM "server\setup\teamSetup.sqf";
[] execVM "server\setup\setRadioFreq.sqf";
[] execVM "server\setup\startPositions.sqf";
