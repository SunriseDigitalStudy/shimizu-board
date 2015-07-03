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
    $entry = Bd_Orm_Main_Entry::getTable()->findByPkey($this->param('entry_no', -1));
    if ($entry instanceof Sdx_Null) {
      $this->_forward404();
    }

    $this->view->assign('body', $entry->getBody());
    $this->view->assign('value', $entry->getThreadId());

    if ($this->_getParam('submit')) {
      $db = $entry->updateConnection();
      $db->beginTransaction();
      try {
        $entry->delete();
        $db->commit();
        $this->redirectAfterSave('/thread/title?thread_id=' . $entry->getThreadId('thread_id'));
      } catch (Exception $e) {
        $db->rollback();
        throw $e;
      }
    } 
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
          $current_account = Sdx_Context::getInstance()->getVar('signed_account')->getId();
          if (!$current_account) {
            throw new Sdx_Exception("ログインしてください");
          }
          $entry
            ->setBody($this->_getParam('body'))
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
    $entry = Bd_Orm_Main_Entry::getTable()->findByPKey($this->param('entry_no', -1));
    if ($entry instanceof Sdx_Null) {
      $this->_forward404();
    }

    $form = new Sdx_Form();
    $form
      ->setActionCurrentPage()
      ->setMethodToPost();

    $elem = new Sdx_Form_Element_Textarea();
    $elem
      ->setName('edit')
      ->setLabel($entry->getBody())
      ->addValidator(new Sdx_Validate_NotEmpty());
    $form->setElement($elem);
    $form->bind($entry->toArray());

    if ($this->_getParam('submit')) {
      $form->bind($this->_getAllParams());

      if ($form->execValidate()) {
        $db = $entry->upDateConnection();
        $db->beginTransaction();

        try {
          $entry->setBody($this->_getParam('edit'));
          $entry->save();
          $db->commit();
          $this->redirectAfterSave('/thread/title?thread_id=' . $entry->getThreadId());
        } catch (Exception $e) {
          $db->rollback();
          throw $e;
        }
      }
    }
    $this->view->assign('form', $form);
    $this->view->assign('value',$entry->getThreadId());
  }
  
  public function ajaxtestAction(){
    $t_tag = Bd_Orm_Main_Tag::createTable();
    $select = $t_tag->select();
    $list = $t_tag->fetchAll($select);
    $this->view->assign('list',$list);
  }
  
  public function ajaxlisttestAction(){
//    $t_thread = Bd_Orm_Main_Thread::createTable();
//    $t_select = $t_thread->select();
//    $t_select->order($t_thread->appendAlias('id'));
//    $t_list = $t_thread->fetchAll($t_select);
//    $this->view->assign("t_list",$t_list);
    
    $t_thread_tag = Bd_Orm_Main_ThreadTag::createTable();
    $select = $t_thread_tag->select();
    $list = $t_thread_tag->fetchAll($select);
    $this->view->assign('list',$list);
    
    $array = array('check'=>(1));
    http_build_query($array);
    Sdx_Debug::dump(http_build_query($array));
  }
}