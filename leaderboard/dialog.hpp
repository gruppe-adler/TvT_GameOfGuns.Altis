#include "base.hpp"
#include "defines.sqf"

class Cell: w_RscText
{
  idc = -1;
  /*colorBackground[] ={0.5,0.5,0.5,1};*/
  colorBackground[] = {0,0,0,0};
  style = ST_RIGHT;
  sizeEx = TEXT_SCALE * 0.025;

  w = lb_cellW;
  h = lb_cellH;
  font = "PuristaMedium";
  text = "";
};

class TitleCell: Cell
{
  font = "PuristaSemiBold";
  sizeEx = TEXT_SCALE * 0.03;
};


class leaderboard
{
  idd = leaderboard_dialog;
  movingEnable = false;
  enableSimulation = true;
  enableDisplay = true;
  duration = lb_DURATION;
  onLoad = "uiNamespace setVariable [""LeaderBoard_Display"", _this select 0]";

  class ControlsBackground
  {
    class TitleBar: w_RscText
    {
      idc = -1;
      movingEnable = true;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0])",1};

      x = lb_mainX;
      y = lb_titleY;
      w = lb_mainW;
      h = lb_titleH;

      sizeEx = 0.04 * TEXT_SCALE;
      text = "GAME OF GUNS - LEADERBOARD";
    };

    class MainBackground: IGUIBack
    {
      idc = -1;
      colorBackground[] = {0, 0, 0, 0.6};

      x = lb_mainX;
      y = lb_mainY;
      w = lb_mainW;
      h = lb_mainH;
    };

    class MyStatsTitle: w_RscText
    {
      idc = -1;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0])",1};

      x = lb_mainX;
      y = lb_mystatsTitleY;
      w = lb_mainW;
      h = lb_titleH;

      sizeEx = 0.04 * TEXT_SCALE;
      text = "YOUR STATS THIS GAME";
    };

    class MyStatsBG: IGUIBACK
    {
      idc = -1;
      colorBackground[] = {0, 0, 0, 0.6};

      x = lb_mainX;
      y = lb_mystatsY;
      w = lb_mainW;
      h = lb_mystatsH;
    };

    class Title0: TitleCell
    {
      idc = -1;
      text = "RANK";
      x = lb_mainX + lb_cellPaddingX + (0 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY;
      style = ST_LEFT;
    };

    class Title1: TitleCell
    {
      idc = -1;
      text = "NAME";
      x = lb_mainX + lb_cellPaddingX + (1 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY;
    };

    class Title2: TitleCell
    {
      idc = -1;
      text = "K/D";
      x = lb_mainX + lb_cellPaddingX + (2 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY;
    };

    class Title3: TitleCell
    {
      idc = -1;
      text = "GAMES";
      x = lb_mainX + lb_cellPaddingX + (3 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY;
    };

    class Title4: TitleCell
    {
      idc = -1;
      text = "POINTS";
      x = lb_mainX + lb_cellPaddingX + (4 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY;
    };

    class Cell00: Cell
    {
      idc = lb_0_0;
      x = lb_mainX + lb_cellPaddingX + (0 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (0 * (lb_cellH + lb_cellPaddingY));
      style = ST_LEFT;
    };

    class Cell01: Cell
    {
      idc = lb_0_1;
      x = lb_mainX + lb_cellPaddingX + (1 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (0 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell02: Cell
    {
      idc = lb_0_2;
      x = lb_mainX + lb_cellPaddingX + (2 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (0 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell03: Cell
    {
      idc = lb_0_3;
      x = lb_mainX + lb_cellPaddingX + (3 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (0 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell04: Cell
    {
      idc = lb_0_4;
      x = lb_mainX + lb_cellPaddingX + (4 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (0 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell10: Cell
    {
      idc = lb_1_0;
      x = lb_mainX + lb_cellPaddingX + (0 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (1 * (lb_cellH + lb_cellPaddingY));
      style = ST_LEFT;
    };

    class Cell11: Cell
    {
      idc = lb_1_1;
      x = lb_mainX + lb_cellPaddingX + (1 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (1 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell12: Cell
    {
      idc = lb_1_2;
      x = lb_mainX + lb_cellPaddingX + (2 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (1 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell13: Cell
    {
      idc = lb_1_3;
      x = lb_mainX + lb_cellPaddingX + (3 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (1 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell14: Cell
    {
      idc = lb_1_4;
      x = lb_mainX + lb_cellPaddingX + (4 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (1 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell20: Cell
    {
      idc = lb_2_0;
      x = lb_mainX + lb_cellPaddingX + (0 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (2 * (lb_cellH + lb_cellPaddingY));
      style = ST_LEFT;
    };

    class Cell21: Cell
    {
      idc = lb_2_1;
      x = lb_mainX + lb_cellPaddingX + (1 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (2 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell22: Cell
    {
      idc = lb_2_2;
      x = lb_mainX + lb_cellPaddingX + (2 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (2 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell23: Cell
    {
      idc = lb_2_3;
      x = lb_mainX + lb_cellPaddingX + (3 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (2 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell24: Cell
    {
      idc = lb_2_4;
      x = lb_mainX + lb_cellPaddingX + (4 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (2 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell30: Cell
    {
      idc = lb_3_0;
      x = lb_mainX + lb_cellPaddingX + (0 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (3 * (lb_cellH + lb_cellPaddingY));
      style = ST_LEFT;
    };

    class Cell31: Cell
    {
      idc = lb_3_1;
      x = lb_mainX + lb_cellPaddingX + (1 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (3 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell32: Cell
    {
      idc = lb_3_2;
      x = lb_mainX + lb_cellPaddingX + (2 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (3 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell33: Cell
    {
      idc = lb_3_3;
      x = lb_mainX + lb_cellPaddingX + (3 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (3 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell34: Cell
    {
      idc = lb_3_4;
      x = lb_mainX + lb_cellPaddingX + (4 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (3 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell40: Cell
    {
      idc = lb_4_0;
      x = lb_mainX + lb_cellPaddingX + (0 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (4 * (lb_cellH + lb_cellPaddingY));
      style = ST_LEFT;
    };

    class Cell41: Cell
    {
      idc = lb_4_1;
      x = lb_mainX + lb_cellPaddingX + (1 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (4 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell42: Cell
    {
      idc = lb_4_2;
      x = lb_mainX + lb_cellPaddingX + (2 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (4 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell43: Cell
    {
      idc = lb_4_3;
      x = lb_mainX + lb_cellPaddingX + (3 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (4 * (lb_cellH + lb_cellPaddingY));
    };

    class Cell44: Cell
    {
      idc = lb_4_4;
      x = lb_mainX + lb_cellPaddingX + (4 * (lb_cellW + lb_cellPaddingX));
      y = lb_mainY + lb_cellPaddingY + lb_titleH + lb_cellPaddingY + (4 * (lb_cellH + lb_cellPaddingY));
    };



    class MyStatsTitle0: TitleCell
    {
      idc = -1;
      style = ST_LEFT;
      text = "KILLS";
      x = lb_mainX + lb_cellPaddingX + (0 * (lb_cellW + lb_cellPaddingX));
      y = lb_mystatsY + lb_cellPaddingY;
    };

    class MyStatsTitle1: TitleCell
    {
      idc = -1;
      text = "DEATHS";
      x = lb_mainX + lb_cellPaddingX + (1 * (lb_cellW + lb_cellPaddingX));
      y = lb_mystatsY + lb_cellPaddingY;
    };

    class MyStatsTitle2: TitleCell
    {
      idc = -1;
      text = "K/D";
      x = lb_mainX + lb_cellPaddingX + (2 * (lb_cellW + lb_cellPaddingX));
      y = lb_mystatsY + lb_cellPaddingY;
    };

    class MyStatsTitle3: TitleCell
    {
      idc = -1;
      text = "SNIPED";
      x = lb_mainX + lb_cellPaddingX + (3 * (lb_cellW + lb_cellPaddingX));
      y = lb_mystatsY + lb_cellPaddingY;
    };

    class MyStatsTitle4: TitleCell
    {
      idc = -1;
      text = "MOVED";
      x = lb_mainX + lb_cellPaddingX + (4 * (lb_cellW + lb_cellPaddingX));
      y = lb_mystatsY + lb_cellPaddingY;
    };

    class MyStats0: Cell
    {
      idc = mystats_0;
      style = ST_LEFT;
      x = lb_mainX + lb_cellPaddingX + (0 * (lb_cellW + lb_cellPaddingX));
      y = lb_mystatsY + lb_cellPaddingY + (1 * (lb_cellH + lb_cellPaddingY));
    };

    class MyStats1: Cell
    {
      idc = mystats_1;
      x = lb_mainX + lb_cellPaddingX + (1 * (lb_cellW + lb_cellPaddingX));
      y = lb_mystatsY + lb_cellPaddingY + (1 * (lb_cellH + lb_cellPaddingY));
    };

    class MyStats2: Cell
    {
      idc = mystats_2;
      x = lb_mainX + lb_cellPaddingX + (2 * (lb_cellW + lb_cellPaddingX));
      y = lb_mystatsY + lb_cellPaddingY + (1 * (lb_cellH + lb_cellPaddingY));
    };

    class MyStats3: Cell
    {
      idc = mystats_3;
      x = lb_mainX + lb_cellPaddingX + (3 * (lb_cellW + lb_cellPaddingX));
      y = lb_mystatsY + lb_cellPaddingY + (1 * (lb_cellH + lb_cellPaddingY));
    };

    class MyStats4: Cell
    {
      idc = mystats_4;
      x = lb_mainX + lb_cellPaddingX + (4 * (lb_cellW + lb_cellPaddingX));
      y = lb_mystatsY + lb_cellPaddingY + (1 * (lb_cellH + lb_cellPaddingY));
    };
  };

  class Controls
  {

  };
};
