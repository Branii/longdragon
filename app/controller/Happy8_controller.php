<?php 

class Happy8_controller extends Happy8_rules {

    public static function happy8_with_no_balls(array $drawnumber, string $bsId, string $ovId, string $flId,string $morId){
        return [
             'big' => ($count = Generators::happy8_no_ball_genertor($drawnumber, 'big')) >= 2 ? self::getGameInfoById('Happy8', $bsId,  $count, 'Big') : [],
             'small' => ($count = Generators::happy8_no_ball_genertor($drawnumber, 'small')) >= 2 ? self::getGameInfoById('Happy8', $bsId,  $count, 'Big') : [],
             'odd' => ($count = Generators::happy8_no_ball_genertor($drawnumber, key: 'odd')) >= 2 ? self::getGameInfoById('Happy8', $ovId,  $count, 'Big') : [],
             'even' => ($count = Generators::happy8_no_ball_genertor($drawnumber, key: 'even')) >= 2 ? self::getGameInfoById('Happy8', $ovId,  $count, 'Big') : [],
             'more_first' => ($count = Generators::happy8_no_ball_genertor($drawnumber,  'more_last')) >= 2 ? self::getGameInfoById('Happy8', $flId,  $count, 'Big') : [],
             'more_last' => ($count = Generators::happy8_no_ball_genertor($drawnumber,  'more_first')) >= 2 ? self::getGameInfoById('Happy8', $flId,  $count, 'Big') : [],
             'more_even' => ($count = Generators::happy8_no_ball_genertor($drawnumber,  'more_even')) >= 2 ? self::getGameInfoById('Happy8', $morId,  $count, 'Big') : [],
             'more_odd' => ($count = Generators::happy8_no_ball_genertor($drawnumber,  'more_odd')) >= 2 ? self::getGameInfoById('Happy8', $morId,  $count, 'Big') : [],
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