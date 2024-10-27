<?php 

class Utils {


    public static function generateMapping($start) {
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

    public static function generateArray($position) {
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

    public static function zodiacSky(array $drawnumber){
       return in_array(
        end($drawnumber),
        explode(
            ",",
                implode(",", self::generateArray(2)) . ',' .
                implode(",", self::generateArray(4)) . ',' .
                implode(",", self::generateArray(7)) . ',' .
                implode(",", self::generateArray(9)) . ',' .
                implode(",", self::generateArray(12))
        )
        );
    }

    public static function zodiacGround(array $drawnumber){
        return in_array(
            end($drawnumber),
            explode(
                ",",
                implode(",", self::generateArray(1)) . ',' .
                    implode(",", self::generateArray(3)) . ',' .
                    implode(",", self::generateArray(6)) . ',' .
                    implode(",", self::generateArray(8)) . ',' .
                    implode(",", self::generateArray(10)) . ',' .
                    implode(",", self::generateArray(11))
            )
            );
    }

    public static function zodiacFirst(array $drawnumber){
        return in_array(
            end($drawnumber),
            explode(
                ",",
                implode(",", self::generateArray(1)) . ',' .
                    implode(",", self::generateArray(2)) . ',' .
                    implode(",", self::generateArray(3)) . ',' .
                    implode(",", self::generateArray(4)) . ',' .
                    implode(",", self::generateArray(5)) . ',' .
                    implode(",", self::generateArray(6))
            )
            );
    }

    public static function zodiacLast(array $drawnumber){
        return in_array(
            end($drawnumber),
            explode(
                ",",
                implode(",", self::generateArray(7)) . ',' .
                    implode(",", self::generateArray(8)) . ',' .
                    implode(",", self::generateArray(9)) . ',' .
                    implode(",", self::generateArray(10)) . ',' .
                    implode(",", self::generateArray(11)) . ',' .
                    implode(",", self::generateArray(12))
            )
            );
    }

    public static function poultry(array $drawnumber){
        return in_array(
            end($drawnumber),
            explode(
                ",",
                implode(",", self::generateArray(2)) . ',' .
                    implode(",", self::generateArray(7)) . ',' .
                    implode(",", self::generateArray(8)) . ',' .
                    implode(",", self::generateArray(10)) . ',' .
                    implode(",", self::generateArray(11)) . ',' .
                    implode(",", self::generateArray(12))
            )
            );
    }

    public static function beast(array $drawnumber){
        return in_array(
            end($drawnumber),
            explode(
                ",",
                implode(",", self::generateArray(1)) . ',' .
                    implode(",", self::generateArray(3)) . ',' .
                    implode(",", self::generateArray(5)) . ',' .
                    implode(",", self::generateArray(6)) . ',' .
                    implode(",", self::generateArray(4)) . ',' .
                    implode(",", self::generateArray(9))
            )
            );
    }

}