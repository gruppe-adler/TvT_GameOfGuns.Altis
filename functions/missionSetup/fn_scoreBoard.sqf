#include "component.hpp"
#include "..\..\dialog\scoreboard\defines.hpp"

if (!hasInterface) exitWith {};
if !(missionNamespace getVariable [QGVAR(gameStarted),false]) exitWith {};

private ["_display", "_teamScore", "_teamName"];
if (!alive player) exitWith {};
disableSerialization;

private _numberOfDisplayedRanks = (count GVAR(currentRanking)) min 3;

private _createDisplay = false;
private _display = uiNamespace getVariable "ScoreBoard_Display";
if (isNil "_display") then {
    _createDisplay = true;
} else {
    if (isNull _display) then {
        _createDisplay = true;
    };
};

if (_createDisplay) then {
    cutRsc ["ScoreBoard", "PLAIN", 1];
    _display = uiNamespace getVariable "ScoreBoard_Display";
    for [{_i=0}, {_i < _numberOfDisplayedRanks}, {_i=_i+1}] do {
        _scoreBoardItem = _display displayCtrl SCOREBOARD_ITEM1 + _i;
        _scoreBoardScore = _display displayCtrl SCOREBOARD_SCORE1 + _i;
        _scoreBoardItem ctrlSetBackgroundColor [0,0,0,0.4];
        _scoreBoardScore ctrlSetBackgroundColor [0,0,0,0.4];
    };
};

private _teamNamespace = player getVariable [QGVAR(teamNamespace),objNull];
private _groupName = _teamNamespace getVariable [QGVAR(displayName),""];
private _teamScore = _teamNamespace getVariable [QGVAR(currentScore),0];

for [{_i=0}, {_i < _numberOfDisplayedRanks}, {_i=_i+1}] do {
    _teamRankArray = GVAR(currentRanking) select _i;
    _teamScore = _teamRankArray select 0;
    _teamName = _teamRankArray select 2;
    _scoreBoardItem = _display displayCtrl SCOREBOARD_ITEM1 + _i;
    _scoreBoardScore = _display displayCtrl SCOREBOARD_SCORE1 + _i;
    _scoreBoardItem ctrlSetText _teamName;
    _scoreBoardScore ctrlSetText (str _teamScore);
};


//player team is not in top 3
private _scoreBoardItem = _display displayCtrl SCOREBOARD_ITEM4;
private _scoreBoardScore = _display displayCtrl SCOREBOARD_SCORE4;

if (([GVAR(currentRanking), _groupName, 1] call EFUNC(common,findStringInArray)) > 2) then {
    _scoreBoardItem ctrlSetBackgroundColor [0,0,0,0.4];
    _scoreBoardScore ctrlSetBackgroundColor [0,0,0,0.4];
    _scoreBoardItem ctrlSetText _teamName;
    _scoreBoardScore ctrlSetText (str _teamScore);
} else {
    _scoreBoardItem ctrlSetBackgroundColor [0,0,0,0];
    _scoreBoardScore ctrlSetBackgroundColor [0,0,0,0];
    _scoreBoardItem ctrlSetText "";
    _scoreBoardScore ctrlSetText "";
};
