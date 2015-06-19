<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of ControlController
 *
 * @author newpc
 */
class ControlController extends Sdx_Controller_Action_Http {

    //put your code here
    public function tagAction() {
//      テンプレートのパスの設定  
        $this->_helper->scaffold->setViewRendererPath('default/control/scaffold.tpl');
        $this->_helper->scaffold->run();
    }

    //    Sdx_Db_Select_Builder_Contextクラスをテストするためのアクション
    public function selectbuilderAction() {
        $this->_disableViewRenderer();
//        作成するSQL
//        SELECT
//        `entry`.`id`,
//        `entry`.`thread_id`,
//        `entry`.`account_id`,
//        `entry`.`body`,
//        `entry`.`updated_at`,
//        `entry`.`created_at`
//        FROM
//        `entry`
//        WHERE
//        (
//        `entry`.`thread_id` = 1
//        )
//        AND (
//        `entry`.`created_at` >= '2015-04-01 00:00:00'
//        )
//        ORDER BY
//        `entry`.`created_at` DESC
//        Entryテーブルの生成
        $t_entry = Bd_Orm_Main_Entry::createTable();
        $sb_entry = $t_entry->createSelectBuilder();

//        Sdx_Db_Select_Builder_Context
//        public function addWhere($column, $value, $comparison = Sdx_Db_Select::EQUAL) {
//            return $this->add($column, $value, $comparison);
//        }
        $sb_entry
                ->addWhere('thread_id', 1)
                ->addWhere('create_at', '2015-04-01 00:00:00', Sdx_Db_Select::GREATER_EQUAL)
//                比較演算子を省略した場合のテストコード
//                ->addWhere('create_at', '2015-04-01 00:00:00')
                ->order('create_at DESC');

//      Sdx_Db_Selectの生成
        $select = $sb_entry->build();

//        SQLを発行しリストを取得
        $list = $t_entry->fetchAll($select);
    }

//    Sdx_Db_Selectをテストするためのアクション
    public function selectAction() {
        $this->_disableViewRenderer();
//        Entryテーブルの生成
        $t_entry = Bd_Orm_Main_Entry::createTable();
        $select = $t_entry->select();
        $select
                ->addWhere('thread_id', 1, $t_entry)
                ->addWhere('create_at', '2015-04-01 00:00:00', $t_entry, Sdx_Db_Select::GREATER_EQUAL)
//                order句を複数つける場合は複数回呼び出す
                ->order($t_entry->appendAlias('create_at'));

//        SQLを発行しリストを取得
        $list = $t_entry->fetchAll($select);
    }

//    Sdx_Db_Select_Builder_Contextクラスを使用してJOINするテスト用アクション
    public function joinbuilderAction() {
        $this->_disableViewRenderer();
//        Entryテーブルの生成
        $t_entry = Bd_Orm_Main_Entry::createTable();
        $sb_entry = $t_entry->createSelectBuilder();

//        複数テーブルの一括JOIN
        $sb_entry->thread->genre->innerJoinChain()
                ->order('sequence DESC');

        $sb_entry->thread->thread_tag->innerJoin()
                ->addWhere('tag_id', array(2, 3));

        $select = $sb_entry->build();

//        SQLを発行しリストを取得
        $list = $t_entry->fetchAll($select);
    }

//    Sdx_Db_Selectクラスを使用してJOINするテスト用アクション
    public function joinselectAction() {
        $this->_disableViewRenderer();
        
        $t_entry = Bd_Orm_Main_Entry::createTable();
//        thread/genre両テーブルをJOIN。返り値には配列で書くSdx_Db_Tableのインスタンスが返る
        list($t_thread,$t_genre) = $t_entry->innerJoin('Thread','Genre');
        list($_thread_tag) = $t_thread->innerJoin('ThreadTag');
        
        $select = $t_entry->select();
        $select
           ->addWhere('tag_id',array(2,3),$_thread_tag)
           ->order($t_genre->appendAlias('sequence DESC'));
        
        $list = $t_entry->fetchAll($select);
    }

}
