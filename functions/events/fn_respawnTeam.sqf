#include "component.hpp"

params [["_teamNamespace",objNull]];

if (_teamNamespace getVariable [QGVAR(teamRespawnRunning),false]) exitWith {};
_teamNamespace setVariable [QGVAR(teamRespawnRunning),true];

private _teamMateUIDs = _teamNamespace getVariable [QEGVAR(missionSetup,teamMateUIDs),[]];
private _teamMates = _teamMateUIDs apply {[_x] call BIS_fnc_getUnitByUid};

private _teamRespawnPos = [0,0,0];
for "_i" from 0 to 1000 do {
    _teamRespawnPos = [EGVAR(missionSetup,playAreaCenter),[0,EGVAR(missionSetup,playAreaSize) - 25],[0,360]] call EFUNC(common,randomPos);
    if (!surfaceIsWater _teamRespawnPos) exitWith {};
};
if (surfaceIsWater _teamRespawnPos) then {
    _teamRespawnPos = EGVAR(missionSetup,playAreaCenter);
};

{
    _respawnPos = ([_searchPos,[0,30]] call EFUNC(common,randomPos)) findEmptyPosition [0,30,"B_Soldier_F"];
    if (count _respawnPos > 0) then {_respawnPos = _teamRespawnPos};

    diag_log [_x,_respawnPos];
    [_respawnPos] remoteExec [QFUNC(respawnPlayer),_x,false];
} forEach _teamMates;

[{
    _this setVariable [QGVAR(teamRespawnRunning),false];
},_teamNamespace,4] call CBA_fnc_waitAndExecute;
