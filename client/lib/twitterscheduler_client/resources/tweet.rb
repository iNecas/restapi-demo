module TwitterschedulerClient
  module Resources
    class Tweet < TwitterschedulerClient::Base

      def index(user_id)
        call(:get, "/users/#{user_id}/tweets")
      end

      def show(user_id, id)
        call(:get, "/users/#{user_id}/tweets/#{id}")
      end

      def create(user_id, params = {})
        validate_params!(params, {"tweet"=>["scheduled_at", "sent", "text", "user_id"]})
        call(:post, "/users/#{user_id}/tweets", params)
      end

      def update(user_id, id, params = {})
        validate_params!(params, {"tweet"=>["scheduled_at", "sent", "text", "user_id"]})
        call(:put, "/users/#{user_id}/tweets/#{id}", params)
      end

      def destroy(user_id, id)
        call(:delete, "/users/#{user_id}/tweets/#{id}")
      end

    end
  end
end
