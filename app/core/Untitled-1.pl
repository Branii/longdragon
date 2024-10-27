<?php

error_reporting(1);


class longdragon
{
    private static  $lotteryid;

    public function __construct($lotteryid)
    {
        self::$lotteryid = $lotteryid;
    }


    // get 5d balls 
    public static function get5dBall($drawNumber, $gameid): mixed
    {
        $number = null; // Default to null or another sensible default
        switch ($gameid) {
            case 133:
            case 138:
                $number = $drawNumber[0];
                break;
            case 134:
            case 139:
                $number = $drawNumber[1];
                break;
            case 135:
            case 140:
                $number = $drawNumber[2];
                break;
            case 136:
            case 141:
                $number = $drawNumber[3];
                break;
            case 137:
            case 142:
                $number = $drawNumber[4];
                break;
            default:
                // Optionally handle unexpected gameid values
                break;
        }
        return $number;
    }
    // compare draw numbers
    public static function compareDrawNumbers($drawNumber1, $drawNumber2, $gameIds)
    {
        $result = [];
        $outcomes = [];
        // Iterate through each of the first 5 balls since there are 5 pairs of checks: "Big/Small" and "Odd/Even".
        foreach ($gameIds as $gameid) {
            $ball1 = self::get5dBall($drawNumber1, $gameid);
            $ball2 = self::get5dBall($drawNumber2, $gameid);
            $ball1Category = $ball2Category = 'Undefined'; // Initialize with a default value

            if ($gameid >= 133 && $gameid <= 137) {
                $ball1Category = $ball1 > 5 ? 'Big' : ($ball1 === 11 ? 'Tie' : 'Small');
                $ball2Category = $ball2 > 5 ? 'Big' : ($ball2 === 11 ? 'Tie' : 'Small');
            } else if ($gameid >= 138 && $gameid <= 142) {
                $ball1Category = $ball1 % 2 == 0 ? 'Even' : ($ball1 === 11 ? 'Tie' : 'Odd');
                $ball2Category = $ball2 % 2 == 0 ? 'Even' : ($ball2 === 11 ? 'Tie' : 'Odd');
            }

            if ($ball1Category === $ball2Category) {
                $result[] = $gameid;
                $outcomes[] = $ball1Category;
            }
        }
        $filter = array_filter($result, function ($value) {
            return $value !== null;
        });

        return [$filter, $outcomes];
    }




    // 
    // fast3 Sum of big small cppmpparism
    public static function comparefast3SumBigSmall($drawNumber1, $drawNumber2, $gameIds): array
    {
        // 2.B/S SumB/S Sum: Sum of ≥ 11 as "Big"; ≤ 10 as "Small." 3 No. same, as not win.  rules 
        $result = [];
        $outcome = [];
        $sum1 = array_sum($drawNumber1);
        $sum2 = array_sum($drawNumber2);
        $sum1Category = $sum1 >= 11 ? 'Big' : 'Small';
        $sum2Category = $sum2 >= 11 ? 'Big' : 'Small';
        // check if the draw numbers are the same

        // for ($i = 0; $i < count($gameIds); $i++) {
        //     if ($sum1Category === $sum2Category) {
        //         $result[] = $gameIds[$i];
        //         $outcome []= $sum1Category;
        //     }
        // }

        foreach ($gameIds as $gameid) {
            if ($gameid === 46) {
                if ($sum1Category === $sum2Category) {
                    $result[] = $gameid;
                    $outcome[] = $sum1Category;
                }
            }
        }
        $filter = array_filter($result, function ($value) {
            return $value !== null;
        });
        return  [$filter, $outcome];
    }


    // big small oddd even elleven Draw number element 

    public static function geteleven5Ball($drawNumber, $gameid): mixed
    {
        switch ($gameid) {
            case 69:
            case 74:
                $number = $drawNumber[0];
                break;

            case 70:
            case 75:
                $number = $drawNumber[1];
                break;

            case 71:
            case 76:
                $number = $drawNumber[2];
                break;

            case 72:
            case 77:
                $number = $drawNumber[3];
                break;

            case 73:
            case 78:
                $number = $drawNumber[4];
                break;
        }
        return $number;
    }



    // compare big small eleven5  
    public static function compareBigSmalleleven5($drawNumber1, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];
        // B/S: Winning No. > 6 as "B"; ≤ 5 as "S"; 11 as Tie (Refund).
        // O/E: winning No. units digit at 1, 3, 5, 7, 9 as "O"; 0, 2, 4, 6, 8 as "E";11 as Tie (Refund).
        // id from  69 to 73 is for big small 1st 2nd 3rd 4th 5th  and 74 to 78 is for odd even 1st 2nd 3rd 4th 5th
        foreach ($gameIds as $gameid) {
            $ball1 = self::geteleven5Ball($drawNumber1, $gameid);
            $ball2 = self::geteleven5Ball($drawNumber2, $gameid);
            if ($gameid >= 69 && $gameid <= 73) {
                $ball1Category = $ball1 > 5 ? 'Big' : ($ball1 === 11 ? 'Tie' : 'Small');
                $ball2Category = $ball2 > 5 ? 'Big' : ($ball2 === 11 ? 'Tie' : 'Small');
            }
            if ($gameid >= 74 && $gameid <= 78) {
                $ball1Category = $ball1 % 2 == 0 ? 'Even' : ($ball1 === 11 ? 'Tie' : 'Odd');
                $ball2Category = $ball2 % 2 == 0 ? 'Even' : ($ball2 === 11 ? 'Tie' : 'Odd');
            }
            if ($ball1Category === $ball2Category) {
                $result[] = $gameid;
                $outcomes[] = $ball1Category;
            }
        }
        return [$result, $outcomes];
    }

    // compare eleven5  sum  big small odd even dragon tiger 
    public static function compareEleven5Sumbsoedt($drawNumber1, $drawNumber2, $gameIds): array
    {
        //         1.Sum
        // Sum B/S: Sum of winning No. > 30 as Big, < 30 as Small, 30 as Tie; refund.
        // Sum O/E : Sum of winning No. Units digit at 1, 3, 5, 7, 9 as Odd; ended with 0, 2, 4, 6, 8 as Even.
        // Sum of Tails: Sum of winning No. Units digit ≥ 5 as Big; ≤ 4 as Even.
        // D/T：1st winning No. > 5th winning No. (0 smallest, 9 biggest) as D, or else T.
        // bs id  =79 oe id =80 dt id =81
        $result = [];
        $outcomes = [];
        $sum1 = array_sum($drawNumber1);
        $sum2 = array_sum($drawNumber2);
        $sum1Category = $sum1 > 30 ? 'Big' : ($sum1 === 30 ? 'Tie' : 'Small');
        $sum2Category = $sum2 > 30 ? 'Big' : ($sum2 === 30 ? 'Tie' : 'Small');
        $sum1Oe = $sum1 % 2 == 0 ? 'Even' : 'Odd';
        $sum2Oe = $sum2 % 2 == 0 ? 'Even' : 'Odd';
        // $sum1Tail = $sum1 % 10 >= 5 ? 'Big' : 'Even';
        // $sum2Tail = $sum2 % 10 >= 5 ? 'Big' : 'Even';
        $dt1 = $drawNumber1[0] > $drawNumber1[4] ? 'Dragon' : 'Tiger';
        $dt2 = $drawNumber2[0] > $drawNumber2[4] ? 'Dragon' : 'Tiger';
        for ($i = 0; $i < count($gameIds); $i++) {
            if ($gameIds[$i] === 79) {
                if ($sum1Category === $sum2Category) {
                    // adding the actual outcome to the result
                    $result[] = $gameIds[$i];
                    $outcomes[] = $sum1Category;
                }
            }
            if ($gameIds[$i] === 80) {
                if ($sum1Oe === $sum2Oe) {
                    $result[] = $gameIds[$i];
                    $outcomes[] = $sum1Oe;
                }
            }
            if ($gameIds[$i] === 81) {
                if ($dt1 === $dt2) {
                    $result[] = $gameIds[$i];
                    $outcomes[] = $dt1;
                }
            }
        }
        return [$result, $outcomes];
    }

    // compare dragon tiger 

    public static function compareDragonTiger($drawNumber, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];
        for ($i = 0; $i < count($gameIds); $i++) {
            $gameId = $gameIds[$i];
            $res = self::drawcombinator($gameId, $drawNumber);
            $res2 = self::drawcombinator($gameId, $drawNumber2);
            $dragonTiger1 = $res[0] > $res[1] ? 'Dragon' : ($res[0] === $res[1] ? 'Tie' : 'Tiger');
            $dragonTiger2 = $res2[0] > $res2[1] ? 'Dragon' : ($res2[0] === $res2[1] ? 'Tie' : 'Tiger');
            if ($dragonTiger1 === 'Tie' && $dragonTiger2 === 'Tie') {
                // If both are 'Tiger', skip this game ID and continue to the next iteration
                continue;
            }
            if ($dragonTiger1 === $dragonTiger2) {
                $result[] = $gameId;
                $outcomes[] = $dragonTiger1;
            }
        }
        return [$result, $outcomes];
    }






    public static function drawcombinator($gameid, $drawnumber): array
    {
        switch ($gameid) {

            case 11:
                $newdraw  = array_slice($drawnumber, 0, 2);
                break;
            case 12:
                $newdraw  = [$drawnumber[0], $drawnumber[2]];
                break;
            case 13:
                $newdraw  = [$drawnumber[0], $drawnumber[3]];
                break;
            case 143:
                $newdraw  = [$drawnumber[0], $drawnumber[4]];
                break;
            case 15:
                $newdraw  = [$drawnumber[1], $drawnumber[2]];
                break;
            case 16:
                $newdraw  = [$drawnumber[1], $drawnumber[3]];
                break;
            case 17:
                $newdraw  = [$drawnumber[1], $drawnumber[4]];
                break;
            case 18:
                $newdraw  = [$drawnumber[2], $drawnumber[3]];
                break;
            case 19:
                $newdraw  = [$drawnumber[2], $drawnumber[4]];
                break;
            case 20:
                $newdraw  = [$drawnumber[3], $drawnumber[4]];
                break;
        }
        return $newdraw;
    }
    // ***************************************************************Consegetive pairs********************************************************************************************************************


    // getting consecutive pairs
    public static function fiveDConsecutivePairs($gameIds, $drawNumberList): array
    {
        $consecutiveStreaks = [];
        $drawCount = count($drawNumberList);
        $gameIdCounts = array_fill_keys($gameIds, 1); // Initialize counters with default value 1
        $gameIdStreaks = array_fill_keys($gameIds, 0);
        $bscategory = [133, 134, 135, 136, 137];
        $oecategory = [138, 139, 140, 141, 142];
        $dtcategory = [143];

        for ($i = 0; $i < $drawCount - 1; $i++) {
            // print_r($drawNumberList);
            $drawNumber = $drawNumberList[$i];
            $drawNumber2 = $drawNumberList[$i + 1];
            $matchingGameIds = null;
            // $matchingGameIds = compareDragonTiger($drawNumber, $drawNumber2, $gameIds);
            if (!array_diff($gameIds, $dtcategory)) {
                $matchingGameIds = self::compareDragonTiger($drawNumber, $drawNumber2, $gameIds)[0];
            } elseif (!array_diff($gameIds, $bscategory) || !array_diff($gameIds, $oecategory)) {
                $matchingGameIds = self::compareDrawNumbers($drawNumber, $drawNumber2, $gameIds)[0];
            }
            // After the first iteration, use the new matching game IDs as the current game IDs
            $gameIds = $matchingGameIds;
            // echo '<pre>-------------------------------';
            // Consecutive occurrence, update streak
            if ($i == 0) {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            } else {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            }
            // Update game ID counts and streaks
            foreach ($matchingGameIds as $gameId) {
                $gameIdCounts[$gameId]++;
                $gameIdStreaks[$gameId]++;
            }
        }
        return array_count_values($consecutiveStreaks);
    }





    // fast 3 comsecutive pairs

    public static function fast3ConsecutivePairs($gameIds, $drawNumberList): array
    {

        $consecutiveStreaks = [];
        $drawCount = count($drawNumberList);
        $gameIdCounts = array_fill_keys($gameIds, 1); // Initialize counters with default value 1
        $gameIdStreaks = array_fill_keys($gameIds, 0);
        $Sumbscategory = [46];
        for ($i = 0; $i < $drawCount - 1; $i++) {
            $drawNumber = $drawNumberList[$i];
            $drawNumber2 = $drawNumberList[$i + 1];
            $matchingGameIds = null;
            if (!array_diff($gameIds, $Sumbscategory)) {
                $matchingGameIds = self::comparefast3SumBigSmall($drawNumber, $drawNumber2, $gameIds)[0];
            }
            // After the first iteration, use the new matching game IDs as the current game IDs
            $gameIds = $matchingGameIds;
            // Consecutive occurrence, update streak
            if ($i == 0) {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            } else {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            }
            // Update game ID counts and streaks
            foreach ($matchingGameIds as $gameId) {
                $gameIdCounts[$gameId]++;
                $gameIdStreaks[$gameId]++;
            }
        }
        return array_count_values($consecutiveStreaks);
    }



    // eleven5 consecutive pairs


    public static function eleven5ConsecutivePairs($gameIds, $drawNumberList): array
    {
        $consecutiveStreaks = [];
        $drawCount = count($drawNumberList);
        $gameIdCounts = array_fill_keys($gameIds, 1); // Initialize counters with default value 1
        $gameIdStreaks = array_fill_keys($gameIds, 0);
        $bscategory = [69, 70, 71, 72, 73];
        $oecategory = [74, 75, 76, 77, 78];
        $sumbs = [79];
        $sumoe = [80];
        $sumdt = [81];
        for ($i = 0; $i < $drawCount - 1; $i++) {
            $drawNumber = $drawNumberList[$i];
            $drawNumber2 = $drawNumberList[$i + 1];
            $matchingGameIds = null;

            if (!array_diff($gameIds, $bscategory) || !array_diff($gameIds, $oecategory)) {

                $matchingGameIds = self::compareBigSmalleleven5($drawNumber, $drawNumber2, $gameIds)[0];
            }
            if (!array_diff($gameIds, $sumbs) || !array_diff($gameIds, $sumoe) || !array_diff($gameIds, $sumdt)) {
                $matchingGameIds = self::compareEleven5Sumbsoedt($drawNumber, $drawNumber2, $gameIds)[0];
            }
            // After the first iteration, use the new matching game IDs as the current game IDs
            $gameIds = $matchingGameIds;
            // Consecutive occurrence, update streak
            if ($i == 0) {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            } else {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            }
            // Update game ID counts and streaks
            foreach ($matchingGameIds as $gameId) {
                $gameIdCounts[$gameId]++;
                $gameIdStreaks[$gameId]++;
            }
        }
        return array_count_values($consecutiveStreaks);
    }





    // *************************PK10****************************************************************************

    // pk10balls 
    public static function getpk10Ball($drawNumber, $gameid): mixed
    {
        switch ($gameid) {
            case 23:
            case 33:
                $number = $drawNumber[0];
                break;
            case 24:
            case 34:
                $number = $drawNumber[1];
                break;
            case 25:
            case 35:
                $number = $drawNumber[2];
                break;
            case 26:
            case 36:
                $number = $drawNumber[3];
                break;
            case 27:
            case 37:
                $number = $drawNumber[4];
                break;
            case 28:
            case 38:
                $number = $drawNumber[5];
                break;
            case 29:
            case 39:
                $number = $drawNumber[6];
                break;
            case 30:
            case 40:
                $number = $drawNumber[7];
                break;
            case 31:
            case 41:
                $number = $drawNumber[8];
                break;
            case 32:
            case 42:
                $number = $drawNumber[9];
                break;
        }
        return $number;
    }


    // pk10bsoe

    public static function pk10bsoe($drawNumber1, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];
        foreach ($gameIds as $gameid) {
            $ball1 = self::getpk10Ball($drawNumber1, $gameid);
            $ball2 = self::getpk10Ball($drawNumber2, $gameid);
            if ($gameid >= 23 && $gameid <= 32) {
                $ball1Category = $ball1 > 5 ? 'Big' : ($ball1 === 11 ? 'Tie' : 'Small');
                $ball2Category = $ball2 > 5 ? 'Big' : ($ball2 === 11 ? 'Tie' : 'Small');
            }
            if ($gameid >= 33 && $gameid <= 42) {
                $ball1Category = $ball1 % 2 == 0 ? 'Even' : ($ball1 === 11 ? 'Tie' : 'Odd');
                $ball2Category = $ball2 % 2 == 0 ? 'Even' : ($ball2 === 11 ? 'Tie' : 'Odd');
            }
            if ($ball1Category === $ball2Category) {
                $result[] = $gameid;
                $outcomes[] = $ball1Category;
            }
        }
        return [$result, $outcomes];
    }

    // pk10 sumofTop

    public static function pk10sumtoptwo($drawNumber1, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];
        $sum1 = $drawNumber1[0] + $drawNumber1[1];
        $sum2 = $drawNumber2[0] + $drawNumber2[1];
        // Sum of Top 2 B/S: Sum of Top 2 winning No. >11 as "Big"; ≤11 as "Small."
        // Sum of Top 2 O/E: Sum of Top 2 winning No. unit digit at 1, 3, 5, 7, 9 as "Big"; 0, 2, 4, 6, 8 as "Small."

        $sum1Category = $sum1 > 11 ? 'Big' : 'Small';
        $sum2Category = $sum2 > 11 ? 'Big' : 'Small';
        $sum1Oe = $sum1 % 2 == 0 ? 'Even' : 'Odd';
        $sum2Oe = $sum2 % 2 == 0 ? 'Even' : 'Odd';
        for ($i = 0; $i < count($gameIds); $i++) {
            if ($gameIds[$i] === 43) {
                if ($sum1Category === $sum2Category) {
                    $result[] = $gameIds[$i];
                    $outcomes[] = $sum1Category;
                }
            }
            if ($gameIds[$i] === 44) {
                if ($sum1Oe === $sum2Oe) {
                    $result[] = $gameIds[$i];
                    $outcomes[] = $sum1Oe;
                }
            }
        }
        return [$result, $outcomes];
    }

    // pk10 dtcombinator 
    //     1st Dragon/Tiger: 1st vs 10th compete;
    // 2nd Dragon/Tiger: 2nd vs 9th compete;
    // 3rd Dragon/Tiger: 3rd vs 8th compete;
    // 4th Dragon/Tiger: 4th vs 7th compete;
    // 5th Dragon/Tiger: 5th vs 6th compete.
    public static function  pk10dtcombinator($gameid, $drawnumber): array
    {
        switch ($gameid) {
            case 82:
                $newdraw = [$drawnumber[0], $drawnumber[9]];
                break;
            case 83:
                $newdraw = [$drawnumber[1], $drawnumber[8]];
                break;
            case 84:
                $newdraw = [$drawnumber[2], $drawnumber[7]];
                break;
            case 85:
                $newdraw = [$drawnumber[3], $drawnumber[6]];
                break;
            case 86:
                $newdraw = [$drawnumber[4], $drawnumber[5]];
                break;
        }
        return $newdraw;
    }


    public static function pk10dt($drawNumber, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];

        foreach ($gameIds as $gameid) {
            $res = self::pk10dtcombinator($gameid, $drawNumber);
            $res2 = self::pk10dtcombinator($gameid, $drawNumber2);
            $dragonTiger1 = $res[0] > $res[1] ? 'Dragon' : ($res[0] === $res[1] ? 'Tie' : 'Tiger');
            $dragonTiger2 = $res2[0] > $res2[1] ? 'Dragon' : ($res2[0] === $res2[1] ? 'Tie' : 'Tiger');
            if ($dragonTiger1 === 'Tie' && $dragonTiger2 === 'Tie') {
                // If both are 'Tiger', skip this game ID and continue to the next iteration
                continue;
            }
            if ($dragonTiger1 === $dragonTiger2) {
                $result[] = $gameid;
                $outcomes[] = $dragonTiger1;
            }
        }
        return [$result, $outcomes];
    }




    public static function pk10ConsecutivePairs($gameIds, $drawNumberList): array
    {
        $consecutiveStreaks = [];
        $drawCount = count($drawNumberList);
        $gameIdCounts = array_fill_keys($gameIds, 1); // Initialize counters with default value 1
        $gameIdStreaks = array_fill_keys($gameIds, 0);
        $pkbscategory = [23, 24, 25, 26, 27, 28, 29, 30, 31, 32];
        $pkoecategory = [33, 34, 35, 36, 37, 38, 39, 40, 41, 42];
        $pksumtop2 = [43, 44];
        $pkdragonTiger = [82, 83, 84, 85, 86];
        for ($i = 0; $i < $drawCount - 1; $i++) {
            $drawNumber = $drawNumberList[$i];
            $drawNumber2 = $drawNumberList[$i + 1];
            $matchingGameIds = null;
            if (!array_diff($gameIds, $pkbscategory) || !array_diff($gameIds, $pkoecategory)) {
                $matchingGameIds = self::pk10bsoe($drawNumber, $drawNumber2, $gameIds)[0];
            }
            if (!array_diff($gameIds, $pksumtop2)) {
                $matchingGameIds = self::pk10sumtoptwo($drawNumber, $drawNumber2, $gameIds)[0];
            }
            if (!array_diff($gameIds, $pkdragonTiger)) {
                $matchingGameIds = self::pk10dt($drawNumber, $drawNumber2, $gameIds)[0];
            }
            // After the first iteration, use the new matching game IDs as the current game IDs
            $gameIds = $matchingGameIds;
            // Consecutive occurrence, update streak
            if ($i == 0) {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            } else {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            }
            // Update game ID counts and streaks
            foreach ($matchingGameIds as $gameId) {
                $gameIdCounts[$gameId]++;
                $gameIdStreaks[$gameId]++;
            }
        }
        return array_count_values($consecutiveStreaks);
    }

    //  **************************pk10 ends here****************************************************************



    // *************************** 3D ***************************************

    public static function threeDConsecutivePairs($gameIds, $drawNumberList): array
    {
        $consecutiveStreaks = [];
        $drawCount = count($drawNumberList);
        $gameIdCounts = array_fill_keys($gameIds, 1); // Initialize counters with default value 1
        $gameIdStreaks = array_fill_keys($gameIds, 0);
        // [[47, 48, 49], [50, 51, 52], [53, 54, 55], [56, 57, 58], [59, 60, 61], [62, 63, 64], [65], [66], [67], [68]];
        $threedbsoepc = [47, 48, 49, 50, 51, 52, 53, 54, 55];
        $sumoe = [56, 57, 58];
        $bstailsum = [59, 60, 61];
        $pctailsum = [62, 63, 64];



        for ($i = 0; $i < $drawCount - 1; $i++) {
            $drawNumber = $drawNumberList[$i];
            $drawNumber2 = $drawNumberList[$i + 1];
            $matchingGameIds = null;
            // echo json_encode(array_diff([47], $threedbsoepc));
            // exit;
            if (!array_diff($gameIds, $threedbsoepc)) {
                $matchingGameIds = self::threeDbsoepc($drawNumber, $drawNumber2, $gameIds)[0];
            }
            if (!array_diff($gameIds, $sumoe)) {

                $matchingGameIds = self::sumof3d($drawNumber, $drawNumber2, $gameIds)[0];
            }
            if (!array_diff($gameIds, $bstailsum)) {

                $matchingGameIds = self::sumof3d($drawNumber, $drawNumber2, $gameIds)[0];
            }

            if (!array_diff($gameIds, $pctailsum)) {

                $matchingGameIds = self::sumof3d($drawNumber, $drawNumber2, $gameIds)[0];
            }
            // if (!array_diff($gameIds, $pkdragonTiger)) {
            //     $matchingGameIds = self::pk10dt($drawNumber, $drawNumber2, $gameIds)[0];
            // }
            // After the first iteration, use the new matching game IDs as the current game IDs
            $gameIds = $matchingGameIds;
            // Consecutive occurrence, update streak
            if ($i == 0) {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            } else {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            }
            // Update game ID counts and streaks
            foreach ($matchingGameIds as $gameId) {
                $gameIdCounts[$gameId]++;
                $gameIdStreaks[$gameId]++;
            }
        }


        // var_dump(array_count_values($consecutiveStreaks));

        return array_count_values($consecutiveStreaks);
    }


    public static function  threeDbsoepc($drawNumber1, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];
        foreach ($gameIds as $gameid) {

            $ball1 = self::threedBall($drawNumber1, $gameid);
            $ball2 = self::threedBall($drawNumber2, $gameid);
            if ($gameid >= 47 && $gameid <= 49) {
                $ball1Category = $ball1 > 5 ? 'Big' : 'Small';
                $ball2Category = $ball2 > 5 ? 'Big' : 'Small';
            }
            if ($gameid >= 50 && $gameid <= 52) {
                $ball1Category = $ball1 % 2 == 0 ? 'Even' :  'Odd';
                $ball2Category = $ball2 % 2 == 0 ? 'Even' :  'Odd';
            }

            if ($gameid >= 53 && $gameid <= 55) {
                // P/C: Winning No. at 1, 2, 3, 5, 7 as "P"; 0, 4, 6, 8, 9 as "C."
                $dtaaset = [1, 2, 3, 5, 7];
                $ball1Category = in_array($ball1, $dtaaset) == 0 ? 'Prime' :  'Composite';
                $ball2Category = in_array($ball2, $dtaaset) == 0 ? 'Prime' :  'Composite';
            }
            if ($ball1Category === $ball2Category) {
                $result[] = $gameid;
                $outcomes[] = $ball1Category;
            }
        }

        return [$result, $outcomes];
    }


    // sum of thress d
    public static function sumof3d($drawNumber1, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];
        foreach ($gameIds as $gameid) {


            if ($gameid == 56) {
                $bsum1 = array_sum([$drawNumber1[0], $drawNumber1[1]]);
                $bsum2 = array_sum([$drawNumber2[0], $drawNumber2[1]]);
                $ball1Category = $bsum1 % 2 == 0 ? 'Even' :  'Odd';
                $ball2Category =  $bsum2 % 2 == 0 ? 'Even' :  'Odd';
            }

            if ($gameid == 57) {
                $bsum1 = array_sum([$drawNumber1[0], $drawNumber1[2]]);
                $bsum2 = array_sum([$drawNumber2[0], $drawNumber2[2]]);
                $ball1Category = $bsum1 % 2 == 0 ? 'Even' :  'Odd';
                $ball2Category =  $bsum2 % 2 == 0 ? 'Even' :  'Odd';
            }

            if ($gameid == 58) {
                $bsum1 = array_sum([$drawNumber1[1], $drawNumber1[2]]);
                $bsum2 = array_sum([$drawNumber2[1], $drawNumber2[2]]);
                $ball1Category = $bsum1 % 2 == 0 ? 'Even' :  'Odd';
                $ball2Category =  $bsum2 % 2 == 0 ? 'Even' :  'Odd';
            }

            if ($gameid == 59) {
                $bsum1 = array_sum([$drawNumber1[0], $drawNumber1[1]]);
                $bsum2 = array_sum([$drawNumber2[0], $drawNumber2[1]]);
                // Tail sum B/S: Sum of 3 No. unit digit ≥ 5 as "Tail sum B"; ≤ 4 as "Tail sum S."
                //  Tail sum P/C: Sum of 3 No. unit digit at 1, 2, 3, 5, 7 as "Tail sum P"; 0, 4, 6, 8, 9 as "Tail sum C."
                $ball1Category = $bsum1  >= 5 ? 'Big' :  'Small';
                $ball2Category =  $bsum2 >= 5 ? 'Big' :  'Small';
            }
            if ($gameid == 60) {
                $bsum1 = array_sum([$drawNumber1[0], $drawNumber1[2]]);
                $bsum2 = array_sum([$drawNumber2[0], $drawNumber2[2]]);
                // Tail sum B/S: Sum of 3 No. unit digit ≥ 5 as "Tail sum B"; ≤ 4 as "Tail sum S."
                //  Tail sum P/C: Sum of 3 No. unit digit at 1, 2, 3, 5, 7 as "Tail sum P"; 0, 4, 6, 8, 9 as "Tail sum C."
                $ball1Category = $bsum1  >= 5 ? 'Big' :  'Small';
                $ball2Category =  $bsum2 >= 5 ? 'Big' :  'Small';
            }

            if ($gameid == 61) {
                $bsum1 = array_sum([$drawNumber1[1], $drawNumber1[2]]);
                $bsum2 = array_sum([$drawNumber2[1], $drawNumber2[2]]);
                // Tail sum B/S: Sum of 3 No. unit digit ≥ 5 as "Tail sum B"; ≤ 4 as "Tail sum S."
                //  Tail sum P/C: Sum of 3 No. unit digit at 1, 2, 3, 5, 7 as "Tail sum P"; 0, 4, 6, 8, 9 as "Tail sum C."
                $ball1Category = $bsum1  >= 5 ? 'Big' :  'Small';
                $ball2Category =  $bsum2 >= 5 ? 'Big' :  'Small';
            }

            // if ($gameid == 62) {
            //     $bsum1 = array_sum([$drawNumber1[1], $drawNumber1[2]]);
            //     $bsum2 = array_sum([$drawNumber2[1], $drawNumber2[2]]);
            //     // Tail sum B/S: Sum of 3 No. unit digit ≥ 5 as "Tail sum B"; ≤ 4 as "Tail sum S."
            //     //  Tail sum P/C: Sum of 3 No. unit digit at 1, 2, 3, 5, 7 as "Tail sum P"; 0, 4, 6, 8, 9 as "Tail sum C."
            //     $ball1Category = $bsum1  >= 5 ? 'Big' :  'Small';
            //     $ball2Category =  $bsum2 >= 5 ? 'Big' :  'Small';
            // }

            if ($gameid == 62) {
                $bsum1 = array_sum([$drawNumber1[0], $drawNumber1[1]]);
                $bsum2 = array_sum([$drawNumber2[0], $drawNumber2[1]]);
                $ball1Category =  self::primeComposite($bsum1);
                $ball2Category = self::primeComposite($bsum2);
            }


            if ($gameid == 63) {
                $bsum1 = array_sum([$drawNumber1[0], $drawNumber1[2]]);
                $bsum2 = array_sum([$drawNumber2[0], $drawNumber2[2]]);
                $ball1Category =  self::primeComposite($bsum1);
                $ball2Category = self::primeComposite($bsum2);
            }

            if ($gameid == 64) {
                $bsum1 = array_sum([$drawNumber1[1], $drawNumber1[2]]);
                $bsum2 = array_sum([$drawNumber2[1], $drawNumber2[2]]);
                $ball1Category =  self::primeComposite($bsum1);
                $ball2Category = self::primeComposite($bsum2);
            }


            if ($ball1Category === $ball2Category) {
                $result[] = $gameid;
                $outcomes[] = $ball1Category;
            }
        }

        return [$result, $outcomes];
    }



    public static  function primeComposite($number)
    {

        // Define which last digits belong to each category
        $tailSumPDigits = [1, 2, 3, 5, 7];
        $tailSumCDigits = [0, 4, 6, 8, 9];
        $lastDigit = $number % 10;
        if (in_array($lastDigit, $tailSumPDigits)) {
            return 'Prime';
        } elseif (in_array($lastDigit, $tailSumCDigits)) {
            return 'Composite';
        }
    }


    // get3d  Ball
    public static function threedBall($drawNumber, $gameId): mixed

    {
        switch ($gameId) {
            case 47:
            case 50:
            case 53:

                $number = $drawNumber[0];
                break;
            case 48:
            case 51:
            case 54:
                $number = $drawNumber[1];
                break;
            case 49:
            case 52:
            case 55:
                $number = $drawNumber[2];
                break;
        }

        return $number;
    }

    // *********************************3D*****************************************************************



    // mark6************************************************************************************************




    //****************************************mark6 End */



    //  ********************************Happy 8 ****************************************************************

    public static function happy8($drawNumber1, $drawNumber2, $gameIds): mixed
    {

        $result = [];
        $outcomes = [];
        foreach ($gameIds as $gameid) {


            if ($gameid == 87) {
                $bsum1 = array_sum($drawNumber1);
                $bsum2 = array_sum($drawNumber2);
                $ball1Category =  $bsum1 > 810 ? 'Big' : ($bsum1  === 810 ? 'Tie' : 'Small');
                $ball2Category =  $bsum2 > 810 ? 'Big' : ($bsum2  === 810 ? 'Tie' : 'Small');
            }

            if ($gameid == 88) {
                $bsum1 = array_sum($drawNumber1);
                $bsum2 = array_sum($drawNumber2);
                $ball1Category = $bsum1 % 2 == 0 ? 'Even' :  'Odd';
                $ball2Category =  $bsum2 % 2 == 0 ? 'Even' :  'Odd';
            }

            if ($gameid == 89) {
                // $bsum1 = array_sum($drawNumber1);
                // $bsum2 = array_sum($drawNumber2);
                $ball1Category = self::moreFirstLast($drawNumber1);
                $ball2Category =  self::moreFirstLast($drawNumber2);
            }

            if ($gameid == 90) {
                // $bsum1 = array_sum($drawNumber1);
                // $bsum2 = array_sum($drawNumber2);
                $ball1Category = self::moreoddeven($drawNumber1);
                $ball2Category =  self::moreoddeven($drawNumber2);
            }

            if ($ball1Category === $ball2Category) {
                $result[] = $gameid;
                $outcomes[] = $ball1Category;
            }
        }

        return [$result, $outcomes];
    }





    // functo to check more ODD even 

    public static function moreoddeven($drawnumber): mixed
    {

        $oddCount = 0;
        $evenCount = 0;

        foreach ($drawnumber as $number) {
            // Get the unit digit of the winning number
            $unitDigit = $number % 10;

            // Check if the unit digit is odd or even
            if ($unitDigit % 2 == 0) {
                // Even unit digit
                $evenCount++;
            } else {
                // Odd unit digit
                $oddCount++;
            }
        }

        // Compare the counts to determine the outcome
        $outcome = $oddCount > $evenCount ? 'Odd' : 'Even';
        if ($oddCount == $evenCount) {
            $outcome = 'tie';
        }

        return $outcome;
    }



    // function to check more first/ast 

    public static function moreFirstLast($drawNumber): string
    {
        $sumMoreFirst = 0;
        $sumMoreLast = 0;

        foreach ($drawNumber as $number) {
            if ($number >= 1 && $number <= 40) {
                // Number is in the range 01-40 (classified as "First")
                $sumMoreFirst += $number;
            } elseif ($number >= 41 && $number <= 80) {
                // Number is in the range 41-80 (classified as "Last")
                $sumMoreLast += $number;
            }
        }

        // Determine the outcome based on the sum of More First and More Last
        $outcome = $sumMoreFirst > $sumMoreLast ? 'First' : 'Last';
        if ($sumMoreFirst == $sumMoreLast) {
            $outcome = 'tie';
        }

        return $outcome;
    }





    // Happy8   consegutive pairs

    public static function happy8ConsecutivePairs($gameIds, $drawNumberList): array
    {
        $consecutiveStreaks = [];
        $drawCount = count($drawNumberList);
        $gameIdCounts = array_fill_keys($gameIds, 1); // Initialize counters with default value 1
        $gameIdStreaks = array_fill_keys($gameIds, 0);
        // [[47, 48, 49], [50, 51, 52], [53, 54, 55], [56, 57, 58], [59, 60, 61], [62, 63, 64], [65], [66], [67], [68]];

        $happyeightsum = [87, 88, 89, 90,];



        for ($i = 0; $i < $drawCount - 1; $i++) {
            $drawNumber = $drawNumberList[$i];
            $drawNumber2 = $drawNumberList[$i + 1];
            $matchingGameIds = null;
            // echo json_encode(array_diff([47], $threedbsoepc));
            // exit;
            if (!array_diff($gameIds, $happyeightsum)) {
                $matchingGameIds = self::happy8($drawNumber, $drawNumber2, $gameIds)[0];
            }
            // After the first iteration, use the new matching game IDs as the current game IDs
            $gameIds = $matchingGameIds;
            // Consecutive occurrence, update streak
            if ($i == 0) {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            } else {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            }
            // Update game ID counts and streaks
            foreach ($matchingGameIds as $gameId) {
                $gameIdCounts[$gameId]++;
                $gameIdStreaks[$gameId]++;
            }
        }
        // var_dump(array_count_values($consecutiveStreaks));

        return array_count_values($consecutiveStreaks);
    }



    //  ********************************Happy 8 ****************************************************************





    // ******************* Mark6 ******************************************************************

    public static function ExtraNUmber($drawNumber1, $drawNumber2, $gameIds): mixed
    {

        $result = [];
        $outcomes = [];
        foreach ($gameIds as $gameid) {


            if ($gameid == 91) {
                $bsum1 = $drawNumber1[6];
                $bsum2 = $drawNumber2[6];
                $ball1Category =  $bsum1 >= 25 ? 'Big' : ($bsum1  === 49 ? 'Tie' : 'Small');
                $ball2Category =  $bsum2 >= 25 ? 'Big' : ($bsum2  === 49 ? 'Tie' : 'Small');
            }

            if ($gameid == 92) {

                $bsum1 = $drawNumber1[6] % 10;
                $bsum2 = $drawNumber2[6] % 10;
                $ball1Category = $bsum1 % 2 == 0 ? 'Even' : ($bsum1  === 49 ? 'Tie' : 'Odd');
                $ball2Category =  $bsum2 % 2 == 0 ? 'Even' : ($bsum2  === 49 ? 'Tie' : 'Odd');
            }

            if ($gameid == 93) {

                $bsum1 = ((int)($drawNumber1[6] / 10)) + ((int)($drawNumber1[6] % 10));
                $bsum2 = ((int)($drawNumber2[6] / 10)) + ((int)($drawNumber2[6] % 10));
                $ball1Category =  $bsum1  >= 7 ? 'Big' : ($bsum1  === 49 ? 'Tie' : 'Small');
                $ball2Category =  $bsum2 >= 7 ? 'Big' : ($bsum2  === 49 ? 'Tie' : 'Small');
            }
            if ($gameid == 94) {

                $bsum1 = ((int)($drawNumber1[6] / 10)) + ((int)($drawNumber1[6] % 10));
                $bsum2 = ((int)($drawNumber2[6] / 10)) + ((int)($drawNumber2[6] % 10));
                $ball1Category = $bsum1 % 2 == 0 ? 'Even' : ($bsum1  === 49 ? 'Tie' : 'Odd');
                $ball2Category =  $bsum2 % 2 == 0 ? 'Even' : ($bsum2  === 49 ? 'Tie' : 'Odd');
            }

            if ($gameid == 95) {
                $zodiacData = self::zodiacSigns();
                $skyZodiac = ['Ox', 'Rabbit', 'Dragon', 'Horse', 'Monkey', 'Pig'];
                $groundZodiac = ['Rat', 'Tiger', 'Snake', 'Goat', 'Rooster', 'Dog'];
                $bsum1 = $drawNumber1[6];
                $bsum2 = $drawNumber2[6];
                $ball1Category = self::skygroundcategorized($bsum1, $zodiacData, $skyZodiac, $groundZodiac);
                $ball2Category = self::skygroundcategorized($bsum2, $zodiacData, $skyZodiac, $groundZodiac);
            }

            if ($gameid == 96) {
                $zodiacData = self::zodiacSigns();
                // Define First and Last Zodiacs
                $firstZodiac = ['Rat', 'Ox', 'Tiger', 'Rabbit', 'Dragon', 'Snake'];
                $lastZodiac = ['Horse', 'Goat', 'Monkey', 'Rooster', 'Dog', 'Pig'];
                $bsum1 = $drawNumber1[6];
                $bsum2 = $drawNumber2[6];
                $ball1Category = self::mark6firstlastcategorized($bsum1, $zodiacData,  $firstZodiac, $lastZodiac);
                $ball2Category = self::mark6firstlastcategorized($bsum2, $zodiacData, $firstZodiac, $lastZodiac);
            }

            if ($gameid == 97) {
                $zodiacData = self::zodiacSigns();
                // Define Poultry and Beast Zodiacs
                $poultryZodiac = ['Ox', 'Horse', 'Goat', 'Rooster', 'Dog', 'Pig'];
                $beastZodiac = ['Rat', 'Tiger', 'Dragon', 'Snake', 'Rabbit', 'Monkey'];
                $bsum1 = $drawNumber1[6];
                $bsum2 = $drawNumber2[6];
                $ball1Category = self::mark6poultrybeatcategorized($bsum1, $zodiacData,  $poultryZodiac, $beastZodiac);
                $ball2Category = self::mark6poultrybeatcategorized($bsum2, $zodiacData, $poultryZodiac, $beastZodiac);
            }

            if ($gameid == 98) {
                $specialNumber = 49;
                $bsum1 = $drawNumber1[6];
                $bsum2 = $drawNumber2[6];
                $ball1Category = self::mark6extatailbscategorized($bsum1,  $specialNumber);
                $ball2Category = self::mark6extatailbscategorized($bsum2,  $specialNumber);
            }




            if ($ball1Category === $ball2Category) {
                $result[] = $gameid;
                $outcomes[] = $ball1Category;
            }
        }

        return [$result, $outcomes];
    }


    // sky/ground categorize 

    private static function skygroundcategorized($number, $zodiacData, $skyZodiac, $groundZodiac)
    {
        if ($number == 49) {
            return 'Refund';
        }

        foreach ($zodiacData as $zodiac => $numbers) {
            if (in_array($number, $numbers)) {
                if (in_array($zodiac, $skyZodiac)) {
                    return 'Sky';
                } elseif (in_array($zodiac, $groundZodiac)) {
                    return 'Ground';
                }
            }
        }

        return 'Not Found';
    }


    // first/last category  

    private static function mark6firstlastcategorized($number, $zodiacData, $firstZodiac, $lastZodiac)
    {
        if ($number == 49) {
            return 'Refund';
        }

        foreach ($zodiacData as $zodiac => $numbers) {
            if (in_array($number, $numbers)) {
                if (in_array($zodiac, $firstZodiac)) {
                    return 'First Zodiac';
                } elseif (in_array($zodiac, $lastZodiac)) {
                    return 'Last Zodiac';
                }
            }
        }

        return 'Not Found';
    }


    // poultry best   categroized  
    private static function mark6poultrybeatcategorized($number, $zodiacData, $poultryZodiac, $beastZodiac)
    {
        if ($number == 49) {
            return 'Refund';
        }

        foreach ($zodiacData as $zodiac => $numbers) {
            if (in_array($number, $numbers)) {
                if (in_array($zodiac, $poultryZodiac)) {
                    return 'Poultry Zodiac';
                } elseif (in_array($zodiac, $beastZodiac)) {
                    return 'Beast Zodiac';
                }
            }
        }

        return 'Not Found';
    }


    // mark6 tail bs category

    private static function mark6extatailbscategorized($number, $specialNumber)
    {
        if ($number == $specialNumber) {
            return 'Refund';
        }
        return $number >= 5 ? 'Big tail' : 'Small tail';
    }


    public static function OddEvenZodaic(array $drawNumber)
    {

        $zodiacsigns = [
            "Rat" => self::generateArray(1),
            "Ox" => self::generateArray(2),
            "Tiger" => self::generateArray(3),
            "Rabbit" => self::generateArray(4),
            "Dragon" => self::generateArray(5),
            "Snake" => self::generateArray(6),
            "Horse" => self::generateArray(7),
            "Goat" => self::generateArray(8),
            "Monkey" => self::generateArray(9),
            "Rooster" => self::generateArray(10),
            "Dog" => self::generateArray(11),
            "Pig" => self::generateArray(12)
        ];
        $uniqueZodiacSigns = [];
        foreach ($drawNumber as $number) {
            foreach ($zodiacsigns as $sign => $signNumbers) {
                if (in_array($number, $signNumbers) && !in_array($sign, $uniqueZodiacSigns)) {
                    $uniqueZodiacSigns[] = $sign;
                }
            }
        }
        $numberOfUniqueSigns = count($uniqueZodiacSigns);
        return ($numberOfUniqueSigns % 2 == 0) ? "Even" : "Odd";
    }


    // function t  return zodic NUmbers animals and signs

    public static function zodiacSigns(): array
    {
        return [
            "Rat" => self::generateArray(1),
            "Ox" => self::generateArray(2),
            "Tiger" => self::generateArray(3),
            "Rabbit" => self::generateArray(4),
            "Dragon" => self::generateArray(5),
            "Snake" => self::generateArray(6),
            "Horse" => self::generateArray(7),
            "Goat" => self::generateArray(8),
            "Monkey" => self::generateArray(9),
            "Rooster" => self::generateArray(10),
            "Dog" => self::generateArray(11),
            "Pig" => self::generateArray(12)
        ];
    }
    public static function generateMapping($start)
    {
        $sequence = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
        $mapping = [];
        $length = count($sequence);
        $distance = 0;
        $index = $start;

        for ($i = 0; $i <= $length; $i++) {
            $mapping[$sequence[$index]] = $distance;
            $distance++;
            $index = $index === 0 ? $length - 1 : $index - 1;
        }
        return $mapping;
    }

    public static function generateArray($position)
    {
        $current_chinese_zodiac = 5;
        $sequenceMappingData = self::generateMapping($current_chinese_zodiac);
        $finalResults = [];
        $maxArrayLoop = $sequenceMappingData[$position] === 1 ? 5 : 4;
        for ($i = 1; $i <= $maxArrayLoop; $i++) {
            $number = 12 * $i - (12 - $sequenceMappingData[$position]);
            $formattedNumber = $number < 10 ? "$number" : "$number";
            $finalResults[] = $formattedNumber;
        }
        return $finalResults;
    }



    public static function mark6BigSMall($drawNumber1, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];
        foreach ($gameIds as $gameid) {
            $index = $gameid - 99; // Assuming game IDs are sequential starting from 99
            if ($index >= 0 && $index < count($drawNumber1)) {
                $bsum1 = $drawNumber1[$index];
                $bsum2 = $drawNumber2[$index];
                $ball1Category = self::mark6categorize($bsum1);
                $ball2Category = self::mark6categorize($bsum2);
                if ($ball1Category === $ball2Category) {
                    $result[] = $gameid;
                    $outcomes[] = $ball1Category;
                }
            }
        }
        return [$result, $outcomes];
    }

    private static function mark6categorize($number)
    {
        if ($number === 49) {
            return 'Tie';
        }
        return $number >= 25 ? 'Big' : 'Small';
    }





    public static function mark6OddEven($drawNumber1, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];
        foreach ($gameIds as $gameid) {
            $index = $gameid - 105; // Assuming game IDs are sequential starting from 99
            if ($index >= 0 && $index < count($drawNumber1)) {
                $bsum1 = $drawNumber1[$index];
                $bsum2 = $drawNumber2[$index];
                $ball1Category = self::mark6oecategorize($bsum1);
                $ball2Category = self::mark6oecategorize($bsum2);
                if ($ball1Category === $ball2Category) {
                    $result[] = $gameid;
                    $outcomes[] = $ball1Category;
                }
            }
        }
        return [$result, $outcomes];
    }

    private static function mark6oecategorize($number)
    {
        if ($number === 49) {
            return 'Tie';
        }
        return  $number % 2 == 0 ? 'Even' : ($number  === 49 ? 'Tie' : 'Odd');
    }


    // b/S sum 
    public static function mark6BigSMallsum($drawNumber1, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];

        foreach ($gameIds as $gameid) {
            $index = $gameid - 111; // Assuming game IDs are sequential starting from 99
            if ($index >= 0 && $index < count($drawNumber1)) {
                $bsum1 =  ((int)($drawNumber1[$index] / 10)) + ((int)($drawNumber1[$index] % 10));
                $bsum2 = ((int)($drawNumber2[$index] / 10)) + ((int)($drawNumber2[$index] % 10));

                $ball1Category = self::mark6bssumcategorize($bsum1);
                $ball2Category = self::mark6bssumcategorize($bsum2);
                if ($ball1Category === $ball2Category) {
                    $result[] = $gameid;
                    $outcomes[] = $ball1Category;
                }
            }
        }

        return [$result, $outcomes];
    }


    private static function mark6bssumcategorize($number)
    {
        if ($number === 49) {
            return 'Tie';
        }
        return  $number  >= 7 ? 'Big' :  'Small';
    }


    // oe sum 

    public static function mark6OddEvensum($drawNumber1, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];

        foreach ($gameIds as $gameid) {
            $index = $gameid - 117; // Assuming game IDs are sequential starting from 99
            if ($index >= 0 && $index < count($drawNumber1)) {
                $bsum1 =  ((int)($drawNumber1[$index] / 10)) + ((int)($drawNumber1[$index] % 10));
                $bsum2 = ((int)($drawNumber2[$index] / 10)) + ((int)($drawNumber2[$index] % 10));

                $ball1Category = self::mark6ossumcategorize($bsum1);
                $ball2Category = self::mark6ossumcategorize($bsum2);

                if ($ball1Category === $ball2Category) {
                    $result[] = $gameid;
                    $outcomes[] = $ball1Category;
                }
            }
        }

        return [$result, $outcomes];
    }

    private static function mark6ossumcategorize($number)
    {
        if ($number === 49) {
            return 'Tie';
        }
        return $number % 2 == 0 ? 'Even' :  'Odd';
    }

    // big


    // Tailbig/small
    public static function mark6tailBigsmall($drawNumber1, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];

        foreach ($gameIds as $gameid) {
            $index = $gameid - 123; // Assuming game IDs are sequential starting from 99
            if ($index >= 0 && $index < count($drawNumber1)) {
                $bsum1 =  (int)($drawNumber1[$index] % 10);
                $bsum2 = (int)($drawNumber2[$index] % 10);

                $ball1Category = self::mark6bstailcategorize($bsum1);
                $ball2Category = self::mark6bstailcategorize($bsum2);

                if ($ball1Category === $ball2Category) {
                    $result[] = $gameid;
                    $outcomes[] = $ball1Category;
                }
            }
        }

        return [$result, $outcomes];
    }

    private static function mark6bstailcategorize($number)
    {
        if ($number === 49) {
            return 'Tie';
        }
        return  $number  >= 5 ? 'Big' :  'Small';
    }


    // mark6sum 

    public static function mark6Sum($drawNumber1, $drawNumber2, $gameIds): array
    {
        $result = [];
        $outcomes = [];
        foreach ($gameIds as $gameid) {


            if ($gameid == 129) {
                $bsum1 = array_sum($drawNumber1);
                $bsum2 = array_sum($drawNumber2);
                $ball1Category =  self::mark6sumbscategorize($bsum1);
                $ball2Category =  self::mark6sumbscategorize($bsum2);
            }

            if ($gameid == 130) {
                $bsum1 = array_sum($drawNumber1);
                $bsum2 = array_sum($drawNumber2);
                $ball1Category =  self::mark6sumbsnotiecategorize($bsum1);
                $ball2Category =  self::mark6sumbsnotiecategorize($bsum2);
            }

            if ($gameid == 131) {
                $bsum1 = array_sum($drawNumber1);
                $bsum2 = array_sum($drawNumber2);
                $ball1Category =  self::mark6sumoecategorize($bsum1);
                $ball2Category =  self::mark6sumoecategorize($bsum2);
            }
            if ($ball1Category === $ball2Category) {
                $result[] = $gameid;
                $outcomes[] = $ball1Category;
            }
        }

        return [$result, $outcomes];
    }


    // mar6sumbs

    private static function mark6sumbscategorize($number)
    {
        if ($number === 175) {
            return 'Tie';
        }
        return  $number  >= 176 ? 'Big' :  'Small';
    }

    private static function mark6sumbsnotiecategorize($number)
    {

        return  $number  >= 1765 ? 'Big' :  'Small';
    }

    public static function mark6sumoecategorize($number): mixed
    {
        return $number % 2 == 0 ? 'Even' :  'Odd';
    }


    // mar6zodiac

    public static function mark6zodiacoe($drawNumber1, $drawNumber2, $gameIds): array
    {

        $result = [];
        $outcomes = [];
        foreach ($gameIds as $gameid) {


            if ($gameid == 132) {
                $ball1Category =  self::OddEvenZodaic($drawNumber1);
                $ball2Category =  self::OddEvenZodaic($drawNumber2);
            }
            if ($ball1Category === $ball2Category) {
                $result[] = $gameid;
                $outcomes[] = $ball1Category;
            }
        }

        return [$result, $outcomes];
    }





    public static function mark6ConsecutivePairs($gameIds, $drawNumberList): array
    {
        $consecutiveStreaks = [];
        $drawCount = count($drawNumberList);
        $gameIdCounts = array_fill_keys($gameIds, 1); // Initialize counters with default value 1
        $gameIdStreaks = array_fill_keys($gameIds, 0);
        // [[47, 48, 49], [50, 51, 52], [53, 54, 55], [56, 57, 58], [59, 60, 61], [62, 63, 64], [65], [66], [67], [68]];

        // $mark6list = [[91, 92, 93, 94, 95, 96, 97, 98], [99, 100, 101, 102, 103, 104], [105, 106, 107, 108, 109, 110], [111, 112, 113, 114, 115, 116], [117, 118, 119, 120, 121, 122], [123, 124, 125, 126, 127, 128], [129, 130, 131], [132]]; //[extra number],[ ball 1-6 b/s],[ball1 -6 o/e],[ball1 -6 bs sum][ball 1-6 oe sum],[ball 1-6 T b/s]

        $extraNumber = [91, 92, 93, 94, 95, 96, 97, 98];
        $mark6bigSmall = [99, 100, 101, 102, 103, 104]; //b1-b6
        $mark6oddEven = [105, 106, 107, 108, 109, 110]; //b1-b6
        $mark6bsSum = [111, 112, 113, 114, 115, 116]; //bs sum
        $mark6oeSum = [117, 118, 119, 120, 121, 122]; //oe sum
        $mark6TailbS =   [123, 124, 125, 126, 127, 128];
        $mark6sum = [129, 130, 131];
        $mark6Zodiac = [132];





        for ($i = 0; $i < $drawCount - 1; $i++) {
            $drawNumber = $drawNumberList[$i];
            $drawNumber2 = $drawNumberList[$i + 1];
            $matchingGameIds = null;
            // echo json_encode(array_diff([47], $threedbsoepc));
            // // exit;
            if (!array_diff($gameIds, $extraNumber)) {
                $matchingGameIds = self::ExtraNUmber($drawNumber, $drawNumber2, $gameIds)[0];
            }
            if (!array_diff($gameIds,  $mark6bigSmall)) {
                $matchingGameIds = self::mark6BigSMall($drawNumber, $drawNumber2, $gameIds)[0];
            }

            if (!array_diff($gameIds, $mark6oddEven)) {
                $matchingGameIds = self::mark6OddEven($drawNumber, $drawNumber2, $gameIds)[0];
            }

            if (!array_diff($gameIds, $mark6bsSum)) {
                $matchingGameIds = self::mark6BigSMallsum($drawNumber, $drawNumber2, $gameIds)[0];
            }

            if (!array_diff($gameIds, $mark6oeSum)) {
                $matchingGameIds = self::mark6OddEvensum($drawNumber, $drawNumber2, $gameIds)[0];
            }

            if (!array_diff($gameIds, $mark6TailbS)) {
                $matchingGameIds = self::mark6tailBigsmall($drawNumber, $drawNumber2, $gameIds)[0];
            }

            if (!array_diff($gameIds, $mark6sum)) {
                $matchingGameIds = self::mark6Sum($drawNumber, $drawNumber2, $gameIds)[0];
            }

            if (!array_diff($gameIds, $mark6Zodiac)) {
                $matchingGameIds = self::mark6zodiacoe($drawNumber, $drawNumber2, $gameIds)[0];
            }
            // After the first iteration, use the new matching game IDs as the current game IDs
            $gameIds = $matchingGameIds;
            // Consecutive occurrence, update streak
            if ($i == 0) {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            } else {
                $consecutiveStreaks = array_merge($consecutiveStreaks, $matchingGameIds);
            }
            // Update game ID counts and streaks
            foreach ($matchingGameIds as $gameId) {
                $gameIdCounts[$gameId]++;
                $gameIdStreaks[$gameId]++;
            }
        }
        // var_dump(array_count_values($consecutiveStreaks));

        return array_count_values($consecutiveStreaks);
    }
    // *******************Mark6 ******************************************************************





    // getting the Outcome  based on gameid 

    public static function getOutcome($gameId): mixed
    {
        $drawNumberList = self::getlas10draws();
        $drawNumber1 = $drawNumberList[0];
        $drawNumber2 = $drawNumberList[1];
        $gameIds = [$gameId];
        $fDbscategory = [133, 134, 135, 136, 137];
        $fDoecategory = [138, 139, 140, 141, 142];
        $fDdtcategory = [143];
        $f3Sumbscategory = [46];
        $e5bscategory = [69, 70, 71, 72, 73];
        $e5oecategory = [74, 75, 76, 77, 78];
        $e5sumbs = [79];
        $e5sumoe = [80];
        $e5sumdt = [81];
        $pkbscategory = [23, 24, 25, 26, 27, 28, 29, 30, 31, 32];
        $pkoecategory = [33, 34, 35, 36, 37, 38, 39, 40, 41, 42];
        $pksumtop2 = [43, 44];
        $pkdragonTiger = [82, 83, 84, 85, 86];


        $threedbsoepc = [47, 48, 49, 50, 51, 52, 53, 54, 55];
        $thredsumoe = [56, 57, 58];
        $thredbstailsum = [59, 60, 61];
        $thredpctailsum = [62, 63, 64];
        $sumHappy8 = [87, 88, 89, 90];

        $extraNumber = [91, 92, 93, 94, 95, 96, 97, 98];
        $mark6bigSmall = [99, 100, 101, 102, 103, 104]; //b1-b6
        $mark6oddEven = [105, 106, 107, 108, 109, 110]; //b1-b6
        $mark6bsSum = [111, 112, 113, 114, 115, 116]; //bs sum
        $mark6oeSum = [117, 118, 119, 120, 121, 122]; //oe sum
        $mark6TailbS =   [123, 124, 125, 126, 127, 128];
        $mark6sum = [129, 130, 131];
        $mark6Zodiac = [132];

        $outcomes = null;
        // $drawNumber1 = json_decode($drawNumber1);
        // $drawNumber2 = json_decode($drawNumber2);
        if (!array_diff($gameIds, $fDbscategory) || !array_diff($gameIds, $fDoecategory) || !array_diff($gameIds, $fDdtcategory)) {
            $outcomes = self::compareDrawNumbers($drawNumber1, $drawNumber2, $gameIds)[1];
        }

        if (!array_diff($gameIds, $fDdtcategory)) {
            $outcomes = self::compareDragonTiger($drawNumber1, $drawNumber2, $gameIds)[1];
        }

        if (!array_diff($gameIds, $f3Sumbscategory)) {
            $outcomes = self::comparefast3SumBigSmall($drawNumber1, $drawNumber2, $gameIds)[1];
        }
        if (!array_diff($gameIds, $e5bscategory) || !array_diff($gameIds, $e5oecategory)) {
            $outcomes = self::compareBigSmalleleven5($drawNumber1, $drawNumber2, $gameIds)[1];
        }
        if (!array_diff($gameIds, $e5sumbs) || !array_diff($gameIds, $e5sumoe) || !array_diff($gameIds, $e5sumdt)) {
            $outcomes = self::compareEleven5Sumbsoedt($drawNumber1, $drawNumber2, $gameIds)[1];
        }
        if (!array_diff($gameIds, $pkbscategory) || !array_diff($gameIds, $pkoecategory)) {
            $outcomes = self::pk10bsoe($drawNumber1, $drawNumber2, $gameIds)[1];
        }
        if (!array_diff($gameIds, $pksumtop2)) {
            $outcomes = self::pk10sumtoptwo($drawNumber1, $drawNumber2, $gameIds)[1];
        }

        if (!array_diff($gameIds, $pkdragonTiger)) {
            $outcomes = self::pk10dt($drawNumber1, $drawNumber2, $gameIds)[1];
        }
        if (!array_diff($gameIds, $threedbsoepc)) {
            $outcomes = self::threeDbsoepc($drawNumber1, $drawNumber2, $gameIds)[1];
        }
        if (!array_diff($gameIds, $thredsumoe) || !array_diff($gameIds, $thredbstailsum) ||  !array_diff($gameIds, $thredpctailsum)) {
            $outcomes = self::sumof3d($drawNumber1, $drawNumber2, $gameIds)[1];
        }

        if (!array_diff($gameIds, $sumHappy8)) {
            $outcomes = self::happy8($drawNumber1, $drawNumber2, $gameIds)[1];
        }

        if (!array_diff($gameIds, $extraNumber)) {
            $outcomes = self::ExtraNUmber($drawNumber1, $drawNumber2, $gameIds)[1];
        }
        if (!array_diff($gameIds,  $mark6bigSmall)) {
            $outcomes = self::mark6BigSMall($drawNumber1, $drawNumber2, $gameIds)[1];
        }

        if (!array_diff($gameIds, $mark6oddEven)) {
            $outcomes = self::mark6OddEven($drawNumber1, $drawNumber2, $gameIds)[1];
        }

        if (!array_diff($gameIds, $mark6bsSum)) {
            $outcomes = self::mark6BigSMallsum($drawNumber1, $drawNumber2, $gameIds)[1];
        }

        if (!array_diff($gameIds, $mark6oeSum)) {
            $outcomes = self::mark6OddEvensum($drawNumber1, $drawNumber2, $gameIds)[1];
        }

        if (!array_diff($gameIds, $mark6TailbS)) {
            $outcomes = self::mark6tailBigsmall($drawNumber1, $drawNumber2, $gameIds)[1];
        }

        if (!array_diff($gameIds, $mark6sum)) {
            $outcomes = self::mark6Sum($drawNumber1, $drawNumber2, $gameIds)[1];
        }

        if (!array_diff($gameIds, $mark6Zodiac)) {
            $outcomes = self::mark6zodiacoe($drawNumber1, $drawNumber2, $gameIds)[1];
        }


        return $outcomes;
    }

    // get last 10 draws
    public static function getlas10draws()
    {
        $select = new select();
        $lotterymapmodel = new lotterymapModel();
        $lotteryDetails = $lotterymapmodel->lotterydetials(self::$lotteryid);

        if (isset($lotteryDetails['draw_table'])) {
            $drawtable = $lotteryDetails['draw_table'];
            $sql = "SELECT * FROM $drawtable ORDER BY draw_id DESC LIMIT 10";
            $getdraw = $select->selectAll($sql);
            $drawNumbers = [];
            foreach ($getdraw as $value) {
                if (isset($value['draw_number'])) {
                    $numbers = json_decode($value['draw_number']);
                    if (json_last_error() === JSON_ERROR_NONE && is_array($numbers)) {
                        $drawNumbers[] = $numbers;
                    }
                }
            }
            $drawNumbersIntegers = array_map(function ($item) {
                return array_map('intval', $item);
            }, $drawNumbers);

            return $drawNumbersIntegers;
        } else {
            return [];
        }
    }
    // 
    // that what get result for each iteration
    public static  function runapi()
    {
        // print_r(self::getlas10draws());
        // exit;
        $ConsecutivePairs = [
            1 => 'fiveDConsecutivePairs',
            2 => 'pk10ConsecutivePairs',
            3 => 'fast3ConsecutivePairs',
            5 => 'threeDConsecutivePairs',
            6 => 'eleven5ConsecutivePairs',
            8 => 'mark6ConsecutivePairs',
            9 => 'pc28ConsecutivePairs',
            10 => 'happy8ConsecutivePairs'
        ];
        $consecutivePair = $ConsecutivePairs[self::getlotteryType()];
        $fivedlist = [[133, 134, 135, 136, 137], [138, 139, 140, 141, 142], [143]];
        $pk10list = [[23, 24, 25, 26, 27, 28, 29, 30, 31, 32], [33, 34, 35, 36, 37, 38, 39, 40, 41, 42], [43, 44], [82, 83, 84, 85, 86]];
        $fast3list = [[46]];
        $threedlist = [[47, 48, 49], [50, 51, 52], [53, 54, 55], [56, 57, 58], [59, 60, 61], [62, 63, 64]]; // [56, 57, 58], [59, 60, 61], [62, 63, 64]  //, [53, 54, 55], [56, 57, 58], [59, 60, 61], [62, 63, 64]  //[65], [66], [67], [68]
        $eleven5list = [[69, 70, 71, 72, 73], [74, 75, 76, 77, 78], [79], [80], [81]];
        $mark6list = [[91, 92, 93, 94, 95, 96, 97, 98], [99, 100, 101, 102, 103, 104], [105, 106, 107, 108, 109, 110], [111, 112, 113, 114, 115, 116], [117, 118, 119, 120, 121, 122], [123, 124, 125, 126, 127, 128], [129, 130, 131]]; //[extra number],[ ball 1-6 b/s],[ball1 -6 o/e],[ball1 -6 bs sum][ball 1-6 oe sum],[ball 1-6 T b/s]
        $pc28list = [];
        $happy8list = [[87, 88, 89, 90]];

        $gameidlist = [1 => $fivedlist, 2 => $pk10list, 3 => $fast3list, 5 => $threedlist, 6 => $eleven5list, 8 => $mark6list, 9 => $pc28list, 10 => $happy8list];
        $gameidlist = $gameidlist[self::getlotteryType()];

        $finalresult = [];

        foreach ($gameidlist as $gameid) {
            $drawnumberlist =  self::getlas10draws();
            $result = self::$consecutivePair($gameid, $drawnumberlist);


            array_push($finalresult, $result);
        }
        $result2 = [];
        foreach ($finalresult as $subArray) {
            foreach ($subArray as $key => $value) {
                $result2[$key] = $value;
            }
        }
        return $result2;
    }

    public static  function getgamenamess($gameid): mixed
    {
        $sql =  "SELECT longdragon.*, ro.game_play_id,
             FROM `longdragon` 
             LEFT JOIN `longdragon_group` ro 
             ON ro.game_play_id = longdragon.gn_id 
             WHERE longdragon.gn_id = ?";
        $game = (new Query())->fetchOne($sql, array($gameid));
        return (isset($game)) ? $game : false;
    }

    public static  function getgamename($gameid): mixed
    {
        $sql =  "SELECT longdragon.* FROM `longdragon` WHERE `gn_id` = ?";
        $game = (new Query())->fetchOne($sql, array($gameid));
        return (isset($game)) ? $game : false;
    }

    //   main function to get result
    public static function sendapi()
    {
        $result = self::runapi();
        return self::formatResult($result);
    }


    // get lottery_type Lotterid
    public static function getlotteryType(): mixed
    {
        $sql =  "SELECT lottery_type FROM `game_type` WHERE `gt_id` = ?";
        $lottery = (new Query())->fetchOne($sql, array(self::$lotteryid));
        return (isset($lottery)) ? $lottery['lottery_type'] : false;
    }
    // formatt final result
    public static function formatResult($result)
    {
        $data = [];
        $lottery = new  lotteryModel();
        $drawseconds = $lottery->singlelottery(self::$lotteryid)['seconds_per_issue'];
        $lotteryname =  $lottery->singlelottery(self::$lotteryid)['name'];
        $drawcontroller = new drawController();
        foreach ($result as $key => $value) {
            // var_dump(self::getOutcome($key)[0]);
            $outcome = isset(self::getOutcome($key)[0]) ? self::getOutcome($key)[0] : '';
            $grouptype = self::getgamename($key)['group_selection'];
            $button = explode('/', $grouptype);
            $dInfo = self::getCurrentDrawInfo(date("H:i:s"),self::$lotteryid);
            $someodss = self::getgamename($key)['odds'];
            $data[] = [
                'gameid' => $key,
                'streak' => $value,
                // i have to add the number that won 
                'game_name' =>   $lotteryname . ' -' . self::getgamename($key)['name'] . ' - ' . $outcome,
                'odds' => $someodss,
                "isSpecial" => self::getgamename($key)['isSpecial'],
                'group_type' => $grouptype,
                'button1' => isset($button[0]) ? $button[0] : '',
                'button2' => isset($button[1]) ? $button[1] : '',
                'rebate' => self::getgamename($key)['rebate'],
                'profit' => self::getgamename($key)['profit'],
                'lottery_id' => self::$lotteryid,
                'timeleft' => $dInfo['timeLeft'],
                // 'drawperiod'=>$generator->getdrawfromapi(self::$lotteryid)['draw_date'],
                'draw_info' => $dInfo['drawinfo'],//$drawcontroller->getCurrentDrawInfo(self::$lotteryid)['drawinfo'],
                'totaltime' => $dInfo['totaltime'],
            ];
        }
        return $data;
    }


    public static function getDrawCount(string $time, string $lotteryId) : string 
    {
          $times = timelistModel::getTimeSet($lotteryId);
          $result = $times[$time] ?? null;
          if (!$result) {
              $lower_time = null;
              foreach (array_keys($times) as $time_key) {
                  if ($time > $time_key) $lower_time = $time_key;
                  else break;
              }
              $result = $lower_time ? $times[$lower_time] : null;
          }
  
          return $result;
    }
    
    public static function getGamesLastDrawInfos(string $gameId){
        $drawTable = timelistModel::getGameTableMap()[$gameId]['draw_table'];
        $select = new Select(); 
        $sql = "SELECT * FROM $drawTable ORDER BY draw_id DESC LIMIT 1";
        return $select->selectOne($sql);
    }

    public static function getDrawPeriod(string $time, string $lotteryId) : string
    {
          $times = timelistModel::getTimeSet($lotteryId);
          $result = $times[$time] ?? null;
          if (!$result) {
              $lower_time = null;
              foreach (array_keys($times) as $time_key) {
                  if ($time > $time_key) $lower_time = $time_key;
                  else break;
              }
              $result = $lower_time ? date("Ymd") . $times[$lower_time] : null;
          }
  
          $endTime = self::getGameStopTimeAndTimeInSec($lotteryId)['endTime'];
          $lastInfos = self::getGamesLastDrawInfos($lotteryId);
          $isWithinTimeRange = self::isWithinTimeRange($endTime, $lotteryId);
          return $isWithinTimeRange ? $lastInfos['period']: $result;
    }
    
    public static function getNextDrawPeriod(string $time, string $lotteryId) 
    { 
          $times = timelistModel::getTimeSet($lotteryId);
          $result = $times[$time] ?? null;
          $nextPeriod = null;
          if (!$result) {
              foreach (array_keys($times) as $time_key) {
                  if ($time > $time_key) $result = $time_key;
              }
          }
          foreach ($times as $key => $val) {
              if ($nextPeriod){
                return date("Ymd").$val;
              } 
              if (strpos($key, $result) === 0) $nextPeriod = $key;
          }
  
        return null;
    }
    
    public static function getDrawDateTime(string $time, string $lotteryId) : string
    {
          $times = timelistModel::getTimeSet($lotteryId);
          $result = $times[$time] ?? null;
          if (!$result) {
              $lower_time = null;
              foreach (array_keys($times) as $time_key) {
                  if ($time > $time_key) $lower_time = $time_key;
                  else break;
              }
              $result = $lower_time ? date("Y-m-d") . ' ' . $lower_time : '';
          }
  
          return $result;
    }
  
    public static function getNextPeriodAndNextTime(string $time, string $lotteryId) 
    {
          $times = timelistModel::getTimeSet($lotteryId);
          $result = date("H:i:s") ?? null;
          $nextPeriodAndTime = [];
          $nextPeriod = false;
          if (!$result) {
              foreach (array_keys($times) as $time_key) {
                  if ($time > $time_key) $result = $time_key;
                  else break;
              }
          }
          foreach ($times as $key => $val) {
              if ($nextPeriod){
                  $nextPeriodAndTime['nexPeriod'] = date("Ymd").$val;
                  $nextPeriodAndTime['nexTime'] = $key  ?? null;
                  break;
              } 
              if (strpos($key, $result) === 0) $nextPeriod = true;
          }
  
          return $nextPeriodAndTime;
    }
  
    public static function getDrawTime(string $time, string $lotteryId) : string
    {
          $times = timelistModel::getTimeSet($lotteryId);
          $result = $times[$time] ?? null;
          if (!$result) {
              $lower_time = null;
              foreach (array_keys($times) as $time_key) {
                  if ($time > $time_key) $lower_time = $time_key;
                  else break;
              }
              $result = $lower_time ? $lower_time : '';
          }
  
          return $result;
    }
  
    public static function getNextDrawTime(string $time, string $lotteryId) : string
    {
          $times = timelistModel::getTimeSet($lotteryId);
          $result = $times[$time] ?? null;
          $nextPeriod = null;
          if (!$result) {
              foreach (array_keys($times) as $time_key) {
                  if ($time > $time_key) $result = $time_key;
              }
          }
          foreach ($times as $key => $val) {
              if ($nextPeriod){
                  return $key  ?? null;
              } 
              if (strpos($key, $result) === 0) $nextPeriod = $key;
          }
  
          return '';
    }
    
    public static function getNextDrawDateTime(string $time, string $lotteryId) : string
    {
          $times = timelistModel::getTimeSet($lotteryId);
          $result = $times[$time] ?? null;
          $nextPeriod = null;
          if (!$result) {
              foreach (array_keys($times) as $time_key) {
                  if ($time > $time_key) $result = $time_key;
              }
          }
          foreach ($times as $key => $val) {
              if ($nextPeriod){
                  return date("Y-m-d") . ' ' . $key ;
              } 
              if (strpos($key, $result) === 0) $nextPeriod = $key;
          }
  
          return null; 
    }
    
    public static function getDrawTimeMilliSeconds() : string
    {
      $dateTime = new DateTime();
      $time = $dateTime->format("H:i:s");
      $milliseconds = sprintf("%03d", $dateTime->format("u") / 1000);
      return "$time.$milliseconds";
    }
    
    public static function getSecondsElapsed($startTime, $endTime) : string //break 3600
    {
        $timeElapsed = abs(strtotime($endTime) - strtotime($startTime));
        return $timeElapsed;
    }
    
    public static function getTimeRemaining(string $time, string $lotteryId) : int
    {
       $nextTime = self::getNextDrawTime($time,$lotteryId);
       $interval =  strtotime($nextTime) - strtotime(date("H:i:s"));
       return strlen((string)$interval) > 5 ? 00 : $interval;
    }
    
    public static function getCurrentDrawNumber(string $time, string $lotteryId) 
    {
      $endTime = self::getGameStopTimeAndTimeInSec($lotteryId)['endTime'];
      $lastInfos = self::getGamesLastDrawInfos($lotteryId);
      $isWithinTimeRange = self::isWithinTimeRange($endTime, $lotteryId);
  
      if($isWithinTimeRange){
        $drawPeriod = self::getDrawPeriod($time, $lotteryId);
        $res = Model::getCurrentDrawNumber($lotteryId, $drawPeriod)['draw_number'] ?? 'Not found.';
        $drawNumber =  [
          "type" => $res ? "success" : "faild",
          "drawinfo" => [
              "draw_number" => json_decode($res)
          ]
        ];
  
      }else{
          $lastInfos = self::getGamesLastDrawInfos($lotteryId);
          $drawNumber =  [
              "type" => $lastInfos ? "success" : "failed",
              "drawinfo" => [
                  "draw_number" => json_decode($lastInfos['draw_number'])
              ]
            ];
  
      }
     return $drawNumber;
  
    }
  
    // public static function getGamesLastDrawInfos(string $lotteryId) : array {
    //   return Model::getGamesLastDrawInfos($lotteryId) ?? ['Not found.'];
    // }
    
    public static function getGameStopTimeAndTimeInSec(string $lotteryId) : array
    {
      $lotteryIdGroups = [
          ['ids' => ["1", "3", "4", "6", "7", "10", "13", "25", "27", "29", "30", "31", "32",
          "33", "34", "35", "36", "37", "38", "39", "40", "41", "42"], 'totalTime' => 60, 'endTime' => '00:00:00'], //23:59:00
          ['ids' => ["9", "11", "14", "17"], 'totalTime' => 90, 'endTime' => '00:00:00'], //23:58:30
          ['ids' => ["8", "12", "15", "16", "23"], 'totalTime' => 180, 'endTime' => 'today 00:00:00'], //23:57:03
          ['ids' => ["5", "26", "28"], 'totalTime' => 300, 'endTime' => '00:00:00'] //23:55:00
      ];
  
      foreach ($lotteryIdGroups as $group) {
          if (in_array($lotteryId, $group['ids'])) {
              return ['totalTime' => $group['totalTime'], 'endTime' => $group['endTime']];
          }
      }
  
      return [];
    }
  
    public static function drawInfoController(string $type, string $lotteryId) {
  
     $time = date("H:i:s");
     return $type == 'drawNumber' ? self::getCurrentDrawNumber($time,$lotteryId) : 
     self::getCurrentDrawInfo($time,$lotteryId);
  
    }
    
    public static function getCurrentDrawInfo(string $time, string $lotteryId) {
  
      $gameStopTime_x_totalTimeInSec = self::getGameStopTimeAndTimeInSec($lotteryId);
      $lastInfos = self::getGamesLastDrawInfos($lotteryId);
      $isWithinTimeRange = self::isWithinTimeRange($gameStopTime_x_totalTimeInSec['endTime'], $lotteryId);
  
      $drawPeriod = $isWithinTimeRange ? $lastInfos['period'] : self::getDrawPeriod($time, $lotteryId);
      $drawDateTime = $isWithinTimeRange ? $lastInfos['time_added'] : self::getDrawDateTime($time, $lotteryId);
      $drawCount = $isWithinTimeRange ? $lastInfos['time_added'] : self::getDrawCount($time, $lotteryId);
      $timeLeft = $isWithinTimeRange ? strtotime("01:00:00") - strtotime(date("H:i:s")) : self::getTimeRemaining($time, $lotteryId);
      $totalTime = $isWithinTimeRange ? 3600 : $gameStopTime_x_totalTimeInSec['totalTime'];
  
      $drawInfo = [
          "type" => "success",
          "drawinfo" => [
              "draw_date" => $drawPeriod,
              "draw_time" => $drawDateTime,
              "request_time" => self::getDrawTimeMilliSeconds(),
              "draw_datetime" => $drawDateTime,
          ],
          "drawCount" => $drawCount,
          "timeLeft" => $timeLeft,
          "currentTime" => (new DateTime())->format('H:i:s'),
          "totaltime" => $totalTime,
          "currentPeriod" => $drawPeriod,
          'nexDrawPeriod' => self::getNextDrawPeriod($time, $lotteryId)
      ];
  
      return $drawInfo ?? [];
    }
  
    public static function isWithinTimeRange($endTime, $lotteryId) : bool {
      $currentTime = new DateTime();
      $endTime = new DateTime($endTime); // e.g., "00:00:00" today
      $startTime = new DateTime("00:59:10"); // "01:00:00" today
      $isWithinTimeRange = $currentTime >= $endTime && $currentTime < $startTime;
      return $isWithinTimeRange;
    }
    


    // testing
}