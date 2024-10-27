<?php 

class Mark6_rules extends Utils {

    public static function mark6_extra_number(array $drawnumber, string $key) : bool {
        $extraNumber = end($drawnumber);
        $data = [
            'big'=> end($drawnumber) > 24, 
            'small' => end($drawnumber) < 25, 
            'odd'=> in_array($extraNumber % 10, [1,3,5,7,9]), 
            'even' => in_array($extraNumber % 10,  [0,2,4,6,8]), 
            'sum_big'=> array_sum(str_split($extraNumber)) > 6, 
            'sum_small' => array_sum(str_split($extraNumber)) < 7, 
            'sum_odd'=> in_array(array_sum(str_split($extraNumber)) % 10, [1,3,5,7,9]), 
            'sum_even' => in_array(array_sum(str_split($extraNumber)) % 10,  [0,2,4,6,8]),
            'sky'=> parent::zodiacSky($drawnumber), 
            'ground' => parent::zodiacGround($drawnumber),
            'first'=> parent::zodiacFirst($drawnumber), 
            'last' => parent::zodiacLast($drawnumber),
            'poultry'=> parent::poultry($drawnumber),
            'beast' => parent::beast($drawnumber),
            'tail_big'=> ($extraNumber % 10) > 4, 
            'tail_small' => ($extraNumber % 10) < 5,
        ];
        return $data[$key];
    }

    public static function mark6_balls(array $drawnumber, int $idx, string $key) : bool {
        $extraNumber = end($drawnumber);
        $data = [
            'big'=> $drawnumber[$idx] > 24, 
            'small' => $drawnumber[$idx] < 25,
            'odd'=> in_array($drawnumber[$idx] % 10, [1,3,5,7,9]),
            'even' => in_array($drawnumber[$idx] % 10,  [0,2,4,6,8]), 
            'sum_big'=> array_sum(array_slice($drawnumber,0,2)) > 6, 
            'sum_small' => array_sum(str_split($extraNumber)) < 7, 
            'sum_odd'=> in_array(array_sum(str_split($extraNumber)) % 10, [1,3,5,7,9]), 
            'sum_even' => in_array(array_sum(str_split($extraNumber)) % 10,  [0,2,4,6,8]),
            'tail_big'=> ($extraNumber % 10) > 4, 
            'tail_small' => ($extraNumber % 10) < 5,
        ];
        return $data[$key];
    }

    public static function mark6_sum(array $drawnumber, string $key) : bool {
        $extraNumber = end($drawnumber);
        $data = [
            'big'=> array_sum($drawnumber) > 175,
            'small' => array_sum($drawnumber) < 176,
            'odd'=> in_array(array_sum($drawnumber) % 10, [1,3,5,7,9]), 
            'even' => in_array(array_sum($drawnumber) % 10,  [0,2,4,6,8]),
            'no_tie_big'=> substr((string) array_sum([$v1,$v2,$v3]), -1) >= 5, 
            'no_tie_small' => substr((string) array_sum([$v1,$v2,$v3]), -1) <= 4,
        ];
        return $data[$key];
    }


    public static function mark6_zodiac(array $drawnumber, int $idx1, int $idx2, int $idx3, string $key) : bool {
        $data = [
            'big'=> substr((string) array_sum([$v1,$v2,$v3]), -1) >= 5, 
            'small' => substr((string) array_sum([$v1,$v2,$v3]), -1) <= 4,
            'odd'=> substr((string) array_sum([$v1,$v2,$v3]), -1) % 2 != 0,
            'even' => substr((string) array_sum([$v1,$v2,$v3]), -1) % 2 == 0,
            'no_tie_big'=> substr((string) array_sum([$v1,$v2,$v3]), -1) >= 5, 
            'no_tie_small' => substr((string) array_sum([$v1,$v2,$v3]), -1) <= 4,
        ];
        return $data[$key];
    }

    # end of rules #

}