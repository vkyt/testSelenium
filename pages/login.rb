class Login
  class << self
    #    check header collector name on Home page
    def check_name_home(name_val)
      if $browser.div(:class, OB["header"][:coll_name_home]).h2.text.include?(name_val) == true
        $logger.info("collector name correct")
      else
        $logger.error("collector name NOT correct")
      end
    end

    #    check header collector name on non-Home page
    def check_name(name_val)
      if  $browser.div(:class, OB["header"][:coll_name]).h2.text.include?(name_val) == true
        $logger.info("collector name correct")
      else
        $logger.error("collector name NOT correct")
      end
    end

    #    check header cash balance
    def check_cash_balance(cash_val)
      if $browser.div(:class, OB["header"][:cash_balance]).strong.text == cash_val
        $logger.info("cash balance correct")
      else
        $logger.error("cash balance NOT correct")
      end
    end

    #    check header dream balance
    def check_dream_balance(dream_val)
      if $browser.div(:class, OB["header"][:dream_balance]).strong.text == dream_val
        $logger.info("dream balance correct")
      else
        $logger.error("dream balance NOT correct")
      end
    end

    #    check collector field on signin l3 page
    def check_coll_l3(coll_val)
      if $browser.text_field(:id, OB["signinl3"][:coll_num_input]).value == coll_val
        $logger.info("collector number pre-populated")
      else
        $logger.error("collector number pre-populated")
      end
    end

    #  l2 intercept login
    def l2_int_login(coll_val)
      $logger.info("l2 intercept page")
      $browser.text_field(:id, OB["signinl2"][:coll_num_input]).set(coll_val)
      General.click_element("button",OB["signinl2"][:continue_button])
    end

    #    earn miles l2 login
    def l2_earnmiles_login(coll_val)
      $logger.info("earn miles overview")
      $browser.text_field(:id, OB["earnmiles"][:coll_num_input]).when_present.set(coll_val)
      #      $browser.button(:src, "/arrow/webresource/images/earnmiles/buttons/btn_go_signin_tout.png").when_present.click
      General.click_element("button",OB["earnmiles"][:go_button])
    end

    #    l2 miss miles login
    def l2_mm_login(coll_val)
      $logger.info("missing mile l2 login page")
      $browser.text_field(:name, OB["signinl2_missingmiles"][:coll_num_input]).when_present.set(coll_val)
      #      $browser.button(:value,"Continue").when_present.click
      General.click_element("button",OB["signinl2_missingmiles"][:continue_button])
    end

    #    check error message for l2 login
    def l2_login_err(coll_val, err_val)
      Login.l2_int_login(coll_val)
      $browser.div(:class, OB["signinl2"][:err_ops]).text.include?(OB["collpin_err"][:ops]).should == true
      $browser.div(:class, OB["signinl2"][:err_text]).text.include?(err_val).should == true
    end

    #check error message for l3 login
    def l3_login_err(coll_val, pin_val, err_val)
      Login.l3_int_login(coll_val, pin_val)
      $browser.div(:class, OB["signinl3"][:err_ops]).text.include?(OB["collpin_err"][:ops]).should == true
      $browser.div(:class, OB["signinl3"][:err_text]).text.include?(err_val).should == true
    end

    #    l3 intercept login
    def l3_int_login(coll_val, pin_val)
      $logger.info("l3 intercept page")
      $browser.text_field(:id, OB["signinl3"][:coll_num_input]).set(coll_val)
      $browser.text_field(:name, OB["signinl3"][:pin_input]).set(pin_val)
      General.click_element("button",OB["signinl3"][:continue_button])
    end
    
#    verify errors for invalid emails
    def email_error
    end

  end
end