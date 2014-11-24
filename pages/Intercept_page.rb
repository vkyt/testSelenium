class Intercept

 
  ##class to check the items in header for intercept/Enroll Now page/Simple header page 
class << self
#########redirection to intercept page############
 def l2_redirection()
   if ($browser.url.include? "login/SignInL2")
     $logger.info("l2 intercept page opened")
   end
  end
####### AIR MILES CARD LOGO ########
def check_airmiles_card()
         if($browser.link(:class => "logo-airmiles").exists?)
           $browser.link(:class => "logo-airmiles").click
           $logger.info("Airmiles card exist")
         else
           $logger.info("failed - Airmiles not exist")
         end
       end
####### Home page link ########
def Home()
               
              if  ($browser.link(:text, "Home").exists?) == true
                $browser.link(:class => "logo-airmiles").click
                $logger.info("Home page link exist and clicked")               
               else
                $logger.info("Home page link does not exist")     
               end
             end         
####### Help page link ########        
def help()
       
     if  ($browser.link(:text, "Help").exists?) == true
   $browser.link(:text => "Help").click
   $logger.info("Help page link exist and clicked")               
   else
    $logger.info("Help page link does not exist")     
       end
end  

def french()
           
    if  ($browser.link(:text, "Français").exists?) == true
       $browser.link(:text => "Français").click
       $logger.info("francais link exist and clicked")               
       else
        $logger.info("francais link does not exist")     
           end
    end         
  #######lower footer links############ 
def contact_us()
             
      if  ($browser.link(:id, "footer-contact-us").exists?) == true
         $browser.link(:id, "footer-contact-us").click
         $logger.info("contact us cliinked")               
         else
          $logger.info("contact us not clicked")     
             end
      end   
  def site_map()
    sleep 200    
      if  ($browser.link(:text, "Site Map").exists?) == true
        sleep 200   
         $browser.link(:text, "Site Map").click
         $logger.info("sitemap liinked")               
         else
          $logger.info("site map not clicked")     
             end
      end   
  def legal()
               
        if  ($browser.link(:text, "Legal").exists?) == true
           $browser.link(:text, "Legal").click
           $logger.info("legal cliinked")               
           else
            $logger.info("legal not clicked")     
               end
        end         
  def privacy()
               
        if  ($browser.link(:text, "Privacy").exists?) == true
           $browser.link(:text, "Privacy").click
           $logger.info("privacy clicked")               
           else
            $logger.info("privacy not clicked")     
               end
        end       
  def about_us()
               
        if  ($browser.link(:text, "About Us").exists?) == true
           $browser.link(:text, "About Us").click
           $logger.info("About Us clicked")               
           else
            $logger.info("about us  not clicked")     
               end
        end      
  def business_oppor()
                
         if  ($browser.link(:text, "Business Opportunities").exists?) == true
            $browser.link(:text, "Business Opportunities").click
            $logger.info("Business Opportunities cliinked")               
            else
             $logger.info("Business Opportunities not clicked")     
                end
         end   
  def careers()
                
         if  ($browser.link(:text, "Careers").exists?) == true
            $browser.link(:text, "Careers").click
            $logger.info("Careers cliinked")               
            else
             $logger.info("Careers not clicked")     
                end
         end    
 #######################Main Content in page############
  def main_contentL2()

    $browser.windows.first.use         
           if  ($browser.text_field(:id, "collectorNum").exists?) == true
             
             $logger.info("collector number text field exist")   
           end   
           if  ($browser.link(:text, "Enroll Now").exists?) == true
           
                 $logger.info("Enroll Now button exist")   
           end 
          if  ($browser.link(:text, "Forgot Collector Number").exists?) == true
                 $logger.info("collector number text field exist")   
         end
           if  ($browser.button(:value, "Continue").exists?) == true
                     $logger.info("Continue button exist")   
          end
          
          if ($browser.checkbox(:name ,"/atg/userprofiling/ProfileFormHandler.rememberCollector").exists?) == true
            $logger.info("remember me check box exist") 
          end

  end        
  
def main_contentL3() 
  #include main_contentL2()
      if  ($browser.link(:id=>"getMyPin").exists?) == true
      $logger.info(" forget pin link exist")   
      end  
      
      if  ($browser.text_field(:type, "password").exists?) == true
      $logger.info("password text field exist")   
      end     
end
  
  def enroll_now_click()
          $browser.a(:text, "Enroll Now").click                   
          $logger.info("Enroll Now button clicked")   
                    
          end  
 

 def forget_coll_click()
          $browser.link(:text, "Forgot Collector Number").click                   
          $logger.info("forget coll no clicked")   
                        
end  
def click_element(element)
  $logger.info("click_emlement started")
     if(element == "forgotpin" )  
            $browser.button(:value=>"Forgot Pin / Need Help").click             
             $logger.info("forget pin clicked from function")  
       else (element == "Continue")
             $browser.button(:value, "Continue").click
             $logger.info("continue button clicked from function") 
     end
end 

def navigate_intercept_l3()
    $browser.link(:id, "upper-footer-needhelp-signin").click
end 
end            
end