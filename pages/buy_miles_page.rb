class Buymiles
  class << self
    ##TODO Create functions for BuyMiles page to be used in step_definitions
    # methods list
    # check_bricks (id_val); by Yun Bai 8/21/2014
    # select_amount(amount_value)
    # click continue button
    #####BuyMiles.click_button("Continue")
    # click email_edit button
    ##########BuyMiles.click_button("Edit")
    #Buy Landing page
    #Buy nav in the bottom of the brick, FAQs nav in the bottom of the brick, #Learn more link
    def check_buylanding
#      $browser.a(:class,OB["buylanding"][:buy_submenu]).click
      General.click_element("a",OB["buylanding"][:buy_submenu])
      #General.click_element("a",OB["buydetails"][:back_to_main_link])
        $browser.link(:text, "Back to main page").click
      General.click_element("a",OB["buylanding"][:buyfaq_submenu])
      #      $browser.iframe(:id, OB["buylanding"][:faq_overlay]).h1.text.include?("Frequently Asked Questions").should == true
      #      $browser.iframe(:id, OB["buylanding"][:faq_overlay]).element(:xpath, OB["buylanding"][:faq_overlay_close]).when_present_click
      Buymiles.check_faq
      General.click_element("element",OB["buylanding"][:learnmore_link])
      $browser.element(:class, OB["buylanding"][:learnmore_msg]).text.include?("Buy reward miles").should == true
      General.click_element("element",OB["buylanding"][:learnmore_close_button])
    end

    # BuyDetails page
    # COST:     #‘Current Dream balance’ with collector's current dream balance
    #‘Reward Miles’ with a default value of zero (0)
    #‘Updated Dream balance’ with current dream balance
    #‘Price per reward mile’ with a default value of zero (0)
    #'Subtotal’ with a default value of zero (0)
    #‘Total’ with a default value of zero (0)
    def check_cost_buydetails
      General.element_include(OB["buydetails"][:current_dream_balance], "Current Dream balance")
      General.element_include(OB["buydetails"][:actual_dream], "3,080")
      General.element_include(OB["buydetails"][:reward_miles], "Reward Miles")
      General.element_include(OB["buydetails"][:actual_miles], "0")
      General.element_include(OB["buydetails"][:updated_balance], "Updated Dream balance")
      General.element_include(OB["buydetails"][:actual_new_balance], "3,080")
      General.element_include(OB["buydetails"][:price_per_mile], "Price per reward mile")
      General.element_include(OB["buydetails"][:actual_per_mile], "$0.00")
      General.element_include(OB["buydetails"][:subtotal], "Subtotal")
      General.element_include(OB["buydetails"][:subtotal_actual], "$0.00")
      $browser.div(:class,"bgtl-cost-row bgtl-cost-total").div(:class, OB["buydetails"][:total]).text.include?("Total").should == true
      #      General.element_include(OB["buydetails"][:total], "Total")
      #      General.element_include(OB["buydetails"][:total_actual], "$0.00")
      $browser.div(:class,"bgtl-cost-row bgtl-cost-total").div(:class, OB["buydetails"][:total]).text.include?("$0.00").should == true
    end

    def check_cost_after_selection
      General.element_include(OB["buydetails"][:current_dream_balance], "Current Dream balance")
      General.element_include(OB["buydetails"][:actual_dream], "3,080")
      General.element_include(OB["buydetails"][:reward_miles], "Reward Miles")
      General.element_include(OB["buydetails"][:actual_miles], "100")
      General.element_include(OB["buydetails"][:updated_balance], "Updated Dream balance")
      General.element_include(OB["buydetails"][:actual_new_balance], "3,180")
      General.element_include(OB["buydetails"][:price_per_mile], "Price per reward mile")
      General.element_include(OB["buydetails"][:actual_per_mile], "$0.30")
      General.element_include(OB["buydetails"][:subtotal], "Subtotal")
      General.element_include(OB["buydetails"][:subtotal_actual], "$30.00")
      General.element_include(OB["buydetails"][:tax_gst], "GST")
      General.element_include(OB["buydetails"][:gst_actual], "$1.50")
      General.element_include(OB["buydetails"][:tax_qst], "QST")
      General.element_include(OB["buydetails"][:qst_actual], "$2.99")
      $browser.div(:class,"bgtl-cost-row bgtl-cost-total").div(:class, OB["buydetails"][:total]).text.include?("Total").should == true
      #      General.element_include(OB["buydetails"][:total], "Total")
      #      General.element_include(OB["buydetails"][:total_actual], "$0.00")
      $browser.div(:class,"bgtl-cost-row bgtl-cost-total").div(:class, OB["buydetails"][:total]).text.include?("$34.99").should == true
    end

    #Then check FAQs section
    def check_faq
      $browser.iframe(:id, OB["buylanding"][:faq_overlay]).h1.text.include?("Frequently Asked Questions").should == true
      $browser.iframe(:id, OB["buylanding"][:faq_overlay]).element(:xpath, OB["buylanding"][:faq_overlay_close]).when_present_click
    end

    #Then check ‘Your Information’ section: e-mail address

    def check_your_info
      $browser.element(:class, OB["buydetails"][:email_label]).text.include?("Email Address").should == true
      $browser.element(:class, OB["buydetails"][:email_default]).text.include?("ybai@loyalty.com").should == true
    end

    #   Then check Ratio buttons for profile email address, or alternate email address; default is profile address
    def check_radio_button
      General.element_include(OB["buydetails"][:email_profile_radio], "Send confirmation to the email address above")
      General.element_include(OB["buydetails"][:email_alter_radio], "Send confirmation to a different email address")
      $browser.element(:xpath, OB["buydetails"][:email_radio_default]).value.should == "true"
      #      $browser.element(:xpath, OB["buydetails"][:email_profile_radio]).text.include?("Send confirmation to the email address above").should == true
      #      $browser.element(:xpath, "/html/body/div[8]/div[2]/div[2]/div/div/div[2]/div[2]/form/div[4]/span[2]").text.include?("Send confirmation to a different email address").should == true
      #      $browser.element(:xpath, "/html/body/div[8]/div[2]/div[2]/div/div/div[2]/div[2]/form/div[4]/input[3]").value.should == "true"
    end

    #When click ‘Terms & Conditions’ link
    #Then it opens T&C overlay, close the overlay
    def check_tnc
      General.click_element("element",OB["buydetails"][:term_condition_link])
      $browser.iframe(:id, OB["buydetails"][:term_condition_link]).h1.text.include?(OB["buydetails"][:term_condition_msg]).should == true
      $browser.iframe(:id, OB["buydetails"][:term_condition_link]).element(:xpath, OB["buydetails"][:term_condition_close]).when_present.click    
    end

    # SELECT THE AMOUNT OF THE MILES
#    def select_amount(obj_val, amount_value)
#      $browser.select_list(:id, obj_val).select(amount_value)
#      $logger.info("Select the amount("+amount_value+")");
#    end

# BuyPayment page
    #Please Review section
    def check_review_section
      General.element_include(OB["buypayment"][:tran_type],"Transaction type")
      General.element_include(OB["buypayment"][:actual_type],"Buy")
      General.element_include(OB["buypayment"][:reward_miles],"Reward Miles")
      General.element_include(OB["buypayment"][:actual_miles],"100")
      General.element_include(OB["buypayment"][:price_per_mile],"Price per reward mile")
      General.element_include(OB["buypayment"][:actual_per_mile],"$0.30")
      General.element_include(OB["buypayment"][:subtotal],"Subtotal")
      General.element_include(OB["buypayment"][:subtotal_actual],"$30.00")
      General.element_include(OB["buypayment"][:tax_gst],"GST")
      General.element_include(OB["buypayment"][:gst_actual],"$1.50")
      General.element_include(OB["buypayment"][:tax_qst],"QST")
      General.element_include(OB["buypayment"][:qst_actual],"$2.99")
      General.element_include(OB["buypayment"][:total],"Total")
      General.element_include(OB["buypayment"][:total_actual],"$34.49")
      General.element_include(OB["buypayment"][:name_tag],"Name")
      General.element_include(OB["buypayment"][:name_actual],"RAVS1 SHAH")
      General.element_include(OB["buypayment"][:email_tag],"Email")
      General.element_include(OB["buypayment"][:email_actual],"ybai@loyalty.com")
    end
    #The footer region ‘2 PAYMENT’ of the main brick is highlighted.
    #The ‘Payment Details’ section which contains the embedded Moneris iframe for the Collector to provide his/her Credit Card details
    #The ‘Please Review’ section – directly to the left of the other section - which contains re-capped details (text/copy) from the previous step. This includes;
    #‘Transaction Type’ with text/copy for value ‘Buy’
    #‘Reward Miles’ with the selected Reward miles value
    #‘Price per reward mile’ with the value for price per Reward mile
    #‘Subtotal’ with the sub-total value for the selected Reward miles
    #‘Tax’ with the appropriate tax values for the selected Reward miles
    #‘Total’ with the final total value for the selected Reward miles
    #Specific area titled ‘Your Information’
    #‘Name’ with the Collector’s first and last name
    #‘Email’ with the Collector’s confirmed e-mail address
    #A button/link 'Cancel Transaction' which when clicked, will take Collector’s back to the previous step


    #When enter the invalid cardholder Name/or Credit card number/or Expiration Date, and click ‘Register Details’ button
    #Then it shows an error message.
    def enter_credit_card
    end

    #When enter the correct cardholder Name/Credit card number/Expiration Date, and click ‘Register Details’ button
    #Then it gos to Payment CCV page.
    def enter_credit
    end

    # BuyPayment CCV page
    #Billing information section: Credit Card Security, Terms and Conditions check box
    #Continue button

    # BuyConfirmation page
    #The footer region ‘3 CONFIRMATION’ of the main brick is highlighted.
    #??A hyperlinked label ‘Back to main page’ which when clicked will re-direct him/her to the initiative’s landing page
    #A ‘thank you’ message is displayed.
    #Directly below the message would be two (2) columns containing the same re-cap information as displayed in the previous step.
    #The first (1st) column titled ‘You’ will contain:
    #'Name’ with the Collector’s first and last name
    #‘Email’ with the Collector’s confirmed e-mail address
    #The second (2nd) column titled ‘Payment details’ will contain:
    #‘Transaction Type’ with text/copy for value ‘Buy’
    #‘Transaction no’ with text/copy for the transaction/confirmation number
    #‘Transaction Date’ with text/copy for the order booking date
    #‘Reward Miles’ with the selected Reward miles value
    #‘Price per reward mile’ with the value for price per Reward mile
    #‘Subtotal’ with the sub-total value for the selected Reward miles
    #‘Tax’ with the appropriate tax values for the selected Reward miles (might include GST, QST)
    #‘Total’ with the final total cash value for the selected Reward miles
    #Directly below the columns the Collector will see;
    #‘Print’ button
    #'Done' button
    #Terms & Conditions link
    def check_buyconfirmation
    end

    # add close_print to general_page??
    #When click 'Print' button -
    #Then the standard windows Print window is displayed. close the window
    def click_print
    end

    #When click Terms & Conditions link
    #Then T&C overlay is opened. Close the overlay
    def terms_conditions
      # call the same check_t&c
    end

    # CHECK IF BUY REWARD MILES BRICK EXIST
    def check_bricks (id_val)
      if($browser.img(:src => id_val).exists?)
        $logger.info("brick exists");
      else
        $logger.info("brick NOT found");
      end
    end

    ### END ###
  end
end