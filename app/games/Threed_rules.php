<?php 

class Threed_rules {

    public static function threed_one_ball(array $drawnumber, int $idx, string $key) : bool {
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

    public static function threed_two_balls(array $drawnumber, int $idx1, int $idx2, string $key) : bool {
        $v1 = $drawnumber[$idx1];
        $v2 = $drawnumber[$idx2];
        $data = [
            'sum_big'=> ($v1 + $v2) > 4, 
            'sum_small' => ($v1 + $v2) < 5,
            'sum_odd'=> ($v1 + $v2) % 2 != 0, 
            'sum_even' => ($v1 + $v2) % 2 == 0,
            'tail_big'=> substr((string) array_sum([$v1,$v2]), -1) >= 5,
            'tail_small' => substr((string) array_sum([$v1,$v2]), -1) <= 4,
            'tail_prime'=> in_array(substr((string) array_sum([$v1,$v2]), -1),[1, 2, 3, 5, 7]), 
            'tail_composite' => in_array(substr((string) array_sum([$v1,$v2]), -1),[0, 4, 6, 8, 9]),
        ];
        return $data[$key];
    }

    public static function threed_three_balls(array $drawnumber, int $idx1, int $idx2, int $idx3, string $key) : bool {
        $v1 = $drawnumber[$idx1];
        $v2 = $drawnumber[$idx2];
        $v3 = $drawnumber[$idx3];
        $data = [
            'sum_big'=> substr((string) array_sum([$v1,$v2,$v3]), -1) >= 5, 
            'sum_small' => substr((string) array_sum([$v1,$v2,$v3]), -1) <= 4,
            'sum_odd'=> substr((string) array_sum([$v1,$v2,$v3]), -1) % 2 != 0,
            'sum_even' => substr((string) array_sum([$v1,$v2,$v3]), -1) % 2 == 0,
            'tail_big'=> substr((string) array_sum([$v1,$v2,$v3]), -1) >= 5, 
            'tail_small' => substr((string) array_sum([$v1,$v2,$v3]), -1) <= 4,
            'tail_prime'=> in_array(substr((string) array_sum([$v1,$v2,$v3]), -1),[1, 2, 3, 5, 7]), 
            'tail_composite' => in_array(substr((string) array_sum([$v1,$v2,$v3]), -1),[0, 4, 6, 8, 9]),
        ];
        return $data[$key];
    }

    # end of rules #

}