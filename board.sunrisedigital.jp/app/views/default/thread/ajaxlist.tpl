<div id="jquery-sample">
  <div class="panel panel-default">
    <div class="panel panel-heading">Thread一覧</div>
    <div class="panel panel-body">
      <table class="table">
      <tr>
        <th>ID</th>
        <th>タイトル</th>
        <th>ジャンル</th>
        <th>登録日時</th>
      </tr>
      {foreach $list as $thread}
        {$thread_t = $thread->getThread()}
        <tr>
          <td>{$thread_t->getId()}</td>
          <td><a href="/thread/title?thread_id={$thread_t->getId()}">{$thread_t->getTitle()}</a></td>
          <td>{$thread_t->getGenre()->getName()}</td>
          <td>{$thread_t->getCreateAt()}</td>
        </tr>
      {/foreach}
    </table>
    <span id="jquery-sample-textStatus"></span>
    </div>
  </div>
</div>
