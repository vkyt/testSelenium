class Header #this is a template of how pages.rb files should be written
  class << self
    def select_remember_me(checked=true, input="51000088201")
      $browser.text_field(:id => "header-collector-number-input").set(input)
      #$browser.text_field(:id => "header-collector-number-input").set(collector_number.to_s)
      if (checked)
        $logger.info("Selecting remember me")
        $browser.checkbox(:id,"header-rememberme").set
      else
        $browser.checkbox(:id,"header-rememberme").clear
      end
    end

    ############## Search Field ##################l

    def checkIfSearchTextFieldExists()
      if $isheadless == 'true'
        $browser.link(:id => "header-search-button").exists?
        $browser.link(:id => "header-search-button").click
      else
        $browser.text_field(:value => "Search").exists?
        $browser.text_field(:value => "Search").click
      end
    end

    def search(query="test")
      checkIfSearchTextFieldExists()
      $browser.text_field(:value => "Search").set(query.to_s)
      $browser.text_field(:value => "Search").send_keys :enter
    end

    ####### AIR MILES CARD LOGO ########
    def click_airmiles_card()
      if($browser.link(:class => "logo-airmiles").exists?)
        $browser.link(:class => "logo-airmiles").click
      else
        $browser.image(:class => "img-responsive", :alt => "AIR MILES Card").click
      end
    end

    ###### CLICK TOOLBAR LINK ######
    def click_toolbar_link(link_name)

      case link_name
      when 'French'
        $browser.link(:href => "fr_FR").click
      when 'English'
        $browser.link(:href => "en_CA").click
      when 'Enroll Now'
        $browser.link(:id => "header-enroll-now").click
      when 'Sign In'
        $browser.link(:id => "header-link-signin").when_present { |a| a.click }
      when 'Sign Out'
        $browser.link(:id => "header-link-signout").when_present { |a| a.click }
      when 'Your Account'
        $browser.link(:id => "header-link-youraccount").click
      when 'Your Transactions'
        $browser.link(:id => "header-toolbar-your-transaction").click
      when 'Your Profile'
        $browser.link(:id => "header-toolbar-profile").click
      when 'Set Balance Preference'
        $browser.link(:id => "header-toolbar-set-balance").click
      when 'Order Cards'
        $browser.link(:id => "header-toolbar-order-cards").click
      when 'Your Wishlist'
        $browser.link(:id => "header-toolbar-wishlist").click
      when 'Buy Miles'
        $browser.link(:id => "header-toolbar-buy-miles").click
      when 'AIR MILES Toolbar'
        $browser.link(:href => "http://www.airmilesshops.ca/shops/airmilesshops/ToolbarHome?changeLocale=en_CA").click
      when 'Lock Your Account'
        $browser.link(:id => "header-toolbar-lock-account").click
      when 'Shopping Cart'
        $browser.link(:id => "header-cart-icon").when_present { |a| a.click }
      else
        $logger.info('Header.click_toolbar_link was not provided a valid argument')
      end
    end

    ###### CLICK SUBNAV LINK ######
    def click_subnav_main_link(link_name)
          case link_name
            when 'Home' 
              $browser.li(:id => "navmenu-home").click
            when 'Earn Miles'
              $browser.li(:id => "navmenu-earnmiles").click
            when 'Redeem Miles'
              $browser.li(:id => "navmenu-redeem").click
            when 'Need Help?'
              $browser.li(:id => "navmenu-needhelp").click
            when 'More'
              $browser.li(:id => "navmenu-more").when_present { |a| a.click }  
            when 'Search'
              checkIfSearchTextFieldExists()  
            when 'AIR MILES shops'
              $browser.link(:id => "link-amshops").click                              
      when 'Sponsors'
        if ($browser.li(:id => "navmenu-sponsors").exist?)
          $browser.li(:id => "navmenu-sponsors").a().click
        else
          $browser.li(:class=> "menu-sponsors").a().click
        end
        $logger.info("Step3 - Sponsor link clicked")
      when 'Offers'
        if ($browser.li(:id => "navmenu-offers").exist?)
          $browser.li(:id => "navmenu-offers").a().click
        else
          $browser.li(:class=>"menu-offers").a().click
        end
        $logger.info("Step3 - Offers link clicked")
            else
              $logger.info('Header.click_subnav_main_link was not provided a valid argument')
          end           
    end

    ###### CLICK SUBNAV CHILD LINK ######
    def click_subnav_child_link(link_name)
      case link_name
      #Earn Miles Sub Nav
      when 'In Store'
        $browser.li(:class => "icon instore").click
      when 'Online'
        $browser.li(:class => "icon online").click
      when 'On everything you purchase'
        $browser.li(:class => "icon everywhere").click
      when 'Browse Offers & Promotions'
        $browser.li(:class => "offers-promotions").click
      when 'How to earn AIR MILES reward miles'
        $browser.li(:class => "how-it-works").click
        #Redeem Miles Sub Nav
      when 'Search'
        checkIfSearchTextFieldExists()
      when 'AIR MILES shops'
              $browser.link(:id => "link-amshops").click    
        #More Sub Nav      
           when 'Gold/Onyx'
              $browser.li(:class => "icon instore").click                                         
      else
        $logger.info('Header.click_subnav_child_link was not provided a valid argument')
      end
    end

    ###### HOVER TOOLBAR LINK ######
    def hover_toolbar_link(link_name)

      case link_name
      when 'French'
        $browser.link(:href => "fr_FR").click
      when 'English'
        $browser.link(:href => "en_CA").click
      when 'Enroll Now'
        $browser.link(:id => "header-enroll-now").click
      when 'Your Account'
        $browser.link(:id => "header-link-youraccount").fire_event 'mouseover'
      when 'Sign In'
        $browser.link(:id => "header-link-signin").click
      else
        $logger.info('Header.click_toolbar_link was not provided a valid argument')
      end

    end
    ###### NAME ######

    def is_name_visible()
      $browser.text.include? "Welcome to AIR MILES, "
    end

    ###### BALANCE ######

    def is_balance_visible()
      if ($browser.div(:class => "panel balances").exists?)
        $browser.div(:class => "panel balances").exists?
      else
        $browser.div(:class => "col-md-4 balances").exists?
      end
    end

    ###### CASH BALANCE ######
    def click_cash_balance()
      $browser.div(:class => "balance cash").when_present.click
    end

    def is_cash_balance_visible()
      $browser.div(:class => "balance cash").exists?
    end

    ###### DREAM BALANCE ######
    def click_dream_balance
      $browser.div(:class => "balance dream").when_present.click
    end

    def is_dream_balance_visible()
      $browser.div(:class => "balance dream").exists?
    end
    ### ENDING ###
#######modified by swati#####################################
    def click_gobutton_header()
        if ( $browser.button(:value,"Go").exist?) == true
           $browser.button(:value,"Go").click
         end
    end
 
    def browser_back()
      $browser.driver.navigate.back();
    end
##########################################################################33
  
  
  end
end
