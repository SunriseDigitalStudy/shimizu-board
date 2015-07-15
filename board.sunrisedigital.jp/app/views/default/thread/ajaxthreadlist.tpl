{extends file='default/base.tpl'}
{block title}Thread検索{/block}
{block js}
  <script>
    $(function () {
      function updateList(page){
        var panelBody = '.panel-body';
        var search_text = $('#text');
        $.ajax({
          url: '/thread/ajaxlist',
          data:{
            title: search_text.val(),
            tag: $('.tag:checked').map(function(){
            return $(this).val();}).get(),
            pid: page ? page : 1
          }
        }).done(function(responce_data){
          $(panelBody).html($(responce_data).find(panelBody).html());
        }).fail(function(responce_data){
          alert("error");
        });
      }

      $("#text").keyup(function () {
        updateList();
      });

      $(":checkbox").change(function () {
          updateList();
        });

      $("button[type=reset]").click(function () {
        $("#text").val("");
        $("input:checked").prop('checked', false);
        updateList();
      });

      $("#prevpage").click(function () {
        if (page <= 1) {
          page = 1;
        }else {
          page = page - 1;
        }
        updateList();
      });

      $("#nextpage").click(function () {
        lastpage = $(".table").data("lastpageid");
        if (page >= lastpage) {
          page = lastpage;
        } else {
          page = page + 1;
        }
          updateList();
      });
    });
  </script>
{/block}
{block main_contents}
  <div class="panel panel-default">
    <p>
      <input type="text" class="form-control" id="text"/>
    </p>
    <p>
      {foreach $taglist as $tag}
        <input type="checkbox" class="tag" value="{$tag->getId()}">{$tag->getName()}
      {/foreach}
    </p>
    <div class="panel panel-heading">Thread一覧</div>
    <div class="panel panel-body">
      {if $list->isEmpty() === true}
        <p>一致する検索結果はありません</p>
      {else}
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
      {/if}
    </div>
    <button class="btn btn-danger" type="reset">リセット</button>
    <div class="text-center">
      {$pager->getPrevLink('前の5件') nofilter}
      {$pager->getNextLink('次の5件') nofilter}
    </div>
  </div>
{/block}