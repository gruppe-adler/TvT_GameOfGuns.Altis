#include "component.hpp"

params [["_shooter",objNull],["_victimName","Someone"],["_weapon",""]];

private _shooterName = _shooter getVariable ["ACE_Name",name _shooter];
private _weaponDisplayname = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");

private _message = if (_weaponDisplayname isEqualTo "") then {
    format ["%1 > %2",_shooterName,_victimName]
} else {
    format ["%1 > %2 (%3)",_shooterName,_victimName,_weaponDisplayname]
};

_message remoteExec ["systemChat",0,false];
