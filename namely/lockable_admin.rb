module AdminTasks
  class LockableAdmin
    include Sidekiq::Worker
  end
end
