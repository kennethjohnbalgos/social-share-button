window.SocialShareButton =
  openUrl : (url, popup) ->
    if popup == "true"
      window.open(url, 'popup', 'height=500,width=500')
    else
      window.open(url)
      false

  share : (el) ->
    share_url = ""
    site = $(el).data('site')
    appkey = $(el).data('appkey') || ''
    $parent = $(el).parent()
    title = encodeURIComponent($(el).data(site + '-title') || $parent.data('title') || '')
    img = encodeURIComponent($parent.data("img") || '')
    url = encodeURIComponent($parent.data("url") || '')
    via = encodeURIComponent($parent.data("via") || '')
    desc = encodeURIComponent($parent.data("desc") || ' ')
    popup = encodeURIComponent($parent.data("popup") || 'false')

    if url.length == 0
      url = encodeURIComponent(location.href)
    switch site
      when "baidu"
        share_url = "http://hi.baidu.com/pub/show/share?url=#{url}&title=#{title}&content=#{desc}"
      when "delicious"
        share_url = "http://www.delicious.com/save?url=#{url}&title=#{title}&jump=yes&pic=#{img}"
      when "douban"
        share_url = "http://shuo.douban.com/!service/share?href=#{url}&name=#{title}&image=#{img}&sel=#{desc}"
      when "email"
        share_url = "mailto:?to=&subject=#{title}&body=#{url}"
      when "facebook"
        share_url = "http://www.facebook.com/sharer.php?u=#{url}"
      when "google_bookmark"
        share_url = "https://www.google.com/bookmarks/mark?op=edit&output=popup&bkmk=#{url}&title=#{title}"
      when "google_plus"
        share_url = "https://plus.google.com/share?url=#{url}"
      when "kaixin001"
        share_url = "http://www.kaixin001.com/rest/records.php?url=#{url}&content=#{title}&style=11&pic=#{img}&aid=#{appkey}"
      when "linkedin"
        share_url = "https://www.linkedin.com/shareArticle?mini=true&url=#{url}&title=#{title}&summary=#{desc}"
      when "pinterest"
        share_url = "http://www.pinterest.com/pin/create/button/?url=#{url}&media=#{img}&description=#{title}"
      when "plurk"
        share_url = "http://www.plurk.com/?status=#{title}: #{url}&qualifier=shares"
      when "qq"
        share_url = "http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=#{url}&title=#{title}&pics=#{img}&summary=#{desc}&site=#{appkey}"
      when "renren"
        share_url = "http://widget.renren.com/dialog/share?resourceUrl=#{url}&srcUrl=#{url}&title=#{title}&pic=#{img}&description=#{desc}"
      when "tqq"
        share_url = "http://share.v.t.qq.com/index.php?c=share&a=index&url=#{url}&title=#{title}&pic=#{img}&appkey=#{appkey}"
      when "tumblr"
        get_tumblr_extra = (param) ->
          cutom_data = $(el).attr("data-#{param}")
          encodeURIComponent(cutom_data) if cutom_data

        tumblr_params = ->
          path = get_tumblr_extra('type') || 'link'
          params = switch path
            when 'text'
              title = get_tumblr_extra('title') || title
              "title=#{title}"
            when 'photo'
              title = get_tumblr_extra('caption') || title
              source = get_tumblr_extra('source') || img
              "caption=#{title}&source=#{source}"
            when 'quote'
              quote = get_tumblr_extra('quote') || title
              source = get_tumblr_extra('source') || ''
              "quote=#{quote}&source=#{source}"
            else # actually, it's a link clause
              title = get_tumblr_extra('title') || title
              url = get_tumblr_extra('url') || url
              "name=#{title}&url=#{url}"
          "/#{path}?#{params}"
        share_url = "http://www.tumblr.com/share#{tumblr_params()}"
      when "twitter"
        via_str = ""
        via_str = "&via=#{via}" if via.length > 0
        share_url = "https://twitter.com/intent/tweet?url=#{url}&text=#{title}#{via_str}"
      when "weibo"
        share_url = "http://service.weibo.com/share/share.php?url=#{url}&type=3&pic=#{img}&title=#{title}&appkey=#{appkey}"

    switch site
      when "email"
        location.href = share_url
      else
        SocialShareButton.openUrl(share_url, popup) if share_url != ""
    false