# frozen_string_literal: true

module Business
  module Schemas
    # Business::Schemas::Product is just the same as the BaseModel but
    # just having a different name
    # spec:
    #  { 'id' => { type: uuid_v4, :required } }
    Product = BaseModel.dup
  end
end
