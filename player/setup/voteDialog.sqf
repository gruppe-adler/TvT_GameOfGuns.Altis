waitUntil {!isNull player};
waitUntil {player == player};
waitUntil {!isNull (findDisplay 46)};

mcd_fnc_voteDialogText = {((_this select 0) displayCtrl 1402) ctrlSetText format ["TIME REMAINING: %1", ([VOTINGTIMELEFT,"MM:SS"] call BIS_fnc_secondsToString)]};

_layer = (["wait1Layer"] call BIS_fnc_rscLayer);
while {VOTINGTIMELEFT > 0} do {
  _layer cutRsc ["voteCountdownTitle", "PLAIN", 0.0001, true];
  sleep 1;
};
player say "taskSucceeded";
_layer cutFadeOut 1;
openMap [false, false];
