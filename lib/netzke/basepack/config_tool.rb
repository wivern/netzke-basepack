module Netzke
  module Basepack
    class ConfigTool < Netzke::Base
      js_base_class "Ext.Component"

      js_method :init, <<-JS
        function(cmp){
          this.parent = cmp;
          if (!cmp.tools) cmp.tools = [];
          cmp.tools.push({id: 'gear', handler: this.onGear, scope: this});
        }
      JS

      js_method :on_gear, <<-JS
        function(){
          this.parent.loadComponent({name: 'configWindow'});
        }
      JS

    end
  end
end