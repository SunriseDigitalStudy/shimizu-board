<script type="text/javascript" src="/js/sdx/sdx.jquery.swapanimation.js"></script>
<script type="text/javascript">
$(function(){

{*  $('btn-sm').click((function(){
    $.ajax({
        data:{
          f: [tag__id][]
          value: 
        }
      )
  });*}
  
  //削除処理
  $('.delete-button').click(function(){
    var btn = $(this);
    var item = btn.closest('.actions');
    var row = btn.closest('.resplist-row');
    row.addClass('deleting');
    if(!confirm(btn.data('message')))
    {
      row.removeClass('deleting');
      return false;
    }

    item.find('.delete_checkbox').attr('checked', 'checked');
  });

  //並び替え
  var list_form = $('#delete_and_sort');
  var btn_sequence = list_form.find('input.btn.sequence');
  $('.up-button').click(function(e){
    e.preventDefault();
    var current = $(this).closest('li.resplist-row');
    var target = current.prev();

    $.sdxSwapAnimation(current, target, {
      onComplete:function(){
        current.prev().before(current);
        btn_sequence.removeAttr('disabled');
      }
    });

    return false;
  });

  $('.down-button').click(function(e){
    e.preventDefault();
    var current = $(this).closest('li.resplist-row');
    var target = current.next();

    $.sdxSwapAnimation(current, target, {
      onComplete:function(){
        target.after(current);
        btn_sequence.removeAttr('disabled');
      }
    });

    return false;
  });

  var submit_sequence = false;
  list_form.submit(function(){
    submit_sequence = true;
  });

  $(window).bind('beforeunload', function(){
    if(btn_sequence.length && !submit_sequence && !btn_sequence.is('[disabled=disabled]')){
      return list_form.data('nosave-alert');
    }
  });

  //一行の横幅を基準に各itemの横幅を決めます。
  //itemのうち横幅が決まっている物の幅の合計を全体から引いた残りを、横幅が決まっていないitem数で割って算出してます。
  //100以下になった時は100にします。
  //TODO 各`resplist-item`の幅を求めるのに、setTimeoutしないと小さめに算出します。CSSの組み方次第かも。折を見て根本的原因を突き止めたい。
  setTimeout(function(){
    $('#list-wrapper .resplist .resplist-row').each(function(){
      var row = $(this);
      var no_style_list = row.find('.resplist-item.no-style');
      var total =　row.outerWidth();
      var reserved = 0;

      row.find('.resplist-item:not(.no-style)').each(function(){
        reserved += $(this).outerWidth();
      });

      var width = ((total - reserved) / no_style_list.length) - 1;
      no_style_list.css({
        'width': Math.max(width, 100)+'px'
      });
    });
  }, 100);

});
</script>