{extends file='default/base.tpl'}
{block js}
  <script>
    $(function () {
      $("#jquery-sample-button").click(
        function () {
          var str,area;
          area = $('[class = "area"]:checked').map(function(){
            return $(this).val();
          }).get();
          str = $("#text").val();
          $.ajax(console.log(str),{
            url: "/thread/ajaxlisttest",
            data: {
              test: str,
              check: area
            },
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
  <div id="jquery-sample">
    <p>
      <input type="text" class="text" id="text" value="test"/>
    </p>
    <p>
      <input type="checkbox" class="area" value="1">1
      <input type="checkbox" class="area" value="2">2
      <input type="checkbox" class="area" value="3">3
      <button id="jquery-sample-button" class="btn btn-primary">表示</button>
      <span id="jquery-sample-textStatus"></span>
    </p>
    <div id="jquery-sample-ajax"></div>
  </div>
{/block}