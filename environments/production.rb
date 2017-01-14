configure :production do
  config[:host] = 'https://pixelsonly.com'

  data.articles.article.each do |id, article|
    proxy "/articles/#{article.slug}/index.html", 'articles/show.html', locals: {article: article }, ignore: true
  end

  activate :external_pipeline,
    name: :webpack,
    command: './node_modules/webpack/bin/webpack.js --bail -p',
    source: '.tmp/dist',
    latency: 0
end