{extends file="default/base.tpl"}
{block title}削除{/block}
{block main_contents}
  <div class="panel panel-heading">削除</div>
  <div class="panel-body">
    <form method="post">
    　<div class="form-group">
        <b>{$body|nl2br nofilter}</b>
        <h5>この書き込みを削除します</h5>
        <div>
          <input type='submit' name='submit' value="削除する" class="btn btn-danger">
          <input type='submit' name="cancel" value="キャンセル" class="btn btn-default">
        </div>
      </div> 
    </form>
  </div>
{/block}