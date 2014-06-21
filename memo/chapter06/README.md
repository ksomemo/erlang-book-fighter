# ６章まとめ

## 終了の方法
* halt().      %% => なにも出力されないで終わる
* init:stop(). %% => okと出力されて終わる

## ロードされるコードのパス
* code:get_path().
* phpのget_include_pathに似ている

## パスの設定
phpのset_include_pathの代わりに、下記がある

* code:add_patha(Dir) %% => 先頭に追加
* code:add_pathz(Dir) %% => 末尾に追加
* erl -pa DirPa -pz DirPz でも設定できる
* その他の設定としては後述の.erlangファイルに記述する

## .erlang
* 中身はErlangファイルである
* 起動前に実行される
* 起動ディレクトリに同名のファイルが存在するとそちらが使われる
* 存在しない場合はホームディレクトリのファイルが実行される
* どちらのファイルが実行されるかを試すために?FILEマクロを使ったがエラーとなった
* .erlangファイルは通常のErlangファイルとは違うようである
* ホームディレクトリのファイルにfile:get_cwd()を記述しても、起動ディレクトリが表示された


## erlコマンドから即時実行

```
% erl -eval 'io:format("hello world~n").'             
1> hello world
q().
ok
```

* q(). はhello worldが出力されてから、入力したものである
* つまり、入力を受付けている状態で止まっている 

そこで、下記のように変更することですぐにshellを終了できる

```
% erl -eval 'io:format("hello world~n"), init:stop().'
1> hello world
```

または、下記のようにすることでshellの行番号を出さずに確認もできる

```
% erl -eval 'io:format("hello world~n").' -noshell -s init stop
hello world
```

* -noshellだけでは終了できないので注意する。
* -s はapplyと同じで ModuleName FunctionName を指定する。
* 引数を与える方法は知らない…

## コンパイル
* erlc filename.erl によりbeamファイルを作成する
* 前述のerl -s により、モジュールと関数を指定して試すことが出来る

## コマンドラインからの引数を使う
* 前述したときは分からなかったが、引数はアトムのリストとして渡される
* 詳しくはuse_args.erlを参照
* よって、アトムを使いたい型に変換する必要がある

## erl_crash.dumpとwebtool
* Erlangを起動中または起動した際にエラーで落ちると、起動ディレクトリにerl_crash.dumpが作成される
* これは文字通りクラッシュした際の情報を持っている
* この情報を詳しく見るためにwebtoolを使う(webtool:start().)
* あとは、表示されたlocalhost:portにアクセスして見るだけ
* 情報の見方については調べてない
* テキストファイルになっているので直接見れる

## 自動化のためのMakeおよびMakefile
* Makefielにごりごり書くよりはrebarを使ったコマンドをMakefileに書くのが主流
* rebar.configを使ってさらに簡単に記述するようなのでこれも調べたい
* 周辺ツール(型解析などいろいろあるので把握できていない…)もMakefileに記述してしまいたい
* makeオプション無しは、一番上のものが実行される(Erlang関係なく知らなかった)
* https://github.com/voluntas/snowflake のErlang用テンプレートがとてもためになる

## 落ちた時のコマンド実行
* erl -heart Cmd
* http://erlang.org/doc/man/heart.html

## Erlang用のヘルプ
* erl -man erl|moduleName など
* kerlでのインストールではManualが用意されていないので下記手順でインストールする

```
cd ~/erlang/r16b03-1/
curl -O http://www.erlang.org/download/otp_doc_man_R16B03-1.tar.gz
tar zxfv otp_doc_man_R16B03-1.tar.gz 
```

以下のものが展開されていた

```
-rw-r--r-- COPYRIGHT
-rw-r--r-- PR.template
-rw-r--r-- README
drwxr-xr-x man/
```

http://www.erlang.org/documentation/doc-5.0.2/doc/installation_guide/problem_reports.html  
を見て、PR.templateの用途がわかった
