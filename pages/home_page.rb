class HomePage 
  class << self
  	def verifyLang()
	  	 $browser.text_field(:id=>"header_collector_number"). set(coll_num)
       $browser.button(:value=>"Go").click
    end
	
	  def verifyL2login(name)
       $browser.text.include? name
	  end
	  def on_homepage()
      $browser.a(:href => "/arrow/Home", :class => 'active').exists?
	  end
  end
end
