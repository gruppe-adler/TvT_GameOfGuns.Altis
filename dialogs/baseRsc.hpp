class mcd_IGUIBack
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

class mcd_RscText
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

class mcd_RscMapText: mcd_RscText
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

class mcd_RscMapTextSmall: mcd_RscText
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


class KillCamText
{
    access = 0;
    type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    w = 0.1; h = 0.05;
    font = "PuristaMedium";
    sizeEx = 0.08;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    text = "";
    fixedWidth = 0;
    shadow = 0;
};

class ScoreBoardItem
{
    access = 0;
    type = CT_STATIC;
    idc = -1;
    style = ST_LEFT;
    x = sb_totalX + sb_scoreW + sb_itemSpacingX;
    w = sb_itemW;
    h = sb_itemH;
    font = "PuristaLight";
    sizeEx = (0.04 * TEXT_SCALE);
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    text = "";
    fixedWidth = 0;
    shadow = 0;
};

class ScoreBoardScore: ScoreBoardItem
{
    style = ST_CENTER;
    x = sb_totalX;
    w = sb_scoreW;
    text = "";
};
