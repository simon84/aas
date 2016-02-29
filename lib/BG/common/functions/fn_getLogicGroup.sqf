#include "script_macros.hpp"

private _grp = missionNamespace getVariable ["BG_common_logicGroup",grpNull];
if (isNull _grp) then {
    _grp = createGroup (createCenter sideLogic);
    missionNamespace setVariable ["BG_common_logicGroup",_grp,true];
};

_grp;
