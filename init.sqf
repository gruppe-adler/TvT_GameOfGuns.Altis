/*  player variables created during setup:
*   groupname:  name of group; is also variable name of score
*   spawnpos:   spawn position; gets updated at start of game and on every respawn
*   isTeamlead: bool; saves if player is leader of team
*   teammates:  UIDs of all teammates
*/

/*PLAYAREACENTER = [15401.7,17088.9,0];*/

call compile preprocessfile "SHK_pos\shk_pos_init.sqf";

if (isServer) then {

  if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
  	[] execVM "tfarsettings.sqf";
  };

  //island config
  call compile preprocessFile "islandConfig.sqf";
  ISWOODLAND = (ISLAND_CONFIG select (ISLANDS find worldName)) select 0;
  MAPSTARTPOS = (ISLAND_CONFIG select (ISLANDS find worldName)) select 1;
  publicVariable "ISWOODLAND";
  publicVariable "MAPSTARTPOS";

  mcd_fnc_addKilledEH = compile preprocessFileLineNumbers "functions\fn_addKilledEH.sqf";
  mcd_fnc_setScore = compile preprocessFileLineNumbers "functions\fn_setScore.sqf";
  mcd_fnc_strToVar = compile preprocessFileLineNumbers "functions\fn_strToVar.sqf";
  mcd_fnc_findGroupPosition = compile preprocessFileLineNumbers "functions\fn_findGroupPosition.sqf";
  mcd_fnc_receiveVote = compile preprocessFileLineNumbers "functions\fn_receiveVote.sqf";
  mcd_fnc_updateVotesMarker = compile preprocessFileLineNumbers "functions\fn_updateVotesMarker.sqf";
  mcd_fnc_findGreatestNum = compile preprocessFileLineNumbers "functions\fn_findGreatestNum.sqf";
  mcd_fnc_formattedLog = compile preprocessFileLineNumbers "functions\fn_formattedLog.sqf";
  mcd_fnc_weaponCleanup = compile preprocessFileLineNumbers "functions\fn_weaponCleanup.sqf";
  mcd_fnc_skipVote = compile preprocessFileLineNumbers "functions\fn_skipVote.sqf";
  mcd_fnc_showCamper = compile preprocessFileLineNumbers "functions\fn_showCamper.sqf";
  mcd_fnc_hideCamper = compile preprocessFileLineNumbers "functions\fn_hideCamper.sqf";
  KK_fnc_fileExists = compile preprocessFileLineNumbers "functions\fn_fileExists.sqf";

  //Parameters
  WEATHER_SETTING = "WeatherSetting" call BIS_fnc_getParamValue;
  TIME_OF_DAY = "TimeOfDay" call BIS_fnc_getParamValue;
  SOLORESPAWNTIME = "SoloRespawnTime" call BIS_fnc_getParamValue;
  TEAMRESPAWNTIME = "TeamRespawnTime" call BIS_fnc_getParamValue;
  KILLSFORWIN = "KillsForWin" call BIS_fnc_getParamValue;
  REVERSEMODE = ("ReverseMode" call BIS_fnc_getParamValue) == 1;
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

  VOTINGDONE = false;
  GAMEENDED = false;

  //Broadcast
  publicVariable "WEATHER_SETTING";
  publicVariable "TIME_OF_DAY";
  publicVariable "SOLORESPAWNTIME";
  publicVariable "TEAMRESPAWNTIME";
  publicVariable "KILLSFORWIN";
  publicVariable "REVERSEMODE";
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

};
