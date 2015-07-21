{extends file = "default/base.tpl"}
{block js append}
<script>
  $(function () {
    $.ajax({
      url: '/thread/jsontest' ,
{*      data: {
        title: searchTitle,
        tagid: searchTagIds,
        pagenum: page
      }*}
    }).done(function(responceData){
      var jsonObject = JSON.parse($('table').attr('data-jsonTest'));
      $(".table").append("<tr><th>ID</th><th>タイトル</th><th>ジャンル</th><th>登録日時</th></tr>");
      for(var i in jsonObject){
        $(".table").append("<tr><td>"+jsonObject[i].id+"</td><td>"+jsonObject[i].title+"</td><td>"+jsonObject[i].ジャンル+"</td><td>"+jsonObject[i].登録日+"</td></tr>");
      }
    }).fail(function(responceData){
      alert("error");
    });
  });
</script>
{/block}
{block main_contents}
  <div class="panel panel-default">
    <div class="panel panel-heading">JSONテスト</div>
    <div class="panel panel-body">
      <table class="table" data-jsonTest={$jsonData}>
      </table>
    </div>
  </div>
{/block}