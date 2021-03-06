# Social Share Button
This gem is a helper that you can able to create a share feature in your Rails app.
A social sharing plugin with complete social networks

## Screenshot
<img src="http://s24.postimg.org/p4p3kpojp/ZZZ_Small_Bite_Small_Bite_Test_Event_3_Vig.png"/>

## Available Social Network List
* Facebook
* Twitter
* Google+
* Linkedin
* Pinterest
* Tumblr
* Google Bookmark
* Douban
* Weibo
* QZone
* Tencent Weibo
* Renren
* Hi Baidu
* Kaixin001
* Delicious
* Plurk
* Email

## Install

In your `Gemfile`:
```ruby
gem 'social-share-button', :git => "git@github.com:marvindpunongbayan/social-share-button.git"
```

And generate it:
```bash
$ bundle install
$ rails generate social_share_button:install
```

## How to update (skip this when you haven't used this gem yet)
```bundle update --source social-share-button```


## Configure
You can config `config/initializes/social_share_button.rb` to select which social sites you wanted to use:
```ruby
SocialShareButton.configure do |config|
  config.allow_sites = %w(twitter facebook google_plus linkedin tumblr pinterest email)
end
```

## Usage
You need add require css,js file in your app assets files:
`app/assets/javascripts/application.coffee`

```
#= require social-share-button
```

`app/assets/stylesheets/application.scss`

```
*= require social-share-button
```

Then you can use `social_share_button_tag` helper in views, for example `app/views/posts/show.html.erb`
```erb
<%= social_share_button_tag(@post.title) %>
```

And you can choose within 2 available sizes of images 16 for 16x16, 32 for 32x32 (default):
```erb
<%= social_share_button_tag(@post.title, :image_size => "16") %>
```

Apart from the default title, you can specify the title for the special social network:
```erb
<%= social_share_button_tag(@post.title, 'data-twitter-title' => 'TheTitleForTwitter') %>
```

For Popup window use this custom popup attribute:

```erb
<%= social_share_button_tag(@post.title, :popup => "true")
```

And you can custom rel attribute:

```erb
<%= social_share_button_tag(@post.title, :rel => "twipsy") %>
```

You can also specify the URL that it links to:

```erb
<%= social_share_button_tag(@post.title, :url => "http://myapp.com/foo/bar") %>
```

```erb
<%= social_share_button_tag(@post.title, :url => "http://myapp.com/foo/bar", :image => "http://foo.bar/images/a.jpg", desc: "The summary of page", via: "MyTwitterName") %>
```

For the Tumblr there are an extra settings, prefixed with :'data-*'
```erb
<%= social_share_button_tag(@post.title, :image => "https://raw.github.com/vkulpa/social-share-button/master/lib/assets/images/sprites/social-share-button/tumblr.png", :'data-type' => 'photo') %>
<%= social_share_button_tag(@post.title, :'data-source' => "https://raw.github.com/vkulpa/social-share-button/master/lib/assets/images/sprites/social-share-button/tumblr.png", :'data-type' => 'photo') %>
```
Those two above calls are identical.
Here are the mapping of attributes depending on you data-type parameter

<pre>
| data-type         | standard  | custom :"data-*" prefixed  |
--------------------------------------------------------------
| link (default)    | title     | data-title                 |
|                   | url       | data-url                   |
| text              | title     | data-title                 |
| photo             | title     | data-caption               |
|                   | image     | data-source                |
| quote             | title     | data-quote                 |
|                   |           | data-source                |
</pre>