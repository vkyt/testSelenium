class HomePage #this is a template of how pages.rb files should be written
  class << self
  	def enter_valid_collector_num(coll_num="51000088201")
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
