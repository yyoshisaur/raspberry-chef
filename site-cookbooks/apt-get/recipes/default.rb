#
# Cookbook Name:: apt-get
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "update system " do
  command "apt-get update"
end
