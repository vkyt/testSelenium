class Earnmiles
  # This class defines the Earn Miles common functionalities
  # Functional Methods: RegionSelectAll, LoadAllOffers, CheckFlyerDetails, CheckFlyerType, 
  # Helper Method: write_binary_file
  #
  #Define class variables
  @FlyerType="something"
  
  class << self
    def RegionSelectAll()
      if ($browser.div(:class =>"region-select-container").present?)
        $browser.select_list(:name, "region").select_value("ALL")
      end
    end
    
    def LoadAllOffers()
      @more=true
      while (@more)
        if (!$browser.a(:class => "load-more").present?)
          actual_png = $browser.screenshot.png
          timestamp = Time.now.strftime("%Y-%m-%d-%H-%M-%S-%L")
          dirname = "../features/EarnMiles/output/screenshots"
          filebase = "#{dirname}/screenshot_#{timestamp}.png"
          puts filebase
          write_binary_file(filebase, actual_png)
          @more=false
        else 
          $browser.a(:class => "load-more").click
          $browser.div(:class=> "loading").wait_while_present
        end
      end
    end
    
    def write_binary_file(file, content)
      dir = File.dirname(file)
      FileUtils.mkdir_p dir unless File.directory?(dir)
      File.open(file, "wb") { |f| f.write content }
    end
    
    def CheckFlyerDetails(type="none")
      if type!= "none"
        @FlyerType=type
      end
      case @FlyerType
      when "OffersListing"
        #puts "checking offers on Offers Listing page"
        $browser.divs(:id => "offer-items-wrap").each do |thumbnail|
          if thumbnail.div.class == "flyerIcon"
            (thumbnail.div.class.a(:class => "btn-offer-actions last see-details").present?).should==true 
          end
        end
      when "OfferThumbnail"
        puts "checking offers on Thumbnail page"
        $logger.info("checking offers on Thumbnail page")
      when "HomeOfferThumbnail"
        puts "checking offers on Home page"
        $logger.info("checking offers on Home page")
      when "none"
        puts "Offer does not exist on this page"
        $logger.info("Offer does not exist on this page")
      else 
        puts "No type specified"
        $logger.info("No type specified")
      end
    end
    
    def CheckFlyerType(page)
      #  if page=~ /IssuanceMiles/
      #    Go(page)
      #    @FlyerType="OffersListing"
      #  end
      case page
      when /IssuanceMiles/
        Go(page)
        @FlyerType="OffersListing"
      when "SponsorHome"
        Go(page)
        @FlyerType="OfferThumbnail"
      when "Home"
        Go(page)
        @FlyerType="HomeOfferThumbnail"
      else 
        Go(page)
        @FlyerType="none"
      end
    end
    #END-OF-EM-CLASS#    
  end
end