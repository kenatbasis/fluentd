#
# Fluent
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#

require 'fluent/configurable'

module Fluent
  module PluginId
    @@_id_configured = {}

    def configure(conf)
      @id = conf['@id'] || conf['id']
      @_id_configured = !!@id # plugin id is explicitly configured by users (or not)
      if @@_id_configured[@id]
        raise Fluent::ConfigError, "Duplicated plugin id `#{@id}`. Check whole configuration and fix it."
      end
      @@configured_ids[@id] = self
      super
    end

    def plugin_id_configured?
      @_id_configured
    end

    def plugin_id
      @id ? @id : "object:#{object_id.to_s(16)}"
    end

    def configured_plugin_id
      @_id_configured && @id || nil
    end
  end
end
