/*  Teleports unit
*
*   Params:
*   0:  unit
*   1:  destination
*/

if (!hasInterface) exitWith {};

params [["_unit", player], "_pos", ["_allowDamage", true]];

_unit allowDamage false;
_unit setPos _pos;
[_unit, _allowDamage] spawn {
  params ["_unit", "_allowDamage"];
  sleep 1;
  if (_allowDamage) then {
    _unit allowDamage true;
  };
};
