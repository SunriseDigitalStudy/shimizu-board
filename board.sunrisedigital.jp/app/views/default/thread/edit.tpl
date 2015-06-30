{extends file='default/base.tpl'}
{block title}編集{/block}
{block main_contents}
    <div class="panel panel-heading">
        <h5>編集</h5>
    </div>
        <div class="panel panel-body">
            {$form->renderStartTag() nofilter}
            <div class="form-group">
                {$form.edit->setLabel('編集内容')->renderLabel() nofilter}
                {$form.edit->setValue({$body})->render([class=>"form-control",rows=>"3"]) nofilter}
                {$form.edit->renderError() nofilter}
            <div>
                <input type="submit" name="submit"  value="編集する" class="btn btn-default">
            </div>
        </div>
    </div> 
{/block}