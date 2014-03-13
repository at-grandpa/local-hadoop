#
# Cookbook Name:: hadoop
# Recipe:: default
#
# All rights reserved - Do Not Redistribute
#

# -----------------------------------------
# ssh setting

execute "ssh setting" do
    cwd node['vagrant']['home_dir']
    command <<-_EOF_
        ssh-keygen -t rsa -N '' -f #{node['vagrant']['home_dir']}/.ssh/id_rsa
        cat .ssh/id_rsa.pub >> .ssh/authorized_keys
        chmod 600 .ssh/authorized_keys
    _EOF_
    user "vagrant"
    group "vagrant"
    action :run
end


cookbook_file "#{node['vagrant']['home_dir']}/.ssh/config" do
    source "config"
    group "vagrant"
    owner "vagrant"
    mode "0600"
end



# -----------------------------------------
# env setting

cookbook_file "/etc/profile.d/jdk_hadoop_mahout_env.sh" do
    source "jdk_hadoop_mahout_env.sh"
    group "vagrant"
    owner "vagrant"
    mode "0644"
end


# -----------------------------------------
# install JDK

if File.exists?("/vagrant/jdk-7u51-linux-x64.tar.gz")
    execute "copy jdk-7u51-linux-x64.tar.gz" do
        command "cp /vagrant/jdk-7u51-linux-x64.tar.gz /tmp"
        user "vagrant"
        group "vagrant"
        action :run
        notifies :run, "execute[tar JDK]", :immediately
        not_if { File.exists?("#{node['jdk']['install_dir']}/jdk1.7.0_51") }
    end
else
    execute "wget JDK" do
        cwd "/tmp"
        command "wget http://www.reucon.com/cdn/java/jdk-7u51-linux-x64.tar.gz"
        user "vagrant"
        group "vagrant"
        action :run
        notifies :run, "execute[tar JDK]", :immediately
        not_if { File.exists?("#{node['jdk']['install_dir']}/jdk1.7.0_51") }
    end
end


execute "tar JDK" do
    cwd "/tmp"
    command "tar zxf jdk-7u51-linux-x64.tar.gz"
    user "vagrant"
    group "vagrant"
    action :run
    notifies :run, "execute[move JDK]", :immediately
    not_if { File.exists?("#{node['jdk']['install_dir']}/jdk1.7.0_51") }
end


execute "move JDK" do
    cwd "/tmp"
    command <<-_EOF_
        mv jdk1.7.0_51 #{node['jdk']['install_dir']}
        ln -s #{node['jdk']['install_dir']}/jdk1.7.0_51 #{node['jdk']['install_dir']}/jdk
    _EOF_
    user "root"
    group "root"
    action :run
    not_if { File.exists?("#{node['jdk']['install_dir']}/jdk1.7.0_51") }
end


# -----------------------------------------
# install hadoop

if File.exists?("/vagrant/hadoop-1.2.1.tar.gz")
    execute "copy hadoop-1.2.1.tar.gz" do
        command "cp /vagrant/hadoop-1.2.1.tar.gz /tmp"
        user "vagrant"
        group "vagrant"
        action :run
        notifies :run, "execute[tar hadoop]", :immediately
        not_if { File.exists?("#{node['hadoop']['install_dir']}/hadoop-1.2.1") }
    end
else
    execute "wget hadoop" do
        cwd "/tmp"
        command "wget http://ftp.tsukuba.wide.ad.jp/software/apache/hadoop/common/hadoop-1.2.1/hadoop-1.2.1.tar.gz"
        user "vagrant"
        group "vagrant"
        action :run
        notifies :run, "execute[tar hadoop]", :immediately
        not_if { File.exists?("#{node['hadoop']['install_dir']}/hadoop-1.2.1") }
    end
end


execute "tar hadoop" do
    cwd "/tmp"
    command "tar zxf hadoop-1.2.1.tar.gz"
    user "vagrant"
    group "vagrant"
    action :run
    notifies :run, "execute[move hadoop]", :immediately
    not_if { File.exists?("#{node['hadoop']['install_dir']}/hadoop-1.2.1") }
end


execute "move hadoop" do
    cwd "/tmp"
    command <<-_EOF_
        mv hadoop-1.2.1 #{node['hadoop']['install_dir']}
        ln -s #{node['hadoop']['install_dir']}/hadoop-1.2.1 #{node['hadoop']['install_dir']}/hadoop
    _EOF_
    user "root"
    group "root"
    action :run
    not_if { File.exists?("#{node['hadoop']['install_dir']}/hadoop-1.2.1") }
end


directory "/home/hadoop/dfs/name" do
    group "vagrant"
    owner "vagrant"
    recursive true
    mode "0755"
    action :create
    not_if { File.exists?("/home/hadoop/dfs/name") }
end


directory "/home/hadoop/dfs/data" do
    group "vagrant"
    owner "vagrant"
    recursive true
    mode "0755"
    action :create
    not_if { File.exists?("/home/hadoop/dfs/data") }
end


directory "/home/hadoop/mapred" do
    group "vagrant"
    owner "vagrant"
    recursive true
    mode "0755"
    action :create
    not_if { File.exists?("/home/hadoop/mapred") }
end


cookbook_file "#{node['hadoop']['install_dir']}/hadoop/conf/hadoop-env.sh" do
    source "hadoop-env.sh"
    group "vagrant"
    owner "vagrant"
    mode "0644"
end


cookbook_file "#{node['hadoop']['install_dir']}/hadoop/conf/core-site.xml" do
    source "core-site.xml"
    group "vagrant"
    owner "vagrant"
    mode "0644"
end


cookbook_file "#{node['hadoop']['install_dir']}/hadoop/conf/hdfs-site.xml" do
    source "hdfs-site.xml"
    group "vagrant"
    owner "vagrant"
    mode "0644"
end


cookbook_file "#{node['hadoop']['install_dir']}/hadoop/conf/mapred-site.xml" do
    source "mapred-site.xml"
    group "vagrant"
    owner "vagrant"
    mode "0644"
end


# -----------------------------------------
# install mahout

if File.exists?("/vagrant/mahout-distribution-0.9.tar.gz")
    execute "copy mahout-distribution-0.9.tar.gz" do
        command "cp /vagrant/mahout-distribution-0.9.tar.gz /tmp"
        user "vagrant"
        group "vagrant"
        action :run
        notifies :run, "execute[tar mahout]", :immediately
        not_if { File.exists?("#{node['mahout']['install_dir']}/mahout-distribution-0.9") }
    end
else
    execute "wget mahout" do
        cwd "/tmp"
        command "wget http://www.us.apache.org/dist/mahout/0.9/mahout-distribution-0.9.tar.gz"
        user "vagrant"
        group "vagrant"
        action :run
        notifies :run, "execute[tar mahout]", :immediately
        not_if { File.exists?("#{node['mahout']['install_dir']}/mahout-distribution-0.9") }
    end
end


execute "tar mahout" do
    cwd "/tmp"
    command "tar zxf mahout-distribution-0.9.tar.gz"
    user "vagrant"
    group "vagrant"
    action :run
    notifies :run, "execute[move mahout]", :immediately
    not_if { File.exists?("#{node['mahout']['install_dir']}/mahout-distribution-0.9") }
end


execute "move mahout" do
    cwd "/tmp"
    command <<-_EOF_
        mv mahout-distribution-0.9 #{node['mahout']['install_dir']}
        ln -s #{node['mahout']['install_dir']}/mahout-distribution-0.9 #{node['mahout']['install_dir']}/mahout
    _EOF_
    user "root"
    group "root"
    action :run
    not_if { File.exists?("#{node['mahout']['install_dir']}/mahout-distribution-0.9") }
end


# -----------------------------------------
# stop hadoop

execute "stop hadoop" do
    command "/usr/local/hadoop/bin/stop-all.sh"
    user "vagrant"
    group "vagrant"
    action :run
end


# -----------------------------------------
# namenode format

execute "namenode format" do
    command "/usr/local/hadoop/bin/hadoop namenode -format -force"
    user "vagrant"
    group "vagrant"
    action :run
end


# -----------------------------------------
# start hadoop

execute "start hadoop" do
    command "/usr/local/hadoop/bin/start-all.sh"
    user "vagrant"
    group "vagrant"
    action :run
end

