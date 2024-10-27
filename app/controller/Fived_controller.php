<?php 

class Fived_controller extends Fived_rules {

    public static function fived_with_no_balls(array $drawnumber){
        return [
             'big' => Generators::fived_no_ball_genertor($drawnumber, 'big'),
             'small' =>  Generators::fived_no_ball_genertor($drawnumber, 'small'),
             'odd' => Generators::fived_no_ball_genertor($drawnumber, key: 'odd'),
             'even' => Generators::fived_no_ball_genertor($drawnumber, key: 'even'),
             'dragon' =>  Generators::fived_no_ball_genertor($drawnumber,  'dragon'),
             'tiger' => Generators::fived_no_ball_genertor($drawnumber,  'tiger'),
        ];
    }

    public static function fived_with_balls(array $drawnumber, int $idx, string $bsId, string $odId){
        return [
            'big' => ($count = Generators::fived_balls_generator($drawnumber, $idx, 'big')) >= 2 ? self::getGameInfoById('5d', $bsId,  $count, 'Big') : [],
            'small' => ($count = Generators::fived_balls_generator($drawnumber, $idx, 'small')) >= 2 ? self::getGameInfoById('5d', $bsId,  $count, 'Small') : [],
            'odd' => ($count = Generators::fived_balls_generator($drawnumber, $idx, 'odd')) >= 2 ? self::getGameInfoById('5d', $odId,  $count, 'Odd') : [],
            'even' => ($count = Generators::fived_balls_generator($drawnumber, $idx, 'even')) >= 2 ? self::getGameInfoById('5d', $odId, $count, 'Even') : [],
            // 'prime' => ($count = Generators::fived_balls_generator($drawnumber, $idx,  'prime')) >= 2 ? self::getGameInfoById('5d', $gameId, $count, 'big') : [],
            // 'composite' => ($count = Generators::fived_balls_generator($drawnumber, $idx,  'composite')) >= 2 ? self::getGameInfoById('5d', $gameId, $count, 'big') : [],
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