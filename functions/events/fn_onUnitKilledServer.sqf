#include "component.hpp"

params ["_victim",["_shooter",objNull],["_victimPos", [0,0,0]],["_victimName", "Someone"]];

if (isNull _shooter) exitWith {};

//exit if self-kill
if (_victim == _shooter) exitWith {};

_victim setVariable [QEGVAR(missionSetup,deaths),(_victim getVariable [QEGVAR(missionSetup,deaths), 0]) + 1, true];
_shooter setVariable [QEGVAR(missionSetup,kills),(_shooter getVariable [QEGVAR(missionSetup,kills), 0]) + 1, true];

private _shotDistance = (getPos _shooter) distance2D _victimPos;
if (_shotDistance > (_shooter getVariable [QEGVAR(missionSetup,longestKill), 0])) then {
    _shooter setVariable [QEGVAR(missionSetup,longestKill), _shotDistance, true];
};

// exit if teamkill
if ((_victim getVariable [QEGVAR(missionSetup,teamNamespace),objNull]) isEqualTo (_shooter getVariable [QEGVAR(missionSetup,teamNamespace),objNull])) exitWith {
    INFO_2("%1 just teamkilled %2",_shooter,_victim),
};

private _teamNamespace = _shooter getVariable [QEGVAR(missionSetup,teamNamespace),objNull];
private _newScore = (_teamNamespace getVariable [QEGVAR(missionSetup,currentScore),0]) + 1;
_teamNamespace setVariable [QEGVAR(missionSetup,currentScore),_newScore, true];

[_teamNamespace] call FUNC(updateRanking);

if (_newScore >= ("KillsForWin" call BIS_fnc_getParamValue)) exitWith {
    [_teamNamespace] call FUNC(endMissionServer);
};

{
    [_x,_newScore] remoteExec [QFUNC(onIncreasedScore),_x,false];
} forEach (units group _shooter);
