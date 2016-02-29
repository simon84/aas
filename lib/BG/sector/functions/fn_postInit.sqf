#include "script_macros.hpp"
diag_log "POST INIT";
{
    [_x] call FUNC(createSectorTrigger);
    nil;
} count GVAR(allSectorsArray);

if (isServer) then {
    GVAR(sectorLoopCounter) = 0;
    [FUNC(loop), 0.1, []] call CBA_fnc_addPerFrameHandler;
    ["sector_side_changed", {
        params ["_sector", "_oldSide", "_newSide"];

        private _marker = _sector getVariable ["marker",""];

        if (_marker != "") then {
            _marker setMarkerColor format["Color%1",_newSide];
        };
        }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    GVAR(captureStatusPFH) = -1;
    //["sector_entered", {hint format["SECTOR %1 ENTERED",_this select 0];}] call EFUNC(events,addEventHandler);
    ["sector_entered", {[true,_this select 0] call FUNC(showCaptureStatus);}] call CBA_fnc_addEventHandler;
    ["sector_leaved", {[false,_this select 0] call FUNC(showCaptureStatus);}] call CBA_fnc_addEventHandler;
    //["sector_leaved", {hint format["SECTOR %1 LEAVED",_this select 0];}] call EFUNC(events,addEventHandler);
    ["sector_side_changed", {hint format["SECTOR %1 SIDE CHANGED FROM %2 TO %3",_this select 0,_this select 1,_this select 2];}] call CBA_fnc_addEventHandler;
    /*
    player addEventHandler ["Respawn", {
        {
            [_x] call FUNC(createSectorTrigger);
            nil;
        } count GVAR(allSectorsArray);
        nil;
    }];
    */
};
