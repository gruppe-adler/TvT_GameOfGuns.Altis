#include "component.hpp"

params [["_teamNamespace",objNull]];

private _groupRankingID = _teamNamespace getVariable [QEGVAR(missionSetup,groupRankingID),-1];
if (_groupRankingID < 0) exitWith {};

private _groupRankingArray = GVAR(currentRanking) param [_groupRankingID,[]];
_groupRankingArray set [0,_teamNamespace getVariable [QEGVAR(missionSetup,currentScore),0]];

GVAR(currentRanking) sort false;
publicVariable QEGVAR(missionSetup,currentRanking);
