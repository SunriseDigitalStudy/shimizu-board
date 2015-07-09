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
    //テンプレートのパスの設定  
    $this->_helper->scaffold->setViewRendererPath('default/control/scaffold.tpl');
    $this->_helper->scaffold->run();
  }

  //Sdx_Db_Select_Builder_Contextクラスをテストするためのアクション
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
//        entryテーブルの生成
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
  public function joinBuilderAction() {
    $this->_disableViewRenderer();
//        entryテーブルの生成
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
  public function joinSelectAction() {
    $this->_disableViewRenderer();

    $t_entry = Bd_Orm_Main_Entry::createTable();
//        thread/genre両テーブルをJOIN。返り値には配列で書くSdx_Db_Tableのインスタンスが返る
    list($t_thread, $t_genre) = $t_entry->innerJoin('Thread', 'Genre');
    list($_thread_tag) = $t_thread->innerJoin('ThreadTag');

    $select = $t_entry->select();
    $select
            ->addWhere('tag_id', array(2, 3), $_thread_tag)
            ->order($t_genre->appendAlias('sequence DESC'));

    $list = $t_entry->fetchAll($select);
  }

  public function changeJoinAction() {
    $this->_disableViewRenderer();

    $t_entry = Bd_Orm_Main_Base_Entry::createTable();
    $sb_entry = $t_entry->createSelectBuilder();
    $sb_entry->account->innerJoin('%%left%%.account_id = %%right%%.id AND %%left%%.thread_id = 2');

    $select = $sb_entry->build();

    $list = $t_entry->fetchAll($select);
  }

  public function groupAction() {
    $this->_disableViewRenderer();

    $t_entry = Bd_Orm_Main_Base_Entry::createTable();
    $sb_entry = $t_entry->createSelectBuilder();

//        SELECT
//        `entry`.`id`,
//        `entry`.`thread_id`,
//        `entry`.`account_id`,
//        `entry`.`body`,
//        `entry`.`updated_at`,
//        `entry`.`created_at`
//        FROM
//        `entry`
//        GROUP BY
//        `entry`.`account_id`
//        HAVING(
//        COUNT(`entry`.id) >= 2
//        )
    $sb_entry->group('account_id');
    $sb_entry->builder()->formatHaving(
//              配列で:count_entry_idに2を渡す
            'Count({entry}.id)>=:count_entry_id', array(':count_entry_id' => 2)
    );

    $select = $sb_entry->build();

    $list = $t_entry->fetchAll($select);
  }

  public function whereBuilderAction() {
    $this->_disableViewRenderer();

    $t_entry = Bd_Orm_Main_Entry::createTable();
    $sb_entry = $t_entry->createSelectBuilder();
//        INNERJOIN
    $sb_entry->account->innerJoin();
//        配列でthread_id,like1に1、fooを渡す
    $sb_entry->builder()->format(
//                '{entry}.thread_id = :thread_id AND ({account}.name LIKE :like_1 OR {account}.name LIKE :like_1)',
//                like2にbarが渡されてるかのテストコード
            '{entry}.thread_id = :thread_id AND ({account}.name LIKE :like_1 OR {account}.name LIKE :like_2)', array(':thread_id' => 1, ':like_1' => '%foo%', ':like_2' => '%bar%',)
    );
    $select = $sb_entry->build();

    $list = $t_entry->fetchAll($select);
  }

  public function subqueryAction() {
    $this->_disableViewRenderer();

    $t_entry = Bd_Orm_Main_Entry::createTable();
    $sb_entry = $t_entry->createSelectBuilder();
    $sb_entry->account->innerJoin();

    $sb_entry
            ->addWhere('thread_id', array(2, 3));
//        サブクエリJOINのため一旦Sdx_Db_Selectを生成する
    $select = $sb_entry->build();

//        サブクエリ用のSdx_Db_Selectを新たに生成
    $sub_sel = Bd_Orm_Main_Entry::createTable()->select()
            ->group('id')
            ->setColumns(array('max_id' => 'MAX(id)'));
//        JOINする
    $select->joinInner(
            array('sub_entry' => new Zend_Db_Expr('(' . $sub_sel->assemble() . ')')), 'sub_entry.max_id = ' . $sb_entry->table()->appendAlias('account_id')
    );
    $list = $t_entry->fetchAll($select);
  }

  public function __call($name, $arguments) {
    $this->_helper->scaffold->setViewRendererPath('default/control/scaffold.tpl');
    $this->_helper->scaffold->run();
  }

//    public function threadAction() {
//        $this->_helper->scaffold->setViewRendererPath('default/control/scaffold.tpl');
//
//        $this->_helper->scaffold->setHook(Sdx_Controller_Action_Helper_Scaffold::HOOK_CREATE_FORM, array($this, 'hookCreateForm'));
//
//        $this->_helper->scaffold->setHook(Sdx_Controller_Action_Helper_Scaffold::HOOK_BIND_FORM, array($this, 'hookBindForm'));
//
//        $this->_helper->scaffold->setHook(Sdx_Controller_Action_Helper_Scaffold::HOOK_BIND_PARAMS_TO_FORM, array($this, 'hookBindParamsToForm'));
//
//        $this->_helper->scaffold->setHook(Sdx_Controller_Action_Helper_Scaffold::HOOK_BEFORE_RECORD_SAVE, array($this, 'hookBeforeRecordSave'));
//
//        $this->_helper->scaffold->setHook(Sdx_Controller_Action_Helper_Scaffold::HOOK_OPTIONAL_VALIDATE, array($this, 'hookOptionalValidate'));
//
//        $this->_helper->scaffold->setHook(Sdx_Controller_Action_Helper_Scaffold::HOOK_AFTER_RECORD_SAVE, array($this, 'hookAfterRecordSave'));
//
//        $this->_helper->scaffold->setHook(Sdx_Controller_Action_Helper_Scaffold::HOOK_LIST_SELECT_BUILDER, array($this, 'hookListSelectBuilder'));
//
//        $this->_helper->scaffold->setHook(Sdx_Controller_Action_Helper_Scaffold::HOOK_LIST_SELECT, array($this, 'hookListSelect'));
//
//        $this->_helper->scaffold->run();
//    }
//
//    public function hookCreateForm($params) {
//        Sdx_Debug::dump($params, 'hookCreateForm');
//    }
//
//    public function hookBindForm($params) {
//        Sdx_Debug::dump($params, 'hookBindForm');
//    }
//
//    public function hookBindParamsToForm($params) {
//        Sdx_Debug::dump($params, 'hookBindParamsToForm');
//    }
//
//    public function hookBeforeRecordSave($params) {
//        Sdx_Debug::dump($params, 'hookBeforeRecordSave');
//    }
//
//    public function hookOptionalValidate($params) {
//        Sdx_Debug::dump($params, hookOptionalValidate);
//    }
//
//    public function hookAfterRecordSave($params) {
//        Sdx_Debug::dump($params, 'hookAfterRecordSave');
//    }
//
//    public function hookListSelectBuilder($params) {
//        Sdx_Debug::dump($params, 'hookListSelectBuilder');
//    }
//
//    public function hookListSelect($params) {
//        Sdx_Debug::dump($params, 'hookListSelect');
//    }
//
//    public function genreListAction() {
//        $this->_helper->scaffold->setViewRendererPath('default/control/scaffold.tpl');
////      リスト画面のみを起動する（編集画面のURL,設定名）  
//        $this->_helper->scaffold->runList('/control/genre-edit', 'scaffold/default/control/genre');
//    }
//
//    public function genreEditAction() {
//        $this->_helper->scaffold->setViewRendererPath('default/control/scaffold.tpl');
////      編集画面を起動する（リスト画面のURL,設定名）  
//        $this->_helper->scaffold->runEdit('/control/genre-list', 'scaffold/default/control/genre');
//    }

  function newthreadAction() {
    $t_thread = Bd_Orm_Main_Thread::createTable();
    $select = $t_thread->select()->limitPage($this->param('page'), 5);
    $list = $t_thread->fetchAll($select);

    $this->view->assign("list", $list);

    $record_count = $t_thread->select()->countRow();
    $pager = new Sdx_Pager(5, $record_count);
    $pager->setPage($this->param('page'));

    $this->view->assign("pager", $pager);
  }
}