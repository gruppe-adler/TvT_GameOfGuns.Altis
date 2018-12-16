#include "component.hpp"

params [["_respawnUnit",objNull]];

private _aliveTeamMates = ([_respawnUnit] call EFUNC(common,teamMates)) select {alive _x};
private _respawnPos = [];

private _searchPos = if (count _aliveTeamMates > 0) then {
    getPos selectRandom _aliveTeamMates
} else {
    _noWaterPos = [0,0,0];
    for "_i" from 0 to 1000 do {
        _noWaterPos = [EGVAR(missionSetup,playAreaCenter),[0,EGVAR(missionSetup,playAreaSize) - 35],[0,360]] call EFUNC(common,randomPos);
        if (!surfaceIsWater _noWaterPos) exitWith {};
    };
    if (surfaceIsWater _noWaterPos) then {
        _noWaterPos = EGVAR(missionSetup,playAreaCenter);
    };
    _noWaterPos
};

for "_i" from 0 to 10 do {
    _respawnPos = ([_searchPos,[0,50]] call EFUNC(common,randomPos)) findEmptyPosition [0,30,"B_Soldier_F"];
    if ((count _respawnPos) > 0) exitWith {};
};

if (count _respawnPos == 0) then {
    _respawnPos = _searchPos;
};

_respawnPos
