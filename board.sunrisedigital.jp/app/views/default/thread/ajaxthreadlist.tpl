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
          if(isUpdateData(currentData,newData) === true){
            currentData = newData;
            $.ajax({
              url: '/thread/ajaxthreadlist',
              data: newData
            }).done(function(responce_data){
              console.log(newData);
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
        var hasNextId = $(".table").data("has-next");
        console.log("cb次のページがあるか:"+hasNextId);
        console.log("cblastpage"+lastPage);
        updateList();
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
        var hasprevId = $(".table").data('has-prev');
        console.log(hasprevId);
        if (page <= 1) {
          page = 1;
          divclass.addClass('has-next');
          divclass.removeClass('has-prev');
        } else {
          if(hasprevId === 1){
            divclass.addClass('has-prev has-next');
          }
        }
        
        updateList(page);
      });
      
      
      var lastPage = $(".table").data("lastpageid");
      $("#nextpage").click(function () {
        var hasNextId = $(".table").data("has-next");
        divclass.removeClass('has-prev has-next');
        page = page + 1;
        console.log("次のページがあるか:"+hasNextId);
        console.log("nblastpage:"+lastPage);
        console.log("currentpage:"+page);
        if (page >= lastPage) {
          page = lastPage;
          divclass.removeClass('has-next');
          divclass.addClass('has-prev');
        } else {
          if(hasNextId === 1){
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
      {include file = "default/thread/ajaxlist.tpl"}
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