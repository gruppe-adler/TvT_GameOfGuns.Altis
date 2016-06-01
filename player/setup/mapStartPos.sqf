waitUntil {!isNil "MAPSTARTPOS"};
waitUntil {!isNull player};

_pos = MAPSTARTPOS findEmptyPosition [0, 10];
[player, _pos] call mcd_fnc_teleport;
