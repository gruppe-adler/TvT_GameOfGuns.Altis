/*  player variables:
*   groupname:  name of group; is also variable name of score
*   spawnpos:   spawn position; gets updated at start of game and on every respawn
*   isTeamlead: bool; saves if player is leader of team
*/

PLAYAREACENTER = [15401.7,17088.9,0];

call compile preprocessfile "SHK_pos\shk_pos_init.sqf";

if (isServer) then {

  mcd_fnc_addKilledEH = compile preprocessFileLineNumbers "functions\fn_addKilledEH.sqf";
  mcd_fnc_setScore = compile preprocessFileLineNumbers "functions\fn_setScore.sqf";
  mcd_fnc_strToLoadout = compile preprocessFileLineNumbers "functions\fn_strToLoadout.sqf";

  //Parameters
  WEATHER_SETTING = "WeatherSetting" call BIS_fnc_getParamValue;
  TIME_OF_DAY = "TimeOfDay" call BIS_fnc_getParamValue;
  SOLORESPAWNTIME = "SoloRespawnTime" call BIS_fnc_getParamValue;
  TEAMRESPAWNTIME = "TeamRespawnTime" call BIS_fnc_getParamValue;
  KILLSFORWIN = "KillsForWin" call BIS_fnc_getParamValue;
  RANDOMTEAMS = ("RandomTeams" call BIS_fnc_getParamValue) == 1;
  TEAMSIZE = "TeamSize" call BIS_fnc_getParamValue;

  //Settings
  MUZZLEATTACHMENTPROB = 100;
  SPAWNGROUPMINDIST = 150;
  STARTDISTTOLEADER = 30;

  //Broadcast
  publicVariable "WEATHER_SETTING";
  publicVariable "TIME_OF_DAY";
  publicVariable "SOLORESPAWNTIME";
  publicVariable "TEAMRESPAWNTIME";
  publicVariable "KILLSFORWIN";
  publicVariable "RANDOMTEAMS";
  publicVariable "TEAMSIZE";
  publicVariable "MUZZLEATTACHMENTPROB";
  publicVariable "SPAWNGROUPMINDIST";

  //Setup
  [] execVM "server\setup\setTime.sqf";
  [] execVM "server\setup\setWeather.sqf";
  [] execVM "server\setup\playAreaSetup.sqf";
  [] execVM "server\setup\chooseWeapons.sqf";
  [] execVM "server\setup\teamSetup.sqf";
  [] execVM "server\setup\setRadioFreq.sqf";
  [] execVM "server\setup\startPositions.sqf";

};
