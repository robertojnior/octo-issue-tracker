class GithubEventPayload
  attr_reader :issue

  def initialize(payload, issued_on = Time.zone.now)
    @payload = payload
    @issued_on = issued_on
    @issue = find_or_initialize_issue
    @action = @payload['action']
  end

  def build_issue_params
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
end
