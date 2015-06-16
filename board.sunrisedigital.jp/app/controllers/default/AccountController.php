<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class AccountController extends Sdx_Controller_Action_Http {

    public function listAction() {
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

    public function createAction() {
        $form = new Sdx_Form();
        $form
                ->setActionCurrentPage() //アクション先を現在のURLに設定
                ->setMethodToPost(); //メソッドをポストに変更
        //各エレメントをフォームにセット
//        login_id
        $t_account = Bd_Orm_Main_Account::createTable();
        $elem = new Sdx_Form_Element_Text();
        $elem->setName('login_id');
        $elem
                ->addValidator(new Sdx_Validate_NotEmpty())
                ->addValidator(new Sdx_Validate_Regexp('/^[a-zA-Z0-9]+$/u', '英数字と＠_-のみ使用可能です'))
                ->addValidator(new Sdx_Validate_Db_Unique(
                        $t_account,
                        'login_id',
                        $t_account->getSelect()->forUpdate()
                ));
        $form->setElement($elem);

        //password
        $elem = new Sdx_Form_Element_Password();
        $elem
                ->setName('password')
                ->addValidator(new Sdx_Validate_NotEmpty())
                ->addValidator(new Sdx_Validate_StringLength(array('min' => 4)));
        $form->setElement($elem);

        //name
        $elem = new Sdx_Form_Element_Text();
        $elem
                ->setName('name')
                ->addValidator(new Sdx_Validate_NotEmpty())
                ->addValidator(new Sdx_Validate_StringLength(array('max' => 18)));
        $form->setElement($elem);

//        formがsubmitされていたら
        if ($this->_getParam('submit')) {
//            Validateを実行するためにformを値をセット
//            エラーがあったとき各エレメントに値を戻す処理も兼ねている
            $form->bind($this->_getAllParams());

            $account = new Bd_Orm_Main_Account();
            $db = $account->updateConnection();

            $db->beginTransaction();

            try {
//                Validateの実行はFOR UPDATEのためトランザクションの内側
                if ($form->execValidate()) {
//                    すべてのエラーチェックを通過
                    $account
                            ->setLoginId($this->_getParam('login_id'))
                            ->setRawPassword($this->_getParam('password'))
                            ->setName($this->_getParam('name'));

                    $account->save();

                    $db->commit();

                    $this->redirectAfterSave('/account/create');
                } else {
                    $db->rollback();
                }
            } catch (Exception $e) {
                $db->rollback();
                throw $e;
            }

//            Validateを実行
            if ($form->execValidate()) {
//               すべてのエラーチェックを通過
            }
        }
        $this->view->assign('form', $form);
    }
}
