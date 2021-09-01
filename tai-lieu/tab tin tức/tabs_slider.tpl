{$owl_id = ''}
<div class="row {$arr_config.class_prefix}">
    <div class="tabs-block position-relative tabSliderNews  mt-15">
        {if !empty($arr_cate)}
            <div class="title-tab-02 clearfix">
                <div class=''>
                    {if $arr_config.show_title eq 1}
                        <div class="pull-left">
                            <h3 class="titleTabSliderNews">{$arr_config.title}</h3>
                        </div>
                    {/if}
                    <div class="pull-right">
                        
                        
                        {if !empty($arr_cate)}
                            <ul class="nav_title nav-tab-right clearfix {if $arr_config.view_display == 'tabs_slider'} margin-r-50 {/if}" 
                        id="sub-menu01" role="tablist" limit="{$arr_config.max_items}"
                            list-type="{$arr_config.list_type}" display="{$arr_config.display}" data-col="{$col}"
                            data-row="{$per_row}" data-chunk="{$chunk}" data-url="/news/NewsBlock/ajaxLoadNewsByTab/{if isset($arr_block.id)}{$arr_block.id}{/if}" data-view="{$arr_config.view_display}">
                            {$ext = time()-rand(1, 1000)}
                            {foreach from = $arr_cate key=key item=item  name=foo}
                                    {if isset($arr_block.id)}
                                        {$id_slider = "#box-item-{$key}-{$arr_block.id}-{$ext}"}
                                    {else}
                                        {$id_slider = "#box-item-{$key}-{$ext}"}
                                    {/if}
                                <li role="presentation" class="{if $smarty.foreach.foo.first}active{/if}">
                                    <a class="tab-item" href="{$id_slider}" role="tab" data-toggle="tab"  aria-expanded="true" data-id="{$item.id}" {if $smarty.foreach.foo.first}loaded="1"{/if}>{$item.name}</a>
                                </li>
                            {/foreach}
                        </ul>
                        {/if}
                    </div>
                </div>
            </div>
            <div class="tab-content">
                {foreach from = $arr_cate key=key item=item name=foo}
                
                    {if isset($arr_block.id)}
                        {$id_slider = "box-item-{$key}-{$arr_block.id}-{$ext}"}
                    {else}
                        {$id_slider = "box-item-{$key}-{$ext}"}
                    {/if}
                    <div id="{$id_slider}" class="tab-pane {if $smarty.foreach.foo.first}in active{/if}">
                        <div class="item-slider">
                            {if $smarty.foreach.foo.first}
                                {if !empty($arr_data)}
                                    {$owl_id = $id_slider}
                                    {$arr_data = $this->App->convertChunk($arr_data,$chunk, $per_row)}
                                    {foreach from=$arr_data key=k_d item=data}
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            {foreach from=$data key=k_d item=item}
                                                {$this->element("News.news_{$arr_config.element}",['item'=> $item,'col' =>'12','col_tablet' =>'12','col_moblie' =>'12','view_slider' => 1,'view_sort' => 'list'])}
                                            {/foreach}
                                        </div>
                                    {/foreach}
                                {/if}
                            {/if}
                        </div>
                    </div>
                {/foreach}
            </div>
        {/if}
        {$this->element('loading_element')}
    </div>
</div>

{$this->element('script_block_tabs')}

<script type="text/javascript">
    {if $owl_id}
    var owl = $("#{$owl_id}  .item-slider");
    owl.owlCarousel({
        items:"{$per_row}",
        loop:true,
        stopOnHover:true,
        lazyLoad : true,
        autoPlay:{if isset($arr_config.auto_play)} Boolean({$arr_config.auto_play}) {else} false {/if},
        autoplayTimeout:{if isset($arr_config.nav_speed)} {$arr_config.nav_speed} {else} 5000 {/if},
        autoplayHoverPause:true,
        navigation:{if isset($arr_config.button_next_pre)} Boolean({$arr_config.button_next_pre}) {else} false {/if},
        pagination:{if isset($arr_config.button_dots_nav)} Boolean({$arr_config.button_dots_nav}) {else} false {/if},
        animateOut: '{if isset($arr_config.animate_out)} {$arr_config.animate_out} {else} fadeIn {/if}',
        animateIn: '{if isset($arr_config.animate_in)} {$arr_config.animate_in} {else} fadeOut{/if}',
        itemsCustom: [
            [0, "{$arr_config.per_row_mobile}"],
            [768, "{$arr_config.per_row_tablet}"],
            [992, "{$arr_config.per_row}"],
        ],
    });
    {/if}
</script>