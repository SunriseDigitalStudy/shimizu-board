<?php

require_once 'Bd/Orm/Main/Base/Const/Thread.php';

class Bd_Orm_Main_Const_Thread extends Bd_Orm_Main_Base_Const_Thread
{
    private static $_genres = array(1=>'ジャンル1',2=>'ジャンル2',3=>'ジャンル3');
    
    public static function getGenreCode($genre_id)
    {
        return self::$_genres[$genre_id];
    }
    public static function getGenreList()
    {
        return self::$_genres;
    }
}

