//DEFINE PLAY AREA SIZE ========================================================
//get param
PLAYAREASIZE = "PlayAreaSize" call BIS_fnc_getParamValue;

//automatic size
if (PLAYAREASIZE == -1) then {
  PLAYAREASIZE = 500;
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
