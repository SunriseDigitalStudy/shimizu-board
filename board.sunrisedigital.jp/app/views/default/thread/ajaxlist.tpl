{if $list->isEmpty() === true}
  <p>一致する検索結果はありません</p>
{else}
  <table class="table" data-currentpageid="{$pager->getPage()}" data-lastpageid="{$pager->getLastPageId()}" data-has-next="{if $pager->hasNextPage()}1{/if}"
         data-has-prev="{if $pager->hasPrevPage()}1{/if}">
    <p>最終ページ「{$pager->getLastPageId()}」ページ,次のページがあれば「1」→{$pager->hasNextPage()}</p>
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