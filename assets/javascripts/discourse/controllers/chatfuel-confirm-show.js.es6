import { popupAjaxError } from 'discourse/lib/ajax-error';
import { ajax } from 'discourse/lib/ajax';

export default Ember.Controller.extend({
  queryParams: ["user_id"],
  confirmed: false,

  actions: {
    confirm: function(){
      var self = this;
      console.log('confirmed');
      console.log(this);
      console.log(this.user_id);
      return ajax("/chatfuel/confirm/submit", {
        data: JSON.stringify({"user_id": this.user_id}),
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json'
      }).then(function(result) {
        if (result.errors){
          bootbox.alert(result.errors);
        }
        else {
          self.set("confirmed", true);
        };
      });
    }
  }
})