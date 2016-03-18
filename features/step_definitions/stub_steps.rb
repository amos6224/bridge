Given /^the call to the lockable admin worker is stubbed$/ do
  AdminTasks::LockableAdmin.stub perform_async: nil
end
