<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

Class ThreadController extends Sdx_Controller_Action_Http {

    public function indexAction() {
        Sdx_Debug::dump($this->_getParam('thread_id'), 'title');
    }

    public function addAction() {
        Sdx_Debug::dump($this->_getParam('thread_id'), 'title');
    }

    public function deleteAction() {
        Sdx_Debug::dump($this->_getParam('thread_id'), 'title');
    }

    public function menuAction() {
        $t_genre = Bd_Orm_Main_Genre::createTable();
        $select = $t_genre->select();
        $select->resetColumns()
                ->addColumns('name');
        $list = $t_genre->fetchAll($select);

//        Sdx_Debug::dump($list->getFirstRecord(),'title');
        $this->view->assign('list', $list);
    }

    public function contributeAction() {
        $form = new Sdx_Form();
        $form->setActionCurrentPage()->setMethodToPost();

//      ユーザーIDの取得
        $context = Sdx_Context::getInstance();
        $name = $context->getVar('signed_account')->getId();
        Sdx_Debug::dump($name, 'name');

//      thread_idを取得したい  
        $t_entry = Bd_Orm_Main_Entry::createTable();
//      innerjoinは成功している
        list($t_thread) = $t_entry->innerJoin('Thread');              
        $select = $t_entry->select();
        
//        $select ->resetColumns()
//              ->addColumns('thread_id');
        $list = $t_entry->fetchAll($select);
        
        Sdx_Debug::dump($list->getFirstRecord(),'listcheck');
//        $id = $list->getThredId();
//                ->getThreadId();
        
        Sdx_Debug::dump($select,'check');
        
//        $t_entry = Bd_Orm_Main_Entry::createTable();
        $elem = new Sdx_Form_Element_Text();
        $elem ->setName('body');
//          １文字以上の入力を必須にする
//            ->addValidator(new Sdx_Validate_StringLength(array('min' => 1)));
        $form ->setElement($elem);

//      formがsubmitされていたら
        if ($this->_getParam('submit')) {
            $form->bind($this->_getAllParams());

            $entry = new Bd_Orm_Main_Entry();
            $db = $entry->updateConnection();

            $db->beginTransaction();



            try {
                if ($form->execValidate()) {
                    $entry  ->setBody($this->_getParam('body'))
                            ->setAccountId($name)
//          thread_idがないとエラーが出たのでとりあえず適当な値をsetし動くかだけ確認     
                            ->setThreadId('1');
                    $entry->save();
                    $db->commit();

                    $this->redirectAfterSave('/thread/contribute');
                } else {
                    $db->rollback();
                }
            } catch (Exception $e) {
                $db->rollback();
                throw $e;
            }
        }
        $this->view->assign('form', $form);
    }

    public function contentAction() {
        
    }

}
