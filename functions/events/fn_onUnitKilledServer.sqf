#include "component.hpp"

params ["_victim",["_shooter",objNull],["_victimPos", [0,0,0]],["_victimName", "Someone"],["_weapon",""]];

if (missionNamespace getVariable [QGVAR(gameEnded),false]) exitWith {
    INFO_2("%1 killed %2 after game had already ended.",_shooter,_victimName);
};
if (isNull _shooter) exitWith {};

[_shooter,_victim,_victimName,_weapon] call FUNC(killfeedMessage);0

//exit if self-kill
if (_victim == _shooter) exitWith {};

// update killstreak
_victim setVariable [QEGVAR(missionSetup,currentKillstreak),0,true];
private _currentKillstreak = (_shooter getVariable [QEGVAR(missionSetup,currentKillstreak),0]) + 1;
_shooter setVariable [QEGVAR(missionSetup,currentKillstreak),_currentKillstreak,true];
if ((_shooter getVariable [QEGVAR(missionSetup,highestKillstreak),0]) < _currentKillstreak) then {
    _shooter setVariable [QEGVAR(missionSetup,highestKillstreak),_currentKillstreak,true];
};

// update deaths and kills
_victim setVariable [QEGVAR(missionSetup,deaths),(_victim getVariable [QEGVAR(missionSetup,deaths), 0]) + 1, true];
_shooter setVariable [QEGVAR(missionSetup,kills),(_shooter getVariable [QEGVAR(missionSetup,kills), 0]) + 1, true];

// update longest kill
private _shotDistance = (getPos _shooter) distance2D _victimPos;
if (_shotDistance > (_shooter getVariable [QEGVAR(missionSetup,longestKill), 0])) then {
    _shooter setVariable [QEGVAR(missionSetup,longestKill), _shotDistance, true];
};

// update score and check for win
private _newScore = (_shooter getVariable [QEGVAR(missionSetup,currentScore),0]) + 1;
_shooter setVariable [QEGVAR(missionSetup,currentScore),_newScore,true];

if (_newScore >= ("KillsForWin" call BIS_fnc_getParamValue)) exitWith {
    [_shooter] call FUNC(endMissionServer);
};

[_shooter,_newScore] remoteExec [QFUNC(onIncreasedScore),_shooter,false];
