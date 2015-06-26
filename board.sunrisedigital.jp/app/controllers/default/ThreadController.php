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

        
        $this->view->assign('list', $list);
    }

    public function titleAction() {
        $t_entry = Bd_Orm_Main_Entry::createTable();
        $sb_entry = $t_entry->createSelectBuilder();
        $sb_entry->account->innerJoin();
        $sb_entry->addWhere('thread_id',array($this->_getParam('thread_id')));
        $select = $sb_entry->build();
        $this->view->assign('list', $t_entry->fetchAll($select));

        $form = new Sdx_Form();
        $form->setActionCurrentPage()->setMethodToPost();
        $elem = new Sdx_Form_Element_Textarea();
        $elem   ->setName('body')
                ->addValidator(new Sdx_Validate_NotEmpty());
        $form->setElement($elem);

        //formがsubmitされていたら
        if ($this->_getParam('submit')) {
            //entryテーブルにinsertする際にユーザーIDが必要なためログインユーザーの情報を取得
            $context = Sdx_Context::getInstance();

            $form->bind($this->_getAllParams());

            $entry = new Bd_Orm_Main_Entry();
            $db = $entry->updateConnection();

            $db->beginTransaction();
            try {
                if ($form->execValidate()) {
                    $entry ->setBody($this->_getParam('body'))
                           ->setAccountId($context->getVar('signed_account')->getId())
                           ->setThreadId($this->_getParam('thread_id'));
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

}
