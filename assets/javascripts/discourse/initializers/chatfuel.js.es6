import { withPluginApi } from 'discourse/lib/plugin-api';
import { observes } from 'ember-addons/ember-computed-decorators';
import { default as computed } from "ember-addons/ember-computed-decorators";
import NotificationsPreferencesController from 'discourse/controllers/preferences/notifications';
import UserController from 'discourse/controllers/user';

export default {
  name: 'chatfuel',

  initialize(container){
    NotificationsPreferencesController.reopen({
      userChatfuelEnabled(){
        const user = this.get("model");
        return user.get("custom_fields.chatfuel_enabled");
      },

      @observes("model.custom_fields.chatfuel_enabled")
      _setUserChatfuelEnabled(){
        var attrNames = this.get("saveAttrNames");
        attrNames.push('custom_fields');
        this.set("saveAttrNames", attrNames);
        const user = this.get("model");
        const userChatfuelEnabled = user.custom_fields.chatfuel_enabled;
        user.set("custom_fields.chatfuel_enabled", userChatfuelEnabled);
      }
    })
  }
}