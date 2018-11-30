#include "component.hpp"

//reset recent distance
player setVariable [QEGVAR(common,recentDistanceArray),[0]];

//send killer to server
private _shooter = player getVariable ["ACE_medical_lastDamageSource",player];
[player,_shooter,getPos player,profileName] remoteExecCall [QFUNC(onUnitKilledServer),2,false];

[getPos player,profileName] remoteExecCall [QEFUNC(common,weaponCleanup),2,false];

//create kill cam
private _killCamHandle = [(EGVAR(missionSetup,soloRespawnTime) min EGVAR(missionSetup,teamRespawnTime)) min 10,player,_shooter] spawn FUNC(killCam);
player setVariable [QGVAR(killCamHandle),_killCamHandle];

//keep player from respawning
setPlayerRespawnTime 9999;

[EGVAR(missionSetup,soloRespawnTime)] call FUNC(waitPlayerRespawnTime);
