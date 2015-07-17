{extends file = "default/base.tpl"}
{block js append}
<script>
  $(function () {
      $.ajax({
        url: "/thread/jsontest",
 {*       dataType:"json"*}
      }).done(function(data){
        console.log("in");
        alert("success");          
      }).fail(function(data){
        alert("fail");
      });
  });
  
{*  $.getJSON({$test})
    ]};*}
</script>
{/block}
{block main_contents}
<div class="testShow">
  <p>表示確認</p>
</div>
{/block}