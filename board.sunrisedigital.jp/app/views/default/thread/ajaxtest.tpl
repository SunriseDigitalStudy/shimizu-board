{block js}
 <script>
<!--
jQuery( function() {
    jQuery( '#jquery-sample-button' ) . toggle(
        function() {
            jQuery . ajax( {
                url: 'board.sunrisedigital.jp/thread/ajaxtest',
                success: function( data ) {
                    jQuery( '#jquery-sample-ajax' ) . html( data );
                    jQuery( '#jquery-sample-textStatus' ) . text( '読み込み成功' );
                },
                error: function( data ) {
                    jQuery( '#jquery-sample-textStatus' ) . text( '読み込み失敗' );
                }
            } );
        },
        function() {
            jQuery( '#jquery-sample-ajax' ) . html( '' );
            jQuery( '#jquery-sample-textStatus' ) . text( '' );
        }
    );
} );
// -->
</script>{/block}
{block main_contents}
 <div id="jquery-sample">
    <p>
        <button id="jquery-sample-button">toggle</button>
        <span id="jquery-sample-textStatus"></span>
    </p>
    <div id="jquery-sample-ajax"></div>
</div>
{/block}