{extends file='default/base.tpl'}
{block title}Thread検索{/block}
{block js}
  <script>
    $(function () {  
      function countChecked(){
        var count = $("input:checked").length;
        return count;
      }
      countChecked();
      $(":checkbox").click(countChecked);

      $("button[type=submit]").click(
          function () {
            var tag = $('[class = "tag"]:checked').map(function () {
              return $(this).val();
            }).get();
            var str = $("#texttest").val();
            var countcheck = countChecked();
            console.log(tag)
            $.ajax({
              url: '/thread/ajaxlisttest',
              traditional: true,
              data: {
                search: str,
                tag: tag,
                count: countcheck
              },
              success: function (data) {
                $('#jquery-sample-ajax').html(data);
              },
              error: function (data) {
                $('#jquery-sample-textStatus').text('読み込み失敗');
              }
            });
          });
          
          $("button[type=reset]").click(
          function () {
            $("input:checked").prop('checked',false);
            $.ajax({
              url: '/thread/ajaxlisttest',
              traditional: true,
              success: function (data) {
                $('#jquery-sample-ajax').html(data);
              },
              error: function (data) {
                $('#jquery-sample-textStatus').text('読み込み失敗');
              }
            });
          });
    });
  </script>
{/block}

{block main_contents}
  <div class="panel panel-default">
    <div class="panel panel-body">
      <div id="jquery-sample">
        <p>
          <input type="text" class="form-control" id="texttest"/>
        </p>
        <p>
          {foreach $list as $tag}
          <input type="checkbox" class="tag" value="{$tag->getId()}">{$tag->getName()}
          {/foreach}
        </p>
        <p>
          <button type="reset" class="text-left btn btn-danger">リセット</button> 
          <button type="submit" class="btn btn-primary text-center">検索</button>
          <span id="jquery-sample-textStatus"></span>
        </p>
        <div id="jquery-sample-ajax"></div>
      </div>
    </div>
  </div>
{/block}