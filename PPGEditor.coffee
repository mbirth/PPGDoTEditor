window.loadSavegame = ->
    data = $.trim($('#file').val())
    console.log 'Loaded %i characters.', data.length
    fields = data.split ';'
    console.log 'Found %i fields.', fields.length
    savedata = {}
    for own i, field of fields
        [name, value, type] = field.split ':'
        switch type
            when 'B' then value = (value is 'T')
            when 'I' then value = parseInt value
            when 'F' then value = parseFloat value
            when 'L' then value = parseInt value
        savedata[name] = {
            'value': value
            'type': type
        }
    console.log 'Savegame data: %o', savedata
    missing = 0
    for own field, value of savedata
        html = $('#'+field)
        if html.length is 0
            console.log 'Missing HTML field for: %s (%s:%o)', field, value.type, value.value
            missing++
            continue
        element = html.get(0).tagName
#        console.log 'HTML: %o %s', html, html.get(0).tagName
        switch element
            when 'INPUT'
                type = html.prop 'type'
                switch type
                    when 'checkbox'
                        html.attr 'checked', value.value
                        html.attr 'data-type', value.type
                    else
                        html.val value.value
                        html.attr 'data-type', value.type
            else
                html.val value.value
                html.attr 'data-type', value.type
    console.log '%i HTML fields were missing', missing

window.copySavegame = (src, trg) ->
    srcFields = $('*[id^=S'+src+']')
    console.log 'Source objects: %o', srcFields
    for i in [0..srcFields.length-1]
        srcEl = srcFields.eq(i)
        srcId = srcEl.attr('id')
        srcType = srcFields.eq(i).prop 'type'
        trgId = srcId.replace 'S'+src, 'S'+trg
        trgEl = $('#'+trgId)
        console.log 'Copy %o to %o', srcEl, trgEl
        switch srcType
            when 'checkbox'
                trgEl.attr 'checked', srcEl.attr 'checked'
            else
                trgEl.val srcEl.val()
    console.log 'All done.'

window.generateSavegame = ->
    console.log 'Creating savegame from fields.'
