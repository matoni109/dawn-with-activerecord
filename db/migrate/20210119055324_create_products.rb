class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.integer :code
      t.string :product_name
      t.text :description
      t.text :long_descr
      t.text :custom_col
      t.integer :gpo_uk, default: 0
      t.integer :gpo_euro, default: 0
      t.integer :gpo_au, default: 0
      t.integer :gpo_china, default: 0
      t.integer :tuf, default: 0
      t.integer :tuf_r, default: 0
      t.integer :watts, default: 0
      t.float :lead_m, default: 0
      t.integer :hdmi_f, default: 0
      t.integer :hdmi_cut, default: 0
      t.integer :hdmi_coupler, default: 0
      t.integer :data_cut, default: 0
      t.integer :data_f, default: 0
      t.integer :data_coupler, default: 0
      t.boolean :three_pin_to, default: false
      t.boolean :three_pin, default: false
      t.boolean :j_coupler, default: false
      t.boolean :red, default: false
      t.boolean :white, default: false
      t.boolean :black, default: false
      t.boolean :grey, default: false
      t.boolean :silver_ano, default: false
      t.timestamps
    end
  end
end
