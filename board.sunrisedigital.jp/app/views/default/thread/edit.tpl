{extends file='default/base.tpl'}
{block title append}編集{/block}
{block main_contents}
    <div class="panel panel-default">
        <div class="panel panel-heading">
        <h5 class="panel-title">編集</h5>
        </div>
        <div class="panel panel-body">
            {$form->renderStartTag() nofilter}
            <div class="form-group">
                {$form.edit->setLabel('編集内容')->renderLabel() nofilter}
                {$form.edit->render([class=>"form-control",rows=>"3"]) nofilter}                
            </div>
        </div>
    </div>
{/block}