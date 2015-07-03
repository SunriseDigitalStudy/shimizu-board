{extends file='default/base.tpl'}
{block title}Thread検索{/block}
{block js}
  <script>
    $(function () {
      $("button[type=submit]").click(
          function () {
            var tag = $('[class = "tag"]:checked').map(function () {
              return $(this).val();
            }).get();
            var str = $("#texttest").val();
            console.log(tag)
            $.ajax({
              url: '/thread/ajaxlisttest?check=1',
{*              data: {
                test: str,
                check: tag
              },*}
              success: function (data) {
                $('#jquery-sample-ajax').html(data);
              },
              error: function (data) {
                $('#jquery-sample-textStatus').text('読み込み失敗');
              }
            });
          }
      );
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
          <input type="checkbox" class="tag" value="{$tag->getName()}">{$tag->getName()}
          {/foreach}
        </p>
        <p>
          <button class="text-left btn btn-danger">リセット</button> 
          <button type="submit" class="btn btn-primary text-center">検索</button>
          <span id="jquery-sample-textStatus"></span>
        </p>
        <div id="jquery-sample-ajax"></div>
      </div>
    </div>
  </div>
{/block}