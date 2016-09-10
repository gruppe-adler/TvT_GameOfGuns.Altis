if (!hasInterface) exitWith {};

#include "defines.sqf";
disableSerialization;

params ["_gogStats"];
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
_kd = (_kills max 1) / (_deaths max 1);
(_display displayCtrl mystats_2) ctrlSetText (str _kd);

//longest kill
_longestKill = (round ((player getVariable ["longestKill", 0])*10)) / 10;
(_display displayCtrl mystats_3) ctrlSetText ((str _longestKill)+"m");

//distance moved
_distanceMoved = round (player getVariable ["totalDistance", 0]);
(_display displayCtrl mystats_4) ctrlSetText ((str _distanceMoved)+"m");


//DISPLAY LEADERBOARD ==========================================================
//fill one row function
_fillRow = {
  params ["_display","_startID","_playerArray", "_rank"];
  _statsArray = _playerArray select 3;

  (_display displayCtrl _startID) ctrlSetText (str _rank);

  _name = _playerArray select 2;
  (_display displayCtrl (_startID+1)) ctrlSetText (str _name);

  _kd = (round ((((_statsArray select 0) max 1) / ((_statsArray select 1) max 1)) * 100)) / 100;
  (_display displayCtrl (_startID+2)) ctrlSetText (str _kd);

  _games = _statsArray select 2;
  (_display displayCtrl (_startID+3)) ctrlSetText (str _games);

  _playerUnit = [_playerArray select 1] call BIS_fnc_getUnitByUID;
  _playerPointsGained = round (_playerUnit getVariable ["eloThisGame", 0]);
  _points = round (_playerArray select 0);
  _sign = if (_playerPointsGained < 0) then {""} else {"+"};
  _pointsText = format ["%1 (%2%3)", _points, _sign, _playerPointsGained];
  (_display displayCtrl (_startID+4)) ctrlSetText _pointsText;
};

//fill all but last rows
for [{_i=0}, {_i< ((count _gogStats) min (lb_numberOfRows-1))}, {_i=_i+1}] do {
  [_display, lb_0_0 + (_i*100), _gogStats select _i, _i+1] call _fillRow;
};

//fill last row
if (count _gogStats > (lb_numberOfRows-1)) then {
  _playerID = [_gogStats, getPlayerUID player, 1] call mcd_fnc_findStringInArray;
  _rowFiveID = if (_playerID < (lb_numberOfRows-1)) then {(lb_numberOfRows-1)} else {_playerID};
  [_display, lb_9_0, _gogStats select _rowFiveID, _rowFiveID + 1] call _fillRow;
};
