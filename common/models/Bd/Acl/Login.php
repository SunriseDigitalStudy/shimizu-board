<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Bd_Acl_Login
 *
 * @author newpc
 */
class Bd_Acl_Login implements Sdx_Acl_Directory
{
    //put your code here
    public function isAllowed(Sdx_Context $context)
    {
//        Sdx_Userのインスタンス
        $user = $context->getUser();
//        認証されたユーザーの場合はtureが返る
        return $user->hasId();
    }
}