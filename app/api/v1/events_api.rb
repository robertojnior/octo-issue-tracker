module V1
  class EventsAPI < Grape::API
    helpers do
      def ping_event?
        headers['X-Github-Event'] == 'ping'
      end

      def event_params
        declared(params, include_missing: false)
      end
    end

    desc 'List issue events'
    params do
      requires :number, type: String, desc: 'Issue number'
    end

    get '/issues/:number/events' do
      issue = Issue.find_by(number: params[:number])

      error!({ error: "Couldn't find Issue with number #{params[:number]}" }, :not_found) if issue.nil?

      present issue.events, with: Entities::EventEntity
    end

    desc 'Create events and issue if doesnt exists'
    route_setting :auth, disabled: true
    params do
      optional :action, type: String, desc: 'Event action'
      given :action do
        requires :issue, type: Hash do
          requires :number, type: Integer, desc: 'Issue number'
          requires :title, type: String, desc: 'Issue title'
          requires :body, type: String, desc: 'Issue body'
          requires :updated_at, type: String, desc: 'Issue event updated at'
        end
      end
    end

    post '/events' do
      return body false if ping_event?

      event_payload = EventPayload.new(event_params)

      event_registration = EventRegistration.new

      result = event_registration.(event_payload)

      if result.valid?
        present result, with: Entities::IssueEntity, type: :full
      else
        error!({ errors: result.errors }, :unprocessable_entity)
      end
    end
  end
end
