module TwitterschedulerClient
  module Resources
    class User < TwitterschedulerClient::Base

      def index
        call(:get, "/users")
      end

      def show(id)
        call(:get, "/users/#{id}")
      end

      def create(params = {})
        validate_params!(params, {"user"=>["name"]})
        call(:post, "/users", params)
      end

      def update(id, params = {})
        validate_params!(params, {"user"=>["name"]})
        call(:put, "/users/#{id}", params)
      end

      def destroy(id)
        call(:delete, "/users/#{id}")
      end

    end
  end
end
