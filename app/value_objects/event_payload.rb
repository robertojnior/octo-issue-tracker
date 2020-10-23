class EventPayload
  attr_reader :issue

  def initialize(payload)
    @payload = payload
    @action = @payload['action']
    @issued_on = @payload['issue']['updated_at']
  end

  def build_issue_params
    @issue = find_or_initialize_issue

    issue_params.merge(events_params)
  end

  def ==(other)
    hash == other.hash
  end

  def eql?(other)
    hash == other.hash
  end

  def equal?(other)
    hash == other.hash
  end

  def hash
    @payload.hash
  end

  private

  def find_or_initialize_issue
    issue = Issue.find_by(number: @payload['issue']['number'])

    return issue unless issue.nil?

    Struct.new(:number, :title, :body, :persisted?).new(
      @payload['issue']['number'],
      @payload['issue']['title'],
      @payload['issue']['body'],
      false
    )
  end

  def issue_params
    issue.persisted? ? {} : { number: issue.number, title: issue.title, body: issue.body }
  end

  def events_params
    {
      events_attributes: [
        {
          action: @action,
          issued_on: @issued_on
        }
      ]
    }
  end
end
