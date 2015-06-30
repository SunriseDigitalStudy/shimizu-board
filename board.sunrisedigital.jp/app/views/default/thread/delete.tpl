{extends file="default/base.tpl"}
{block title}削除{/block}
{block main_contents}
  <div class="panel panel-default">{$sdx_user = $sdx_context->getUser()}
    <div class="panel panel-heading">削除</div>
    <div class="panel-title">削除内容</div>
    <div class="panel-body">
      {$body|nl2br nofilter}
      {$form->renderStartTag() nofilter}
      　<div class="form-group">
        　{$form.submit->setTagValue("削除する")->render([type=>"submit",class=>"btn btn-danger"]) nofilter}      
     　 </div>
      </form>
    </div> 
  </div>
{/block}