<?php 

class App {
    public static function run() {

        app()->get("/api/v1/5d", function () {
            $response = (new Renderer())->render_5d((new Data)->fiveD());
            $filtered = array_map(fn($value) => array_filter($value, fn($array) => !empty($array)), $response);
            $mergedArray = array_merge(...array_map('array_values', $filtered));
            response()->json($mergedArray);
        });

        app()->get("/api/v1/3d", function () {
            $response = (new Renderer())->render_3d((new Data)->threeD());
            $filtered = array_map(fn($value) => array_filter($value, fn($array) => !empty($array)), $response);
            $mergedArray = array_merge(...array_map('array_values', $filtered));
            response()->json($mergedArray);
        });

        app()->get("/api/v1/pk10", function () {
            $response = (new Renderer())->render_pk10((new Data)->pk10());
            $filtered = array_map(fn($value) => array_filter($value, fn($array) => !empty($array)), $response);
            $mergedArray = array_merge(...array_map('array_values', $filtered));
            response()->json($mergedArray);
        });

        app()->get("/api/v1/fast3", function () {
            $response = (new Renderer())->render_fast3((new Data)->fast3());
            $filtered = array_map(fn($value) => array_filter($value, fn($array) => !empty($array)), $response);
            $mergedArray = array_merge(...array_map('array_values', $filtered));
            response()->json($mergedArray);
        });

        app()->get("/api/v1/eleven5", function () {
            $response = (new Renderer())->render_eleven5((new Data)->eleven5());
            $filtered = array_map(fn($value) => array_filter($value, fn($array) => !empty($array)), $response);
            $mergedArray = array_merge(...array_map('array_values', $filtered));
            response()->json($mergedArray);
        });

        app()->get("/api/v1/happy8", function () {
            $response = (new Renderer())->render_happy8((new Data)->happy8());
            $filtered = array_map(fn($value) => array_filter($value, fn($array) => !empty($array)), $response);
            $mergedArray = array_merge(...array_map('array_values', $filtered));
            response()->json($mergedArray);
        });
          
        app()->run();

    }
}