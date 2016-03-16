#! /usr/bin/env ruby

require 'sinatra'
require 'json'
require 'mongo'

@connection ||= Mongo::Client.new([ '127.0.0.1:27017'  ], :database => 'standup')


get '/' do
  'Hello world!'
end


get '/allTasks' do
  a = {
    projects: [
      {
        project_id: 1,
        project_name: "pyro",
        employeesOnProject: [
          {
            employee_name: 'julien',
            avatar: 'http://img0.imgtn.bdimg.com/it/u=4191831375,138217075&fm=23&gp=0.jpg',
            tasks: [
              {
                content: 'fix pryo bug',
                status: 'new'
              },
              {
                content: 'pyro feedback',
                status: 'done'
              }
            ]
          },
          {
            employee_name: 'maxime',
            avatar: 'http://img2.imgtn.bdimg.com/it/u=3467797325,3110048149&fm=23&gp=0.jpg',
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
            avatar: 'http://img0.imgtn.bdimg.com/it/u=1124017760,2858350780&fm=23&gp=0.jpg',
            tasks: [
              {
                content: 'bug fixes',
                status: 'new'
              },
              {
                content: 'feedback from client',
                status: 'done'
              }
            ]
          },
          {
            employee_name: 'xiaoming',
            avatar: 'http://img0.imgtn.bdimg.com/it/u=2948082143,704569477&fm=23&gp=0.jpg',
            tasks: [
              {
                content: 'set up the basic env',
                status: 'new'
              },
              {
                content: 'haha',
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
