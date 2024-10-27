<?php  

class Database {

    private static $pdo;

    public static function openLink() {
       self::$pdo = new PDO("mysql:host=localhost;dbname=lottery","root","");
       return self::$pdo;
    }

    public static function closeLink() {
        return self::$pdo = null;
    }

}