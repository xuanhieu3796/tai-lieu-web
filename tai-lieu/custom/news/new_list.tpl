{assign var=link value="{Router::url('/',true)}{$this->Slug->slugHtml("{$item.url}")}"}
{if !isset($view_sort)}
    {assign var=view_sort value=''}
{/if}
<div class="item-news-home">
    <div class="row">
        <div class="col-xs-5 p-0">
            {if !empty($item.url_img)}
                {assign var = url_img value = "{Router::url('/', true)}{$item.url_img}"}
            {else}
                {assign var = url_img value = "{Router::url('/', true)}img/no-image.png"}
            {/if}
            <div class="img-news-right">
                <a href="{$link}"><img src="{$url_img}" alt="#"></a>
            </div>
        </div>
        <div class="col-xs-7">
            <div class="info-news-right">
                <h4 class="title-news-right">
                    <a href="{$link}">{$this->Slug->subStringLength($item.title,60)}</a>
                </h4>
                {if isset($item.description)}
                    <p class="desc-news-right">
                        {$this->Slug->subStringLength($item.description,75)}
                    </p>
                {/if}
            </div>        
        </div>
    </div>
</div>