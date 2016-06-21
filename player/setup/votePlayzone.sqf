waitUntil {!isNil "isSpectator"};
if (isSpectator) exitWith {};

waitUntil {!isNil "PLAYAREASIZE"};
waitUntil {!isNil "VOTESYSTEMINITIALIZED"};
waitUntil {VOTESYSTEMINITIALIZED};
waitUntil {!isNull player};
waitUntil {player == player};
waitUntil {!isNull (findDisplay 46)};
openMap [true, true];

[] execVM "player\setup\voteDialog.sqf";

//MAP CLICK EVENT ==============================================================
mcd_choosePlayzoneClick = [
  "mcd_choosePlayzone",
  "onMapSingleClick",
  {
    [_pos, player] remoteExec ["mcd_fnc_receiveVote", 2, false];
  }
] call BIS_fnc_addStackedEventHandler;

//CONFIRM SELECTION ============================================================
/*mcd_onPlayzoneKeyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", {
  if ((_this select 1 == 28)||(_this select 1 == 156)) then {
    diag_log "votePlayzone.sqf - Player pressed enter...";
    (findDisplay 46) displayRemoveEventHandler ["KeyDown", mcd_onPlayzoneKeyDown];
  };
}];*/

//==============================================================================
waitUntil {!isNil "PLAYAREACENTER"};
["mcd_choosePlayzone", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
