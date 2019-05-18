module InvitationsHelper
  def get_status_color(status)
    color = Hash[
      "pending"=> "yellow",
      "denied"=> "red",
      "accepted"=> "green",
    ]
    color["#{status}"]
  end
end
