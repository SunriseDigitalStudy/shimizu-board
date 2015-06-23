<?php

/**
 *
 *
 * @author  Masamoto Miyata <miyata@able.ocn.ne.jp>
 * @create  2010/03/21
 * @copyright 2007 Sunrise Digital Corporation.
 * @version  v 1.0 2010/03/21 18:50:08 Miyata
 * */
class IndexController extends Sdx_Controller_Action_Http {

    public function indexAction() {
        $form = new Sdx_Form();
        $form
            ->setActionCurrentPage()
            ->setMethodToPost();
        
//      login_id
        $t_account = Bd_Orm_Main_Account::createTable();
        $elem = new Sdx_Form_Element_Text();
        $elem->setName('login_id');
        $form->setElement($elem);
        
//      password  
        $elem = new Sdx_Form_Element_Password();
        $elem->setName('password');
        $form->setElement($elem);
        
        $this->view->assign('form' , $form);
    }
}