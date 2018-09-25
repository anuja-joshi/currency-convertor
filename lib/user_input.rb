class UserInput

  # TODO: Add validation based on input type
  def accept(msg)
    p msg
    gets.chomp.upcase
  end
end
