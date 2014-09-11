require_dependency 'coffee_bag_preprocessor'
require_dependency 'hash_direct_fetch_extension'
Rails.application.assets.unregister_processor('application/javascript', Sprockets::DirectiveProcessor)
Rails.application.assets.register_processor('application/javascript', CoffeeBag::Preprocessor)
