class Tweet < TwitterschedulerClient::CliCommand

  desc 'index', 'List tweets'
  method_option :user_id, :required => 'true'
  def index
    user_id, options, *_ = transform_options(["user_id"])
    data, resp = client.index(user_id)
    print_data(data)
  end

  desc 'show', 'Show a tweet'
  method_option :user_id, :required => 'true'
  method_option :id, :required => 'true'
  def show
    user_id, id, options, *_ = transform_options(["user_id", "id"])
    data, resp = client.show(user_id, id)
    print_data(data)
  end

  desc 'create', 'Create a tweet'
  method_option :user_id, :required => 'true'
  method_option :scheduled_at, :required => false, :desc => '', :type => :string
  method_option :sent, :required => false, :desc => '', :type => :string
  method_option :text, :required => false, :desc => '', :type => :string
  method_option :user_id, :required => false, :desc => '', :type => :string
  def create
    user_id, options, *_ = transform_options(["user_id"], {"tweet"=>["scheduled_at", "sent", "text", "user_id"]})
    data, resp = client.create(user_id, options)
    print_data(data)
  end

  desc 'update', 'Update a tweet'
  method_option :user_id, :required => 'true'
  method_option :id, :required => 'true'
  method_option :scheduled_at, :required => false, :desc => '', :type => :string
  method_option :sent, :required => false, :desc => '', :type => :string
  method_option :text, :required => false, :desc => '', :type => :string
  method_option :user_id, :required => false, :desc => '', :type => :string
  def update
    user_id, id, options, *_ = transform_options(["user_id", "id"], {"tweet"=>["scheduled_at", "sent", "text", "user_id"]})
    data, resp = client.update(user_id, id, options)
    print_data(data)
  end

  desc 'destroy', 'Destroy a tweet'
  method_option :user_id, :required => 'true'
  method_option :id, :required => 'true'
  def destroy
    user_id, id, options, *_ = transform_options(["user_id", "id"])
    data, resp = client.destroy(user_id, id)
    print_data(data)
  end

end
