<!doctype html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="//netdna.bootstrapcdn/bootstrap/3.0.0/css/bootstrap.min.css">
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
    <header class="navbar navbar-inverse">
        <div class="container">
            <div class="navbar-header">
                <a class="navber-brand" href="/"><i class="fa fa-comments-o text-warning"></i> Board</a>
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