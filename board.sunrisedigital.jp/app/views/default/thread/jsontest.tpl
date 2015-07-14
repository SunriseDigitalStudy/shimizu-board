{extends file = "default/base.tpl"}
{block js append}
<script>
  $(function () {
      $.ajax({
        url: "/thread/jsontest",
        data: {
          name:'test'
        },
        dataType:"json"
      });
          var dataArray = test.testdata;
          $.each(dataArray,function(i){
            console.log("test");
            console.log(dataArray[i]);
            $(".testShow").append("<p>id:" +dataArray[i].id + "title:" + dataArray[i].title);
          });
  });
  
  var test = {
    "testdata": [
      {
        "id": "1",
        "title": "test",
        "genre": "test",
        "create": "0000-00-00"
      },
      {
        "id": "2",
        "title": "test2",
        "genre": "test2",
        "create": "0000-00-00"
      }
    ]};
</script>
{/block}
{block main_contents}
<div class="testShow">
  <p>表示確認</p>
</div>
{/block}