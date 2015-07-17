{extends file = "default/base.tpl"}
{block js append}
<script>
  $(function () {
      $.ajax({
              url: '/thread/jsontest'
            }).done(function(responce_data){
              $(".testShow").html("<h1>test</h1>");
            }).fail(function(responce_data){
              alert("error");
            });
  });
  
</script>
{/block}
{block main_contents}
<div class="testShow">
  <p></p>
</div>
{/block}