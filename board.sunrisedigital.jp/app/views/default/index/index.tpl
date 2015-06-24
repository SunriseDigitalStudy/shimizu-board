{extends file='default/base.tpl'}

{block title}掲示板へようこそ{/block}
{block main_contents}
    <div class="text center">
        <div class="panel-body">
            {$form->renderStartTag() nofilter}
            {*とりあえず仮のボタンの作成*}
            <input type="submit" name="door" value="入口" class="btn btn-primary">
        </div>
    </form>
</div>
{/block}