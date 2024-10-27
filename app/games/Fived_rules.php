<?php 

class Fived_rules {

    public static function Dragon_Tiger(int $idx1, int $idx2, array $drawNumber): int{ // dragon|tiger|pattern
        $drawNumber = explode(",", implode(",", $drawNumber));
        $v1 = $drawNumber[$idx1];
        $v2 = $drawNumber[$idx2];
        return ($v1 > $v2) ? 1 : 2;
    }

    public static function fived_no_ball(array $drawnumber, string $key) : bool { 
        $data = [
            'big'=> array_sum($drawnumber) > 22, 
            'small'=>array_sum($drawnumber) < 23,
            'odd'=> array_sum($drawnumber) % 2 != 0, 
            'even'=> array_sum($drawnumber) % 2 == 0,
            'dragon'=> self::Dragon_Tiger(0, 4,$drawnumber) == 1, 
            'tiger' => self::Dragon_Tiger(0, 4,$drawnumber) == 2
        ];
        return $data[$key];
    }

    public static function fived_balls(array $drawnumber, int $idx, string $key) : bool {
        $data = [
            'big'=> $drawnumber[$idx] > 4, 
            'small' => $drawnumber[$idx] < 5,
            'odd'=> $drawnumber[$idx] % 2 != 0, 
            'even' => $drawnumber[$idx] % 2 == 0,
            'prime'=> in_array($drawnumber[$idx],  [1, 2, 3, 5, 7]), 
            'composite' => in_array($drawnumber[$idx],  [0, 4, 6, 8, 9])
        ];
        return $data[$key];
    }

    # end of rules #

}