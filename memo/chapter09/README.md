# ９章まとめ

並行プログラムにおけるエラー処理とその対処

## プロセスが死んだ時
プロセスにリンクされているプロセスに終了シグナルが送られる

## リンク
* プロセス同士の監視経路のようなもの
* link(pid) によって、呼んだプロセスと呼ばれたプロセス同士をリンクさせる

## 終了シグナルを受け取る
* 終了シグナルは、エラーおよび例外(引数が合わない、算術エラーなど)で死んだプロセスからのメッセージである
* 受け取ったプロセスも、なにもしないと死ぬ
* 死んだプロセスからの終了シグナルをReceiveすれば処理できる

### 終了シグナルの種類
* normal
* kill、シグナルが伝搬されるときkilledシグナルになり他のプロセスを殺さないようにする
* 任意

### プロセスの種類
* 通常のプロセス, normalシグナル以外を受け取ると受け取ったプロセスの場合は死ぬ
* システムプロセス, kill以外の任意のプロセスを受け取っても死なないプロセス

システムプロセスにする関数が存在する

## まとめ
* エラー処理と終了シグナルとプロセスの関係を書いた
* 他にもいろいろあるので、基本的なことだけを書いた
