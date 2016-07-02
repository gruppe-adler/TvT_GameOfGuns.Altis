/*  Executes map-specific scripts
*
*   executed via init.sqf on server
*/

_path = format ["customMap\%1.sqf", worldName];
_fileExists = [_path] call KK_fnc_fileExists;
if (!_fileExists) exitWith {};

diag_log format ["customMapInit.sqf - %1 has custom scripts.", worldName];
[] execVM _path;
