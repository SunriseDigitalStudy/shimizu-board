{extends file='default/base.tpl'}

{block title}掲示板へようこそ{/block}

{block main_contents}
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">ログイン</h3>
        </div>
        <div class="panel-body">
            {$form->renderStartTag() nofilter}
            <div class="form-group">
                {$form.login_id->setLabel('ログインID')->renderLabel() nofilter}
                {$form.login_id->render([class=>"form-control" , placeholder=>$form.login_id->getLabel()]) nofilter}
{*                {$form.login_id->renderError() nofilter}*}
            </div>
            <div class="form-group">
                {$form.password->setLabel('パスワード')->renderLabel() nofilter}
                {$form.password->render([class=>"form-control" , placeholder=>$form.password->getLabel()]) nofilter}
{*                {$form.password->renderError() nofilter}*}
            </div>
            <div class="text-center">
                <input type="submit" name="login" value="ログイン" class="btn btn-success">
                <input type="submit" name="newaccount" value="新規登録" class="btn btn-success">
            </div>
            </form>
        </div>
    </div>
{/block}