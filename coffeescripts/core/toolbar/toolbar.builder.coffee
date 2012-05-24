# This builds the toolbar from the given component groups.
# 
# Arguments:
# * template - element holding the toolbar template
# * availableComponents - a map of available components
# * components - the components to display
#
# The format of the availableComponents is an array of objects that respond to
# htmlForToolbar() and cssForToolbar().
#
# The components argument is an array of components.
# * "|" specifies a division between groups of components.
# * "-" specifies a gap between components.
# * Strings are mapped to the availableComponents.
# e.g.
#   [
#     "Bold", "Italic", "-", "Underline", "|",
#     "H1", "H2", "H3", "|",
#     "Left, "Center", "Right", "|",
#     "Image", "Link", "Table", "|"
#   ]
define ["jquery.custom", "core/helpers"], ($, Helpers) ->
  class ToolbarBuilder
    constructor: (template, @availableComponents, @components) ->
      @$template = $(template)

    # Builds the toolbar with the given component groups.
    # Returns [toolbar, css]
    build: ->
      [components, css] = @getComponents()
      $toolbar = $(@$template.mustache(componentGroups: components))
      $toolbar.find("[data-action]").each(->$(this).attr("unselectable", "on"))
      return [$toolbar, css]

    # Returns an array of component groups.
    # e.g.
    #   [
    #     [{components: {html: "HTML string"}}, ...],
    #     ...
    #   ]
    getComponents: ->
      groups = []
      html = ""
      css = ""
      for component in @components
        if component == "|"
          # If there is a new group, store the old one and create a new one.
          groups.push(html: html)
          html = ""
        else
          # If it is a component, continue adding it to the current group.
          [componentHTML, componentCSS] = @getComponentHtmlAndCss(component)
          html += componentHTML
          css += componentCSS
      # Store the last group if there are components in it.
      groups.push(html: html) unless html.length == 0
      return [groups, css]

    # Return the HTML and CSS strings that correspond to the component.
    getComponentHtmlAndCss: (key) ->
      html = ""
      css = ""
      # Normalize the key to lowercase.
      components = @availableComponents[key.toLowerCase()]
      throw "The component(s) for #{key} is not available. Please check that the plugin has been included." unless components
      for component in components
        switch Helpers.typeOf(component)
          when "string" then [componentHTML, componentCSS] = @getComponentHtmlAndCss(component)
          when "object" then [componentHTML, componentCSS] = [component.htmlForToolbar(), component.cssForToolbar()]
          else throw "Unrecognized component format for '#{key}'. Expecting a string or UI component object"
        html += componentHTML
        css += componentCSS
      return [html, css]

  return ToolbarBuilder
