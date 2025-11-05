## This is empty; any customization happens by copying plugin_init.rb.template to replace
# this file (plugin_init.rb), then modifying the values as needed

AppConfig[:pui_collection_org_sidebar_position] = 'left'

# Sites with only one repository don't need a 'Repositories' tab
AppConfig[:pui_hide][:repositories] = true
AppConfig[:pui_hide][:subjects] = false
AppConfig[:pui_hide][:agents] = false
AppConfig[:pui_hide][:accessions] = true
AppConfig[:pui_hide][:classifications] = true
AppConfig[:pui_branding_img] = "/assets/SWCenter-Logo.png"
AppConfig[:pui_branding_img_alt_text] = "Center of Southwest Studies"
AppConfig[:pui_branding_href] = "https://swcenter.fortlewis.edu/"

# page actions override
AppConfig[:pui_page_actions_cite] = true
AppConfig[:pui_page_actions_request] = true
AppConfig[:pui_page_actions_print] = true

# If you want a link to your institution in the footer, modify the locales/en.yml,  and set this switch to true:
AppConfig[:institutionfooter] = true

Rails.application.config.after_initialize do

  # UNCOMMENT THE CODE BELOW to eliminate some types in the search results presentation
   # we don't want to see agents or subjects in the search results, only in facets; 
   # you can delete these or add other components like accession to exclude

   Searchable.module_eval do
    alias_method :core_set_up_advanced_search, :set_up_advanced_search

   
    def set_up_advanced_search(default_types = [], default_facets = [], default_search_opts = {}, params = {})
      unless default_types.blank?
        default_types.delete("agent")
        default_types.delete("subject")
      end
      core_set_up_advanced_search(default_types, default_facets, default_search_opts, params)
    end
  end 

end
