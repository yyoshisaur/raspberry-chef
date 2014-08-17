# -*- coding: utf-8 -*-
#
# Cookbook Name:: python
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

PYENV_ROOT = "#{node["user"]["home"]}/.pyenv"

# git checkout pyenv
git PYENV_ROOT do
  repository "https://github.com/yyuu/pyenv.git"
  reference "master"
  action :checkout
  user node["user"]["name"]
  group node["user"]["group"]
end

# git checkout pyenv-virtualenv
git "#{PYENV_ROOT}/plugins/pyenv-virtualenv" do
  repository "https://github.com/yyuu/pyenv-virtualenv.git"
  reference "master"
  action :checkout
  user node["user"]["name"]
  group node["user"]["group"]
end

# create .bash_profile
file "#{node["user"]["home"]}/.bash_profile" do
  owner node["user"]["name"]
  group node["user"]["group"]
  action :create_if_missing
end

# setup pyenv
bash "setup pyenv" do
  user node["user"]["name"]
  group node["user"]["group"]
  environment "HOME" => node["user"]["home"]
  code <<-EOC
    echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile
    source ~/.bash_profile
  EOC
  not_if { File.read("#{node["user"]["home"]}/.bash_profile").include?("pyenv") }
end

# install package
%w(libbz2-dev libsqlite3-dev).each do |pkg|
  package pkg do
    action :install
  end
end

# install
bash "install python" do
  user node["user"]["name"]
  group node["user"]["group"]
  environment "HOME" => node["user"]["home"]
  code <<-EOC
    #{PYENV_ROOT}/bin/pyenv install #{node["version"]["python2"]}
    #{PYENV_ROOT}/bin/pyenv install #{node["version"]["python3"]}
    #{PYENV_ROOT}/bin/pyenv global #{node["version"]["python2"]}
  EOC
  timeout 6 * 60 * 60
end
