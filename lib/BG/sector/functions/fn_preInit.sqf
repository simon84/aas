#include "script_macros.hpp"
diag_log "PRE INIT";
GVAR(competingSides) = [];
{
    GVAR(competingSides) pushBack configName _x;
    missionNamespace setVariable [format ["%1_%2",QGVAR(Flag),configName _x], getText (_x >> "flag")];
    missionNamespace setVariable [format ["%1_%2",QGVAR(SideColor),configName _x], getArray (_x >> "color")];
    nil;
} count ("true" configClasses (missionConfigFile >> "BG" >> "sides"));

if (isServer) then {
    [] spawn {
        GVAR(allSectors) = (call EFUNC(common,getLogicGroup)) createUnit ["Logic", [0,0,0], [], 0, "NONE"];
        publicVariable QGVAR(allSectors);
        GVAR(allSectorsArray) = [];


        private _sectors = "true" configClasses (missionConfigFile >> "BG" >> "CfgSectors");

        {
            [configName _x, getArray (_x >> "dependency"),getNumber (_x >> "ticketBleed"),getNumber (_x >> "minUnits"),getArray (_x >> "captureTime"), getText (_x >> "designator")] call FUNC(createSectorLogic);
            nil;
        } count _sectors;
        publicVariable QGVAR(allSectorsArray);
    };
};
