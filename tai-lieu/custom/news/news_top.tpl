<div class="block-news-hpage {$arr_config.class_prefix}">
    <div class="tab-product">
        {if !empty($arr_config.show_title)}
            <div class="block-title">
                <h2>{$block_title}</h2>
            </div>
        {/if}
        {if !empty($arr_data)}
        <div class="row">
            {foreach from = $arr_data item=item key=key name=foo}
                {assign var=link_detail value="{Router::url('/',true)}{$this->Slug->slugHtml("{$item.url}")}"}
                {if $smarty.foreach.foo.first}
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        {$this->element('News.news_block_thumb',['item'=> $item,'col' => $col,'view_slider' => 0,'view_sort' => 'list'])}
                    </div>
                {/if}
            {/foreach}
            <div class="col-md-6 col-sm-6 col-xs-12">
                {foreach from = $arr_data item=item key=key name=foo}
                    {if !$smarty.foreach.foo.first}
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            {$this->element('News.new_list',['item'=> $item,'col' => $col,'view_slider' => 0,'view_sort' => 'list'])}
                        </div>
                    {/if}
                {/foreach}
            </div>
           
        </div>
        {else}
            <label>{__d('default', 'empty_data')}</label>
        {/if}
    </div>
</div>

