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
class ControlController extends Sdx_Controller_Action_Http
{
    //put your code here
    public function tagAction()
    {
//      テンプレートのパスの設定  
        $this->_helper->scaffold->setViewRendererPath('default/control/scaffold.tpl');
        $this->_helper->scaffold->run();
    }
    
}
