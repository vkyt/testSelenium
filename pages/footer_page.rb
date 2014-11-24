#general function library for Home page footer
class Footer
  class << self
    ####### common function to be used in link ########
    def click_footer_link(id_val)
      $browser.a(:id => id_val).click
    end

    def click_footer_need_help_link(id_val, a_link)
      $browser.a(:id => id_val, :href=>a_link).click
    end

    ####### CLICK AIR MILES LOGO ########
    def click_airmiles_logo()
      $logo_image_footer = $browser.img(:class => "img-responsive", :src => CONFIG['AIR MILES logo'])
      $logger.info('In the Footer.click_airmiles_logo() function');
      if($logo_image_footer.exists?)
        $logo_image_footer.click
        $logger.info('clicking on AIRMILES logo in upper middle footer');
      end
    end

    ###### CLICK FOOTER LINK
    # Desc : This function will click a link in the footer by searching for a matching link_name in the config.yml file.
    #        The actual attribute on which it searches to execute the click must be specified in the config.yml file and is done by prefixing the value in the key:value pair with, example (id_, href_, alt_, etc...)
    def click_upper_footer_link(link_name)

      if link_name == "AIR MILES logo"
        self::click_airmiles_logo()
      else

        _upper_footer_link = (CONFIG[link_name].nil? || CONFIG[link_name].empty?) ? $browser.link(:id => "no-footer-link-specified").click : CONFIG[link_name]

        _search_by =  _upper_footer_link.partition("_")[0]
        _upper_footer_link = _upper_footer_link.partition("_")[2]

        case _search_by
        when "href"
          $browser.footer(:index, 0).div(:class => "container-wrap").link(:href => _upper_footer_link.to_s).click
        when "id"
          $browser.footer(:index, 0).div(:class => "container-wrap").link(:id => _upper_footer_link.to_s).click
        when "class"
          $browser.footer(:index, 0).div(:class => "container-wrap").link(:id => _upper_footer_link.to_s).click
        else
          return false
        end
      end
    end

    def click_bottom_footer_link(link_name)

      _bottom_footer_link = (CONFIG[link_name].nil? || CONFIG[link_name].empty?) ? $browser.link(:id => "no-footer-link-specified").click : CONFIG[link_name]

      _search_by =  _bottom_footer_link.partition("_")[0]
      _bottom_footer_link = _bottom_footer_link.partition("_")[2]

      p _search_by+" "+_bottom_footer_link
      case _search_by
      when "href"
        if ($browser.link(:index => 0, :href => _bottom_footer_link.to_s).exists?)
          $browser.link(:index => 0, :href => _bottom_footer_link.to_s).click
        else
          $browser.link(:index => 1, :href => _bottom_footer_link.to_s).click
        end
      when "id"
        $browser.footer(:index => 0).div(:index => "container").ul(:index => 1).link(:id => _bottom_footer_link.to_s).click
      when "class"
        $browser.footer(:index => 0).div(:index  => "container").ul(:index => 1).link(:class => _bottom_footer_link.to_s).click
      else
        return false
      end
    end
    
    def check_alwayson_img_exists(image_src)
      if $browser.div(:class => "always-on").image().exists?
        $browser.div(:class => "always-on").image().hover
        _image_src = $browser.div(:class => "always-on").image().attribute_value "src"
        $logger.info('Always on image passed = '+ image_src + ' actual image src = '+ _image_src)
        p("\nActual Image"+_image_src)
        p("\nPassed Image "+ image_src)
        _image_src.include?(image_src).should == true
      else
        $logger.error("AlwaysOn image doesn't exist")
      end
     
    end

    ### END ###
  end
end