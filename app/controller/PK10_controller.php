<?php 

class PK10_controller extends PK10_rules {

    public static function pk10_with_no_balls(array $drawnumber){
        return [
             'big' => Generators::pk10_no_ball_generator($drawnumber, 'big'),
             'small' => Generators::pk10_no_ball_generator($drawnumber, 'small'),
             'odd' => Generators::pk10_no_ball_generator($drawnumber, key: 'odd'),
             'even' => Generators::pk10_no_ball_generator($drawnumber, key: 'even'),
            //  'dragon' => Generators::pk10_no_ball_generator($drawnumber,  'dragon'),
            //  'tiger' => Generators::pk10_no_ball_generator($drawnumber,  'tiger')
        ];
    }

    public static function pk10_with_balls(array $drawnumber, int $idx, int $vrs1, int $vrs2, string $bsId, string $ovId, string $dtId){
        return [
            'big' => ($count = Generators::pk10_balls_generator($drawnumber, $idx, $vrs1, $vrs2,'big')) >= 2 ? self::getGameInfoById('PK10', $bsId,  $count, 'Big') : [],
            'small' => ($count = Generators::pk10_balls_generator($drawnumber, $idx, $vrs1, $vrs2,'small')) >= 2 ? self::getGameInfoById('PK10', $bsId,  $count, 'Small') : [],
            'odd' => ($count = Generators::pk10_balls_generator($drawnumber, $idx, $vrs1, $vrs2,'odd')) >= 2 ? self::getGameInfoById('PK10', $ovId,  $count, 'Odd') : [],
            'even' => ($count = Generators::pk10_balls_generator($drawnumber, $idx, $vrs1, $vrs2,'even')) >= 2 ? self::getGameInfoById('PK10', $ovId,  $count, 'Even') : [],
            'dragon' => ($count = Generators::pk10_balls_generator($drawnumber, $idx,  $vrs1, $vrs2,'dragon')) >= 2 ? self::getGameInfoById('PK10', $dtId,  $count, 'Dragon') : [],
            'tiger' => ($count = Generators::pk10_balls_generator($drawnumber, $idx,  $vrs1, $vrs2,'tiger')) >= 2 ? self::getGameInfoById('PK10', $dtId,  $count, 'Tiger') : [],
        ];
    }

    public static function pk10_with_balls_to_10(array $drawnumber, int $idx, string $bsId, string $ovId){
        return [
            'big' => ($count = Generators::pk10_balls_generator($drawnumber, $idx, 0, 0,'big')) >= 2 ? self::getGameInfoById('PK10', $bsId,  $count, 'Big') : [],
            'small' => ($count = Generators::pk10_balls_generator($drawnumber, $idx, 0, 0,'small')) >= 2 ? self::getGameInfoById('PK10', $bsId,  $count, 'Small') : [],
            'odd' => ($count = Generators::pk10_balls_generator($drawnumber, $idx, 0, 0,'odd')) >= 2 ? self::getGameInfoById('PK10', $ovId,  $count, 'Odd') : [],
            'even' => ($count = Generators::pk10_balls_generator($drawnumber, $idx, 0, 0,'even')) >= 2 ? self::getGameInfoById('PK10', $ovId,  $count, 'Even') : [],
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