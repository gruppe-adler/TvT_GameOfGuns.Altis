#include "component.hpp"

[] call EFUNC(missionSetup,applyUniform);

if (missionNamespace getVariable [QGVAR(gameEnded),false]) exitWith {};

private _teamNamespace = player getVariable [QEGVAR(missionSetup,teamNamespace),objNull];
[player,_teamNamespace getVariable [QEGVAR(missionSetup,currentScore),0]] call EFUNC(missionSetup,applyWeapon);

cutText ["","BLACK IN",0.1];
hintSilent "";

private _respawnPos = player getVariable [QGVAR(respawnPos),EGVAR(missionSetup,playAreaCenter)];
[player,_respawnPos] call EFUNC(common,teleport);

player setVariable [QEGVAR(missionSetup,isCamping),false,false];

[] call EFUNC(missionSetup,scoreBoard);
