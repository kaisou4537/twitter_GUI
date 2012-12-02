# -*- coding: utf-8 -*-

### twitter gui
#  動くだけ。日本語入力不可、返信、RT、Favなど何もできない
#  つぶやけるだけ。更新もできます。
#  アイコンは表示できない
###
require 'tk'
require './oauth-access'

# 初期化
  def init
    $text = []
    $tweet_date = []
    $text_count = 0
    $t_y = 0
  end

# タイムラインを取得後、表示させるメソッドへ
  def updateTimeline
    clearData
    $tweet_data = []
    options = {"count" => 10}
#    Twitter.user_timeline("kaisou_test", options).each do |res|
    Twitter.home_timeline.each do |res|
      $tweet_data << "#{res.from_user}: #{res.text}\n"
    end
    showTimeline
  end

# タイムラインを表示
  def showTimeline
    deleteTkText
    $tweet_data.each do |tweet|
      $text << TkText.new(@main_window){
        wrap 'word'
        width 100
        height 100
      }.place(:x=>'40', :y=>(100+$t_y).to_s)
      s_tweet = tweet.split(": ")
      $text[$text_count].insert('1.0',"#{s_tweet[0]}: \n")
      $text[$text_count].insert('2.0',s_tweet[1])
      $text[$text_count].state = 'disabled'
      $t_y += 50
      $text_count += 1
    end
  end

# 新しくツイートする
  def tweetUpdate(strs)
    Twitter.update(strs)
  end

# TkTextオブジェクトを一掃
  def deleteTkText
    $text.each do |t|
      t.destroy
    end
  end

# 値の初期化
  def clearData
    $text = []
    $text_count = 0
    $t_y = 0
  end

# guiの部分
  def mainloop
    @main_window = TkRoot.new{
      title "kaisou_client"
      resizable(0,0)
    }
    @main_window.bind("KeyPress-Escape",proc{exit})
    canv = TkCanvas.new { |canv|
      width 800
      height 400
      pack
    }

    updateTimeline

    v = TkVariable.new
    e = TkEntry.new {
      textvariable v
      width 50
    }.place(:x=>'10', :y=>'10')

    $flag = false
    TkButton.new{
      text "tweet"
      command {
        Twitter.update(v.to_s)
        updateTimeline
        v.set_value("")
      }
    }.place(:x=>'425', :y=>'10')

    TkButton.new{
      text "update"
      command {
#        $text.each do |t|
#          t.destroy
#        end
      updateTimeline
      }
    }.place(:x=>'500', :y=>'10')

    TkButton.new{
      text "exit"
      command proc{
        exit
      }
    }.place(:x=>'580', :y=>'10')

    Tk.mainloop

  end


#end
init
mainloop
#TwitterGUI.new.mainloop
