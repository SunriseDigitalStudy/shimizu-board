{extends file='default/base.tpl'}
{block title}Thread検索{/block}
{block js}
  <script>
    $(function () {
      var page = 1;

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
      
      function isUpdateData(current_data,new_data){
        if(current_data !== new_data){
          return true;
        }else{
          return false;
        }
      }
      
      var current_data = getFormData();
      var nextpage;
      var prevpage;
      var lastpage;
      function updateList(page){
        clearTimeout(timeout);
        
        var timeout = setTimeout(function(){
          var new_data = getFormData();
          if(isUpdateData(current_data,new_data) === true){
            current_data = new_data;
            $.ajax({
              url: '/thread/ajaxlist',
              data: new_data,
              datatype: 'json'
            }).done(function(responceData){
              console.log(responceData);
              var table = $(".table");
              json_data_object = JSON.parse(responceData);
              
              if(json_data_object.length === 0){
                prevpage,nextpage = false;
                table.html("<p>検索に一致するスレッドはありません</p>");
              }else{
                  console.log("in");
                page = json_data_object["pager"].currentpage;
                nextpage = json_data_object["pager"].nextpage;
                prevpage = json_data_object["pager"].prevpage;
                lastpage = json_data_object["pager"].lastpage;
              
                table.html("<tr><th>ID</th><th>タイトル</th><th>ジャンル</th><th>登録日時</th></tr>");
                for(var i in json_data_object["thread"]){
                  table.append("<tr><td>"+json_data_object["thread"][i].id+"</td><td><a href=/thread/title?thread_id="+json_data_object["thread"][i].id+">"+json_data_object["thread"][i].title+
                    "</a></td><td>"+json_data_object["thread"][i].ジャンル+"</td><td>"+json_data_object["thread"][i].登録日+"</td></tr>");
                }
              }
                judgePrevPage();
                judgeNextPage();
            }).fail(function(responceData){
              alert("error");
            });
          }
        },300);
      }
      
      function judgePrevPage(){
        if (page <　1) {
          page = 1;
          divclass.addClass('has-next');
          divclass.removeClass('has-prev');
        } else {
          if(prevpage === true){
            divclass.addClass('has-prev');
          }else{
            divclass.removeClass('has-prev');
          }
        }
        return this;
      }
      
      function judgeNextPage(){
        if (page > lastpage) {
          page = lastpage;
          divclass.removeClass('has-next');
          divclass.addClass('has-prev');
        } else {
          if (nextpage === true) {
            divclass.addClass('has-next');
          } else {
            divclass.removeClass('has-next');
          }
        } 
        return this;
       }

      $("#text").keyup(function () {
        //強制的に1ページに戻すために代入。ここで代入しないとページングをしてから検索した場合、直前にいたpidでページが呼ばれてしまう
        page = 1;
        updateList(page);
      });
      
      $(":checkbox").change(function () {
        //強制的に1ページに戻すために代入。ここで代入しないとページングをしてから検索した場合、直前にいたpidでページが呼ばれてしまう
        page = 1;
        updateList(page);
      });

      $("button[type=reset]").click(function () {
        $("#text").val("");
        $("input:checked").prop('checked', false);
        updateList();
      });
     
      var divclass = $('.text-center');
      $("#prevpage").click(function () {
        divclass.removeClass('has-prev has-next');
        page = page - 1;
        
        updateList(page);
      });

      $("#nextpage").click(function () {
        divclass.removeClass('has-prev has-next');
        page = page + 1;        

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
      <table class="table"></table>
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
