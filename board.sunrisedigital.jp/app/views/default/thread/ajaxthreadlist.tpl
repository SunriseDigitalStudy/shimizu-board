{extends file='default/base.tpl'}
{block title}Thread検索{/block}
{block js}
  <script>
    $(function () {
      var title;
      var tag;
      var page = {$pager->getPage()};
      
      function updateList(titleName,tagId,pagenumber){
        $.ajax({
          url: '/thread/ajaxlist',
          data: {
            title: titleName,
            tag: tagId ,
            page: pagenumber
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
          updateList(title,tag,page);
          page = 1;
        });
      
      $(":checkbox").click(
        function () {
          tag = $('[class = "tag"]:checked').map(function () {
            return $(this).val();
          }).get();
          page = 1;
          updateList(title,tag,page);
        });

      $("button[type=reset]").click(
        function () {
          $("#text").val("");
          $("input:checked").prop('checked', false);
          updateList();
        });
        
      $("#prevpage").click(
        function(){
          page= page - 1;
          console.log(page);
          updateList(title,tag,page);        
      });
      
      $("#nextpage").click(
        function(){     
          page= page + 1;
          console.log(page);
          updateList(title,tag,page);
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
      <div class="text-center">
{*        {$pager->getPrevLink('前の5件') nofilter}*}
        <button class="btn panel-default" id="prevpage" type="button">前の5件</button>
        <button class="btn panel-default" id="nextpage" type="button">次の5件</button>
      </div>
    </div>
  </div>
{/block}