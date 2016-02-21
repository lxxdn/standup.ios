require 'sinatra'
require 'json'

get '/' do
  'Hello world!'
end


get '/allTasks' do
  content_type 'application/json'

  a = {
    projects: [
      {
        project_id: 1,
        project_name: "pyro",
        employeesOnProject: [
          {
            employee_name: 'julien',
            avatar: 'http://',
            tasks: [
              {
                content: 'fix bug',
                status: 'new'
              },
              {
                content: 'feedback',
                status: 'done'
              }
            ]
          },
          {
            employee_name: 'maxime',
            avatar: 'http://',
            tasks: [
              {
                content: 'sdjklf jlsdf',
                status: 'new'
              },
              {
                content: 'weiu o rx cmn,',
                status: 'done'
              },
              {
                content: 'lskdfj wuieyr',
                status: 'new'
              }
            ]
          }
        ]
      },
      {
        project_id: 2,
        project_name: 'kidizz',
        employeesOnProject: [
          {
            employee_name: 'alex',
            avatar: 'http://',
            tasks: [
              {
                content: 'fix bug',
                status: 'new'
              },
              {
                content: 'feedback',
                status: 'done'
              }
            ]
          },
          {
            employee_name: 'xiaoming',
            avatar: 'http://',
            tasks: [
              {
                content: 'fix bug',
                status: 'new'
              },
              {
                content: 'feedback',
                status: 'done'
              }
            ]
          }
        ]
      }
    ]
  }

  a.to_json
end