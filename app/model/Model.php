<?php 

class Model extends Helper {

    public static function getLastTenDraws(string $lotteryId): array {
        return [];
    }

    public static function getGameInfoByGameId(int $gameId): array {
        $sql = "SELECT * FROM longdragon WHERE gn_id = ?";
        $result = parent::selectAll($sql,[$gameId]);
        return $result;
    }



}