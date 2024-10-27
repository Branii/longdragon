<?php 

class Happy8_rules {

    public static function More_First_Last_Pattern(array $drawNumber) { // dragon|tiger|pattern
       
    }

    public static function happy8_no_ball(array $drawnumber, string $key) : bool { 

        $superNum = array_filter($drawnumber, function ($num) {
            return is_numeric($num) && intval($num) >= 1 && intval($num) <= 40;
          });
        $duperNum = array_diff($drawnumber, $superNum);
        $data = [
            'big'=> array_sum($drawnumber) > 810, 
            'small'=>array_sum($drawnumber) < 810,
            'odd'=> array_sum($drawnumber) % 2 != 0, 
            'even'=> array_sum($drawnumber) % 2 == 0,
            'more_first' => count($superNum) > count($duperNum),
            'more_last' => count($superNum) < count($duperNum),
            'more_even' => count(array_filter($drawnumber, fn ($num) => $num % 2 == 0)) > count(array_filter($drawnumber, fn ($num) => $num % 2 != 0)),
            'more_odd' =>  count(array_filter($drawnumber, fn ($num) => $num % 2 == 0)) < count(array_filter($drawnumber, fn ($num) => $num % 2 != 0))
        ];
        return $data[$key];
    }

    # end of rules #

}