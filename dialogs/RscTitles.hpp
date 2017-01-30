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
	idd = UPGRADEWEAPON_DIALOG;
	duration = 99999;

	enableSimulation = 1;
	enableDisplay = 1;

	onload = "disableSerialization; _this call mcd_fnc_upgradeWeaponTitle;";

	class ControlsBackground
	{
		class Background: mcd_IGUIBack
		{
			idc = UPGRADEWEAPON_BG;
			x = uw_x;
            y = uw_y;
			w = uw_w;
			h = uw_h;
		};

		class WeaponPicture: mcd_RscPicture
		{
			idc = UPGRADEWEAPON_PIC;
			x = uw_x + uw_paddingX;
			y = uw_y;
			w = uw_w - 2*uw_paddingX;
			h = uw_h - uw_paddingY;
			text = "";
		};

		class WeaponText: RscText
		{
			idc = UPGRADEWEAPON_TEXT;
			style = ST_CENTER;
			x = uw_x;
			y = uw_y + uw_h - uw_paddingY*1.4;
			w = uw_w;
			h = uw_paddingY;

		};
	};
};

class KillCamTitle
{
    idd = KILLCAMTITLE_DIALOG;
    enableDisplay = true;
    enableSimulation = true;
	duration = 8;
	onLoad = "uiNamespace setVariable [""KillCamTitle_Display"", _this select 0]";

    class ControlsBackground
    {
        class Title: KillCamText
        {
            idc = KILLCAMTITLE_TITLE;
            x = kc_titleX;
            y = kc_titleY;
            w = kc_W;
            h = kc_H;
        };
    };
};

class ScoreBoard
{
	idd = SCOREBOARD_DIALOG;
	enableDisplay = true;
	enableSimulation = true;
	duration = 1e+1000;
	onLoad = "uiNamespace setVariable [""ScoreBoard_Display"", _this select 0]";

	class ControlsBackground {
		class Item1: ScoreBoardItem
		{
			idc = SCOREBOARD_ITEM1;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 0);
		};

		class Score1: ScoreBoardScore
		{
			idc = SCOREBOARD_SCORE1;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 0);
		};

		class Item2: ScoreBoardItem
		{
			idc = SCOREBOARD_ITEM2;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 1);
		};

		class Score2: ScoreBoardScore
		{
			idc = SCOREBOARD_SCORE2;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 1);
		};

		class Item3: ScoreBoardItem
		{
			idc = SCOREBOARD_ITEM3;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 2);
		};

		class Score3: ScoreBoardScore
		{
			idc = SCOREBOARD_SCORE3;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 2);
		};

		class Item4: ScoreBoardItem
		{
			idc = SCOREBOARD_ITEM4;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 3);
		};

		class Score4: ScoreBoardScore
		{
			idc = SCOREBOARD_SCORE4;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 3);
		};
	};
};
