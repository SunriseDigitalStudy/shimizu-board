{extends file='default/base.tpl'}
{block title}編集{/block}
{block main_contents}
  <div class="panel panel-heading">
    <h5>編集</h5>
  </div>
  <div class="panel-body">
    {$form->renderStartTag() nofilter}
      <div class="form-group">
        <h5>編集内容</h5>
        {$form.edit->setValue($form.edit->getLabel())->render([class=>"form-control",rows=>"3"]) nofilter}
        {$form.edit->renderError() nofilter}
        <div>
          <input type="submit" name="submit" value="編集する" class="btn btn-success">
          <input type="submit" name="cancel" value="キャンセル" class="btn btn-default">
        </div>
      </div>
    </form>
  </div> 
{/block}