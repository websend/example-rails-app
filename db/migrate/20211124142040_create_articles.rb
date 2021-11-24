class CreateArticles < ActiveRecord::Migration[6.1]
  def up
    create_table :articles do |t|
      t.string :title
      t.text :body

      t.timestamps
    end

    Article.create(title: "Hello Rails", body: "I am on Rails!")
  end

  def down
    drop_table :articles
  end
end
