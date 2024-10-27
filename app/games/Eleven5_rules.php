<?php 

class Eleven5_rules {

    public static function Dragon_Tiger(int $idx1, int $idx2, array $drawNumber): int{ // dragon|tiger|pattern
        $drawNumber = explode(",", implode(",", $drawNumber));
        $v1 = $drawNumber[$idx1];
        $v2 = $drawNumber[$idx2];
        return ($v1 > $v2) ? 1 : 2;
    }

    public static function eleven5_no_ball(array $drawnumber, string $key) : bool { 
        $data = [
            'big'=> array_sum($drawnumber) > 30, 
            'small'=>array_sum($drawnumber) < 30,
            'odd'=> array_sum($drawnumber) % 2 != 0, 
            'even'=> array_sum($drawnumber) % 2 == 0,
            'dragon'=> self::Dragon_Tiger(0, 4,$drawnumber) == 1, 
            'tiger' => self::Dragon_Tiger(0, 4,$drawnumber) == 2
        ];
        return $data[$key];
    }

    public static function eleven5_balls(array $drawnumber, int $idx, string $key) : bool {
        $data = [
            'big'=> $drawnumber[$idx] > 4, 
            'small' => $drawnumber[$idx] < 5,
            'odd'=> $drawnumber[$idx] % 2 != 0, 
            'even' => $drawnumber[$idx] % 2 == 0,
        ];
        return $data[$key];
    }

    # end of rules #

}