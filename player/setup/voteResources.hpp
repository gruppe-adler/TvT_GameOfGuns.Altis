#define ST_LEFT           0x00

class RscText
{
	access = 0;
	type = 0;
	idc = -1;
	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {1, 1, 1, 1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	colorShadow[] = {0, 0, 0, 0.5};
	font = "PuristaMedium";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	linespacing = 1;
};

class mcd_RscMapText: RscText
{
	idc = -1;
	type = CT_STATIC;
	style = ST_LEFT;
	font = "PuristaLight";
	sizeEx = 0.04;
	colorBackground[] = { 0,0,0, 0.8 };
	text = "";
	w = 0.52 * 3/4;
	h = 0.05;
	duration = 1e+1000;
};

class mcd_RscMapTextSmall: RscText
{
	idc = -1;
	type = CT_STATIC;
	style = ST_LEFT;
	shadow = 2;
	font = "PuristaLight";
	sizeEx = 0.04;
	colorBackground[] = { 0,0,0, 0.8 };
	text = "";
	w = 0.52 * 3/4;
	h = 0.05;
	duration = 1e+1000;
};


class RscTitles
{
  class voteCountdownTitle
  {
    idd = 1400;
    duration = 99999;

    enableSimulation = 1;
    enableDisplay = 1;
    onLoad = "disableSerialization; _this call mcd_fnc_voteDialogText;";

    class ControlsBackground
    {
      class statusMessage: mcd_RscMapText
      {
        moving = 1;
        idc = 1401;
        text = "PLAYZONE VOTING"
        x = safeZoneX + safeZoneW - 0.6 * 3/4;
        y = safeZoneY + safeZoneH - 1.6;
      };

      class waitMessage: mcd_RscMapTextSmall
      {
        idc = 1402;
        text = "PLEASE WAIT";
        x = safeZoneX + safeZoneW - 0.6 * 3/4;
        y = safeZoneY + safeZoneH - 1.545;
      };
    };
  };
};
