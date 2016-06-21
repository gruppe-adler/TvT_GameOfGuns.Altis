_unit = (_this select 0) select 0;
_pos = getPos _unit;

sleep 5;

_weaponHolders = nearestObjects [_pos, ["WeaponHolderSimulated"], 20];
diag_log format ["fn_weaponCleanup - %1 dropped weapons found around %2. Deleting...", count _weaponHolders, _pos];

{
  deleteVehicle _x;
} forEach _weaponHolders;
