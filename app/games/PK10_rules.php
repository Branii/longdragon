<?php 

class PK10_rules {

    public static function Dragon_Tiger(int $idx1, int $idx2, array $drawNumber): int{ // dragon|tiger|pattern
        $drawNumber = explode(",", implode(",", $drawNumber));
        $v1 = $drawNumber[$idx1];
        $v2 = $drawNumber[$idx2];
        return ($v1 > $v2) ? 1 : 2;
    }

    public static function pk10_no_ball(array $drawnumber, string $key) : bool { 
        $data = [
            'big'=>array_sum(array_slice($drawnumber,0,2)) > 11, 
            'small'=>array_sum(array_slice($drawnumber,0,2)) < 12,
            'odd'=> array_sum(array_slice($drawnumber,0,2)) % 2 != 0, 
            'even'=> array_sum(array_slice($drawnumber,0,2)) % 2 == 0,
            // 'dragon'=> self::Dragon_Tiger(0, 9,$drawnumber) == 1, 
            // 'tiger' => self::Dragon_Tiger(0, 9,$drawnumber) == 2
        ];
        return $data[$key];
    }

    public static function pk10_balls(array $drawnumber, int $idx, int $vrs1, int $vrs2, string $key) : bool {
        $data = [
            'big' =>   $drawnumber[$idx] > 4, 
            'small' => $drawnumber[$idx] < 5,
            'odd' =>   $drawnumber[$idx] % 2 != 0, 
            'even' =>  $drawnumber[$idx] % 2 == 0,
            'dragon'=> self::Dragon_Tiger($vrs1, $vrs2,$drawnumber) == 1, 
            'tiger' => self::Dragon_Tiger($vrs1, $vrs2,$drawnumber) == 2
        ];
        return $data[$key];
    }

    # end of rules #
}