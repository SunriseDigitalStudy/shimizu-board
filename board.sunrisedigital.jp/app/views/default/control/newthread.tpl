{extends file = "default/base.tpl"}
{block title}スレッド一覧{/block}
{block main_contents}
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
          <td>{$thread->getName()}</td>
{*          <td>{$thread->getGenre()->getName()}</td>*}
{*          <td>{$thread->getCreateAt()}</td>*}
        </tr>
        {/foreach}
      </table>
      <div class="text-center"><a href="/control/newthread?page={$pager->getPrevPageId()}"><<前の5件</a>
        
        <a href="/control/newthread?page={$pager->getNextPageId()}">次の5件>></a></div>
    </div>
  </div>
{/block}  