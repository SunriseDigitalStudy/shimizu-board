<!doctype html>
<html lang="ja">
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.1/css/font-awesome.css" rel="stylesheet">
        <style>
            .sdx_error{
                font-size: 12px;
                margin: 0;
                padding: 0;
                font-weight: bold;
                link-style: none;
                color: #b94a48;
            }
            .sdx_error > li:before{
                content: "\f14a";
                font-family: FontAwesome;
            }
        </style>
    {block css}{/block}
<sclipt src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></sclipt>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
{block js}{/block}
<title>Board {block title}{/block}</title>
</head>
<body>
    <header class="navbar navbar-inverse">{$sdx_user = $sdx_context->getUser()}
        <div class="container">
            <div class="navbar-header">
                <a class="navber-brand" href="/"><i class="fa fa-comments-o text-warning"></i> Board</a>
            </div>
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav navar-right">
                    <li class ="dropdawn{if $sdx_user->hasId()} has-id{/if}">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-user fa-lg"></i> <b class="caret"></b> 
                        </a>
                        <ul class="dropdown-header">
                            {if $sdx_user->hasId()}
                            <li class="dropdown-header">{$sdx_user->getLoginId()}</li>
                            <li><a href="/secure/logout"><i ckass="fa fa-sign-out"></i> ログアウト</a></li>
                            {else}
                            <li><a href="/account/create"><i class="fa fa-plus-sequre"></i>ユーザー登録</a></li>
                            <li><a href="/secure/login"><i class="fa fa-sign-in"></i>ログイン</a></li>
                            {/if}
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </header>
    <section>
        <div class="container">
        {block main_contents}{/block}
    </div>
</section>
</body>
</html>