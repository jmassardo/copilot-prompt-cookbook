require 'sinatra'
require 'json'
require 'octokit'

# Create an enpoint to receive the webhook
post '/protect' do
  # Create a github client using an environment variable for the token
  gh = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])

  # Capture the payload
  request.body.rewind
  payload = JSON.parse(request.body.read)
  
  # If we have a Create action, then enable the rules
  if payload["action"] == "created"

    # Create a hash of the rules
    rules = {
    enforce_admins: false,
    required_pull_request_reviews: {
      dismissal_restrictions: {},
      dismiss_stale_reviews: false,
      require_code_owner_reviews: false
      }
    }

    # Grab the repo name (org/repo)
    repo = payload["repository"]["full_name"]

    # Since this only runs against new repos, it's relatively safe to assume the first branch is the only one
    branch = gh.branches(repo).first.name
    puts "Attempting to set branch protection rules on the #{branch} branch of #{repo}"

    # Attempt to set the rules
    # TODO: This shoul be wrapped in a rescue block to trap errors
    rules_result = gh.protect_branch(repo, branch, rules)

    # Build issue body
    issue_body = <<~EOF
    Greetings @jmassardo!

    This issue is to notify you that the following branch protection rules were enabled on this repo.

    ```
    #{rules}
    ```
    EOF

    # Attempt to create the notification issue
    # TODO: This shoul be wrapped in a rescue block to trap errors
    issue_result = gh.create_issue(repo, "Branch Proection rules enabled.", issue_body)
  else
    # Received something else besides a "create". skipping webhook
    puts "IDK what to do with this action"
  end
end
