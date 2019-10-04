#include "component.hpp"
#include "..\..\dialog\chooseUniform\defines.hpp"

private _display = findDisplay CHOOSEUNIFORM_IDD_DIALOG;
if (isNull _display) exitWith {};

private _ctrlButtonReroll = _display displayCtrl CHOOSEUNIFORM_IDC_REROLL;
if (isNull _ctrlButtonReroll) exitWith {};

private _rerolls = (_ctrlButtonReroll getVariable [QGVAR(rerolls),0]) + 1;
_ctrlButtonReroll setVariable [QGVAR(rerolls),_rerolls];
_ctrlButtonReroll ctrlSetText format ["REROLL (%1/2)",_rerolls];

[_display] call FUNC(reroll);
[-1] call FUNC(onUniformSelected);

if (_rerolls == 2) then {
    _ctrlButtonReroll ctrlEnable false;
};
