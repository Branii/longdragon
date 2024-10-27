<?php 

class Threed_controller extends Threed_rules {

    public static function threed_with_one_ball(array $drawnumber, string $idx, string $bsId, string $odId, string $primId) {
        return [
             'big' =>($count = Generators::threed_one_balls_generator($drawnumber, $idx,'big')) >= 2 ? self::getGameInfoById('ThreeD', $bsId,  $count, 'Big') : [],
             'small' =>($count =  Generators::threed_one_balls_generator($drawnumber, $idx,'small')) >= 2 ? self::getGameInfoById('ThreeD', $bsId,  $count, 'Small') : [],
             'odd' =>($count = Generators::threed_one_balls_generator($drawnumber, $idx,'odd')) >= 2 ? self::getGameInfoById('ThreeD', $odId,  $count, 'Odd') : [],
             'even' =>($count = Generators::threed_one_balls_generator($drawnumber, $idx,'even')) >= 2 ? self::getGameInfoById('ThreeD', $odId,  $count, 'Even') : [],
             'prime' => ($count = Generators::threed_one_balls_generator($drawnumber,  $idx, 'prime')) >= 2 ? self::getGameInfoById('ThreeD', $primId,  $count, 'Prime') : [],
             'composite' =>($count = Generators::threed_one_balls_generator($drawnumber,  $idx,'composite')) >= 2 ? self::getGameInfoById('ThreeD', $primId,  $count, 'Composite') : []
        ];
    }

    public static function threed_with_two_ball(array $drawnumber, int $idx1, int $idx2, string $sumovId, string $sumtailId, string $sumPrimeId){
        return [
            // 'sum_big' => ($count = Generators::threed_two_balls_generator($drawnumber, $idx1, $idx2, 'sum_big')) >= 2 ? self::getGameInfoById('ThreeD', $sumbsId,  $count, 'Big') : [],
            // 'sum_small' => ($count = Generators::threed_two_balls_generator($drawnumber, $idx1, $idx2,'sum_small')) >= 2 ? self::getGameInfoById('ThreeD', $sumbsId,  $count, 'Small') : [],
            'sum_odd' => ($count = Generators::threed_two_balls_generator($drawnumber, $idx1, $idx2, 'sum_odd')) >= 2 ? self::getGameInfoById('ThreeD', $sumovId,  $count, 'Odd') : [],
            'sum_even' => ($count = Generators::threed_two_balls_generator($drawnumber, $idx1, $idx2, 'sum_even')) >= 2 ? self::getGameInfoById('ThreeD', $sumovId, $count, 'Even') : [],
            'tail_big' => ($count = Generators::threed_two_balls_generator($drawnumber, $idx1, $idx2,  'tail_big')) >= 2 ? self::getGameInfoById('ThreeD', $sumtailId, $count, 'Big') : [],
            'tail_small' => ($count = Generators::threed_two_balls_generator($drawnumber, $idx1,$idx2,  'tail_small')) >= 2 ? self::getGameInfoById('ThreeD', $sumtailId, $count, 'Small') : [],
            'tail_prime' => ($count = Generators::threed_two_balls_generator($drawnumber, $idx1, $idx2,  'tail_prime')) >= 2 ? self::getGameInfoById('ThreeD', $sumPrimeId, $count, 'Prime') : [],
            'tail_composite' => ($count = Generators::threed_two_balls_generator($drawnumber, $idx1, $idx2, 'tail_composite')) >= 2 ? self::getGameInfoById('ThreeD', $sumPrimeId, $count, 'Composite') : [],
        ];
    }

    public static function threed_with_three_ball(array $drawnumber, int $idx1, int $idx2, int $idx3, string $sumbsId, string $sumovId, string $sumtailId, string $sumPrimeId){
        return [
            'sum_big' => ($count = Generators::threed_three_balls_generator($drawnumber, $idx1, $idx2, $idx3,'sum_big')) >= 2 ? self::getGameInfoById('ThreeD', $sumbsId,  $count, 'Big') : [],
            'sum_small' => ($count = Generators::threed_three_balls_generator($drawnumber, $idx1, $idx2,$idx3,'sum_small')) >= 2 ? self::getGameInfoById('ThreeD', $sumbsId,  $count, 'Small') : [],
            'sum_odd' => ($count = Generators::threed_three_balls_generator($drawnumber, $idx1, $idx2, $idx3,'sum_odd')) >= 2 ? self::getGameInfoById('ThreeD', $sumovId,  $count, 'Odd') : [],
            'sum_even' => ($count = Generators::threed_three_balls_generator($drawnumber, $idx1, $idx2, $idx3,'sum_even')) >= 2 ? self::getGameInfoById('ThreeD', $sumovId, $count, 'Even') : [],
            'tail_big' => ($count = Generators::threed_three_balls_generator($drawnumber, $idx1, $idx2,  $idx3,'tail_big')) >= 2 ? self::getGameInfoById('ThreeD', $sumtailId, $count, 'Big') : [],
            'tail_small' => ($count = Generators::threed_three_balls_generator($drawnumber, $idx1,$idx2,  $idx3,'tail_small')) >= 2 ? self::getGameInfoById('ThreeD', $sumtailId, $count, 'Small') : [],
            'tail_prime' => ($count = Generators::threed_three_balls_generator($drawnumber, $idx1, $idx2,  $idx3,'tail_prime')) >= 2 ? self::getGameInfoById('ThreeD', $sumPrimeId, $count, 'Prime') : [],
            'tail_composite' => ($count = Generators::threed_three_balls_generator($drawnumber, $idx1, $idx2, $idx3,'tail_composite')) >= 2 ? self::getGameInfoById('ThreeD', $sumPrimeId, $count, 'Composite') : [],
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