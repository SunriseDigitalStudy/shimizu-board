{extends file='default/base.tpl'}
{block title}ジャンル一覧{/block}
{block main_contents}
    <a href="/">トップに戻る</a>
    <div class="panel panel-heading">
        <h3>ジャンル一覧</h3></div>
    <div class="panel panel-default">
        <div class="panel-body">  
    {foreach from=$list item=genre}
        <ul>
            <li>{$genre}</li>
        </ul>
    {/foreach}
    </div>  
    </div>
{/block}