<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

Class ThreadController extends Sdx_Controller_Action_Http
{
    public function indexAction()
    {
        Sdx_Debug::dump($this->_getParam('thread_id'),'title');
    }
    
     public function addAction()
    {
        Sdx_Debug::dump($this->_getParam('thread_id'),'title');
    }
    
     public function deleteAction()
    {
        Sdx_Debug::dump($this->_getParam('thread_id'),'title');
    }
    
    public function menuAction()
    {
        $t_genre = Bd_Orm_Main_Genre::createTable();
        $select = $t_genre->select();
        $select ->resetColumns()
                ->addColumns('name');
        $list = $t_genre->fetchAll($select);
        
        Sdx_Debug::dump($list->getFirstRecord(),'title');
        $this->view->assign('list',$list);
    }
    public function newsAction()
    {
        
    }
}