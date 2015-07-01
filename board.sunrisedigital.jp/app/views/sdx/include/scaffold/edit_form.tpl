{function formElement}
  {if $item.settings.write_only && $record->get($column)}
    <div class="alert alert-warning"><i class="fa fa-arrow-up"></i>{$i18n_scaffold_write_only_notice}</div>
  {/if}
  {if $item.comment || $item.settings.comments}
    <ul class="help-block">
    {if $item.comment}
      <li>{$item.comment nofilter}</li>
    {/if}
    {foreach $item.settings.comments as $comment}
      <li>{$comment nofilter}</li>
    {/foreach}
    </ul>
  {/if}
  {$elem->renderError() nofilter}
{/function}

{* form *}
<div id="edit-wrapper" class="panel panel-primary">
  <div class="panel-heading">
    {if $form_label && !$record->isNew()}{$tmp_form_lable = $record->get($form_label)}{else}{$tmp_form_lable = $page_name}{/if}
    <h3 class="panel-title">
      {if $group.parent}{$group.parent}&nbsp;-&nbsp;{/if}{$tmp_form_lable}&nbsp;{if !$record->isNew()}{$i18n_scaffold_edit}{else}{$i18n_scaffold_add}{/if}
    </h3>
  </div>
  <div class="panel-body">
    {$form->renderStartTag([autocomplete=>off]) nofilter}
    <div>
      <div class="form-elements">
      {foreach $form_settings as $item}
      {$is_hedden = $form.{$item@key} instanceof Sdx_Form_Element_Hidden || $hidden_element == $item@key}
        {if $is_hedden}
        <div style="display: none;">
          {$form.{$item@key}->renderHidden() nofilter}
        </div>
        {else if $form.{$item@key} instanceof Sdx_Form_Element_Group_Checkbox}
        <div class="form-group item_{$item@iteration}{if $form.{$item@key}->hasError()} error has-error{/if}">
          <div class="checkbox-title">{$form.{$item@key}->getLabel()}</div>
          <div class="checkbox-list">
          {foreach $form.{$item@key}->getChildren() as $elem}
            {$elem->renderWithLabel() nofilter}
          {/foreach}
          </div>
          {formElement item=$item elem=$form.{$item@key} column={$item@key} record=$record}
        </div>
        {else if $form.{$item@key} instanceof Sdx_Form_Element_Group_Radio}
        <div class="form-group item_{$item@iteration}{if $form.{$item@key}->hasError()} error has-error{/if}">
          <div class="radio-title">{$form.{$item@key}->getLabel()}</div>
          <div class="radio-list">
          {foreach $form.{$item@key}->getChildren() as $elem}
            {$elem->renderWithLabel() nofilter}
          {/foreach}
          </div>
          {formElement item=$item elem=$form.{$item@key} column={$item@key} record=$record}
        </div>
        {else if $form.{$item@key} instanceof Sdx_Form_Element_Checkbox}
        <div class="checkbox item_{$item@iteration}{if $form.{$item@key}->hasError()} error has-error{/if}">
          {$form.{$item@key}->renderWithLabel() nofilter}
          {formElement item=$item elem=$form.{$item@key} column={$item@key} record=$record}
        </div>
        {else}
        <div class="form-group item_{$item@iteration}{if $form.{$item@key}->hasError()} error has-error{/if}">
          {$form.{$item@key}->renderLabel() nofilter}
          {$form.{$item@key}->render([class=>'form-control']) nofilter}
          {formElement item=$item elem=$form.{$item@key} column={$item@key} record=$record}
        </div>
        {/if}
      {/foreach}
      </div>
      {if $sequence}<input type="hidden" name="{$ns_edit_form}[{$sequence.column}]" value="{$record->get($sequence.column, $sequence.next)}" />{/if}
      <ul class="submit_actions clearfix">
        <li>
          {if !$record->isNew() || $is_separated}
            <a class="btn btn-default" href="{$uri_list->toString([], $pkeys)}"><i class="fa fa-chevron-left pre-str"></i>{$i18n_scaffold_back}
            </a>
          {else}
            &nbsp;
          {/if}
        </li>
        <li class="text-center"><input type="submit" value="{$i18n_scaffold_submit}" name="submit" id="scaffold_edit_submit" class="btn btn-success" /></li>
        <li>&nbsp;</li>
      </ul>
    </div>
    {$form->renderEndTag() nofilter}
  </div>
</div>
{* /form *}