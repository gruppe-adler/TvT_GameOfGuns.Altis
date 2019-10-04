#include "component.hpp"



["gungame", {
    params [["_command",""]];

    _command = toLower _command;
    playSound "click";

    private _fnc_help = {
        systemChat "List of commands:";
        systemChat "#gungame fixWeapon - for problems with your weapon";
        systemChat "#gungame fixMag - for problems with your magazine";
    };

    diag_log _command;

    switch (_command) do {
        case (""): _fnc_help;
        case ("help"): _fnc_help;
        case ("fixweapon"): {[] call FUNC(fixWeapon)};
        case ("fixmag"): {[] call FUNC(fixMag)};
        case ("fixmagazine"): {[] call FUNC(fixMag)};
    };


}, "all"] call CBA_fnc_registerChatCommand;
