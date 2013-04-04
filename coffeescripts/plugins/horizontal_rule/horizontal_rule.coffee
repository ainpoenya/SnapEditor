define ["jquery.custom", "plugins/helpers"], ($, Helpers) ->
  window.SnapEditor.internalPlugins.horizontalRule =
    commands:
      horizontalRule: Helpers.createCommand("horizontalRule", "ctrl.=", (e) ->
        e.api.clean() if e.api.insertHorizontalRule()
      )
  window.SnapEditor.insertStyles("plugins_horizontal_rule", Helpers.createStyles("horizontalRule", 24 * -26))
