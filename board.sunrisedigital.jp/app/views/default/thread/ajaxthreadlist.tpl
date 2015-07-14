{extends file='default/base.tpl'}
{block title}Thread検索{/block}
{block js}
  <script>
    $(function () {
      var title;
      var tag;
      var page = 1;
 
      function updateList(titleName, tagId, pagenumber) {
        $.ajax({
          url: '/thread/ajaxthreadlist',
          data: {
            title: titleName,
            tag: tagId,
            pid: pagenumber
          },
          success: function (data) {
            $('.panel-body').html($(data).find(".panel-body").html());
          },
          error: function (data) {
            alert("error");
          }
        });
      }

      $("#text").keyup(
          function () {
            title = $("#text").val();
            updateList(title, tag, page);
            page = 1;
          });

      $(":checkbox").click(
          function () {
            tag = $('[class = "tag"]:checked').map(function () {
              return $(this).val();
            }).get();
            page = 1;
            updateList(title, tag, page);
          });

      $("button[type=reset]").click(
          function () {
            $("#text").val("");
            $("input:checked").prop('checked', false);
            updateList();
          });

      $("#prevpage").click(
          function () {
            if (page <= 1) {
              page = 1;
            } else {
              page = page - 1;
            }
            updateList(title, tag, page);
          });

      $("#nextpage").click(
          function () {
          lastpage = $(".table").data("lastpageid");
          if (page >= lastpage) {
            page = lastpage;
          } else {
            page = page + 1;
          }
          updateList(title, tag, page);
        });
    });
  </script>
{/block}
{block main_contents}
  <div class="panel panel-default">
    {*    <div class="panel panel-body">*}
    <p>
      <input type="text" class="form-control" id="text"/>
    </p>
    <p>
      {foreach $taglist as $tag}
        <input type="checkbox" class="tag" value="{$tag->getId()}">{$tag->getName()}
      {/foreach}
    </p>
    {*    </div>*}
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
    <div class="text-center">
      {$pager->getPrevLink('前の5件') nofilter}
      {$pager->getNextLink('次の5件') nofilter}
    </div>
  </div>
{/block}