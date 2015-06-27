# SEO Test Cases
功能：使用配置文件来配置各网页的SEO要素内容。 然后使用程序来检测网页是否符合要求。

## 安装
* 运行环境： ruby 2.0+ & bundler
* clone 这些代码到本地
* 运行 `bundle install` ， 安装依赖
* 运行 `rspec` 来测试

## 使用
### 整体结构
整个项目采用了Rspec这个Ruby的测试框架，使用时，直接在根目录下执行命令 `rspec` 即可。默认输出到命令行。 也可以输出为 HTML: `rspec -f h -o result.html` 

所有的测试用例都按照一些规定放在data文件夹下。也可以给data文件夹起个不同的名字， 如 `my-data` 文件夹，运行时的命令需要改为： `data=my-data rspec`

data文件夹的内容： https://github.com/semseo/seo-test-cases/tree/master/data

测试用例用CSV或者TSV文件来存储。后缀名必须是 .csv 或 .tsv。 两种后缀代码着文件采用什么分隔符来分列， csv 代表用`,`, tsv 代表用 TAB。每个文件的第一行是表头，都是约定好的，不能自己乱写。

一共定义了几种测试，每种测试都对应着data文件夹下的一个子文件夹。每个子文件夹里可以放多个文件文件。
所有spec文件： https://github.com/semseo/seo-test-cases/tree/master/spec

### OPF
测试 On Page Factor，也是最重要的部分 （网页 title， h1 等)

测试用例文件夹： opf

表头：
* url ： 要测试页面的URL地址
* factor
  可以用的值有：
   * status 
   * location 
   * title
   * meta_keywords
   * meta_description
   * meta_robots
   * h1-h6
   * canonical
* value
  期望值，会拿来与网页上解析出来的值做对比，一样的才会通过，不一样的报错
* user_agent
  留空则代表PC和Mobile都测试， PC则使用百度桌面的UA， Mobile则使用百度移动的UA
