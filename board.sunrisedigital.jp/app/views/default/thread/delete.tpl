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
        </div>
      </div> 
    </form>
    <a href="/thread/title?thread_id={$value}"><button class="btn btn-default">キャンセル</button></a>
  </div>
{/block}