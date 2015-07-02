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
        <tr>
          <td>{$thread->getId()}</td>
          <td>{$thread->getTitle()}</td>
          <td>{$thread->getGenre()->getName()}</td>
          <td>{$thread->getCreateAt()}</td>
        </tr>
      {/foreach}
    </table>
    <span id="jquery-sample-textStatus"></span>
    </div>
  </div>
</div>
