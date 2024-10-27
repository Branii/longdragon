<?php 

spl_autoload_register(function ($class) {
    $dirs = [
        'app/','app/config/','app/controller/','app/core/',
        'app/database/','app/games/','app/data/','app/utils',
        'app/services/','public/','app/games/','app/model/'
    ];
    foreach ($dirs as $dir) {
        $filename = $dir . DIRECTORY_SEPARATOR . $class . '.php';
        if (file_exists($filename)) {
            include $filename;
            return;
        }
    }
});