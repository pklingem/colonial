attr :name, 'Tom Wilson'
attr :title, 'Tom Wilson'

content :haml => file('tom.haml'), :layout => layout('default.haml')

=begin
---
name: Tom Wilson
---
.grid_4.alpha{:style => 'text-align: right'}
  %div{:style => 'background:whitesmoke;padding: 5px;border 1px solid lightgray;'}
    %img{:src => gravatar_img_src_for_email('tom@jackhq.com'), :alt => 'Tom Wilson', :style => 'float:left;padding:3px;border:1px solid darkgray;'}
  
    %h2 Tom Wilson
    %p Member since 2010
.grid_8.omega
  %ul{:style => 'margin:0;padding:20px;'}
    %li
      %a{:href => 'http://github.com/twilson63'} Projects
    %li
      %a{:href => 'http://www.linkedin.com/in/jackhq'} Profile
    %li
      %a{:href => 'http://twitter.com/jackhq'} Twitter
.clear
=end