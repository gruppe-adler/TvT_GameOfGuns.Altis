//DEFINE PLAY AREA SIZE ========================================================
//get param
PLAYAREASIZE = "PlayAreaSize" call BIS_fnc_getParamValue;

//automatic size
if (PLAYAREASIZE == -1) then {
  PLAYAREASIZE = 300;
};
publicVariable "PLAYAREASIZE";

//wait for players to pick center
waitUntil {!isNil "PLAYAREACENTER"};


//CREATE PLAY AREA MARKERS =====================================================
_marker = createMarker ["PLAYAREAMARKER", PLAYAREACENTER];
_marker setMarkerColor "COLORWEST";
_marker setMarkerShape "ELLIPSE";
_marker setMarkerBrush "Border";
_marker setMarkerSize [PLAYAREASIZE, PLAYAREASIZE];


//BUILD WALL ===================================================================
_flag = createVehicle ["Flag_Blue_F", PLAYAREACENTER,[],0, "CAN_COLLIDE"];
waitUntil {!isNull _flag};
_wallCounter = 0;
_pi = 3.1415;
_wallX = 4;
_step = (360*_wallX) / (2*_pi*PLAYAREASIZE);
_maxDegree = (360+_step*(PLAYAREASIZE/230));
for [{_i=1},{_i<=_maxDegree},{_i=_i+_step}] do {
  _pos = _flag getRelPos [PLAYAREASIZE, _i];
  _wall = createVehicle ["Land_Mil_WallBig_4m_F", _pos,[],0,"CAN_COLLIDE"];
  _wall setDir _i;
  _wall enableSimulationGlobal false;
  _wallCounter = _wallCounter + 1;
};
deleteVehicle _flag;


diag_log format ["playAreaSetup.sqf - Playareasize is %1. %2 wall segments created.", PLAYAREASIZE, _wallCounter];
