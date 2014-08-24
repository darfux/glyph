require 'coffee_bag_preprocessor'
Rails.application.assets.unregister_processor('application/javascript', Sprockets::DirectiveProcessor)
Rails.application.assets.register_processor('application/javascript', CoffeeBag::Preprocessor)
