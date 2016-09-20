waitUntil {!isNil "isSpectator"};
if (isSpectator) exitWith {};

waitUntil {!isNil "VOTESYSTEMINITIALIZED"};
waitUntil {VOTESYSTEMINITIALIZED};
waitUntil {!isNull player};
waitUntil {player == player};
waitUntil {!isNull (findDisplay 46)};
openMap [true, true];

playzoneSkipVote = false;
vp_EventRunning = false;
_recommendedMid = sqrt((count playableUnits) * (45000 / 3.1415));
recommendedMin = ((round ((_recommendedMid * 0.75)/10)) *10);
recommendedMax = ((round ((_recommendedMid * 1.25)/10)) *10);
recommendedLabelDist = ((sin 45) * recommendedMax) * 1.1;

[] execVM "player\setup\voteDialog.sqf";

//MAP CLICK EVENT ==============================================================
mcd_mouseButtonDownEvent = {
  params ["_control", "_button", "_xScreen", "_yScreen"];
  if (_button != 0) exitWith {};
  if (vp_EventRunning) exitWith {};

  vp_EventRunning = true;
  vp_start = _control ctrlMapScreenToWorld [_xScreen,_yScreen];

  deleteMarkerLocal "vp_currentMarker";
  vp_currentMarker = createMarkerLocal ["vp_currentMarker", vp_start];
  vp_currentMarker setMarkerColorLocal "COLORWEST";
  vp_currentMarker setMarkerShapeLocal "ELLIPSE";
  vp_currentMarker setMarkerBrushLocal "Border";
  vp_currentMarker setMarkerSizeLocal [1,1];

  deleteMarkerLocal "vp_distanceMarker";
  vp_distanceMarker = createMarkerLocal ["vp_distanceMarker", vp_start];
  vp_distanceMarker setMarkerColorLocal "COLORWEST";
  vp_distanceMarker setMarkerTypeLocal "hd_dot";

  deleteMarkerLocal "vp_recMin";
  vp_recMin = createMarkerLocal ["vp_recMin", vp_start];
  vp_recMin setMarkerColorLocal "COLORGUER";
  vp_recMin setMarkerShapeLocal "ELLIPSE";
  vp_recMin setMarkerBrushLocal "Border";
  vp_recMin setMarkerSizeLocal [recommendedMin,recommendedMin];

  deleteMarkerLocal "vp_recMax";
  vp_recMax = createMarkerLocal ["vp_recMax", vp_start];
  vp_recMax setMarkerColorLocal "COLORGUER";
  vp_recMax setMarkerShapeLocal "ELLIPSE";
  vp_recMax setMarkerBrushLocal "Border";
  vp_recMax setMarkerSizeLocal [recommendedMax,recommendedMax];

  deleteMarkerLocal "vp_recLabel";
  vp_recLabel = createMarkerLocal ["vp_recLabel", [(vp_start select 0) + recommendedLabelDist, (vp_start select 1) - recommendedLabelDist]];
  vp_recLabel setMarkerColorLocal "COLORGREEN";
  vp_recLabel setMarkerTypeLocal "hd_dot";
  vp_recLabel setMarkerTextLocal (format ["Recommended Diameter: %1m - %2m", recommendedMin*2, recommendedMax*2]);


  mcd_onMouseMoving = _control ctrlAddEventHandler ["MouseMoving", "_this call mcd_mouseMovingEvent"];
};

mcd_mouseMovingEvent = {
  params ["_control", "_deltaXScreen", "_deltaYScreen"];
  _currentPos = _control ctrlMapScreenToWorld [_deltaXScreen, _deltaYScreen];
  _distance = vp_start distance2D _currentPos;

  vp_distanceMarker setMarkerPosLocal [(_currentPos select 0)+100, (_currentPos select 1)-100];
  vp_distanceMarker setMarkerTextLocal (format ["Diameter: %1m", round (_distance*2)]);
  vp_currentMarker setMarkerSizeLocal [_distance,_distance];
  false
};

mcd_mouseButtonUpEvent = {
  params ["_control", "_button", "_xScreen", "_yScreen"];
  if (_button != 0) exitWith {};

  deleteMarkerLocal "vp_currentMarker";
  deleteMarkerLocal "vp_distanceMarker";
  deleteMarkerLocal "vp_recMin";
  deleteMarkerLocal "vp_recMax";
  deleteMarkerLocal "vp_recLabel";

  _control ctrlRemoveEventHandler ["MouseMoving", mcd_onMouseMoving];
  vp_end = _control ctrlMapScreenToWorld [_xScreen,_yScreen];
  _size = vp_start distance2D vp_end;

  [vp_start, player, _size] remoteExec ["mcd_fnc_receiveVote", 2, false];
  vp_EventRunning = false;
  true
};


//CONFIRM SELECTION ============================================================
mcd_keyDownEvent = {
  _keyDown = _this select 1;
  if (_keyDown == 28 || _keyDown == 156) then {
    diag_log "votePlayzone.sqf - Player pressed enter...";
    (findDisplay 46) displayRemoveEventHandler ["KeyDown", mcd_onPlayzoneKeyDown];
    playzoneSkipVote = true;
    [player, true] remoteExec ["mcd_fnc_skipVote", 2, false];
    true
  };
};


//ADD EHs ======================================================================
disableSerialization;
_map = (findDisplay 12 displayCtrl 51);
mcd_onMouseButtonDown = _map ctrlAddEventHandler ["MouseButtonDown", "_this call mcd_mouseButtonDownEvent"];
mcd_onMouseButtonUp = _map ctrlAddEventHandler ["MouseButtonUp", "_this call mcd_mouseButtonUpEvent"];
mcd_onPlayzoneKeyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call mcd_keyDownEvent"];

//==============================================================================
waitUntil {!isNil "PLAYAREACENTER"};
deleteMarkerLocal "vp_currentMarker";
_map ctrlRemoveEventHandler ["MouseButtonDown", mcd_onMouseButtonDown];
_map ctrlRemoveEventHandler ["MouseMoving", mcd_onMouseMoving];
_map ctrlRemoveEventHandler ["MouseButtonUp", mcd_onMouseButtonUp];
(findDisplay 46) displayRemoveEventHandler ["KeyDown", mcd_onPlayzoneKeyDown];
