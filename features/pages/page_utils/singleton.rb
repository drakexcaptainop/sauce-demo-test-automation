class SingletonParent
  def self.instance 
    @instance||=new
  end
  private_class_method :new
end