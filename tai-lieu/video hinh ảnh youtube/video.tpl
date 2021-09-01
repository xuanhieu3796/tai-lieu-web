{if !empty($item.url_media)}
    {assign var = url_img value = "{Router::url('/', true)}img/no-image.png"}
    {if !empty($item.url_img)}
        {assign var = url_img value="{Router::url('/',true)}{$item.url_img}"}
    {/if}

    {if $item.video_type == 1}
        <a class="col-md-{$col} col-sm-{$col_tablet} col-xs-{$col_mobile} nh-video-item" href="https://www.youtube.com/watch?v={$item.url_media}">
            <div class="image-wrapper fancybox-gallery">
                <iframe width="100%" height="100%" src="https://www.youtube.com/embed/{$item.url_media}" frameborder="0" allow="picture-in-picture" allowfullscreen></iframe>
                <span class="image-hover">
                <!--<i class="demo-icon icon-play-circled"></i>-->
            </span>
                <span class="image-title">
                {if !empty($item.title)}
                    {$item.title}
                {/if}
            </span>
            </div>
        </a>
    {else}
        <div class="col-md-{$col} col-sm-{$col_tablet} col-xs-{$col_mobile} nh-video-item"
             data-poster="{if !empty($item.url_img)}{Router::url('/',true)}{$item.url_img}{/if}"
             data-sub-html="{if !empty($item.title)}{$item.title}{/if}" data-html="#nh-video-{$item.id}">
            <div class="image-wrapper">
                <a href="#" class="fancybox-gallery">
                    <img class="animate scale animated" src="{$url_img}"/>
                    <span class="image-hover">
                    <i class="demo-icon icon-play-circled"></i>
                </span>
                    <span class="image-title">
                    {if !empty($item.title)}
                        {$item.title}
                    {/if}
                </span>
                </a>
            </div>
        </div>
    {/if}
{/if}