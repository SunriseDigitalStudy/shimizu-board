{extends file = 'default/base.tpl'}

{block title append} {$page_name}{/block}

{block js append}
    {*javascliptのinclude 必須*}
    {include 'sdx/include/scaffold/js.tpl'}
{/block}

{block css append}
    {*cssのinclude　必須*}
    {include 'sdx/include/scaffold/css.tpl'}
<link rel="stylesheet" type="text/css" href="/css/sdx/scaffold.bootstrap.css">
{/block}

{block main_contents}
     {*フォームやhtml本体が書かれている場所*}
    {include 'sdx/include/scaffold/html.tpl'}
{/block}