# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module XPack
    module API
      module Security
        module Actions
          # Adds and updates roles in the native realm.
          #
          # @option arguments [String] :name Role name
          # @option arguments [String] :refresh If `true` (the default) then refresh the affected shards to make this operation visible to search, if `wait_for` then wait for a refresh to make this operation visible to search, if `false` then do nothing with refreshes.
          #   (options: true,false,wait_for)

          # @option arguments [Hash] :headers Custom HTTP headers
          # @option arguments [Hash] :body The role to add (*Required*)
          #
          # @see https://www.elastic.co/guide/en/elasticsearch/reference/current/security-api-put-role.html
          #
          def put_role(arguments = {})
            raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]
            raise ArgumentError, "Required argument 'name' missing" unless arguments[:name]

            headers = arguments.delete(:headers) || {}

            arguments = arguments.clone

            _name = arguments.delete(:name)

            method = Elasticsearch::API::HTTP_PUT
            path   = "_security/role/#{Elasticsearch::API::Utils.__listify(_name)}"
            params = Elasticsearch::API::Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)

            body = arguments[:body]
            perform_request(method, path, params, body, headers).body
          end

          # Register this action with its valid params when the module is loaded.
          #
          # @since 6.2.0
          ParamsRegistry.register(:put_role, [
            :refresh
          ].freeze)
      end
    end
    end
  end
end
