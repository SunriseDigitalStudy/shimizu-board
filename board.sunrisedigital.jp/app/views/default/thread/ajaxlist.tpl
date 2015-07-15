<div class="panel panel-default">
  <div class="panel panel-body">
    {if $list->isEmpty() === true}
      <p>一致する検索結果はありません</p>
    {else}
      <table class="table" data-lastpageid="{$pager->getLastPageId()}">
        <tr>
          <th>ID</th>
          <th>タイトル</th>
          <th>ジャンル</th>
          <th>登録日時</th>
        </tr>
        {foreach $list as $thread}
          <tr>
            <td>{$thread->getId()}</td>
            <td><a href="/thread/title?thread_id={$thread->getId()}">{$thread->getTitle()}</a></td>
            <td>{$thread->getGenre()->getName()}</td>
            <td>{$thread->getCreateAt()}</td>
          </tr>
        {/foreach}
      </table>
    {/if}
  </div>
</div>