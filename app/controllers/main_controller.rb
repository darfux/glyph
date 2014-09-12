class MainController < ApplicationController
  def index
    @episodes = [
      %w{第零章 字符之始 新世界的大门已经打开！},
      %w{第一章 字符之用 新世界渴望你来引导！}
    ]
  end

  @@episode_pages = {
    '0' => { '0' => 'word_recite' },
    '1' => { }
  }

  @@word_info = 
    %w{ 一 二 大 小 男 女 人 鱼 狗 鸟
        树 叶 根 皮 肉 血 眼 鼻 嘴 牙齿
        舌 手 脚 骨 卵 角 尾 羽 头 耳
        肚腹 脖子/领 咬 看，视 ?? 躺 死 游 飞 走 
        坐 站 太阳 月 星 水 石 沙子 土地 云
        火 路 山 夜 黑 白 土地？ 这 那
      }
  def episode
    @episode = params[:ep]
    @paragraph = params[:paragraph]
    @word_info = @@word_info
    render @@episode_pages.direct_fetch([@episode,@paragraph], 'episode')
  end

  def word_info
    respond_to do |format|
      format.json { render json: @@word_info }
    end
  end
end
