class Base 
  attr_accessor :center_id, :name, :address, :state_name, :district_name, :block_name, :pincode, :from, :to, :sessions
  def from_attributes(params)
    keys =  self.class.instance_methods
    center_info = params.slice(*keys)
    center_info.each do |key, value|
      self.send(key.to_s+'=', value)
    end
  end
end
