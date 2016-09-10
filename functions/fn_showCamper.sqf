params ["_camper","_camperName"];

diag_log format ["fn_showCamper executed with %1 %2", _camper, _camperName];

if (!hasInterface)  exitWith {};
if (isNil "_camper") exitWith {};
if (isNull _camper || !alive _camper) exitWith {};

//PLAYER IS CAMPER =============================================================
if (player == _camper) exitWith {
  _insult = selectRandom [
    "dirty camper",
    "camping coward"
  ];
  _message = format ["You %1... I told them where you are hiding!", _insult];
  [_message,0,0,2,0.3] spawn BIS_fnc_dynamicText;
};

//PLAYER IS SOMEONE ELSE =======================================================
_order = selectRandom [
  "Get that",
  "Kill that",
  "Shoot that",
  "Go and wreck that",
  "Go and smack that",
  "Go and slap that",
  "Find that",
  "Go and gunbutt that"
];

_insult = selectRandom [
  "idiot",
  "dirty camper",
  "coward",
  "asshole",
  "bastard",
  "fool",
  "scumbag",
  "bitch"
];

_function = {
  params ["_camper", "_handle"];
  if (isNull _camper || !alive _camper) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};
	drawIcon3D ["a3\ui_f\data\gui\Rsc\RscDisplayIntel\azimuth_ca.paa", [1,1,1,1], (getPosATL _camper) vectorAdd [0,0,1], 1, 1, 45, format ["%1 (%2m)", name _camper, round (player distance _camper)], 1, 0.04, "PuristaMedium"];
};
_handle = [_function, 0, _camper] call CBA_fnc_addPerFrameHandler;

_message = format ["%1 is camping. %2 %3!", _camperName, _order, _insult];
[_message,0,0,2,0.3] spawn BIS_fnc_dynamicText;

if (isNil "camperNames") then {camperNames = []};
if (isNil "camperHandles") then {camperHandles = []};
camperNames pushBack _camperName;
camperHandles pushBack _handle;
