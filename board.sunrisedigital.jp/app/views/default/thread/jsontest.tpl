{extends file = "default/base.tpl"}
{block js append}
<script>
  $(function () {
    var jsonData = JSON.parse($('table').attr('data-jsonTest'));
    console.log(jsonData);
    $.ajax({
      url: '/thread/jsontest' ,
{*      data: {
        title: searchTitle,
        tagid: searchTagIds,
        pagenum: page
      }*}
    }).done(function(responceData){
      $(".table").html("<tr><th>ID</th><th>タイトル</th><th>ジャンル</th><th>登録日時</th></tr><tr><td>a</td><td>b</td><td>c</td><td>d</td></tr>");
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
     {$jsonData}
      <table class="table" data-jsonTest={$jsonData}>
      </table>
    </div>
  </div>
{/block}