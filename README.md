# ソフトウェア・ライセンス  
- 同梱のバッチファイル：MIT Lisence
- 依存ソフトウェア：すべて権利元に帰属

# 準備  
## バックグラウンドで利用されるアプリケーションのインストール  
- FFmpeg ... audio_cap.batで利用  
  DL: https://ffmpeg.org/download.html  
- Streamlink ... audio_cap.batで利用  
  DL: https://streamlink.github.io/install.html  
- OBS Studio ... obs_captureで利用  
    DL: https://obsproject.com/ja/download  

## OBS Studioの初期設定  
- インストール完了後，起動を確認し， 「設定」から「出力」の設定を行う．（付属のfigフォルダの画像を参考のこと）  
- 「設定」から「ホットキー」の設定を行う．「録画開始」と「録画終了」にはF10キーを設定する．  
- 「シーン」から「DesktopRecording」と名付けられたシーンを追加する．
- 「ソース」から「ウインドウキャプチャ」を選択し，録画対象とするウインドウを選択する．

# バッチファイルの取り扱い方法  
## audio_cap.bat  
- Streamlinkを利用して配信の録音・FFmpegを利用して圧縮を行う．radikoサイトでの動作確認済．  
- 実行時の入力項目：配信のURL（必須）, 出力ファイル名（任意），録画時間（任意）  
- 任意項目でデフォルト設定を適用する場合は何も入力せずにEnterを入力します．  
- 要確認項目：バッチファイル中の変数"ffmpeg_path"にFFmpegの実行ファイルへのパスが設定されていること  
- その他の情報：出力ファイル名はデフォルトでは録画開始時点での時刻がYY-MMDD-hhmmss.mp3の形式で設定されます．録画時間はデフォルトでは無期限となります．  

## obs_capture.bat  
- OBS Studioをバックグラウンド実行して録画を行う．Chromeの録画での動作確認済．
- 実行時の入力項目：録画時間（分）
- 要確認項目：録画用シーン「DesktopRecording」が作成されていること，ホットキー「録画開始」と「録画終了」の設定がF10にされていること，バッチファイル中の変数"obs_path"にOBS Studioのフォルダパスが設定されていること  
- その他の情報：録画設定はすべてOBS Studioの設定に依存します．OBS Studioの起動遅延により，実際の録画時間は設定した録画時間よりも若干短くなることがあります．

