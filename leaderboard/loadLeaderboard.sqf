#include "defines.sqf";
disableSerialization;

private ["_display"];

cutRsc ["leaderboard", "PLAIN", 1];
waitUntil {_display = uiNamespace getVariable "LeaderBoard_Display"; !isNil "_display"};


//DISPLAY OWN STATS ============================================================
//kills
_kills = player getVariable ["kills", 0];
(_display displayCtrl mystats_0) ctrlSetText (str _kills);

//deaths
_deaths = player getVariable ["deaths", 0];
(_display displayCtrl mystats_1) ctrlSetText (str _deaths);

//K/D
_kd = _kills / _deaths;
(_display displayCtrl mystats_2) ctrlSetText (str _kd);

//longest kill
_longestKill = (round ((player getVariable ["longestKill", 0])*10)) / 10;
(_display displayCtrl mystats_3) ctrlSetText ((str _longestKill)+"m");

//distance moved
_distanceMoved = round (player getVariable ["totalDistance", 0]);
(_display displayCtrl mystats_4) ctrlSetText ((str _distanceMoved)+"m");
