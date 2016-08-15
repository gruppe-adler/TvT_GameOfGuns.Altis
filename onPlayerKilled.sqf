/*  Handles player respawn
*
*   automatically executed locally, on death
*/

if (isSpectator) exitWith {};

//check JIP player is spawning for the first time
if (serverTime-joinTime < 20 && didJIP) exitWith {diag_log "Player is JIP, not executing onPlayerKilled.sqf"};

//reset recent distance
player setVariable ["recentDistanceArray", [0]];

//send killer to server
_shooter = player getVariable ["ACE_medical_lastDamageSource",player];
[player, _shooter, getPos player, profileName] remoteExec ["mcd_fnc_setScore", 2, false];
[getPos player, profileName] remoteExec ["mcd_fnc_weaponCleanup", 2, false];

//create kill cam
_killCamHandle = [(SOLORESPAWNTIME min TEAMRESPAWNTIME) min 10] execVM "player\killCam.sqf";
player setVariable ["killCamHandle", [_killCamHandle]];

//keep player from respawning
setPlayerRespawnTime 9999;
sleep 2;

waitUntil {!isNil "SOLORESPAWNTIME"};
_timeleft = SOLORESPAWNTIME;
_teammates = player getVariable "teammates";
_teammatesalive = true;

//hint predefine ===============================================================
_rule = parseText "<t align='center'><t color='#708090'>-----------------------------------------------------<br /></t></t>";
_lineBreak = parseText "<br />";

//main =========================================================================
while {_timeleft > 0} do {
  if (GAMEENDED) exitWith {};

  _startTime = time;

  //hint
  _timestr = [_timeleft, "MM:SS"] call BIS_fnc_secondsToString;
  _respawnIn = parseText format ["<t align='center' size='1.4'>Respawn in: <t color='#ffff00'>%1</t></t>", _timestr];
  hint composeText [_rule,_respawnin,_linebreak,_rule];

  //check if teammates alive
  _teammatesalive = false;
  {
    _unit = [_x] call BIS_fnc_getUnitByUid;
    if (alive _unit) then {_teammatesalive = true};
  } forEach _teammates;
  if (!_teammatesalive) exitWith {diag_log "onPlayerKilled.sqf - All teammates are dead."};

  _timeleft = _timeleft - 1;
  sleep ((1-(time - _startTime)) max 0.1);
};

//team respawn - find positions ================================================
//whole team is dead
if (!_teammatesalive) then {
  _timeleft = TEAMRESPAWNTIME;
  _isTeamlead = player getVariable "isTeamlead";
  if (_isTeamlead) then {
    diag_log "onPlayerKilled.sqf - Player is teamlead. Asking server for spawnpositions...";
    [getPlayerUID player] remoteExec ["mcd_fnc_findGroupPosition",2,false];
  };

  diag_log "onPlayerKilled.sqf - Starting team respawn...";
  while {_timeleft > 0} do {
    if (GAMEENDED) exitWith {};

    _timestr = [_timeleft, "MM:SS"] call BIS_fnc_secondsToString;
    _teamDead = if (TEAMSIZE>1) then {parseText format ["<t align='center' size='1.4'>Team is dead.</t>"]} else {parseText format ["<t align='center' size='1.4'>You are dead.</t>"]};
    _respawnIn = parseText format ["<t align='center' size='1.4'>Respawn in: <t color='#ffff00'>%1</t></t>", _timestr];
    hint composeText [_rule,_teamDead,_linebreak,_respawnin,_linebreak,_rule];

    _timeleft = _timeleft - 1;
    sleep 1;
  };

//someone is alive
} else {
  _teammates = player getVariable "teammates";
  [player, _teammates] call mcd_fnc_findSoloPosition;
  sleep 2;
};

//respawn ======================================================================
if (GAMEENDED) exitWith {};
//respawn hint
_respawning = parseText format ["<t align='center' color='#00ff00' size='1.4'>Respawning...</t>"];
hint composeText [_rule, _respawning, _lineBreak, _rule];

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
