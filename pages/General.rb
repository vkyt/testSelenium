class General 
  class << self
  	def verifyLang(lang)
  	  case lang.downcase
  	  when "en"
        if($browser.div(:text =>"En Français").exist?) 
          return true
        else return false
        end
  	  when "fr"
  	    if($browser.div(:text =>"In English").exist?)
  	      return true
  	    else return false
  	    end
  	  else 
  	    $logger.info("language unrecognized")
  	    return false #language unrecognized
  	  end
      
    end
	
	  def constructURL(page)
       case page.downcase
       when "home" then
         return "http://www.flyertown.ca/"
       else #if page unrecognized, return home page by default
         return "http://www.flyertown.ca/"
       end
	  end

  end
end
