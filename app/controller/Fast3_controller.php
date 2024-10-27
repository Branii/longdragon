<?php 

class Fast3_controller extends Fast3_rules {
    public static function fast3_sum_big_x_small(array $drawnumber, string $bsId){
        return [
           'big' => ($count = Generators::fast3_no_ball_generator($drawnumber, 'big')) >= 2 ? self::getGameInfoById('Fast 3', $bsId,  $count, 'Big') : [],
           'small' => ($count = Generators::fast3_no_ball_generator($drawnumber, 'small')) >= 2 ? self::getGameInfoById('Fast 3', $bsId,  $count, 'Big') : [],
        ];
    }

    public static function getGameInfoById(string $lotteyName , int $gameId, string $gameCount, string $gameName){
        $result = Model::getGameInfoByGameId($gameId)[0];
        return [
            'gameid'=> $gameId,
            'streak' => $gameCount . ' issues in a row',
            'game_name' => $result['name'] . ' ' . $gameName,
            'odds' => $result['odds'],
            "isSpecial" => true,
            'group_type' => $result['group_type'],
            'button1' => explode("/",$result['group_type'])[0],
            'button2' => explode("/",$result['group_type'])[1],
            'rebate' => $result['rebate'],
            'profit' => $result['profit'],
            'lottery_id' => $result['lottery_type'],
            'timeleft' => 50,
        ];
    }

}
