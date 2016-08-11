waitUntil {!isNil "isSpectator"};
if (isSpectator) exitWith {};

waitUntil {!isNil "CAMPTIME"};
waitUntil {!isNil "GAMESTARTED"};
waitUntil {GAMESTARTED};


#define CAMPTHRESHOLD 50                                                        //distance you have to move in CAMPTIME to not be considered camping
#define INTERVAL 5                                                              //interval in which PFH is executed
#define MAXDISTPERINTERVAL 30                                                   //max distance that a player can travel per interval

sleep 10;

//PREPARE VARIABLES ============================================================
player setVariable ["recentDistanceArray", [0]];
player setVariable ["recentDistance", 0];
player setVariable ["totalDistance", 0];
player setVariable ["lastPosition", getPos player];
player setVariable ["isCamping", false];

//ADD PFH ======================================================================
_delay = 5;
_function = {
  if (!alive player) exitWith {};
  //update position
  _currentPosition = getPos player;
  _lastPosition = player getVariable ["lastPosition", _currentPosition];
  _currentDistance = _currentPosition distance2D _lastPosition;
  player setVariable ["lastPosition", _currentPosition];

  //calculate total distance
  player setVariable ["totalDistance", (player getVariable ["totalDistance", 0]) + _currentDistance];

  if (CAMPTIME <= 0) exitWith {};

  //calculate recent distance
  _recentDistanceArray = player getVariable ["recentDistanceArray", [0,0]];
  _recentDistance = player getVariable ["recentDistance", 0];
  if (count _recentDistanceArray >= CAMPTIME/INTERVAL) then {
    _recentDistance = _recentDistance - (_recentDistanceArray select 0) + (_currentDistance min MAXDISTPERINTERVAL);
    _recentDistanceArray deleteAt 0;
  } else {
    _recentDistance = _recentDistance + (_currentDistance min MAXDISTPERINTERVAL);
  };
  player setVariable ["recentDistance", _recentDistance];
  _recentDistanceArray pushBack _currentDistance;

  //camp warning
  if (count _recentDistanceArray >= CAMPTIME/INTERVAL && (player getVariable ["recentDistance", 0]) < CAMPTHRESHOLD) then {
    if !(player getVariable ["isCamping", false]) then {
      player setVariable ["isCamping", true];
      [player, profileName] remoteExec ["mcd_fnc_showCamper", 0, false];
    };
  } else {
    if (player getVariable ["isCamping", false]) then {
      player setVariable ["isCamping", false];
      [profileName] remoteExec ["mcd_fnc_hideCamper", 0, false];
    };
  };
};
[_function, _delay] call CBA_fnc_addPerFrameHandler;
