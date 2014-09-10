class MainController < ApplicationController
  def index
    @episodes = [
      %w{第零章 字符之始 新世界的大门已经打开！},
      %w{第一章 字符之用 新世界渴望你来引导！}
    ]
  end

  @@episode_pages = {
    '0' => { '0' => 'word_recite' }
    '1' => { }
  }

  def episode
    @episode = params[:ep]
    @paragraph = params[:paragraph]
    render @@episode_pages[@episode][@paragraph]
  end
end
