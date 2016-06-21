waitUntil {!isNil "isSpectator"};
if (isSpectator) exitWith {};

waitUntil {!isNil "PLAYAREASIZE"};
waitUntil {!isNil "VOTESYSTEMINITIALIZED"};
waitUntil {VOTESYSTEMINITIALIZED};
waitUntil {!isNull player};
waitUntil {player == player};
waitUntil {!isNull (findDisplay 46)};
openMap [true, true];

playzoneSkipVote = false;
[] execVM "player\setup\voteDialog.sqf";

//MAP CLICK EVENT ==============================================================
mcd_choosePlayzoneClick = [
  "mcd_choosePlayzone",
  "onMapSingleClick",
  {
    [_pos, player] remoteExec ["mcd_fnc_receiveVote", 2, false];
    if (playzoneSkipVote) then {
      mcd_onPlayzoneKeyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call mcd_keyDownEvent"];
      [player, false] remoteExec ["mcd_fnc_skipVote", 2, false];
      playzoneSkipVote = false;
    };
  }
] call BIS_fnc_addStackedEventHandler;

//KEYDOWN EVENT ================================================================
mcd_keyDownEvent = {
  _keyDown = _this select 1;
  if (_keyDown == 28 || _keyDown == 156) then {
    diag_log "votePlayzone.sqf - Player pressed enter...";
    (findDisplay 46) displayRemoveEventHandler ["KeyDown", mcd_onPlayzoneKeyDown];
    playzoneSkipVote = true;
    [player, true] remoteExec ["mcd_fnc_skipVote", 2, false];
  };
};

//CONFIRM SELECTION ============================================================
mcd_onPlayzoneKeyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call mcd_keyDownEvent"];

//==============================================================================
waitUntil {!isNil "PLAYAREACENTER"};
["mcd_choosePlayzone", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
(findDisplay 46) displayRemoveEventHandler ["KeyDown", mcd_onPlayzoneKeyDown];
