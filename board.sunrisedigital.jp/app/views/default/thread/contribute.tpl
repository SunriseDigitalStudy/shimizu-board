{extends file = 'default/base.tpl'}

{block title}投稿ページ{/block}

{block main_contents} 
    <div class="panel panel-default">
        <div class="panel panel-heading">
            <div class="panel-title"><h5>記事投稿</h5></div>
            <div class="panel panel-body">
                {$form->renderStartTag() nofilter}
                <div class="form-group">
                    ニックネーム:{$sdx_context->getVar('signed_account')->getName()} さん
                </div>
                <div class="form-group">
                    {$form.body->setLabel('内容')->renderLabel() nofilter}
                    {$form.body->render([class=>"form-control" , row=>"5"]) nofilter}
                    {$form.body->renderError() nofilter}
                </div>
                <div>
                    <input type="submit" name="submit" value="投稿" class="btn btn-info"> 
                </div>
            </div>
            </form>
        </div>
    </div>
{/block}