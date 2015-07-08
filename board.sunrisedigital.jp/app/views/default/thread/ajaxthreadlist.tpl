{extends file='default/base.tpl'}
{block title}Thread検索{/block}
{block js}
  <script>
    $(function () {
      var title;
      var tag;
      
      function updateList(titleName,tagId){
        $.ajax({
          url: '/thread/ajaxlist',
          data: {
            title: titleName,
            tag: tagId
          },
          success: function (data) {
            $('#thread-list').html(data);
          },
          error: function (data) {
            alert("error");
          }
        });
      }
      
      $("#text").keyup(
        function () {
          title = $("#text").val();            
          updateList(title,tag);
        });
      
      $(":checkbox").click(
        function () {
          tag = $('[class = "tag"]:checked').map(function () {
            return $(this).val();
          }).get();
          updateList(title,tag);
        });

      $("button[type=reset]").click(
        function () {
          $("#text").val("");
          $("input:checked").prop('checked', false);
          updateList();
        });
    });
  </script>
{/block}

{block main_contents}
  <div class="panel panel-default">
    <div class="panel panel-body">
      <p>
        <input type="text" class="form-control" id="text"/>
      </p>
      <p>
        {foreach $taglist as $tag}
          <input type="checkbox" class="tag" value="{$tag->getId()}">{$tag->getName()}
        {/foreach}
      </p>
      <div id="thread-list">
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
              {foreach $threadlist as $thread}
                <tr>
                  <td>{$thread->getId()}</td>
                  <td><a href="/thread/title?thread_id={$thread->getId()}">{$thread->getTitle()}</a></td>
                  <td>{$thread->getGenre()->getName()}</td>
                  <td>{$thread->getCreateAt()}</td>
                </tr>
              {/foreach}
            </table>
          </div>
        </div>
      </div>
      <p>
        <button type="reset" class="text-left btn btn-danger">リセット</button> 
      </p>
    </div>
  </div>
{/block}