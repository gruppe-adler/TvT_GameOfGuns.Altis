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
