#include "component.hpp"

if (player getVariable [QEGVAR(missionSetup,isSpectator),false]) exitWith {};
if (missionNamespace getVariable [QGVAR(gameEnded),false]) exitWith {};

//send killer to server
private _shooter = player getVariable ["ACE_medical_lastDamageSource",player];
[player,_shooter,getPos player,profileName] remoteExecCall [QFUNC(onUnitKilledServer),2,false];

[getPos player,profileName] remoteExecCall [QEFUNC(common,weaponCleanup),2,false];

//create kill cam
private _killCamHandle = [EGVAR(missionSetup,respawnTime) min 10,player,_shooter] spawn FUNC(killCam);
player setVariable [QGVAR(killCamHandle),_killCamHandle];

//keep player from respawning
setPlayerRespawnTime 9999;

[EGVAR(missionSetup,respawnTime)] call FUNC(waitPlayerRespawnTime);
