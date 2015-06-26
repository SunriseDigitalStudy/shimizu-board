{extends file='default/base.tpl'}
{block title}書き込み一覧{/block}
{block main_contents}
    <div class="panel panel-heading">
        書き込み一覧</div>
        {*    <div class="panel panel-default">*}
    <div class="panel-body">
        <table class="table">
                <tr>
                    <th>No</th>
                    <th></th>
                    <th>書き込み日時</th>
                    <th>ユーザー</th>
                </tr>
                {foreach $list as $entry}
                <tr>
                    <td>{$entry->getId()}</td>
                    <td>{$entry->getBody()}</td>
                    <td>{$entry->getUpdatedAt()}</td>
                    <td>{$entry->getAccount()->getName()}</td>
                </tr>
                {/foreach}
            </table>
    </div>
    {*    </div>*}
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="panel-title"><h5>新規投稿</h5></div>
            {$form->renderStartTag() nofilter}
            <div class="form-group">
                ニックネーム:{$sdx_context->getVar('signed_account')->getName()} さん
            </div>
            <div class="form-group">
                {$form.body->setLabel('内容')->renderLabel() nofilter}
                {$form.body->render([class=>"form-control",rows=>"3"]) nofilter}
                {$form.body->renderError() nofilter}
            </div>
            <div>
                <input type="submit" name="submit" value="投稿する" class="btn btn-info"> 
            </div>
        </div>
    </div>
{/block}