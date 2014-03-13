local-hadoop
===============
hadoopの擬似分散環境をローカル環境に構築します。

「Hadoopをサクッと動かして学習したい」という自分の要望のために作りました。

構築はSampleを動かすところまでです。

　
必要環境
------------
以下のものをインストールしてください。

* `VirtualBox 4.2.18` (Mac OS X 10.8.2) で動作確認済み
 * https://www.virtualbox.org/wiki/Downloads
* `Vagrant 1.4.3` (Mac OS X 10.8.2) で動作確認済み
 * https://www.vagrantup.com/downloads.html

　
Vagrant Plugin のインストール
------------
Vagrant Plugin である`vagrant-omnibus`をインストールしてください。

```shell
$ vagrant plugin install vagrant-omnibus
```

　
git clone
-------------
適当な場所に`git clone`してください。

```shell
$ git clone https://github.com/at-grandpa/local-hadoop.git
```

　
Set Up
--------------
下記コマンドで全て立ち上がります。

```shell
$ cd local-hadoop
$ vagrant up
```

setup中は最大約300MBのファイルをダウンロードします。

この場合、ダウンロードがとても遅いです。（おそらく1時間以上かかります）

別途ブラウザでダウンロードしておくことをお勧めします。

　

以下、別途ダウンロードする際の手順を記します。

最低でも Vagrant Box File のダウンロードをお勧めします。

全ファイルを予めダウンロードしておけば、約５分ほどで立ち上がります。

（ネット環境によります）

　
　
### Vagrant Box File
以下のURLより適当な場所にダウンロードしてください。

* http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box

`vagrant box`コマンドにて、boxを登録します。

```shell
$ vagrant box add ubuntu13.04_amd64 /path/to/raring-server-cloudimg-amd64-vagrant-disk1.box
```

以上でVagrantのBoxファイルの登録は完了です。

この時点で`vagrant up`を行っても、多少は短い時間で立ち上がります。

(それでも30分近くかかります)

　
### JDK
以下のURLよりダウンロードしてください。

* http://www.reucon.com/cdn/java/jdk-7u51-linux-x64.tar.gz

ダウンロードしたファイルは`git clone`した`local-hadoop`ディレクトリ直下に置いてください。

```shell
$ cp /path/to/jdk-7u51-linux-x64.tar.gz /path/to/local-hadoop
```

　
### Hadoop
以下のURLよりダウンロードしてください。

* http://ftp.tsukuba.wide.ad.jp/software/apache/hadoop/common/hadoop-1.2.1/hadoop-1.2.1.tar.gz

ダウンロードしたファイルは`git clone`した`local-hadoop`ディレクトリ直下に置いてください。

```shell
$ cp /path/to/hadoop-1.2.1.tar.gz /path/to/local-hadoop
```

　
### Mahout
以下のURLよりダウンロードしてください。

* http://www.us.apache.org/dist/mahout/0.9/mahout-distribution-0.9.tar.gz

ダウンロードしたファイルは`git clone`した`local-hadoop`ディレクトリ直下に置いてください。

```shell
$ cp /path/to/mahout-distribution-0.9.tar.gz /path/to/local-hadoop
```


　
Sampleの実行
---------------------
立ち上がったら、`local-hadoop`ディレクトリに移動し、以下のコマンドでVMにログインしてください。

```shell
$ vagrant ssh
```

VMにログインしたら、以下のコマンドで Hadoop の Sample プログラムを実行できます。

```shell
[VM] $ hadoop jar /usr/local/hadoop-1.2.1/hadoop-examples-1.2.1.jar pi 10 10
```

これは円周率の計算を行っています。

他にも Sample はあるので、以下コマンドで Sample List を眺めてみてください。

```shell
[VM] $ hadoop jar /usr/local/hadoop-1.2.1/hadoop-examples-1.2.1.jar
```

　
その他
-------------------------
`up.sh`、`provision.sh`は、`vagrant up`と`vagrant provision`のコマンドの実行時間を計測するものです。

