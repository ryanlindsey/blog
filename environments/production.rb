configure :production do
  config[:host] = 'https://pixelsonly.com'

  after_configuration do
    data.articles.article.each do |id, article|
      proxy "/articles/#{article.slug}/index.html", 'articles/show.html', locals: {article: article }, ignore: true
    end

    puts "Proxy pages generated successfully!"

    activate :external_pipeline,
      name: :webpack,
      command: './node_modules/webpack/bin/webpack.js --bail -p',
      source: '.tmp/dist',
      latency: 0
  end
end
