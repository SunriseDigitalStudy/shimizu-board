<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
class AccountController extends Sdx_Controller_Action_Http
{
    public function listAction()
    {
        $t_account = Bd_Orm_Main_Account::createTable();
        $t_entry = Bd_Orm_Main_Entry::createTable();
        $t_thread = Bd_Orm_Main_Thread::createTable();
        
//        JOIN
        $t_account->addJoinLeft($t_entry);
        $t_entry->addJoinLeft($t_thread);
        
//        selectを生成
        $select = $t_account->getSelectWithJoin();
        $select->order('id DESC');
        
//        $listはSdx_Db_Record_Listのインスタンス
        $list = $t_account->fetchAll($select);
        
//        テンプレートにレコードリストのままアサイン
        $this->view->assign('account_list', $list);
        
    }
}
