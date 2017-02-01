/*#include "..\player\defines.hpp"*/

private ["_display", "_teamScore", "_teamName"];
if (!alive player) exitWith {};
disableSerialization;

_numberOfDisplayedRanks = (count CURRENTRANKING) min 3;

_createDisplay = false;
_display = uiNamespace getVariable "ScoreBoard_Display";
if (isNil "_display" ) then {
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

_groupName = player getVariable "groupname";

for [{_i=0}, {_i < _numberOfDisplayedRanks}, {_i=_i+1}] do {
  _team = CURRENTRANKING select _i;
  _teamScore = _team select 0;
  _teamName = _team select 1;
  _scoreBoardItem = _display displayCtrl SCOREBOARD_ITEM1 + _i;
  _scoreBoardScore = _display displayCtrl SCOREBOARD_SCORE1 + _i;
  _scoreBoardItem ctrlSetText _teamName;
  _scoreBoardScore ctrlSetText (str _teamScore);
};

//player team is not in top 3
_scoreBoardItem = _display displayCtrl SCOREBOARD_ITEM4;
_scoreBoardScore = _display displayCtrl SCOREBOARD_SCORE4;
_teamName = player getVariable "groupdisplayname";
_teamScore = call compile (player getVariable "groupname");
if (([CURRENTRANKING, _teamName, 1] call mcd_fnc_findStringInArray) > 2) then {
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
