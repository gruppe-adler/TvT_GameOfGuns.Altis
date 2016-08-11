
params ["_pos", "_playerName"];
/*_unit = (_this select 0) select 0;
_pos = getPos _unit;*/

sleep 5;

_weaponHolders = nearestObjects [_pos, ["WeaponHolderSimulated"], 20];
diag_log format ["fn_weaponCleanup - %1 dropped weapons found around %2 (%3). Deleting...", count _weaponHolders, _pos, _playerName];

{
  deleteVehicle _x;
} forEach _weaponHolders;
