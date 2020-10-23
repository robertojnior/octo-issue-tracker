module V1
  class EventsAPI < Grape::API
    desc 'List issue events'
    params do
      requires :number, type: String, desc: 'Issue number'
    end

    get '/issues/:number/events' do
      issue = Issue.find_by(number: params[:number])

      error!({ error: "Couldn't find Issue with number #{params[:number]}" }, not_found) if issue.nil?

      present issue.events, with: Entities::EventEntity
    end
  end
end
