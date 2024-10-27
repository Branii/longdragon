<?php 

class Generators {

    
    #FiveD --------------
    public static function fived_no_ball_genertor(array $drawnumber, string $key){ // no balls
        $streakCount = 0;
        foreach ($drawnumber as $draw) {
            if ((new Fived_rules)->fived_no_ball($draw, $key)) {
                $streakCount++;
            } else {
                break;
            }
        }
        return $streakCount > 1 ? $streakCount : 0 ;
    }

    public static function fived_balls_generator(array $drawnumber, int $idx, string $key){  // only balls
        $streakCount = 0;
        foreach ($drawnumber as $draw) {
            if ((new Fived_rules)->fived_balls($draw, $idx, $key)) {
                $streakCount++;
            } else {
                break;
            }
        }
        return $streakCount > 1 ? $streakCount : 0 ;
    }

    #ThreeD --------------

    public static function threed_one_balls_generator(array $drawnumber, int $idx, string $key){  // only balls
        $streakCount = 0;
        foreach ($drawnumber as $draw) {
            if ((new Threed_rules)->threed_one_ball($draw, $idx, $key)) {
                $streakCount++;
            } else {
                break;
            }
        }
        return $streakCount > 1 ? $streakCount : 0 ;
    }

    public static function threed_two_balls_generator(array $drawnumber, int $idx1, int $idx2, string $key){  // only balls
        $streakCount = 0;
        foreach ($drawnumber as $draw) {
            if ((new Threed_rules)->threed_two_balls($draw, $idx1, $idx2,$key)) {
                $streakCount++;
            } else {
                break;
            }
        }
        return $streakCount > 1 ? $streakCount : 0 ;
    }

    public static function threed_three_balls_generator(array $drawnumber, int $idx1, int $idx2, int $idx3, string $key){  // only balls
        $streakCount = 0;
        foreach ($drawnumber as $draw) {
            if ((new Threed_rules)->threed_three_balls($draw, $idx1, $idx2, $idx3, $key)) {
                $streakCount++;
            } else {
                break;
            }
        }
        return $streakCount > 1 ? $streakCount : 0 ;
    }

    #Fast3 --------------

    public static function fast3_no_ball_generator(array $drawnumber, string $key){ // no ball
        $streakCount = 0;
        foreach ($drawnumber as $draw) {
            if ((new Fast3_rules)->fast3_big_x_small($draw, $key)) {
                $streakCount++;
            } else {
                break;
            }
        }
        return $streakCount > 1 ? $streakCount : 0 ;
    }

    #PK10 --------------

    public static function pk10_no_ball_generator(array $drawnumber, string $key){ // no ball
        $streakCount = 0;
        foreach ($drawnumber as $draw) {
            if ((new PK10_rules)->pk10_no_ball($draw, $key)) {
                $streakCount++;
            } else {
                break;
            }
        }
        return $streakCount > 1 ? $streakCount : 0 ;
    }

    public static function pk10_balls_generator(array $drawnumber, int $idx, int $vrs1, int $vrs2, string $key){ // only balls
        $streakCount = 0;
        foreach ($drawnumber as $draw) {
            if ((new PK10_rules)->pk10_balls($draw, $idx, $vrs1, $vrs2, $key)) {
                $streakCount++;
            } else {
                break;
            }
        }
        return $streakCount > 1 ? $streakCount : 0 ;
    }

    #Eleven5 --------------
    public static function eleven5_no_ball_genertor(array $drawnumber, string $key){ // no balls
        $streakCount = 0;
        foreach ($drawnumber as $draw) {
            if ((new Eleven5_rules)->eleven5_no_ball($draw, $key)) {
                $streakCount++;
            } else {
                break;
            }
        }
        return $streakCount > 1 ? $streakCount : 0 ;
    }

    public static function eleven5_balls_generator(array $drawnumber, int $idx, string $key){  // only balls
        $streakCount = 0;
        foreach ($drawnumber as $draw) {
            if ((new Eleven5_rules)->eleven5_balls($draw, $idx, $key)) {
                $streakCount++;
            } else {
                break;
            }
        }
        return $streakCount > 1 ? $streakCount : 0 ;
    }

    public static function happy8_no_ball_genertor(array $drawnumber, string $key){ // no balls
        $streakCount = 0;
        foreach ($drawnumber as $draw) {
            if ((new Happy8_rules)->happy8_no_ball($draw, $key)) {
                $streakCount++;
            } else {
                break;
            }
        }
        return $streakCount > 1 ? $streakCount : 0 ;
    }

}