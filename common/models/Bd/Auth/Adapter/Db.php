<?php

/**
 * データベースを使うログインに使用します。使わない場合はSdx_Auth_Adapterを継承して下さい。
 * */
class Bd_Auth_Adapter_Db extends Sdx_Auth_Adapter_Db2 {

    /**
     * 入力されたログインID
     * @var string
     */
    private $_login_id;

    /**
     * 生パスワード
     * @var string
     */
    private $_password;

    /**
     * コンストラクタ
     * @param string $login_id 入力されたログインID
     * @param string $password 生パスワード
     */
    public function __construct($login_id, $password) {
        $this->_login_id = $login_id;
        $this->_password = $password;
    }

    /**
     * アカウントのデータを検索して返す
     * この段階ではまだパスワードチェックはしません。
     * @return boolean|mixed
     */
    protected function _find() {
        $t_account = Bd_Orm_Main_Account::getTable();
        $account = $t_account->findByColumn('login_id', $this->_login_id, $this->getDb());
//    アカウントが見つからなかったときの処理
        if (!$account instanceof Bd_Orm_Main_Account) {
//        サイドチャネル攻撃対策として同程度の時間を掛けるためにパスワード処理を行う
            Bd_Orm_Main_Account::hashPassword('timing attack guard');
            return false;
        }
        return $account;
    }

    /**
     * パスワードが一致しているか検証する
     * @param mixed $account
     * @return bool|array セッションの保持されてSdx_Userから取得可能になります。例：array('login_id'=>'xxxx', 'role'=>'xxx')
     */
    protected function _auth($account) {
//  入力されたパスワード($this->_password)と登録されているパスワード（$account->getPassword）
//  が一致しなかった場合
        if (Bd_Orm_Main_Account::hashPassword($this->_password) != $account->getPassword()) {
//      falseを返す
            return false;
        }
        return array(
            'id' => $account->getId(),
            'login_id' => $account->getLoginId(),
            'name' => $account->getName(),
        );
    }

}
