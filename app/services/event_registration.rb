class EventRegistration
  def call(event_payload)
    @event_payload = event_payload

    start
    complete
  end

  private

  def start
    @issue = @event_payload.find_or_initialize_issue
    @issue_params = @event_payload.build_issue_params
  end

  def complete
    @issue.assign_attributes(@issue_params)

    @issue.save

    @issue
  end
end
