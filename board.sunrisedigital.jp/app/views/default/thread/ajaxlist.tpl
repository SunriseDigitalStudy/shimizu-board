<table class="table" data-currentpageid="{$pager->getPage()}" data-lastpageid="{$pager->getLastPageId()}" data-has-next="{if $pager->hasNextPage()}1{/if}"
         data-has-prev="{if $pager->hasPrevPage()}1{/if}" data-jsonencodedata={$jsonEncodeData}>
</table>
  {$jsonEncodeData}

