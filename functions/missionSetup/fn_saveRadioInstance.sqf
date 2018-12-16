#include "component.hpp"

[QGVAR(radiosReceivedEH), "OnRadiosReceived",{
    params ["","_args"];
    _args params [["_radioClassname","TFAR_anprc152"]];

    player setVariable [QGVAR(radioInstance),_radioClassname];
    [QGVAR(radiosReceivedEH),"OnRadiosReceived"] call tfar_fnc_removeEventHandler;

},player] call TFAR_fnc_addEventHandler;
