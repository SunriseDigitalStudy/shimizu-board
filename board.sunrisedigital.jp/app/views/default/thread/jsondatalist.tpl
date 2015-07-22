{extends file = "default/base.tpl"}

{block js append}
<script>
  $(function () {
      $.ajax({
        url: '/thread/jsondatalist',
        datatype: 'json',
        {*data: {
          title: searchTitle,
          tagid: searchTagIds,
          pagenum: page
        }*}
      }).done(function(responceData){
        var table = $('table');
        var jsonObject = JSON.parse(table.attr('data-jsonencodedata'));
        table.append("<tr><th>ID</th><th>タイトル</th><th>ジャンル</th><th>登録日時</th></tr>");
        for(var i in jsonObject){
          table.append("<tr><td>"+jsonObject[i].id+"</td>\n\
          <td><a href=/thread/title?thread_id="+jsonObject[i].id+">"+jsonObject[i].title+"</a></td>\n\
          <td>"+jsonObject[i].ジャンル+"</td><td>"+jsonObject[i].登録日+"</td></tr>");
        }
      }).fail(function(responceData){
        alert("error");
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
    <div class="panel panel-heading">スレッド一覧</div>
    <div class="panel panel-body">
      <table class="table" data-jsonencodedata ={$jsonEncodeData}>
      </table>
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