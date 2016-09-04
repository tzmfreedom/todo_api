describe API::V1 do
  include Rack::Test::Methods

  def app
    API::V1::Base
  end

  # Todo: paging 
  context 'GET /api/todos' do
    it 'returns an empty array of todos' do
      get '/api/todos'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq []
    end
  end

  context 'GET /api/todos' do
    it 'returns a todo' do
      todo = Todo.create({
        title: 'Test Title',
        description: 'Test Description',
        completed: false
      })
      get "/api/todos/#{todo.id}"
      expect(last_response.status).to eq(200)
      res = JSON.parse(last_response.body, symbolize_names: true)
      expect(res[:title]).to eq todo.title
      expect(res[:description]).to eq todo.description
      expect(res[:id]).not_to eq nil
      expect(res[:completed]).to eq false
      expect(res[:completed_at]).to eq nil
      expect(res[:created_at]).not_to eq nil
      expect(res[:updated_at]).not_to eq nil
    end
  end

  context 'GET /api/todos' do
    it 'returns an array of todos' do
      todo = Todo.create({
        title: 'Test Title',
        description: 'Test Description',
        completed: false
      })
      todo = Todo.create({
        title: 'Test Title',
        description: 'Test Description',
        completed: false
      })

      get '/api/todos'
      expect(last_response.status).to eq(200)
      res = JSON.parse(last_response.body, symbolize_names: true)
      puts res[0]
      puts res[1]
    end
  end

  context 'POST /api/todos' do
    it 'creates a todo and returns it' do
      params = {
        title: 'Test Title',
        description: 'Test Description',
      }
      post '/api/todos', params.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(201)
      res = JSON.parse(last_response.body, symbolize_names: true)
      expect(res[:title]).to eq params[:title]
      expect(res[:description]).to eq params[:description]
      expect(res[:id]).not_to eq nil
      expect(res[:completed]).to eq false
      expect(res[:completed_at]).to eq nil
      expect(res[:created_at]).not_to eq nil
      expect(res[:updated_at]).not_to eq nil

      todo = Todo.find(res[:id])
      expect(todo.title).to eq params[:title]
      expect(todo.description).to eq params[:description]
      expect(todo.completed).to eq false
      expect(todo.completed_at).to eq nil
      expect(todo.created_at).not_to eq nil
      expect(todo.updated_at).not_to eq nil

    end
  end

  context 'PUT /api/todos/:id' do
    it 'updates a todo and returns it' do
      todo = Todo.create({
        title: 'Test Title',
        description: 'Test Description'
      })
      todo = Todo.find(todo.id)

      params = {
        title: 'Test Title2',
        description: 'Test Description2',
        completed: true
      }
      put "/api/todos/#{todo.id}", params.to_json, 'CONTENT_TYPE' => 'application/json'

      expect(last_response.status).to eq(200)
      res = JSON.parse(last_response.body, symbolize_names: true)
      expect(res[:title]).to eq params[:title]
      expect(res[:description]).to eq params[:description]
      expect(res[:id]).to eq todo.id
      expect(res[:completed]).to eq params[:completed]
      expect(res[:completed_at]).not_to eq nil
      expect(res[:created_at]).not_to eq nil
      expect(res[:updated_at]).not_to eq nil

      after_todo = Todo.find(todo.id)
      expect(after_todo.title).to eq params[:title]
      expect(after_todo.description).to eq params[:description]
      expect(after_todo.completed).to eq params[:completed]
      expect(after_todo.completed_at).not_to eq nil
      expect(after_todo.created_at).to eq todo.created_at
      expect(after_todo.updated_at).not_to eq todo.updated_at

    end
  end

  context 'DELETE /api/todos/:id' do
    it 'deletes a todo and returns id' do
      todo = Todo.create({
        title: 'Test Title',
        description: 'Test Description'
      })
      delete "/api/todos/#{todo.id}"
      expect(last_response.status).to eq(200)
      res = JSON.parse(last_response.body, symbolize_names: true)
      expect(res[:id]).to eq todo.id
    end
  end
end
