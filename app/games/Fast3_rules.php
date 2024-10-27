<?php 

class Fast3_rules {

    public static function fast3_big_x_small(array $drawnumber, string $key) : bool { 
        $data = [
            'big' => array_sum($drawnumber) > 10, 
            'small' => array_sum($drawnumber) < 11
        ];
        return $data[$key];
    }

    # end of rules #
}