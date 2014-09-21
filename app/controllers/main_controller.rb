class MainController < ApplicationController
  def index
    @experiments = [
      {index: '实验六', name: '普洛普理论验证', progress: 1, path: nil},
      {index: '实验五', name: '拟境实验', progress: 1, path: nil},
      {index: '实验四', name: '明象实验', progress: 1, path: nil},
      {index: '实验三', name: '辨义实验', progress: 2, path: nil, path: game_episode_path(2, paragraph: 0)},
      {index: '实验二', name: '审音实验', progress: 3, path: nil, path: game_episode_path(1, paragraph: 0)},
      {index: '实验一', name: '实验工具应用实验', progress: 3, path: game_episode_path(0, paragraph: 0)}
    ]
  end

  @@episode_pages = {
    '0' => { '0' => 'character_recite', '1' => 'character_preview' },
    '1' => { '0' => 'recognize_item' },
    '2' => { '0' => 'people_to_people'}
  }

  @@character_info = 
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
    @character_info = @@character_info
    render @@episode_pages.direct_fetch([@episode,@paragraph], 'episode')
  end

  def character_info
    respond_to do |format|
      format.json { render json: @@character_info }
    end
  end
end
