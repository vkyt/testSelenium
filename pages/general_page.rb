class General #this is a template of how pages.rb files should be written
  class << self

    #    $header_collector_id = CONFIG["header_collector_number_input"]
    $header_collector_id = OB["header"][:coll_num_input]
    $default_collector_number = DATA["default_collector_number"]
    ###### Sign In / Sign Out Functions ########
    def do_login(lvl="L1", page="Home", collector_number=$default_collector_number, pin="1111")
      case lvl
      when 'L1' then General.do_L1_login(page).should == true
        #when 'L1.9' then General.do_L19_login(page).should == true
      when 'L1.9' then General.do_L19_login(page, collector_number).should == true
      when 'L2' then General.do_L2_login(page, collector_number).should == true
      when 'L3' then General.do_L3_login(page, collector_number, pin).should == true
      else
        $logger.error("security lvl not defined")
      end
    end

    #def do_L1_login(return_to_page, collector_number=$default_collector_number)
    def do_L1_login(return_to_page, collector_number="")
      General.sign_out()
      if $browser.checkbox(:id,"header-rememberme").checked? == true
        $logger.info('Logging out and logging back in as L1')

        $browser.text_field(:id=>$header_collector_id).when_present.set(collector_number.to_s)
        Header.select_remember_me(false, collector_number)
        $browser.button(:value=>"Go").click
        General.sign_out()
        $browser.goto $base_url+return_to_page
      end
      $logger.info('Security level is L1')
    end

    def do_L19_login(return_to_page, collector_number=$default_collector_number)
      General.sign_out()
      if $browser.checkbox(:id,"header-rememberme").checked? == false
        $logger.info('Logging out and logging back in as L1.9')
        $browser.text_field(:id=>$header_collector_id).when_present.set(collector_number.to_s)
        Header.select_remember_me(true,collector_number)
        $browser.button(:value=>"Go").click
        General.sign_out()
        $browser.goto $base_url+return_to_page
        $logger.info("Signed in as L1.9 and now going back to"+$base_url+return_to_page)
      end

      $logger.info('Security level is L1.9')

    end

    def do_L2_login(return_to_page, collector_number=$default_collector_number)
      General.sign_out
      $browser.goto $base_url+return_to_page
      $logger.info(" ======================================= LOGGIN INFO ========================================")
      $logger.info("Collector Number : "+ collector_number.to_s)
      $logger.info(" ============================================================================================")

      $browser.text_field(:id=>$header_collector_id).hover
      $browser.text_field(:id=>$header_collector_id).when_present.click
      $browser.text_field(:id=>$header_collector_id).set(collector_number.to_s)

      $browser.button(:value=>"Go").click
      $browser.goto $base_url+return_to_page
      return General.verify_logged_in
    end

    def do_L2_login_supp(return_to_page, collector_number=$default_collector_number)
      General.sign_out
      $browser.goto $base_url+return_to_page
      $logger.info("Collector Number : "+ collector_number)

      $browser.text_field(:id=>$header_collector_id).hover
      $browser.text_field(:id=>$header_collector_id).when_present.click
      $browser.text_field(:id=>$header_collector_id).set(collector_number.to_s)

      $browser.button(:value=>"Go").click
      General.element_exist("a", OB["header"][:view_balance_link])

    end

    def do_L3_login(return_to_page, collector_number=$default_collector_number, pin="1111")
      General.sign_out()
      $browser.goto $base_url+return_to_page
      General.sign_in(collector_number, pin)
      return General.verify_logged_in

    end

    def sign_out()
      if $browser.li(:id => "header-link-signout").exists?
        $browser.li(:id => "header-link-signout").click
        Watir::Wait.until { $browser.button(:id=> "btnContinue").exists? == true }
      end
    end

    def sign_in(collector_number=$default_collector_number, pin="1111")
      if $browser.a(:id => "header-link-signin").exists?
        $browser.a(:id => "header-link-signin").when_present.click
        $browser.div(:class => "header-nav-signin").wait_until_present
        $browser.text_field(:id=> "header_signin_overlay_collector_number").when_present.click
        $browser.text_field(:id=> "header_signin_overlay_collector_number").set(collector_number.to_s)
        #$browser.text_field(:id=>"header_signin_overlay_collector_pin").when_present.click
        $browser.text_field(:id=>"header_signin_overlay_collector_pin").when_present.set(pin.to_s)
        $browser.button(:name => "/atg/userprofiling/ProfileFormHandler.login").click
      end
    end

    def verify_logged_in()
      if $browser.div(:class => "balances").exists?
        $logger.info("Found div that contains users cash/dream balance")
        return true
      end
      $logger.error("Did not find div that contains users cash/dream balance")
      return false
    end

    def clear_cache_folder()
      Watir::CookieManager::WatirHelper.deleteSpecialFolderContents(Watir::CookieManager::WatirHelper::COOKIES)
      Watir::CookieManager::WatirHelper.deleteSpecialFolderContents(Watir::CookieManager::WatirHelper::INTERNET_CACHE)
    end

    def click(element_type="div",element_id="", element_class="")
      if(element_type == "div")
        if(element_id != "" && $browser.div(:id => element_id).exists?)
          $browser.div(:id => element_id).click
        end
        if(element_class != "")
          $browser.div(:class => element_id).click
        end
      end
      if(element_type == "a")
        if(element_id != "")
          $browser.a(:id => element_id).click
        end
        if(element_class != "")
          $browser.a(:class => element_id).click
        end
      end
    end

    #Function gf_close 2nd WindowsApplication
    def gf_close_2ndwin()
      $browser.windows.last.use
      $browser.windows.last.close
      $logger.info('gf_close_2ndwin was executed')
    end

    ###########  Function  gf_GetShortStateName :  returns corresponding value for state full name ######################
    def gf_GetShortStateName(strValue)
      case strValue
      when "Alberta"              then    gf_GetShortStateName = "AB"
      when  "British Columbia"    then          gf_GetShortStateName = "BC"
      when  "Manitoba"          then            gf_GetShortStateName = "MB"
      when  "New Brunswick"       then            gf_GetShortStateName = "NB"
      when  "Newfoundland"        then            gf_GetShortStateName = "NL"
      when  "Northwest Territories" then            gf_GetShortStateName = "NT"
      when  "Nova Scotia"           then            gf_GetShortStateName = "NS"
      when  "Nunavut"               then            gf_GetShortStateName = "NU"
      when  "Ontario"                 then            gf_GetShortStateName = "ON"
      when "Prince Edward Island"     then            gf_GetShortStateName = "PE"
      when "Quebec"                   then            gf_GetShortStateName = "QC"
      when "Saskatchewan"               then            gf_GetShortStateName = "SK"
      when "Yukon Territories"          then            gf_GetShortStateName = "YT"
      end
    end

    ###########  Function  gf_GetFullStateName :  returns corresponding value for state short name ######################
    def gf_GetFullStateName(strValue)
      case strValue.upcase
      when "AB" then            gf_GetFullStateName = "Alberta"
      when "BC" then            gf_GetFullStateName = "British Columbia"
      when "MB" then            gf_GetFullStateName = "Manitoba"
      when  "NB" then            gf_GetFullStateName = "New Brunswick"
      when  "NL" then            gf_GetFullStateName = "Newfoundland"
      when  "NT" then            gf_GetFullStateName = "Northwest Territories"
      when "NS" then            gf_GetFullStateName = "Nova Scotia"
      when "NU" then            gf_GetFullStateName = "Nunavut"
      when "ON" then            gf_GetFullStateName = "Ontario"
      when "PE" then            gf_GetFullStateName = "Prince Edward Island"
      when "QC" then            gf_GetFullStateName = "Quebec"
      when "SK" then            gf_GetFullStateName = "Saskatchewan"
      when "YT" then            gf_GetFullStateName = "Yukon Territories"
      end
    end

    ################## function get the tax rate based on the province #####################
    def gf_GetProvinceTaxRate(strProvince)
      case strProvince.upcase
      when "AB"
        gf_GetProvinceTaxRate = 5
      when "BC"
        gf_GetProvinceTaxRate = 5
      when "MB"
        gf_GetProvinceTaxRate = 5
      when "NB"
        gf_GetProvinceTaxRate = 13
      when "NL"
        gf_GetProvinceTaxRate = 13
      when "NT"
        gf_GetProvinceTaxRate = 5
      when "NS"
        gf_GetProvinceTaxRate = 15
      when "NU"
        gf_GetProvinceTaxRate = 5
      when "ON"
        gf_GetProvinceTaxRate = 13
      when "PE"
        gf_GetProvinceTaxRate = 14
      when "QC"
        gf_GetProvinceTaxRate = 9.975 #QC=9.975%(QST),(GST5%)
      when  "SK"
        gf_GetProvinceTaxRate = 5
      when  "YT"
        gf_GetProvinceTaxRate = 5

      end
    end

    ##### Function  gf_ConvertValue :  converts values from to
    def gf_ConvertValue(strCase, strValue)
      case strCase
      when "CheckBox_to_Boolean"
        if strValue.upcase = "ON" then gf_ConvertValue = 1  end
        if strValue.upcase = "OFF" then gf_ConvertValue = 0  end
      end
    end

    #    '************************************************************************
    #    ' Function  gf_IsValueInArray :  verifies if value is in array
    #    ' Parameters:
    #    'strValue - string value
    #    'arrValues - array with values

    #    'Function Return Value: true or false
    #    'Usage: Call gf_IsValueInArray("Home", arrObject)
    #    ''************************************************************************
    #    Function gf_IsValueInArray(strValue, arrValues)
    #
    #       Dim intCounter
    #       gf_IsValueInArray = False
    #
    #       For intCounter=0 to UBound(arrValues)
    #         If strValue= arrValues(intCounter) Then
    #           gf_IsValueInArray = True
    #           Exit For
    #         End If
    #       Next
    #    End Function

    #    'Function gf_FormatCurrencyNumber
    #    Function gf_FormatCurrencyNumber(strNumber)
    #        Dim arrTemp
    #
    #       If Instr(1, strNumber, ".") > 1 Then
    #         arrTemp = Split(strNumber, ".", -1, 1)
    #         arrTemp(0) = FormatCurrency(arrTemp(0), 0, -2, -1, -1)
    #         strNumber = CStr(arrTemp(0)) + "." + CStr(arrTemp(1))
    #       Else
    #         strNumber = FormatCurrency(strNumber, 0, -2, -1, -1)
    #       End If
    #       strNumber = Replace(strNumber, "$", "")
    #
    #       gf_FormatCurrencyNumber = strNumber
    #    End Function

    #    'Function gf_GetMilesOffer
    #    Function gf_GetMilesOffer(strNumber)
    #        Dim arrTemp
    #
    #       If Instr(1, strNumber, "reward") > 1 Then
    #         arrTemp = Split(strNumber)
    #         strNumber = CStr(arrTemp(0))
    #       End If
    #
    #       gf_GetMilesOffer = strNumber
    #    End Function

    #    'Function gf_GetCashOffer
    #    Function gf_GetCashOffer(strNumber)
    #        Dim arrTemp
    #
    #       If Instr(1, strNumber, "$") > 1 Then
    #         arrTemp = Split(strNumber, "$", -1, 1)
    #         strNumber = arrTemp(1)
    #         arrTemp = Split(strNumber,".")
    #         strNumber = CStr(arrTemp(0))
    #       End If
    #
    #       gf_GetCashOffer = strNumber
    #    End Function

    #    'Function gf_GenerateRandomString
    #    Public Function gf_GenerateRandomString(strCharacters, intLength)
    #         Randomize
    #         Dim strS, intI
    #         For intI = 1 To intLength
    #              strS = strS + Mid(strCharacters, Int(Rnd() * Len(strCharacters))+1, 1)
    #         Next
    #         gf_GenerateRandomString=strS
    #    End Function

    #     CHECK MESSAGE
    def check_msg(msg_val)
      if $browser.element(:text => msg_val).exists? == true
        $logger.info("Success - message displayed")
      else
        $logger.error("Fail - message NOT shown")
      end
    end

    #     SELECT VALUE ON WEBLIST
    def select_weblist(list_name,selection_val)
      if browser.select_list(:id, list_name).exists == true
        $browser.select_list(:id, list_name).select(selection_val)
        $logger.info("Pass - web list selected")
      else
        $logger.error("Fail - web list NOT found")
      end
    end

    #    CLCIK WEB ELEMENT
    def click_element(ele_type, ele_val)

      case ele_type
      when "button" then
        if $browser.button(:value => ele_val).exists?
          $browser.button(:value => ele_val).when_present.click
          $logger.info("Pass - web element "+ele_val+" clicked")
        else
          if ($browser.button(:src => ele_val).exists?)
            $browser.button(:src => ele_val).when_present.click
            $logger.info("Pass - web element "+ele_val+" clicked")
          else
            $logger.error("Fail - web element "+ele_val+" NOT found")
          end
        end

      when "img" then
        if $browser.img(:src => ele_val).exists?
          $browser.img(:src => ele_val).when_present.click
          $logger.info("Pass - web element "+ele_val+" clicked")
        else
          $logger.error("Fail - web element "+ele_val+" NOT found")
        end

      when "a" then
        if $browser.a(:href => ele_val).exists?
          $browser.a(:href => ele_val).when_present.click
          $logger.info("Pass - web element "+ele_val+" clicked")
        else
          if $browser.a(:class => ele_val).exists?
            $browser.a(:class => ele_val).when_present.click
            $logger.info("Pass - web element "+ele_val+" clicked")
          else
            if $browser.a(:xpath => ele_val).exists?
              $browser.a(:xpath => ele_val).when_present.click
              $logger.info("Pass - web element "+ele_val+" clicked")
            else
              $logger.error("Fail - web element "+ele_val+" NOT found")
            end
          end
        end

#      when "a_path" then
#        if $browser.a(:xpath => ele_val).exists?
#          $browser.a(:xpath => ele_val).when_present.click
#          $logger.info("Pass - web element "+ele_val+" clicked")
#        else
#          $logger.error("Fail - web element "+ele_val+" NOT found")
#        end

      when "link" then
        if $browser.link(:id => ele_val).exists?
          $browser.link(:id => ele_val).when_present.click
          $logger.info("Pass - web element "+ele_val+" clicked")
        else
          $logger.error("Fail - web element "+ele_val+" NOT found")
        end

      when "element" then
        if $browser.element(:id => ele_val).exists?
          $browser.element(:id => ele_val).when_present.click
          $logger.info("Pass - web element "+ele_val+" clicked")
        else
          if $browser.element(:text => ele_val).exists?
            $browser.element(:text => ele_val).when_present.click
            $logger.info("Pass - web element "+ele_val+" clicked")
          else
            if $browser.element(:class => ele_val).exists?
              $browser.element(:class => ele_val).when_present.click
              $logger.info("Pass - web element "+ele_val+" clicked")
            else
              if $browser.element(:value => ele_val).exists?
                $browser.element(:value => ele_val).when_present.click
                $logger.info("Pass - web element "+ele_val+" clicked")
              else
                if $browser.element(:xpath => ele_val).exists?
                  $browser.element(:xpath => ele_val).when_present.click
                  $logger.info("Pass - web element "+ele_val+" clicked")
                else
                  $logger.error("Fail - web element "+ele_val+" NOT found")
                end
              end
            end
          end
        end
      end

    end

    # check if the target element has the expected value (text)
    def element_include(ele_val,exp_val)
      $browser.element(:xpath, ele_val).text.include?(exp_val).should == true
    end

    # check if the target element exists
    def element_exist(ele_type, ele_val)
      case ele_type
      when "button" then
        if $browser.button(:value => ele_val).exists? then $logger.info("button"+le_val+" exist")
        else
          $logger.error("Fail - web element "+ele_val+" NOT found")
        end
      when "img" then
        if $browser.img(:src => ele_val).exists? then $logger.info(ele_val+" exist")
        else
          $logger.error("Fail - web element "+ele_val+" NOT found")
        end
      when "a" then
        if $browser.a(:href => ele_val).exists? then $logger.info(ele_val+" exist")
        else
          $logger.error("Fail - web element "+ele_val+" NOT found")
        end
      when "a_path" then
        if $browser.a(:xpath => ele_val).exists? then $logger.info(ele_val+" exist")
        else
          $logger.error("Fail - web element "+ele_val+" NOT found")
        end
      when "link" then
        if $browser.link(:id => ele_val).exists? then $logger.info(ele_val+" exist")
        else
          $logger.error("Fail - web element "+ele_val+" NOT found")
        end
      when "element" then
        if $browser.element(:id => ele_val).exists? then $logger.info(ele_val+" exist")
        else
          if $browser.element(:text => ele_val).exists? then $logger.info(ele_val+" exist")
          else
            if $browser.element(:class => ele_val).exists? then $logger.info(ele_val+" exist")
            else
              if $browser.element(:value => ele_val).exists? then $logger.info(ele_val+" exist")
              else
                if $browser.element(:xpath => ele_val).exists? then $logger.info(ele_val+" exist")
                else
                  $logger.error(ele_val+" NOT found")
                end
              end
            end
          end
        end
      end
    end

    ####END####
  end
end

