require 'bang_engine'
require 'bang_preprocessor'
Rails.application.assets.register_engine '.coffee', BangBang::Template
Rails.application.assets.unregister_processor('application/javascript', Sprockets::DirectiveProcessor)
Rails.application.assets.register_processor('application/javascript', BangBang::Processor)
