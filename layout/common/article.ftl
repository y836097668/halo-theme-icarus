<#macro article post,layout,commentType,index>
<#include "../comment/comment.ftl">
<div class="card">
    <#if post.thumbnail?? && post.thumbnail!=''>
        <div class="card-image">
            <#if index>
                <a href="${context!}/archives/${post.url!}">
                    <img class="thumbnail" src="${post.thumbnail!}" alt="${post.title!}">
                </a>
            <#else>
                <span class="image is-7by1">
                    <img class="thumbnail" src="${post.thumbnail!}" alt="${post.title!}">
                </span>
            </#if>
        </div>
    </#if>
    <div class="card-content article">
        <div class="level article-meta is-size-7 is-uppercase is-mobile is-overflow-x-auto">
            <div class="level-left">
                发表于：<time class="level-item has-text-grey" datetime="${post.createTime!}">${post.createTime?string('yyyy-MM-dd HH:mm:ss')}</time>
                最后更新于：<time class="level-item has-text-grey" datetime="${post.updateTime!}">${post.updateTime?string('yyyy-MM-dd HH:mm:ss')}</time>
                <#if index>
                     <#if post.categories?? && post.categories?size gt 0>
                        <div class="level-item">
                            <#list post.categories as category>
                                <a class="has-link-grey -link" href="${context!}/categories/${category.slugName!}">${category.name!}</a>&nbsp;
                            </#list>
                        </div>
                    </#if>
                <#else>
                    <#if categories?? && categories?size gt 0>
                        <div class="level-item">
                            <#list categories as category>
                                <a class="has-link-grey -link" href="${context!}/categories/${category.slugName!}">${category.name!}</a>&nbsp;
                            </#list>
                        </div>
                    </#if>
                </#if>
            </div>
        </div>
        <h1 class="title is-size-3 is-size-4-mobile has-text-weight-normal">
            <#if index>
                <a class="has-link-black-ter" href="${context!}/archives/${post.url!}">${post.title!}</a>
            <#else>
                ${post.title!}
            </#if>
        </h1>
        <#if !index && tags?? && (tags?size gt 0)>
            <div class="level is-size-6">
                <div class="level-start">
                    <div class="level-item">
                        <span class="is-size-6 has-text-grey has-mr-7">#</span>
                        <#list tags as tag>
                            <a class="has-link-grey -link" href="${context!}/tags/${tag.slugName!}">${tag.name!}</a>&nbsp;&nbsp;
                        </#list>
                    </div>
                </div>
            </div>
        </#if>
        <div class="content">
            <#if index && post.summary?? && post.summary!=''>
                ${post.summary!}
            <#else>
                ${post.formatContent!}
            </#if>
        </div>

        <#if index && post.summary?? && post.summary!=''>
        <div class="level is-mobile">
            <div class="level-start">
                <div class="level-item">
                <a class="button is-size-7 is-light" href="${context!}/archives/${post.url!}#more">阅读更多</a>
                </div>
            </div>
        </div>
        </#if>
        <#if !index && settings.share_type?? && settings.share_type!=''>
            <#include "../share/${settings.share_type}.ftl">
        </#if>
    </div>
</div>

<#if !index>
    <#if (settings.donate_alipay?? && settings.donate_alipay!='') || (settings.donate_wechat?? && settings.donate_wechat!='')>
        <div class="card">
            <div class="card-content">
				<p>
					本文由 <a href="${context!}">${user.nickname!}</a> 创作，
					<br>采用 <a href="https://creativecommons.org/licenses/by/4.0/" target="_blank" rel="external nofollow">知识共享署名4.0</a> 国际许可协议进行许可
					<br>本站文章除注明转载/出处外，均为本站原创或翻译，转载前请务必署名
					<br>原文链接：<a href="${context!}/archives/${post.url!}">${context!}/archives/${post.url!}</a>
					<br>最后更新于：${post.editTime?string('yyyy-MM-dd HH:mm:ss')}
				</p>              
                <h3 class="menu-label has-text-centered">喜欢这篇文章？打赏一下作者吧</h3>
                <div class="buttons is-centered">
                    <#if settings.donate_alipay?? && settings.donate_alipay!=''>
                        <#include "../donate/alipay.ftl">
                    </#if>
                    <#if settings.donate_wechat?? && settings.donate_wechat!=''>
                        <#include "../donate/wechat.ftl">
                    </#if>
                </div>
            </div>
        </div>
    </#if>
</#if>

<#if !index && (nextPost?? || prePost??)>
    <div class="card card-transparent">
        <div class="level post-navigation is-flex-wrap is-mobile">
            <#if prePost??>
            <div class="level-start">
                <a class="level level-item has-link-grey article-nav-prev" href="${context!}/archives/${prePost.url}">
                    <i class="level-item fas fa-chevron-left"></i>
                    <span class="level-item">${prePost.title!}</span>
                </a>
            </div>
            </#if>
            <#if nextPost??>
            <div class="level-end">
                <a class="level level-item has-link-grey article-nav-next" href="${context!}/archives/${nextPost.url}">
                    <span class="level-item">${nextPost.title!}</span>
                    <i class="level-item fas fa-chevron-right"></i>
                </a>
            </div>
            </#if>
        </div>
    </div>
</#if>

<#if !index>
    <div class="card" id="comment-wrapper">
        <div class="card-content">
            <h3 class="title is-5 has-text-weight-normal">评论</h3>
            <#if commentType == 'post'>
                <@comment post,"post" />
            <#else>
                <@comment post,"sheet" />
            </#if>
        </div>
    </div>
</#if>
</#macro>