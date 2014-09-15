#
# Cookbook Name:: rpigpio
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

PYENV_ROOT = "#{node["user"]["home"]}/.pyenv"

bash "install RPi.GPIO" do
  user node["user"]["name"]
  group node["user"]["group"]
  environment "HOME" => node["user"]["home"]
  code <<-EOC
    #{PYENV_ROOT}/versions/#{node["version"]["python2"]}/bin/pip install RPi.GPIO
    #{PYENV_ROOT}/versions/#{node["version"]["python3"]}/bin/pip install RPi.GPIO
    
  EOC
  timeout 6 * 60 * 60
end

