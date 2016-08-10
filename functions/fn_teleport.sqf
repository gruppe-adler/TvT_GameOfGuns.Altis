/*  Teleports unit
*
*   Params:
*   0:  unit
*   1:  destination
*/

params ["_unit", "_pos"];

_unit allowDamage false;
_unit setPos _pos;
[_unit] spawn {
  params ["_unit"];
  sleep 1;
  _unit allowDamage true;
};
