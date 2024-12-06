module ApplicationHelper
  def get_tax_rate(province)
    {
      "Alberta" => 0.05,
      "British Columbia" => 0.12,
      "Manitoba" => 0.12,
      "New Brunswick" => 0.15,
      "Newfoundland and Labrador" => 0.15,
      "Nova Scotia" => 0.15,
      "Ontario" => 0.13,
      "Prince Edward Island" => 0.15,
      "Quebec" => 0.14975,
      "Saskatchewan" => 0.06
    }[province] || 0.15
  end
end
