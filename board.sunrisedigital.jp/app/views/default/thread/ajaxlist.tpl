{*<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script>
  $(function () {
      $.ajax({
        url: "/thread/ajaxlist",
        data: {
          name:'test'
        },
        dataType:"json"
      });
      var table = $('table');
      var jsonObject = JSON.parse(table.attr('data-jsonencodedata'));
      table.append("<tr><th>ID</th><th>タイトル</th><th>ジャンル</th><th>登録日時</th></tr>");
      for(var i in jsonObject){
        table.append("<tr><td>"+jsonObject[i].id+"</td>\n\
        <td><a href=/thread/title?thread_id="+jsonObject[i].id+">"+jsonObject[i].title+"</a></td>\n\
        <td>"+jsonObject[i].ジャンル+"</td><td>"+jsonObject[i].登録日+"</td></tr>");
      }
  });
</script>*}
{*{if $list->isEmpty() === true}
  <p>一致する検索結果はありません</p>
{else}*}
<body>
  <table class="table" data-currentpageid="{$pager->getPage()}" data-lastpageid="{$pager->getLastPageId()}" data-has-next="{if $pager->hasNextPage()}1{/if}"
         data-has-prev="{if $pager->hasPrevPage()}1{/if}" data-jsonencodedata={$jsonEncodeData}>
  </table>
  {$jsonEncodeData}
</body>

