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
    $this->view->assign('value', $entry->getThreadId());
  }

  public function ajaxthreadlistAction() {
    if ($this->getRequest()->isXmlHttpRequest()) {
      $this->_forward('ajaxlist');
      return;
    }

    $t_tag = Bd_Orm_Main_Tag::createTable();
    $tagselect = $t_tag->select();
    $taglist = $t_tag->fetchAll($tagselect);
    
    $this->view->assign('taglist', $taglist);
  }

  public function ajaxlistAction() {
    $this->_disableViewRenderer();
    $json_and_pager_object = $this->createSearchDataAndPager($this->param("title"),  $this->param("tag"));  
    
    $this->jsonResponse($json_and_pager_object);
  }
  
  public function createResultListAndPager($search_title = NULL ,$search_tags = NULL){
    $t_thread = Bd_Orm_Main_Thread::createTable();
    $sb_thread = $t_thread->createSelectBuilder();
    
    if ($search_tags) {
      $sb_thread->thread_tag->tag
                ->innerJoinChain()
                ->addWhere('id', $search_tags);
      $sb_thread->group('id');
      $sb_thread->builder()->formatHaving('COUNT({tag}.id) = :count_tag_id', array(':count_tag_id' => count($search_tags)));
    }

    $sb_thread->addLike('title', '%'.$search_title.'%');
    
    $select = $sb_thread->build();
    $record_count = $select->countRow();

    $pager = new Sdx_Pager(5, $record_count);
    $pager->setPage($this->param('pid'));
    $select->limitPager($pager);
    
    $list = $t_thread->fetchAll($select);
    
    return array($list,$pager);
  }
  
  public function createSearchDataAndPager($search_title = NULL ,$search_tags = NULL){
    list($result_list,$pager) = $this->createResultListAndPager($search_title,$search_tags);
   
    $record_pager_list = array();
    $thread_data_array = array();
    
    foreach ($result_list as $array) {
      $thread_data_array[] = array('id'=>$array->getId(),'title'=>$array->getTitle(),'genre'=>$array->getGenre()->getName(),'create'=>'0000-00-00');
    }
    
    $pager_data = array('currentpage'=>$pager->getPage(),'lastpage'=>$pager->getLastPageId(),'nextpage'=>$pager->hasNextPage(),'prevpage'=>$pager->hasPrevPage());
    
    $record_pager_list = array('thread'=>$thread_data_array,'pager'=>$pager_data);
      
    return $record_pager_list;
    
  }
  
  public function jsondatalistAction(){
    $t_thread = Bd_Orm_Main_Thread::createTable();
    $list = $t_thread->fetchAll();
    
    foreach ($list as $array) {
      $thread_data_array[] = array('id'=>$array->getId(),'title'=>$array->getTitle(),
          'genre'=>$array->getGenre()->getName(),'create'=>'0000-00-00');
    }
    
    $json_encode_array = json_encode($thread_data_array);
    $this->view->assign("json_encode_data",$json_encode_array);
  }
}
