#include "component.hpp"

params [["_respawnUnit",objNull]];

private _respawnPos = [];

_searchPos = [0,0,0];
for "_i" from 0 to 1000 do {
    _searchPos = [EGVAR(missionSetup,playAreaCenter),[0,EGVAR(missionSetup,playAreaSize) - 35],[0,360]] call EFUNC(common,randomPos);
    if (!surfaceIsWater _searchPos) exitWith {};
};
if (surfaceIsWater _searchPos) then {
    _searchPos = EGVAR(missionSetup,playAreaCenter);
};

for "_i" from 0 to 10 do {
    _respawnPos = ([_searchPos,[0,50]] call EFUNC(common,randomPos)) findEmptyPosition [0,30,"B_Soldier_F"];
    if ((count _respawnPos) > 0) exitWith {};
};

if (count _respawnPos == 0) then {
    _respawnPos = _searchPos;
};

_respawnPos
