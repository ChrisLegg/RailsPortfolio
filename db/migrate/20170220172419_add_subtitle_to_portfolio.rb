class AddSubtitleToPortfolio < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :subtitle, :string, after: :title
  end
end
