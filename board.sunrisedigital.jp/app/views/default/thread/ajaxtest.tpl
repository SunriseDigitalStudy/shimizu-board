{extends file='default/base.tpl'}
{block js}
  <script>
    jQuery(function () {
      $("#jquery-sample-button").click(
        function () {
           jQuery.ajax({
            url: "/thread/ajaxlisttest",
            success: function (data) {
              jQuery('#jquery-sample-ajax').html(data);
            },
            error: function (data) {
              jQuery('#jquery-sample-textStatus').text('読み込み失敗');
            }
          });
        }
      );
    });
  </script>
{/block}

{block main_contents}
  <div id="jquery-sample">
    <p>
      <button id="jquery-sample-button" class="btn btn-primary">表示</button>
      <span id="jquery-sample-textStatus"></span>
    </p>
    <div id="jquery-sample-ajax"></div>
  </div>
{/block}