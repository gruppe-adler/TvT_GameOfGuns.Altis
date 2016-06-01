waitUntil {!isNil "STARTPOSDONE"};
waitUntil {STARTPOSDONE};

sleep 2;

_mcd_fnc_punish = {
  [["GET BACK INSIDE"],["OR DIE!", "#ff0000"]] call mcd_fnc_formattedHint;
  sleep 5;
  if (player distance2D PLAYAREACENTER > PLAYAREASIZE+2) then {
    player setDamage 1;
  };
};

while {sleep 2; true} do {
  if (alive player && player distance2D PLAYAREACENTER > PLAYAREASIZE+2 && !iJustSpawned) then {
    _hndl = [] spawn _mcd_fnc_punish;
    waitUntil {scriptDone _hndl};
  };
};
