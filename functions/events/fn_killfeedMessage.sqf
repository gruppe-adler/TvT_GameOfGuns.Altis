#include "component.hpp"

params [["_shooter",objNull],["_victim",objNull],["_victimName","Someone"],["_weapon",""]];

(format ["%1 died.",_victimName]) remoteExec ["systemChat",0,false];

private _message = "";

// self kill
if (_shooter isEqualTo _victim) then {
    _message = format ["%1 died",_victimName];

// regular kill
} else {
    private _shooterName = _shooter getVariable ["ACE_Name",name _shooter];
    private _weaponDisplayname = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");

    _message = if (_weaponDisplayname isEqualTo "") then {
        format ["%1 > %2",_shooterName,_victimName]
    } else {
        format ["%1 > %2 (%3)",_shooterName,_victimName,_weaponDisplayname]
    };
};



_message remoteExec ["systemChat",0,false];
