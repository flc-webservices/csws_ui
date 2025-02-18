require "uri"

# sets up the AppConfig to conform to CSWS's
AppConfig[:pui_hide][:repositories] = true
AppConfig[:pui_hide][:subjects] = false
AppConfig[:pui_hide][:agents] = false
AppConfig[:pui_hide][:accessions] = true
AppConfig[:pui_hide][:classifications] = true
AppConfig[:pui_branding_img] = "/assets/SWCenter-Logo.png"
AppConfig[:pui_branding_img_alt_text] = "Center of Southwest Studies"

# page actions override
AppConfig[:pui_page_actions_cite] = true
AppConfig[:pui_page_actions_request] = true
AppConfig[:pui_page_actions_print] = true

## OVERRIDE VARIOUS METHODS/ ADD NEW METHODS
Rails.application.config.after_initialize do
  class ArchivesSpaceClient
    # add "talk directly to solr"
    def solr(params)
      url = URI("#{AppConfig[:solr_url]}/select")
      url.query = URI.encode_www_form(params)
      results = do_search(url)
      results
    end

    # do an internal redirect? from https://coderwall.com/p/gghtkq/rails-internal-requests
    # commenting that out for now; just doing a redirect
    def internal_request(path, params = {})
      #      request_env = Rack::MockRequest.env_for(path, params: params.to_query) #.merge({
      #                                      'rack.session' => session  # remove if session is unavailable/undesired in request
      #                                                                                   })
      # Returns: [ status, headers, body ]
      #      Rails.application.routes.call(request_env)
      ActionController::Redirecting.redirect_to(path)
    end
  end

  class Search
    def Search.get_boolean_opts
      if @@BooleanOpts.empty?
        @@BooleanOpts = %w(AND OR NOT).map { |opt|
          [I18n.t("advanced_search.operator.#{opt}"), opt]
        }
      end
      @@BooleanOpts
    end
  end

  # Override some assumed defaults in the core code
  Searchable.module_eval do
    alias_method :core_set_up_advanced_search, :set_up_advanced_search

    # we don't want to see agents or subjects in the search results, only in facets
    def set_up_advanced_search(default_types = [], default_facets = [], default_search_opts = {}, params = {})
      unless default_types.blank?
        default_types.delete("agent")
        default_types.delete("subject")
      end
      core_set_up_advanced_search(default_types, default_facets, default_search_opts, params)
    end
  end
end
