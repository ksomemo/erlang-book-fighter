# ４章まとめ

## 例外
明示的に起こす

* exit(a).  %% => exception exit: a
* throw(a). %% => exception throw: a
* error(a). %% => exception error: a ※ erlang:モジュールは省略可能

実行時に意図しない挙動をさせて起こす(ex. chapter03の関数
```
geometry:area(milk). 
exception error: no function clause matching geometry:area(milk) (geometry.erl, line 14)
```

* パターン照合にないため、errorが発生している
* スタックトレースが表示される

### 例外の補足 
* try 〜 catch(case式でのパターンを列挙に似ている)
* try ... end. は式であるため値を返す
* afterブロックでは後処理が行われる(finallyと同じ)が、値を返すことはない
* 詳しくはソース参照

## 標準出力
* 例外の補足の際にio:formatを使って変数の内容を出力した
* エスケープ文字は「~」を使う

## 関数spec
* 関数の補助情報を記載するもの？あまり分かっていない

