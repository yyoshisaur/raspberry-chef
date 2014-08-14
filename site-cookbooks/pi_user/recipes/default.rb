#
# Cookbook Name:: pi_user
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user node["user"]["name"] do
  home node["user"]["home"]
  password node["user"]["password"]
  shell "/bin/bash"
  supports :manage_home => true
  action :create
end

group node["user"]["name"] do
  members [node["user"]["name"]]
  append true
end
