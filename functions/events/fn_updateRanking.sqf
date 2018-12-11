#include "component.hpp"

params [["_teamNamespace",objNull]];

diag_log "updateRanking";

private _groupRankingID = _teamNamespace getVariable [QEGVAR(missionSetup,groupRankingID),-1];
if (_groupRankingID < 0) exitWith {};

private _groupRankingArray = EGVAR(missionSetup,currentRanking) select _groupRankingID;
_groupRankingArray set [0,_teamNamespace getVariable [QEGVAR(missionSetup,currentScore),0]];


EGVAR(missionSetup,currentRankingSorted) = +EGVAR(missionSetup,currentRanking);
EGVAR(missionSetup,currentRankingSorted) sort false;

publicVariable QEGVAR(missionSetup,currentRankingSorted);
