#define ST_LEFT           0x00
#define ST_CENTER         0x02

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

class IGUIBack
{
	type = 0;
	idc = 124;
	style = 128;
	text = "";
	colorText[] = {0, 0, 0, 0};
	font = "PuristaMedium";
	sizeEx = 0;
	shadow = 0;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
	colorbackground[] =
	{
		"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"
	};
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

class mcd_RscPicture
{
	shadow = 0;
	type = 0;
	style = 48;
	sizeEx = 0.023;
	font = "PuristaMedium";
	colorBackground[] = {};
	colorText[] = {};
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
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
        text = "PLAYZONE VOTING";
        x = safeZoneX + safeZoneW - 0.6 * 3/4;
        y = safeZoneY + safeZoneH - 1.600;
      };

			class skipMessage: mcd_RscMapTextSmall
			{
				idc = 1403;
				text = "";
				x = safeZoneX + safeZoneW - 0.6 * 3/4;
				y = safeZoneY + safeZoneH - 1.545;
			};

      class waitMessage: mcd_RscMapTextSmall
      {
        idc = 1402;
        text = "";
        x = safeZoneX + safeZoneW - 0.6 * 3/4;
        y = safeZoneY + safeZoneH - 1.490;
      };
    };
  };

	class upgradeWeaponTitle
	{
		idd = 1500;
		duration = 99999;

		enableSimulation = 1;
		enableDisplay = 1;

		onload = "disableSerialization; _this call mcd_fnc_upgradeWeaponTitle;";

		class ControlsBackground
		{
			#define uw_x (safeZoneX + safeZoneW - 0.5)
			#define uw_y (safeZoneY + safeZoneH - 1.6)
			#define uw_w (0.40)
			#define uw_h (0.40 * 3/4)
			#define uw_paddingX (uw_w * 0.1)
			#define uw_paddingY (uw_h * 0.1)

			class Background: IGUIBack
			{
				idc = 1501;
				x = uw_x;
        y = uw_y;
				w = uw_w;
				h = uw_h;
			};

			class WeaponPicture: mcd_RscPicture
			{
				idc = 1502;
				x = uw_x + uw_paddingX;
				y = uw_y;
				w = uw_w - 2*uw_paddingX;
				h = uw_h - uw_paddingY;
				text = "";
			};

			class WeaponText: RscText
			{
				idc = 1503;
				style = ST_CENTER;
				x = uw_x;
				y = uw_y + uw_h - uw_paddingY*1.4;
				w = uw_w;
				h = uw_paddingY;

			};
		};
	};
};
