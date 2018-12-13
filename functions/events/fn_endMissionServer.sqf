#include "component.hpp"

if (!isServer) exitWith {};

params [["_winnerTeamNamespace",objNull]];

missionNamespace setVariable [QGVAR(gameEnded),true,true];

_this spawn {
    params [["_winnerTeamNamespace",objNull]];

    _centerPos = ([EGVAR(missionSetup,playAreaCenter),[0,50]] call EFUNC(common,randomPos)) findEmptyPosition [0,30,"B_Soldier_F"];
    if ((count _centerPos) > 0) then {_centerPos = EGVAR(missionSetup,playAreaCenter)};

    [nil,_centerPos] remoteExec [QEFUNC(common,teleport),0,false];
    [_centerPos] remoteExec [QFUNC(respawnPlayer),0,false];

    sleep 2;

    _teamName = _winnerTeamNamespace getVariable [QEGVAR(missionSetup,displayName),"someone"];
    ["gungame_notification1",["GUNGAME",format ["%1 wins!",_teamName]]] remoteExec ["bis_fnc_showNotification",0,false];

    sleep 8;

    if (EGVAR(missionSetup,rankedMode)) then {
        _stats = [] call EFUNC(common,updateLeaderboard);
        _compiledStats = [_stats] call EFUNC(common,compileForGRADScoreboard);
        [_compiledStats] remoteExec [QEFUNC(common,showGRADScoreboard),0,false];

        sleep 20;
    };

    ["end1", true, true, true, true] remoteExec ["BIS_fnc_endMission",0,false];
};
