<?php 

class Renderer { 

    private $fiveD;
    private $threeD;
    private $fast3;
    private $pk10;
    private $eleven5;
    private $happy8;
    
    public function __construct(){
            $this->fiveD = new Fived_controller();
            $this->threeD = new Threed_controller();
            $this->fast3 = new Fast3_controller();
            $this->pk10 = new PK10_controller();
            $this->eleven5 = new Eleven5_controller();
            $this->happy8 = new Happy8_controller();
    }
    public function render_5d(array $drawnumber) {
        return [
           // $this->fiveD->fived_with_no_balls($drawnumber), 
            $this->fiveD->fived_with_balls($drawnumber,0,133,138), 
            $this->fiveD->fived_with_balls($drawnumber,1,134,139), 
            $this->fiveD->fived_with_balls($drawnumber,2,135,140), 
            $this->fiveD->fived_with_balls($drawnumber,3,136,141), 
            $this->fiveD->fived_with_balls($drawnumber,4,137,142), 
        ];
    }

    public function render_3d(array $drawnumber) {
        return [
            $this->threeD->threed_with_one_ball($drawnumber,0,47,50, 53), 
            $this->threeD->threed_with_one_ball($drawnumber,1,48,51, 54), 
            $this->threeD->threed_with_one_ball($drawnumber,2,49,52, 55), 
            $this->threeD->threed_with_two_ball($drawnumber, 0, 1, 56, 59, 62),
            $this->threeD->threed_with_two_ball($drawnumber, 0, 2, 57, 60, 63),
            $this->threeD->threed_with_two_ball($drawnumber, 1, 2, 58, 61, 64),
            $this->threeD->threed_with_three_ball($drawnumber, 0, 1, 2, 65, 66, 67, 68)
        ];
    }

    public function render_fast3(array $drawnumber) {
        return [
            $this->fast3->fast3_sum_big_x_small($drawnumber, 46)
        ];
    }

    public function render_pk10(array $drawnumber) {
        return [
            //'sum' => $this->pk10->pk10_with_no_balls($drawnumber), 
            $this->pk10->pk10_with_balls($drawnumber,0, 0, 9, 23,33, 82), 
            $this->pk10->pk10_with_balls($drawnumber,1, 1, 8, 24,34, 83), 
            $this->pk10->pk10_with_balls($drawnumber,2, 2, 7, 25,35, 84), 
            $this->pk10->pk10_with_balls($drawnumber,3, 3, 6, 26,36, 85), 
            $this->pk10->pk10_with_balls($drawnumber,4, 4 ,5, 27,37, 86), 
            $this->pk10->pk10_with_balls_to_10($drawnumber,5, 28,38), 
            $this->pk10->pk10_with_balls_to_10($drawnumber,6, 29,39), 
            $this->pk10->pk10_with_balls_to_10($drawnumber,7, 30,40), 
            $this->pk10->pk10_with_balls_to_10($drawnumber,8, 31,41), 
            $this->pk10->pk10_with_balls_to_10($drawnumber,9, 32,42), 
        ];
    }

    public function render_eleven5(array $drawnumber) {
        return [
            //$this->eleven5->eleven5_with_no_balls($drawnumber), 
            $this->eleven5->eleven5_with_balls($drawnumber,0, 69, 74), 
            $this->eleven5->eleven5_with_balls($drawnumber,1, 70, 75), 
            $this->eleven5->eleven5_with_balls($drawnumber,2, 71, 76), 
            $this->eleven5->eleven5_with_balls($drawnumber,3, 72, 77), 
            $this->eleven5->eleven5_with_balls($drawnumber,4, 73, 78), 
        ];
    }
    public function render_happy8(array $drawnumber) {
        return [
            $this->happy8->happy8_with_no_balls($drawnumber, 87, 88 , 89 ,90)
        ];
    }

}