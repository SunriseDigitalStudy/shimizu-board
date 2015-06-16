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
}