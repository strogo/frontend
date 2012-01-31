Frontend::Application.routes.draw do
  # Crude way of handling the situation described at
  # http://stackoverflow.com/a/3443678
  match "*path.gif", :to => proc {|env| [404, {}, ["Not Found"]] }

  match "/help/feedback" => redirect("/feedback")
  match "/help(/:action)", :to => "help"
  match "/feedback", :to => 'feedback#index'

  match "/platform(/:action)", :to => "platform"
  match "/settings", :to => "root#settings"
  match "/section", :to => "root#section"
  match "/tour", :to => "root#tour"
  match "/identify_council/:slug", :as => "identify_council", :to => "root#identify_council"
  match "/places/load_places/:slug", :as => "load_places", :to => "root#load_places"

  with_options(:as => "publication", :to => "root#publication") do |pub|
    pub.match ":slug/video", :format => :video
    pub.match ":slug/print", :format => :print
    pub.match ":slug(/:part)"
  end

  match "/homepage" => redirect("/")
  root :to => 'root#index'
end
