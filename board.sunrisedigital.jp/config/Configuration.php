<?php
/**
 *
 *
 * @author  Masamoto Miyata <miyata@able.ocn.ne.jp>
 * @create  2009/09/14
 * @copyright 2007 Sunrise Digital Corporation.
 * @version  v 1.0 2009/09/14 18:50:08 Miyata
 **/
require_once Sdx_Context::getInstance()->getConfig()->get('sys.context_dir').'/models/Bd/Configuration.php';

class Configuration extends Bd_Configuration
{	
//    Sdx_Contextクラス=リクエスト全体を表現したクラス
protected function _initHttp(Sdx_Context $context)
  {
   parent::_initHttp($context);
 
    //If you want to register other auto load namespase, Remove this comment out.
    //$context->registerAutoloadNamespace('Other');
 
    $context->registerControllerPlugin(new Sdx_Controller_Plugin_AccessControl());
    $context->registerControllerPlugin(new Bd_Controller_Plugin_AutoLogin('.board.sunrisedigital.jp'));
 
    //NotificationCenterを取得
    $nc = $context->getNotificationCenter();
//    ログイン時のイベント
    $nc->addObserver(Sdx_User::NTF_LOGIN, array($this, 'login'));
//    ログインした状態でSdx_Userが生成されたときに呼ばれるイベント
    $nc->addObserver(Sdx_User::NTF_CREATE_WITH_IDENTITY, array($this, 'login'));
//    ログアウト時のイベント
    $nc->addObserver(Sdx_User::NTF_BEFORE_LOGOUT, array($this, 'logout'));
  }
 
  public function login(Sdx_Notification $ntf)
  {
    $user = $ntf->getObject();
    $t_acc = Bd_Orm_Main_Account::getTable();
    $account = $t_acc->findByColumn('login_id', $user->getLoginId());
    //login_idが変更された時は強制的にログアウト
    if($account instanceOf Sdx_Null)
    {
      $user->logout();
    }
    else
    {
      $context = Sdx_Context::getInstance();
      $context->setVar('signed_account', $account);
    }
  }
 
  public function logout(Sdx_Notification $ntf)
  {
    $context = Sdx_Context::getInstance();
    $context->unsetVar('signed_account');
  }
}