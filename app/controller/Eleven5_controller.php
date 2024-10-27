<?php 

class Eleven5_controller extends Eleven5_rules {

    public static function eleven5_with_no_balls(array $drawnumber){
        return [
             'big' => Generators::eleven5_no_ball_genertor($drawnumber, 'big'),
             'small' => Generators::eleven5_no_ball_genertor($drawnumber, 'small'),
             'odd' => Generators::eleven5_no_ball_genertor($drawnumber, key: 'odd'),
             'even' => Generators::eleven5_no_ball_genertor($drawnumber, key: 'even'),
             'dragon' => Generators::eleven5_no_ball_genertor($drawnumber,  'dragon'),
             'tiger' => Generators::eleven5_no_ball_genertor($drawnumber,  'tiger')
        ];
    }

    public static function eleven5_with_balls(array $drawnumber, int $idx, string $bsId, string $ovId){
        return [
            'big' => ($count =  Generators::eleven5_balls_generator($drawnumber, $idx, 'big')) >= 2 ? self::getGameInfoById('Eleven5', $bsId,  $count, 'Big') : [],
            'small' => ($count =  Generators::eleven5_balls_generator($drawnumber, $idx, 'small')) >= 2 ? self::getGameInfoById('Eleven5', $bsId,  $count, 'Small') : [],
            'odd' => ($count =  Generators::eleven5_balls_generator($drawnumber, $idx, 'odd')) >= 2 ? self::getGameInfoById('Eleven5', $ovId,  $count, 'Odd') : [],
            'even' => ($count =  Generators::eleven5_balls_generator($drawnumber, $idx, 'even')) >= 2 ? self::getGameInfoById('Eleven5', $ovId,  $count, 'Even') : [],
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