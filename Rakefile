require 'open-uri'

namespace :update do

  desc '更新 robots.txt 文件: rake update:robots file=data/robots.txt/*'
  task :robots do
    file_list = ENV['file'] || 'data/robots.txt/*'
    Dir[file_list].each do |f|
      file = File.basename(f).sub(/\.txt$/, '')


      if /^https?_/ === file
        schema = file.split('_')[0]
        site = file.sub(schema+'_', '')
      else
        schema = 'http'
        site = file
      end
      File.open(f, 'w').puts open("#{schema}://#{site}/robots.txt").read
      puts `git diff --color #{f}`
      puts "#{site} 的 robots.txt 文件更新完成, 请提交 Git."
    end
  end

end

