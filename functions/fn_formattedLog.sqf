params ["_name"];

_equalchars = [];
for [{_i=0}, {_i<(80-(count _name))}, {_i=_i+1}] do {
  _equalchars pushBack "=";
};

_headline = format ["%1 %2", _name, (_equalchars joinString "")];
diag_log _headline;

for [{_i=1}, {_i<(count _this)}, {_i=_i+1}] do {
  diag_log format["%1",(_this select _i)];
};

diag_log "=================================================================================";
