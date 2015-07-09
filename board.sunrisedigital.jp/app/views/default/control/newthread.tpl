{extends file = "default/base.tpl"}
{block title}スレッド一覧{/block}
{block main_contents}
  <div class="panel panel-default">
    <div class="panel panel-heading">Thread一覧</div>
    <div class="panel panel-body">
      {$current_page = $pager->getPage()}
      {if $current_page <= $pager->getLastPageId()}
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
              <td><a href="/thread/title?thread_id={$thread->getId()}">{$thread->getTitle()}</a></td>
              <td>{$thread->getGenre()->getName()}</td>
              <td>{$thread->getCreateAt()}</td>
            </tr>
          {/foreach}
        </table>
      {else}
        <p>登録がありません</p>
      {/if}
      <div class="text-center">
        {if $current_page > $pager->getFirstPageId()}
          <a href="/control/newthread?page={$pager->getPrevPageId()}"><<前の5件</a>
        {/if}
        {if $current_page < $pager->getLastPageId()}
          <a href="/control/newthread?page={$pager->getNextPageId()}">次の5件>></a>
        {/if}
      </div>
    </div>
  </div>
{/block}  