class EventAction < EnumerateIt::Base
  associate_values(
    :opened,
    :edited,
    :deleted,
    :pinned,
    :unpinned,
    :closed,
    :reopened,
    :assigned,
    :unassigned,
    :labeled,
    :unlabeled,
    :locked,
    :unlocked,
    :transferred,
    :milestoned,
    :demilestoned
  )
end
