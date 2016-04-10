#! /usr/bin/env ruby

require 'sinatra'
require 'json'
require 'mongo'
require 'date'
require 'byebug'

set :bind, '0.0.0.0'

DOMAIN = "http://standup.ekohe.com"

get '/allTasks' do
  content_type 'application/json'

  data = []
  client = get_connection
  date = params['date'] || getLastWeekDay()
  begin
    #today =
    tasks = client[:tasks].find(day: date)
    users = client[:users].find()
    data = transform(tasks, users)
  rescue Exception => e
    puts e
  ensure
    client.close
  end

  {projects: data}.to_json
end


get '/allProjects' do
  content_type 'application/json'

  data = []
  client = get_connection
  begin
    projects = client[:projects].find()
    data = projects.map do |p|
      {
        id: p['_id'],
        name: p['name'],
        team_id:  p['teamId']
      }
    end
    data.sort!{|p1, p2| p1[:name] <=> p2[:name]}
  rescue Exception => e
    puts e
  ensure
    client.close
  end
  {projects: data}.to_json
end

get '/allUsers' do
  content_type 'application/json'

  data = []
  client = get_connection
  begin
    users = client[:users].find({teamId: 'pmEn8uixQEtccsztz'})

    data = users.map do |u|
      {
        id: u['_id'],
        name: u['profile']['name'].split(' ')[0].capitalize,
        email: u['services']['google']['email'],
        avatar: DOMAIN + u['avatar'],
        team_id:  u['teamId']

      }
    end
    data.sort!{|u1, u2| u1[:name] <=> u2[:name] }
  rescue Exception => e
    puts e
  ensure
    client.close
  end
  {users: data}.to_json
end

put '/updateTaskStatus/:id' do
  begin
    task_id = params['id']
    data = JSON.parse request.body.read
    status = data['status']

    client = get_connection
    client['tasks'].find({id: task_id}).first.update_one({"$set" => {status: status}})
  ensure
    client.close
  end
  status 200
end

post '/task/create' do
  client = get_connection
  request.body.rewind
  data = JSON.parse request.body.read
  content = data['content']
  team_id = data['team_id']

  begin
    project = client['projects'].find({_id: data['project_id']}).first
    user = client['users'].find({_id: data['user_id']}).first
    day = Time.now.utc.strftime('%Y-%m-%d')

    client['tasks'].insert_one({
      content: content,
      project: {
        id: project['_id'],
        name: project['name']
      },
      user: {
        id: user['_id']
      },
      day: day,
      order: 1,
      source_from: "api",
      createdBy: {
        id: user['_id'],
        name: user['profile']['name'],
        email: user['services']['google']['email'],
        picture: user['avatar'],
        status: "new"
      },
      teamId: team_id
    })
  ensure
    client.close
  end

  status 200
end

def get_connection
  Mongo::Client.new([ '127.0.0.1:27017'  ], :database => 'standup')
end

def transform(tasks, users)
  projects = {}
  tasks.each do |task|
    project_id =  task["project"]["id"]
    projects[project_id] = {
      project_id: project_id,
      project_name: task['project']['name'],
      employeesOnProject: {}
    } if projects[project_id].nil?

    project_obj = projects[project_id]
    user_info = users.select{|u| u['_id'] == task['createdBy']['id']}[0]

    project_obj[:employeesOnProject][user_info['_id']] = {
      employee_name: user_info['profile']['name'].split(' ')[0],
      avatar: DOMAIN + user_info['avatar'],
      tasks: []
    } if project_obj[:employeesOnProject][user_info['_id']].nil?

    employee_obj = project_obj[:employeesOnProject][user_info['_id']]
    task_id = task['_id'].to_s
    employee_obj[:tasks].push({
      id: task_id,
      content: task['content'],
      status: task['status'] || 'new'
    })
  end

  projects = projects.values
  projects.each do |project|
    project[:employeesOnProject] = project[:employeesOnProject].values
  end
  projects.sort!{|p1, p2| p1[:project_name] <=> p2[:project_name] }
end



def getNextWeekDay()
  date = Date.today
  if Date.today.wday == 0
   date += 1
  elsif Date.today.wday == 6
    date += 2
  end
  date.to_time.utc.strftime("%Y-%m-%d")

end

def getLastWeekDay()
  date = Date.today
  if Date.today.wday == 0
   date -= 2
  elsif Date.today.wday == 6
    date -= 1
  end
  date.to_time.utc.strftime("%Y-%m-%d")
end
