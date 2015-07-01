{* list *}
  <div id="list-wrapper" class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        {if $group.parent}{$group.parent}&nbsp;-&nbsp;{/if}{sprintf($i18n_scaffold_page_name, $page_name)}
      </h3>
    </div>

    <div class="panel-body">

      {if $uri_edit->getBaseUri() != $uri_list->getBaseUri()}
      <div class="add-wrapper">
        <a href="{$uri_edit->toString()}" class="btn btn-primary">{$i18n_scaffold_newadd}</a>
      </div>
      {/if}
      
      {if $list}
      {if $filter_form}
      <div class="clearfix">
        <div class="filter_form well">
          {$filter_form->renderStartTag([class=>"form-horizontal"]) nofilter}
            {if $group.id}<input type="hidden" name="group" value="{$group.id}">{/if}
            {foreach $filter_form as $elem}
              <div class="form-group">
              {if get_class($elem) == Sdx_Form_Element_Checkbox}
              <div class="col-lg-offset-2 col-lg-10">
                  {$elem->renderWithLabel([], [class=>"checkbox-inline"]) nofilter}
              </div>
              {else if get_class($elem) == Sdx_Form_Element_Radio}
              <div class="col-lg-offset-2 col-lg-10">
                  {$elem->renderWithLabel([], [class=>"radio-inline"]) nofilter}
              </div>
              {else if $elem instanceof Sdx_Form_Element_Group_Checkbox}
                <div class="checkbox-title col-lg-2 control-label">{$elem->getLabel()}</div>
                <div class="col-lg-10">
                  {foreach $elem->getChildren() as $child}
                    {$child->renderWithLabel([], [class=>"checkbox-inline"]) nofilter}
                  {/foreach}
                </div>
              {else if $elem instanceof Sdx_Form_Element_Group_Radio}
                <div class="radio-title col-lg-2 control-label">{$elem->getLabel()}</div>
                <div class="col-lg-10">
                  {foreach $elem->getChildren() as $child}
                    {$child->renderWithLabel([], [class=>"radio-inline"]) nofilter}
                  {/foreach}
                </div>
              {else}
                {$elem->renderLabel([class=>'col-lg-2 control-label']) nofilter}
                <div class="col-lg-10">
                {$elem->render([class=>'form-control']) nofilter}
                </div>
              {/if}
              </div>
            {/foreach}
            <ul class="submit clearfix">
              <li class="col-xs-4 text-left"><a href="{$filter_uri->toString()}" class="btn btn-warning btn-sm">リセット</a></li>
              <li class="col-xs-4 text-center">
                <button type="submit" value="filter" name="submit_filter" class="btn btn-default btn-sm">
                  <i class="fa fa-search fa-lg pre-str"></i>{$i18n_scaffold_search}
                </button>
              </li>
              <li class="col-xs-4">
                &nbsp;
              </li>
            </ul>
          </form>
        </div>
      </div>
      {/if}

      {function list_actions}
      <div class="list-actions clearfix">
        {$tmp_left = '<i class="fa fa-chevron-left"></i><span class="alt-fa">&nbsp;◀&nbsp;</span>'}
        {$tmp_right = '<i class="fa fa-chevron-right"></i><span class="alt-fa">&nbsp;▶&nbsp;</span>'}
        {if $pager}
          <div class="paging text-center">
            <ul class="pagination">
              <li><a href="{$pager->getFirstUri()}"><i class="fa fa-step-backward"></i><span class="alt-fa">最初</span></a></li>
              {if $pager->hasPrevPage()}
              <li><a href="{$pager->getPrevUri()}">{$tmp_left nofilter}</a></li>
              {else}
              <li class="disabled"><span class="disable_link">{$tmp_left nofilter}</span></li>
              {/if}
              <li><span>{$pager->getPage()}&nbsp;/&nbsp;{$pager->getLastPageId()}</span></li>
              {if $pager->hasNextPage()}
              <li><a href="{$pager->getNextUri()}">{$tmp_right nofilter}</a></li>
              {else}
              <li class="disabled"><span class="disable_link">{$tmp_right nofilter}</span></li>
              {/if}
              <li><a href="{$pager->getLastUri()}"><i class="fa fa-step-forward"></i><span class="alt-fa">最後</span></a></li>
            </ul>
          </div>
        {/if}
        {if $sequence}
        <div class="buttons pull-right">
          <input type="submit" name="submit_sequence" value="{$i18n_scaffold_save_sort}" disabled="disabled" class="registration btn btn-success btn-sm sequence" />
        </div>
        {/if}
      </div>
      {/function} 
      
      <form name="delete_and_sort" id="delete_and_sort" method="POST" action="{$uri_list->toString([], $pkeys)}" data-nosave-alert="{$i18n_scaffold_nosave_alert}">
      
      {list_actions}
      
      {if $list->isEmpty()}
      <p class="alert alert-warning no-list">{$i18n_scaffold_empty_list}</p>
      {else}
      <ul class="resplist resplist-striped">{$tmp_edit_label = $config->get('list.edit_label')}{$tmp_delete_label = $config->get('list.delete_label')}
        {foreach $list as $record}{$tmp_pkeys_array = $record->pkeyValues()}{$tmp_pkeys_json = Zend_Json::encode($tmp_pkeys_array)}
        <li class="resplist-row">
          {if $config->get('list.item_heading')}
          <div class="resplist-heading">{include $config->get('list.item_heading') record=$record config=$config}</div>
          {/if}
          <div class="resplist-items">
            {foreach $list_display as $item}
            
            {if $item@first && $sequence}
              <input type="hidden" name="sequence[]" value="{$tmp_pkeys_json}" />
            {/if}
            {if $item.column || $item.html}
            <div class="resplist-item{if !$item.style} no-style{/if}"{if $item.style} style="{$item.style}"{/if}>
              {$tmp_label = $item.label|default:'&nbsp;'}
              <div class="resplist-label{if $tmp_label == '&nbsp;'} resplist-label-hidden{/if}">{$tmp_label nofilter}</div>
              <div class="resplist-value">
                {if $item.column}
                  {$record->get($item.column)|truncate:30 nofilter}
                {elseif $item.html}
                  {sdx_scaffold var=$item.html record=$record}
                {/if}
              </div>
            </div>
            {else if $item.action == 'edit'}
              {$tmp_edit_label = $item.label}
            {else if $item.action == 'delete'}
              {$tmp_delete_label = $item.label}
            {/if}
            {/foreach}
          </div>
          <div class="resplist-footer">
            {if $config->get('list.item_footer')}
            <div class="item-footer">
              {include $config->get('list.item_footer') record=$record config=$config}
            </div>
            {/if}
            <div class="clearfix">
              <div class="pull-right actions">
                <input id="sdx_delete_checkbox_{md5($tmp_pkeys_json)}" type="checkbox" name="delete[]" value="{$tmp_pkeys_json}" class="delete_checkbox">
                <div class="btn-group">
                  <a href="{$uri_edit->toString($tmp_pkeys_array)}" class="btn btn-primary edit-button"><i class="fa fa-pencil"></i> {$tmp_edit_label|default:$i18n_scaffold_edit nofilter}</a>
                </div>
                {if $sequence}
                <div class="btn-group">
                  <button class="btn btn-default up-button"><i class="fa fa-chevron-up"></i><span class="alt-fa">▲</span></button>
                  <button class="btn btn-default down-button"><i class="fa fa-chevron-down"></i><span class="alt-fa">▼</span></button>
                </div>
                {/if}
                {if !$config->get('list.prevent_delete')}
                <div class="btn-group">
                  <button type="submit" class="btn btn-danger delete-button" name="submit_delete" value="1" data-message="{$i18n_scaffold_delete_confirm}">
                    {$tmp_delete_label|default:'<i class="fa fa-times"></i><span class="alt-fa">削除</span>' nofilter}
                  </button>
                </div>
                {/if}
              </div>
            </div>
          </div>
        </li>
        {/foreach}
      </ul>
      {/if}{* /if $list->isEmpty() *}
      {list_actions}
      </form>
      {/if}
    </div>
  </div>
  {* /list *}