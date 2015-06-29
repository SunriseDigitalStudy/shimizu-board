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
        $t_entry = Bd_Orm_Main_Entry::createTable();
        $sb_entry = $t_entry->createSelectBuilder();
        $sb_entry->account->innerJoin();
        $sb_entry->addWhere('id', array($this->_getParam('entry_no')));
        $select = $sb_entry->build();
        $this->view->assign('list',$t_entry->fetchAll($select));
        
        $form = new Sdx_Form();
        $form->setActionCurrentPage()->setMethodToPost();
        
        $this->view->assign('form', $form);   
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
        $sb_entry->addWhere('thread_id', array($this->_getParam('thread_id')));
        $select = $sb_entry->build();
        $this->view->assign('list', $t_entry->fetchAll($select));

        $form = new Sdx_Form();
        $form->setActionCurrentPage()->setMethodToPost();
        $elem = new Sdx_Form_Element_Textarea();
        $elem->setName('body')
                ->addValidator(new Sdx_Validate_NotEmpty());
        $form->setElement($elem);

        //formがsubmitされていたら
        if ($this->_getParam('submit')) {
            $form->bind($this->_getAllParams());

            if ($form->execValidate()) {
                $entry = new Bd_Orm_Main_Entry();
                $db = $entry->updateConnection();
                $db->beginTransaction();

                try {
                    $current_account = Sdx_Context::getInstance()->getVar('signed_account');
                    $entry->setBody($this->_getParam('body'))
                            ->setAccountId($current_account)
                            ->setThreadId($this->_getParam('thread_id'));
                    $entry->save();
                    $db->commit();
                    $this->redirectAfterSave('/thread/title?thread_id=' . $this->_getParam('thread_id'));
                } catch (Exception $e) {
                    $db->rollback();
                    throw $e;
                }
            }
        }
        $this->view->assign('form', $form);
    }

    public function editAction() {
        $t_entry = Bd_Orm_Main_Entry::createTable();
        $sb_entry = $t_entry->createSelectBuilder();
        $sb_entry->account->innerJoin();
        $sb_entry->addWhere('id', array($this->_getParam('entry_no')));
        $select = $sb_entry->build();
        foreach ($t_entry->fetchAll($select) as $edit) {
        }
        $this->view->assign('body', $edit->getBody());

        $form = new Sdx_Form();
        foreach ($t_entry->fetchAll($select) as $list) {
            $form->setActionCurrentPage()
                    ->setMethodToPost();
//            Sdx_Debug::dump($list->getBody(),'test');
        }

        $elem = new Sdx_Form_Element_Textarea();
        $elem  ->setName('edit')
               ->addValidator(new Sdx_Validate_NotEmpty());
        $form->setElement($elem);

        if ($this->_getParam('submit')) {
            $form->bind($this->_getAllParams());
            if ($form->execValidate()) {
                $t_entry = Bd_Orm_Main_Entry::createTable();
                $entry = $t_entry->findByPkey($this->Param('entry_no'));
                $db = $entry->upDateConnection();
                $db->beginTransaction();

                try {
                    $entry->setBody($this->_getParam('edit'));
                    $entry->save();
                    $db->commit();
                    $this->redirect('/thread/title?thread_id=' . $list->getThreadId());
                } catch (Exception $e) {
                    $db->rollback();
                    throw $e;
                }
            }
        }
        $this->view->assign('form', $form);
    }
}