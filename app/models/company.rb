class Company

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps
  
  has_many :projects

  field :name, type: String
  validates_presence_of :name, message: "name: can not be blank."


  def update_document(args)
    params = ActionController::Parameters.new(args)
    params.permit!
    params.each do |k,v| 
      if self.has_attribute?(k)
        self.write_attributes({ k.to_sym => v })
      end
    end
  end

  def add_attributes(fields)
    fields.each do |field|
      params = ActionController::Parameters.new(field)
      params.permit!
      self.write_attributes(params)
      self.upsert
    end
  end

  def remove_attributes(fields)
    fields.each do |field|
      if self.has_attribute?(field)
        self.attributes.delete(field)
        self.upsert
      end
    end
  end

  
end
