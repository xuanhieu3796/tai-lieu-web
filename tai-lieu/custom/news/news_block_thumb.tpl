{assign var=link_detail value="{Router::url('/',true)}{$this->Slug->slugHtml("{$item.url}")}"}
<div class="news-feture">
    <div class="img-news-feture">
        {if !empty($item.url_img)}
            {assign var = url_img value = "{Router::url('/', true)}{$item.url_img}"}
        {else}
            {assign var = url_img value = "{Router::url('/', true)}img/no-image.png"}
        {/if}
        <a class="img-news" href="{$link_detail}" title="{$item.title}">
            <img src="{$url_img}" alt="{$item.title}">
        </a>
        <!--<ul class="more-post">-->
        <!--    <li class="item calender">-->
        <!--        <i class="demo-icon icon-calendar-7"></i><span>-->
        <!--            {if !empty($item.created_on)}-->
        <!--                {date("H:i - d/m/Y", strtotime($item.created_on))}-->
        <!--            {/if}-->
        <!--        </span>-->
        <!--    </li>-->
        <!--</ul>-->
    </div>
    <div class="info">
        <h4 class="title-n-feture"><a href="{$link_detail}" title="{$item.title}">{$this->Slug->subStringLength($item.title,120) }</a></h4>
        <p class="more-blogs">
            <span class="time">
                <i class="fa fa-clock-o" aria-hidden="true"></i>
                {if !empty($item.created_on)}
                    {date("H:i - d/m/Y", strtotime($item.created_on))}
                {/if}
            </span>
        </p>
        <p class="desc-new-feture">{$this->Slug->subStringLength($item.description,200) }</p>
    </div>
</div>