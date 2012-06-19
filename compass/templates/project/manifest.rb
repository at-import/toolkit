description "Responsive Web Design Kickstart"

# Stylesheets
stylesheet 'style.scss',  :media => 'screen, projection'

stylesheet 'partials/global/_base.scss'
stylesheet 'partials/global/_variables.scss'
stylesheet 'partials/global/_functions.scss'
stylesheet 'partials/global/_mixins.scss'
stylesheet 'partials/global/_extendables.scss'

stylesheet 'partials/styleguide/_style-guide.scss'

stylesheet 'partials/layout/_layout.scss'
stylesheet 'partials/layout/_ie-layout.scss'
stylesheet 'partials/layout/_print-layout.scss'

stylesheet 'partials/design/_design.scss'
stylesheet 'partials/design/_ie-design.scss'
stylesheet 'partials/design/_print-design.scss'

stylesheet 'print.scss',  :media => 'print'
stylesheet 'ie.scss',     :media => 'screen, projection', :condition => "lt IE 8"

# JavaScript and Images
discover :javascripts

help %Q{
  Please contact Sam Richard or Mason Wendell with questions:

      sam@snug.ug
      mason@zivtech.com
}

welcome_message %Q{

  Responsive Web Design Kickstart
  
  Welcome to the Responsive Web Design Kickstart gem! Provided are the basic tools needed to kickstart a custom Responsive Web Design solution tailor made to your needs! Remember, tools and best practices are always changing, so keep up to date!
  
  The following is included in this build:
  Compass Extensions:
   * Susy
   * Breakpoint
  JavaScript:
   * Modernizr Custom Build with all Standard features of 2.3.5 except html5shiv w/printshiv or Media Queries. Build your own from http://modernizr.com/download/ when you are ready for production
   * Loader.js custom JavaScript file for holding conditional asset loading scripts thanks to Modernizr's yepnope (http://yepnopejs.com/). Comes with yepnope code for loading in Hammer.js, just make sure the path is correct from root.. Ready for production, but remember to minify and gzip!
   * Hammer.js (http://eightmedia.github.com/hammer.js/) for awesome touch events. Ready for production, but remember to minify and gzip!
   * embeds.respond.js is an fluid iFrame solution for YouTube and Vimeo embeds that requires jQuery (for the time being, not included).
    
  Include the following in your <head> tag:
  
  <meta content='width=device-width, initial-scale=1.0' name='viewport' />
  <meta content='IE=edge,chrome=1' http-equiv='X-UA-Compatible' />
  <!--[if lt IE 9 ]> <script src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.2/CFInstall.min.js"></script><script>window.attachEvent("onload",function(){CFInstall.check({mode:"overlay"})})</script> <![endif]-->
  <!-- CSS -->
  <link href='path/to/css/style.css?v=1' rel='stylesheet' />
  <!-- All JavaScript at the bottom, except for Modernizr and Respond/Selectivizr for IE 8 and Below. -->
  <script src='path/to/js/modernizr-2.5.3.js'></script>
  
  Include the following, and all other JavaScript, including any JavaScript frameworks you may be using like jQuery, right before your closing </body> tag:
  
  <!-- Javascript at the bottom for fast page loading -->
  <script src='path/to/js/loader.js'></script>
  
  
}

