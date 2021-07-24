## リンク
[https://pospot-frontend.vercel.app/](https://pospot-frontend.vercel.app/)


## サイト概要
・新しい遊び場を発見・共有するSNS  
・Google Mapに登録されている場所を投稿で共有できる。(Google Map Place APIを使用)  
・ジャンルと都道府県での絞り込み検索で遊び場発見  

### ログイン + 投稿のジャンル検索
![image](https://user-images.githubusercontent.com/70616489/126767379-3c32c2eb-c1d9-4ce4-a5b2-e376c2b29570.gif)

### 投稿機能
![image](https://user-images.githubusercontent.com/70616489/126768547-ea9dfc3d-a392-4f3f-ba96-bd7c73c04624.gif)


### プロフィール機能 + いいね,フォロー投稿一覧
![image](https://user-images.githubusercontent.com/70616489/126854580-3a3a4954-3931-43d1-9a93-220492c431ee.gif)  

サービス名: ポスポット  
URL: [https://pospot-frontend.vercel.app/](https://pospot-frontend.vercel.app/)

github:  
【フロント】 [https://github.com/pon0204/pospot_frontend](https://github.com/pon0204/pospot_frontend)  
【バックエンド】[https://github.com/pon0204/pospot_api](https://github.com/pon0204/pospot_api)

## 制作者の思い
「遊ぶ場所を見つけれずに、毎回同じ場所に行ってしまう」  
これは僕が普段から感じている悩みです。  

世の中には自分が知らない面白い場所、遊び、お店があるはずが、知る機会や方法があまりなく、  
「最近新しい体験ができていないなぁ」と思っていました。

サービスを通して、  
「ユーザーが新しい体験し、共有することで人生を楽しんでほしい」  
「コロナ禍で苦しいお店が紹介されて、経営の助けになってほしい」  

そんな世の中になってくれたらいいなと思い制作しました。

## 使用技術
バックエンド - Ruby On Rails  
フロントエンド - React / TypeScript  
インフラ - Heroku + AWS S3 / Vercel  

【その他技術】  
・ Auth0 → ログイン認証サービス  
・Redux Toolkit → クライアントステートの管理  
・react-query  → サーバーデータ保持  
・Google Map Place API → 場所情報データを取得  
【UI/UX】  
・material-ui  
・Tailwind CSS   
【トップ画像・アイコン製作】  
・Figma  

※インフラ図準備中

## 機能一覧

### ユーザーログイン機能
・Auth0を使用して実装
・メールアドレスとGoogleでのログイン可能

### ユーザー機能  
・token付きの付きの通信を検知し、ユーザーを自動でcreate
・current_user機能付き  

### プロフィール機能  
・ユーザーcreate時に自動でcreate  
・アバター画像登録可能  

### 投稿機能
・一覧表示(新着投稿,フォロー投稿,ユーザー投稿,いいねした投稿)  
・削除機能

### 投稿時  
【バリデーション】  
・文字数,nullのvalidation実装  
【投稿情報】  
・アイキャッチ  
・タイトル  
・説明  
・ジャンル  
・誰と行くのがおすすめか  
・場所情報  

【アイキャッチ】  
・Active Storageで実装  
・画像はAmazon S3に格納  

【タイトルと説明】  
・material uiのTextFiledで実装  
・文字数をカウントし、超えたらエラー  

【ジャンル】  
・AutoCompleteで実装  
・選択肢をクリック or 自分で好きな値を入力  

【誰と行ったか】  
・material uiのラジオボタンで実装  

【場所検索,場所詳細取得】  
・Google Map Place APIを使用  
・自分が登録したい場所をAutoCompleteで検索  
・場所の名前,住所,URLを取得し、DBに保存  
・投稿に表示 

### ページネーション機能
・無限スクロールを実装(react-query useQueryInfiniteを使用)  

### いいね機能
・投稿に対していいね可能  
・いいねした投稿は一覧表示  

### フォロー機能
・ユーザーに対してフォロー可能  
・フォローしたユーザーの投稿を一覧表示  

### 検索機能
・ジャンルと場所の両方で検索  
・AutoCompleteで検索  

