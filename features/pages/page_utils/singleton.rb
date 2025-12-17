class SingletonPageParent
  include Capybara::DSL

  def self.instance 
    @instance||=new
  end
  
  private_class_method :new
end