# Todo: Restful API/ Status Code
module API
  module V1
    class Base < Grape::API
      version 'v1', using: :header, vendor: 'todo'
      format :json
      prefix :api


      helpers do
        def authenticate!
          #error!('401 Unauthorized', 401) unless current_user
        end
      end

      resource :hoge do
        desc 'return all todo'
        params do
          requires :id, type: Integer, desc: 'Status id.'
        end
        post do
          true
        end
      end

      resource :todos do
        # Todo: orderby
        # Todo: search condition(like title, like description, created_date, completed_date, completed)
        desc 'return all todo'
        get do
          authenticate!
          Todo.all
        end

        # requires
        # line break
        desc 'create a todo'
        params do
          requires :title, type: String, desc: 'Todo title.'
          requires :description, type: String, desc: 'Todo title.'
        end
        post do
          authenticate!
          Todo.create!({
            title: params[:title],
            description: params[:description],
            completed: false
          })
        end

        # requires
        route_param :id do
          # requires
          # line break
          desc 'search a todo'
          get do
            Todo.find(params[:id])
          end

          desc 'update a todo'
          put do
            authenticate!
            todo = Todo.find(params[:id])
            todo.update(
              title: params[:title],
              description: params[:description],
              completed: params[:completed]
            )
            # todo; update completed_date
            todo
          end

          desc 'delete a todo'
          delete do
            authenticate!
            todo = Todo.find(params[:id])
            todo.destroy
          end
        end
      end
    end
  end
end