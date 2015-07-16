{extends file='default/base.tpl'}
{block title}Thread検索{/block}
{block js}
  <script>
    $(function () {
      var page;
      function getFormData(){
        var search_text = $('#text');
        var tagIds_checked = $('.tag:checked');
        return {
          title: search_text.val(),
          tag: tagIds_checked.map(function(){
                 return $(this).val();}).get(),
          pid: page ? page : 1
        };
      }
      
      function isUpdateData(currentData,newData){
        if(currentData !== newData){
          return true;
        }else{
          return false;
        }
      }
      
      var currentData = getFormData();
      function updateList(page){
        clearTimeout(timeout);
        var timeout = setTimeout(function(){
          var panelBody = '.panel-body';
          var newData = getFormData();
          if(isUpdateData(currentData,newData)){
            currentData = newData;
            $.ajax({
              url: '/thread/ajaxlist',
              data: newData
            }).done(function(responce_data){
              $(panelBody).html(responce_data);
            }).fail(function(responce_data){
              alert("error");
            });
          }
        },300);
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
     
      var divclass = $('.text-center');
      $("#prevpage").click(function () {
        page = page - 1;
        console.log(page);
        divclass.removeClass('has-prev has-next');
        hasprevId = $(".table").data('has-prev');
        if (page <= 1) {
          page = 1;
          divclass.addClass('has-next');
          divclass.removeClass('has-prev');
        } else {
          divclass.addClass('has-prev has-next');
        }
        updateList(page);
      });
      
      hasnextPageId = $('table').data('has-next');
      $("#nextpage").click(function () {
        divclass.removeClass('has-prev has-next');
        page = page + 1;
        lastpage = $(".table").data("lastpageid");
        page = lastpage;
        if (page >= lastpage) {
          divclass.removeClass('has-next');
          divclass.addClass('has-prev');
        } else {
          if(hasnextPageId === 1){
            divclass.addClass('has-prev has-next');
          }
        }
        updateList(page);
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
        <table class="table" data-has-next="{if $pager->hasNextPage()}1{/if}">
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
    <div class="text-center has-next">
      <button class="btn btn-default" id="prevpage">前の5件</button>
      <span class="disable_link" id='previd'>前の5件</span>
      <button class="btn btn-default" id="nextpage">次の5件</button>
      <span class="disable_link" id='nextid'>次の5件</span>
    </div>
  </div>
{/block}
{block css}
<style type='text/css'> 
  .has-prev #prevpage , .has-next #nextpage{
    visibility: visible;
  }
  .text-center button{
    visibility: hidden;
  }
  .has-prev #previd , .has-next #nextid{
    visibility: hidden;
    display: none;
  }
  .text-center #previd{
    visibility: visible;
  }
</style>
{/block}