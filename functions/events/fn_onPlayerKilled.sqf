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

private _teamNamespace = player getVariable [QEGVAR(missionSetup,teamNamespace),objNull];
private _teammateUIDs = _teamNamespace getVariable [QEGVAR(missionSetup,teamMateUIDs),[]];
private _teamMatesAlive = true;


//main =========================================================================
[EGVAR(missionSetup,soloRespawnTime)] call FUNC(waitPlayerRespawnTime);




//respawn ======================================================================
if (GAMEENDED) exitWith {};
//respawn hint


//destroy killcam
_camera = player getVariable "killCam";
if (!isNil "_camera") then {
  _killCamHandle = (player getVariable ["killCamHandle", [scriptNull]]) select 0;
  terminate _killCamHandle;
  camDestroy _camera;
  showCinemaBorder false;
};

//respawn player
iJustSpawned = true;
setPlayerRespawnTime 0;
forceRespawn player;
cutText ["", "BLACK IN", 0.5];

//make sure player doesn't instantly respawn next time
sleep 1;
setPlayerRespawnTime 9999;

//close hint
sleep 3;
hint "";
