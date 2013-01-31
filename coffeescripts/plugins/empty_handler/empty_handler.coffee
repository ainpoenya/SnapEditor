define ["jquery.custom", "core/helpers"], ($, Helpers) ->
  class EmptyHandler
    register: (@api) ->
      @api.on("snapeditor.activate", @activate)
      @api.on("snapeditor.deactivate", @deactivate)
      @api.on("snapeditor.cleaner_finished", @onCleanerFinished)

    activate: =>
      $(@api.el).on("keyup", @onkeyup)

    deactivate: =>
      $(@api.el).off("keyup", @onkeyup)

    onkeyup: (e) =>
      key = Helpers.keyOf(e)
      if (key == 'delete' or key == 'backspace') and @isEmpty()
        @deleteAll()

    # After the cleaner has finished, insert the default block if the editor is
    # empty.
    onCleanerFinished: =>
      if @isEmpty()
        $(@api.el).empty()
        @insertDefaultBlock()

    # Returns true if the editor has no text. False otherwise.
    isEmpty: ->
      $(@api.el).text().replace(/[\n\r\t ]/g, "").length == 0

    # Removes all content and appends the default block. It then places the
    # selection at the end of the block.
    deleteAll: ->
      $(@api.el).empty()
      @insertDefaultBlock()

    # Insert the default block into the editor and place the selection at the
    # end of the block.
    insertDefaultBlock: ->
      block = $(@api.getDefaultBlock()).html(Helpers.zeroWidthNoBreakSpace)[0]
      @api.el.appendChild(block)
      @api.selectEndOfElement(block) if @api.isValid()

  return EmptyHandler
