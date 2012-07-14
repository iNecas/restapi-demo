class User < TwitterschedulerClient::CliCommand

  desc 'index', 'List users'
  def index
    data, resp = client.index
    print_data(data)
  end

  desc 'show', 'Show an user'
  method_option :id, :required => 'true'
  def show
    id, options, *_ = transform_options(["id"])
    data, resp = client.show(id)
    print_data(data)
  end

  desc 'create', 'Create an user'
  method_option :name, :required => false, :desc => '', :type => :string
  def create
    options, *_ = transform_options([], {"user"=>["name"]})
    data, resp = client.create(options)
    print_data(data)
  end

  desc 'update', 'Update an user'
  method_option :id, :required => 'true'
  method_option :name, :required => false, :desc => '', :type => :string
  def update
    id, options, *_ = transform_options(["id"], {"user"=>["name"]})
    data, resp = client.update(id, options)
    print_data(data)
  end

  desc 'destroy', 'Destroy an user'
  method_option :id, :required => 'true'
  def destroy
    id, options, *_ = transform_options(["id"])
    data, resp = client.destroy(id)
    print_data(data)
  end

end
