<layout_setting>
    <setting 
    if={getState().edit} 
    setting_id={setting_id}
    title={getLanguage().general.text_general} >
        <div class="form-group">
            <label class="control-label">{getLanguage().general.text_display} {getLanguage().general.text_header_footer}</label>
            <div>
                <switcher 
                onclick="{parent.edit}" 
                name="layout[header_footer]" 
                data-label-text="Enabled" 
                value={ getLayout().header_footer } />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label">{getLanguage().general.text_display} {getLanguage().general.text_breadcrumb}</label>
            <div>
                <switcher 
                onclick="{parent.edit}" 
                name="layout[breadcrumb]" 
                data-label-text="Enabled" 
                value={ getLayout().breadcrumb } />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label"> {getLanguage().general.text_layout}</label><br/>
            <select
                class="form-control"
                onchange="{parent.changeLayout}" >
                <option
                    each={layout in getState().layouts }
                    if={layout}
                    value={ layout }
                    selected={ layout == getLayout().codename} >
                    { layout } 
                </option>
            </select>
        </div>

        <div class="form-group">
            <label class="control-label"> {getLanguage().general.text_skin}</label><br/>
            <select
                class="form-control"
                onchange="{parent.changeSkin}" >
                <option
                    each={skin in getState().skins }
                    if={skin}
                    value={ skin }
                    selected={ skin == getSession().skin} >
                    { skin } 
                </option>
            </select>
        </div>


        <div class="form-group">
            <label class="control-label"> {getLanguage().general.text_reset}</label><br/>
            <a class="btn btn-danger" onclick={parent.resetState}>{getLanguage().general.text_reset}</a>
        </div>
    </setting>

    <div class="editor animated fadeIn" if={getState().edit}>
        <div class="editor-heading">
            <span>{getLanguage().general.text_editor_title} {getSession().setting_name}</span>
        </div>
        <div class="editor-control">
            <a class="btn btn-lg btn-primary" onclick={toggleSetting}><i class="fa fa-cog"></i></a>
            <a class="btn btn-lg btn-success" onclick={saveState}>{getLanguage().general.text_update}</a>
            <a class="btn btn-lg btn-danger" href="{this.store.getState().close}" target="_parent"><i class="fa fa-close"></i></a>
        </div>
        <div class="editor-account">
            <div class="btn-group btn-group" data-toggle="buttons">
                <label class="btn btn-lg btn-primary { getAccount() == 'guest' ?  'active' : '' }" onclick={changeAccount}>
                    <input type="radio" name="account" value="guest" id="guest" autocomplete="off" checked={ getAccount() == 'guest' }> {getLanguage().account.entry_guest}
                </label>
                <label class="btn btn-lg btn-primary { getAccount() == 'register' ?  'active' : '' }" onclick={changeAccount}>
                    <input type="radio" name="account" value="register" id="register" autocomplete="off" checked={ getAccount() == 'register' }> {getLanguage().account.entry_register}
                </label>
            </div>
        </div>
        <div class="editor-language" if={Object.keys(getState().languages).length  > 1}>
            <div class="btn-group btn-group" data-toggle="buttons">
                <label each={language, language_id in getState().languages} class="btn btn-lg btn-primary { getSession().language == language_id ?  'active' : '' }" onclick={changeLanguage}>
                    <input type="radio" name="language" value="{language_id}" id="{language_id}" autocomplete="off" checked={ getSession().language == language_id }> {language.name}
                </label>
            </div>
        </div>
        <div class="editor-pro" if={ !getState().pro }>
            <pro_label></pro_label>
        </div>
    </div>

    <script>
        var state = this.store.getState();

        this.setting_id = 'layout_setting';
        this.skin = this.store.getSession().skin;

        toggleSetting(e){
            if($('#'+ this.setting_id).hasClass('show')){
                this.store.hideSetting()
            }else{
                this.store.showSetting(this.setting_id);
            }
        }

        edit(e){
            this.store.dispatch('setting/edit', $('#'+this.setting_id).find('form').serializeJSON());
        }

        saveState(e){
            this.store.dispatch('setting/save');
        }

        resetState(e){
            this.store.dispatch('setting/reset');
        }

        changeAccount(e){
            this.store.dispatch('account/update', { account: $(e.currentTarget).find('input').val()});
        }

        changeLanguage(e){
            this.store.dispatch('setting/changeLanguage', { language_id: $(e.currentTarget).find('input').val()});
        }

        changeLayout(e){
            this.store.dispatch('setting/changeLayout', { layout_codename: $(e.currentTarget).val()});
        }

        changeSkin(e){
            this.store.dispatch('setting/changeSkin', { skin_codename: $(e.currentTarget).val()});
        }

        this.on('updated', function(){
            if(this.store.getState().edit){
                this.store.updateLayoutStyle();
            }
        })
    </script>

</layout_setting>