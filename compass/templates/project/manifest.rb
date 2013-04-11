description "Toolkit Kickstart"

# Stylesheets
file '../shared/style.scss',  :like => :stylesheet, :media => 'screen, projection', :to => 'style.scss'

file '_base.scss',  :like => :stylesheet, :to => 'partials/global/_base.scss'
file '../shared/_variables.scss', :like => :stylesheet, :to => 'partials/global/_variables.scss'
file '../shared/_functions.scss', :like => :stylesheet, :to => 'partials/global/_functions.scss'
file '../shared/_mixins.scss', :like => :stylesheet, :to => 'partials/global/_mixins.scss'
file '../shared/_extendables.scss', :like => :stylesheet, :to => 'partials/global/_extendables.scss'

file '../shared/_style-guide.scss', :like => :stylesheet, :to => 'partials/styleguide/_style-guide.scss'

file '../shared/_layout.scss', :like => :stylesheet, :to => 'partials/layout/_layout.scss'
file '../shared/_ie-layout.scss', :like => :stylesheet, :to => 'partials/layout/_ie-layout.scss'
file '../shared/_print-layout.scss', :like => :stylesheet, :to => 'partials/layout/_print-layout.scss'

file '../shared/_design.scss', :like => :stylesheet, :to => 'partials/design/_design.scss'
file '../shared/_ie-design.scss', :like => :stylesheet, :to => 'partials/design/_ie-design.scss'
file '../shared/_print-design.scss', :like => :stylesheet, :to => 'partials/design/_print-design.scss'

file '../shared/print.scss',  :like => :stylesheet, :media => 'print', :to => 'print.scss'
file '../shared/ie.scss',     :like => :stylesheet, :media => 'screen, projection', :condition => "lte IE 8", :to => 'ie.scss'

help %Q{
  Please contact Sam Richard or Mason Wendell with questions:

      sam@snug.ug
      mason@zivtech.com
}

welcome_message %Q{

  Toolkit Kickstart

  Welcome to Toolkit! Provided are the basic tools needed to kickstart a new Sass project tailor made to your needs! Remember, tools and best practices are always changing, so keep up to date!

The following is included in this build:
  Compass Extensions:
   * Toolkit

  Include the following in your <head> tag:

  <meta content='width=device-width, initial-scale=1.0' name='viewport' />
  <meta content='IE=edge,chrome=1' http-equiv='X-UA-Compatible' />
  <!--[if lt IE 9 ]> <script src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.2/CFInstall.min.js"></script><script>window.attachEvent("onload",function(){CFInstall.check({mode:"overlay"})})</script> <![endif]-->
  <!-- CSS -->
  <link href='path/to/css/style.css?v=1' rel='stylesheet' />
  <!-- All JavaScript at the bottom, except for Modernizr. -->

  Include the following, and all other JavaScript, including any JavaScript frameworks you may be using like jQuery, right before your closing </body> tag:

  <!-- Javascript at the bottom for fast page loading -->


}

