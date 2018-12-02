#include "component.hpp"

[] call EFUNC(missionSetup,applyUniform);

cutText ["","BLACK IN",0.1];
hintSilent "";

private _respawnPos = player getVariable [QGVAR(respawnPos),EGVAR(missionSetup,playAreaCenter)];
[player,_respawnPos] call EFUNC(common,teleport);

player setVariable [QEGVAR(missionSetup,isCamping),false,false];

if (missionNamespace getVariable [QGVAR(gameEnded),false]) exitWith {};

private _teamNamespace = player getVariable [QEGVAR(missionSetup,teamNamespace),objNull];
[player,_teamNamespace getVariable [QEGVAR(missionSetup,currentScore),0]] call EFUNC(missionSetup,applyWeapon);

[] call EFUNC(missionSetup,scoreBoard);
