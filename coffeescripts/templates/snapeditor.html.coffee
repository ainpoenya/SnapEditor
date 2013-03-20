define [], ->
  """
    <div id="snapeditor_toolbar_template">
      <div class="snapeditor_toolbar">
        <div class="snapeditor_toolbar_frame_outer">
          <div class="snapeditor_toolbar_frame">
            <div class="snapeditor_toolbar_frame_inner">
              <div class="snapeditor_toolbar_content_outer">
                <div class="snapeditor_toolbar_content">
                  <div class="snapeditor_toolbar_content_inner">
                    {{#componentGroups}}
                    <div class="snapeditor_toolbar_group">{{{html}}}</div>
                    {{^last}}
                    <div class="snapeditor_toolbar_divider"></div>
                    {{/last}}
                    {{/componentGroups}}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div id="snapeditor_toolbar_button_template">
      <div class="snapeditor_toolbar_button {{class}}">
        <!--
          The space in {{title }} is required for IE7/8. If the space is
          absent, IE7/8 removes the "" thinking it doesn't need it since {{title}}
          would be a single word. Unfortunately, when we replace {{title}} with
          multiple words, the "" are not reinserted and cause incorrect HTML.
        -->
        <input type="button" title="{{title }}" data-action="{{action}}" />
      </div>
    </div>

    <div id="snapeditor_toolbar_gap_template">
      <span class="snapeditor_toolbar_gap"></span>
    </div>

    <div id="snapeditor_contextmenu_template">
      <div class="snapeditor_contextmenu">
        <div class="snapeditor_contextmenu_content">
          <div class="snapeditor_contextmenu_content_inner">
            {{#componentGroups}}
              {{{html}}}
              {{^last}}
                <div class="snapeditor_contextmenu_separator"></div>
              {{/last}}
            {{/componentGroups}}
          </div>
        </div>
      </div>
    </div>

    <div id="snapeditor_contextmenu_button_template">
      <div class="snapeditor_contextmenu_button {{class}}">
        <button data-action="{{action}}">
          <table>
            <tbody>
              <tr>
                <td class="snapeditor_contextmenu_icon"><div></div></td>
                <td class="snapeditor_contextmenu_description">{{description}}</td>
                <td class="snapeditor_contextmenu_shortcut">{{shortcut}}</td>
              </tr>
            </tbody>
          </table>
        </button>
      </div>
    </div>

    <div id="snapeditor_dialog_template">
      <div class="snapeditor_dialog {{class}}">
        <div class="snapeditor_dialog_title_container">
          <div class="snapeditor_dialog_title">{{title}}</div>
        </div>
        <div class="snapeditor_dialog_content">
          {{{html}}}
        </div>
      </div>
    </div>
  """