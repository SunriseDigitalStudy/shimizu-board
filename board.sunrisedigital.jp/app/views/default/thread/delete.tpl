{extends file="default/base.tpl"}
{block title}削除{/block}
{block main_contents}
    <div class="panel panel-heading">{$sdx_user = $sdx_context->getUser()}
    削除</div>
    <div class="panel panel-body">
        <div class="panel panel-title">削除内容</div>
        {$form->renderStartTag() nofilter}
        <div class="form-group">
            {foreach $list as $entry}
                {$entry->getBody()}
            {/foreach}
        </div>
    </div>    
{/block}