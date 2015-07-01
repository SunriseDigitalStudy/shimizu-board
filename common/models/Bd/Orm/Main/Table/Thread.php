<?php

require_once 'Bd/Orm/Main/Base/Table/Thread.php';

class Bd_Orm_Main_Table_Thread extends Bd_Orm_Main_Base_Table_Thread {
  
    public function fetchAllNewerOrdered(Sdx_Db_Select $select = null)
    {
        if($select === null){
            $select = $this->getSelect();
        }
//      orderby句 id降順の並び替え（ORDER BY id DESC）
        $select->order('id DESC');
        
        return $this->fetchAll($select);
    }
    
}
