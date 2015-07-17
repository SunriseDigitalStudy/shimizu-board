{extends file='default/base.tpl'}
{block title}Thread検索{/block}
{block js}
  <script>
    $(function () {      
      var page = $(".table").data("currentpageid");
      function getFormData(){
        var search_text = $('#text');
        var tagIds_checked = $('.tag:checked');
        console.log("現在のページ:"+page);
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
              console.log("updatelistの最後のページ:"+lastPage);
              console.log(newData);
              $(panelBody).html(responce_data);
              judgeprevPage();
              judgenextPage();
            }).fail(function(responce_data){
              alert("error");
            });
          }
        },300);
      }
      
      function judgeprevPage(){
        if (page <　1) {
          page = 1;
          divclass.addClass('has-next');
          divclass.removeClass('has-prev');
        } else {
          if($(".table").data('has-prev') === 1){
            divclass.addClass('has-prev');
          }else{
            divclass.removeClass('has-prev');
          }
        }
        return this;
      }
      
      function judgenextPage(){
        var lastPageId = $(".table").data("lastpageid");
        if (page > lastPageId) {
          page = lastPageId;
          divclass.removeClass('has-next');
          divclass.addClass('has-prev');
        } else {
          if ($(".table").data("has-next") === 1) {
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
      
      var lastPage;
      $(":checkbox").change(function () {
        //lastPage = $(".table").data("lastpageid");
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
        console.log("最初にいたページ:"+page);
        divclass.removeClass('has-prev has-next');
        page = page - 1;
        
        
        updateList(page);
        console.log("今いるページ:"+page);
      });
      

      $("#nextpage").click(function () {
        console.log("最初にいたページ:"+page);
        
        divclass.removeClass('has-prev has-next');
        page = page + 1;        

        updateList(page);
        console.log("今いるページ:"+page);
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