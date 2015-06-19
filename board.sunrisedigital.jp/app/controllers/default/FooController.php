<?php

class FooController extends Sdx_Controller_Action_Http {

    public function indexAction() {
        $this->_disableViewRenderer();
    }

    public function barAction() {
        $this->view->assign('date', date('Y-m-d H:i:s'));
    }

    public function dbAction() {
        $this->_disableViewRenderer();

        //接続を取得
        $db = Bd_Db::getConnection('board_master');

        //トランザクション開始
        $db->beginTransaction();

        //テーブル名を指定してINSERT文を生成・実行
        $db->insert('account', array(
            'login_id' => 'check',
            'password' => 'some_password',
            'name' => 'Some Name',
            'create_at' => date('Y-m-d H:i:s'),
            'updated_at' => date('Y-m-d H:i:s'),
        ));

        //コミット
        $db->commit();

        //取得して確認
        Sdx_Debug::dump($db->query("SELECT * FROM account")->fetchAll(), 'title');
    }

    public function ormNewAction() {
        $this->_disableViewRenderer();

//     レコードクラスの生成
        $account = new Bd_Orm_Main_Account();

        $account
                ->setLoginId('newtest')
                ->setName('New Name')
                ->setPassword('flkdjf0');

//      このレコードが使用する接続を取得
        $db = $account->updateConnection();

        $db->beginTransaction();
        $account->save();
        $db->commit();

//      取得して確認
        Sdx_Debug::dump($db->query("SELECT * FROM account")->fetchAll(), "title");
    }

    public function ormSelectAction() {
        $this->_disableViewRenderer();

//      テーブルクラスの取得
        $t_account = Bd_Orm_Main_Account::createTable();

//      主キー1のレコードを取得
        $account = $t_account->findByPkey(1);

//      toArray()はレコードの配列表現を取得するメソッド
        Sdx_Debug::dump($account->toArray(), 'title');

//      selectの取得
        $select = $t_account->getselect();

//      selectにWHERE句を追加
        $select->add('id', array(6, 8));

//      sqlを発行
        $list = $t_account->fetchAll($select);

//      fetchAllの返り値は配列ではなくBd_Db_Record_Listのインスタンス
        Sdx_Debug::dump($list, 'title');

//      Record_Listの配列表現をdump
        Sdx_Debug::dump($list->toArray(), 'title');

//      簡単なJOIN
//      JOIN対象のテーブルを作成
      $t_account = Bd_Orm_Main_Account::createTable();
      $t_entry = Bd_Orm_Main_Entry::createTable();
      
//      INNNER JOIN
      $t_account->addJoinInner($t_entry);
      
//      selectを取得するメソッドがgetSelectWithJoinなので注意
      $select = $t_account->getSelectWithJoin();
      
//      この結果はまだentryにレコードがないのでSQLだけ確認
      $list = $t_account->fetchAll($select);
    }

    public function ormUpdateAction() {
        $this->_disableViewRenderer();

//      テーブルクラスの取得
        $t_account = Bd_Orm_Main_Account::createTable();

//      主キー1のレコードを更新
        $account = $t_account->findByPKey(6);

        $account->setPassword('updated_password_' . date('Y-m-d H:i:s'));

        $db = $account->updateConnection();

        $db->beginTransaction();
        $account->save();
        $db->commit();

//      取得して確認
        Sdx_Debug::dump($db->query("select * from account")->fetchAll(), 'title');
    }

    public function ormDeleteAction() {
        $this->_disableViewRenderer();

//      テーブルクラスの取得
        $t_account = Bd_Orm_Main_Account::createTable();
//      主キー1のレコードを取得
        $account = $t_account->findByPkey(4);

        $db = $account->updateConnection();

        $db->beginTransaction();
        $account->delete();
        $db->commit();

//      取得して確認
        Sdx_Debug::dump($db->query("select * from account")->fetchAll(), 'title');
    }

}
