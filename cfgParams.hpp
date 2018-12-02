class Params {
    class TimeOfDay {
        title = "Time of Day";
        values[] = {7,8,9,10,11,12,13,14,15,16,17,1000};
        texts[] = {"07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "Random"};
        default = 1000;
    };

    class WeatherSetting {
        title = "Weather";
        values[] = {-1,0,25,50,75,100};
        texts[] = {"Random","Clear","Cloudy","Overcast","Rainy","Stormy"};
        default = -1;
    };

    class KillsForWin {
        title = "Kills Needed To Win (Per Team)";
        values[] = {10,20,30,40,50,60};
        texts[] = {"10","20","30","40","50","60"};
        default = 20;
    };

    class GameMode {
        title = "Game Mode";
        values[] = {0,1,2};
        texts[] = {"Standard (Strong Weapons First)", "Reverse (Weak Weapons First)", "Random (Random Weapon Order)"};
        default = 0;
    };

    class RankedMode {
        title = "Ranked Mode";
        values[] = {0,1};
        texts[] = {"off", "on"};
        default = 1;
    };

    class RandomTeams {
        title = "Random Teams";
        values[] = {1,0};
        texts[] = {"On", "Off"};
        default = 1;
    };

    class TeamSize {
        title = "Random Teams - Size";
        values[] = {1,2,3,4,5};
        texts[] = {"1","2","3","4","5"};
        default = 1;
    };

    class SoloRespawnTime {
        title = "Solo Respawn Time (Seconds)";
        values[] = {5,10,20,30,40,50,60,70,80,90,100,110,120};
        texts[] = {"5","10","20","30","40","50","60","70","80","90","100","110","120"};
        default = 20;
    };

    class TeamRespawnTime {
        title = "Team Respawn Time (Seconds)";
        values[] = {5,10,20,30,40,50,60,70,80,90,100,110,120};
        texts[] = {"5","10","20","30","40","50","60","70","80","90","100","110","120"};
        default = 10;
    };
};
