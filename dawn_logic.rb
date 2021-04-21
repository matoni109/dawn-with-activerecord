# require_relative 'config/application'
require 'csv'
# require "pry-byebug"

def dawn_csv(filepath)
  puts 'looking for products :)'
  CSV.foreach(filepath) do |row|
    product = Product.new(
      code: find_code(row),
      product_name: find_models(row),
      description: short_description(row),
      # custom_col: ,
      # gpo_uk:,
      # gpo_euro:,
      gpo_au: find_gpo(row),
      # gpo_china:,
      tuf: find_tuf(row),
      tuf_r: find_tufr(row),
      # watts:,
      lead_m: find_lead_l(row), #
      hdmi_f: find_hdmi_w_flylead(row),
      hdmi_cut: find_hdmi_w_cutout(row),
      hdmi_coupler: find_hdmi_w_coupler(row),
      data_cut: find_data_w_cutout(row),
      data_f: find_data_w_flylead(row),
      data_coupler: find_data_w_coupler(row),
      three_pin_to: find_3_pin_to(row),
      three_pin: find_3_pin(row),
      j_coupler: find_jc(row),
      # red:,
      white: find_white(row),
      black: find_black(row),
      # grey:,
      silver_ano: find_natural(row)
    )
    # product.save!
    # p product.update(description:)
    product.long_descr = long_description(row, product)
    p product
    binding.pry
    # product.save!
  end
end

peak = '638306 PEK8 4G 2TUFR 2HDF JC 0.8 BLK'

### find the colour ###
## TODO: add silver ano
def find_colour(product)
  # binding.pry
  if product.white == true
    'white'
  elsif product.black == true
    'black'
  elsif product.red == true
    'red'
  elsif product.grey == true
    'grey'
  else
    product.custom_col.join
  end
end

### Models Start  ####
# a = [ "a", "a", "b", "b", "c" ]
# a.uniq!   # => ["a", "b", "c"] a.uniq.length
# a.uniq.length
#
#
def find_models(csv_row)
  model = []
  ## TODO Add all the models
  model << find_peak(csv_row)
  model << nil
  model << nil
  model << nil

  ## Find if it is the only model found
  if model.uniq.length > 2
    model = 'UnKnown'
  else
    # binding.pry
    model.join
  end
end

### Models List  ####
# Find PEAK
def find_peak(csv_row)
  # binding.pry
  model = csv_row.join.scan(/PEAK|PEK\d\b/)
  puts "I found #{model.join}"
  # attributes = { model: model }
  model == '' ? nil : model.join
end

### Models End ####

### Description Start ####

# Find PEAK
def short_description(csv_row)
  # binding.pry string.gsub!(/\d+/,"")
  model = csv_row.join.gsub!(/\b\d{6}\b/, '').strip
end

# Call with "row"
def long_description(csv_row, product)
  # binding.pry
  p model = find_models(csv_row)
  p colour = find_colour(product).capitalize
  p gpos = l_desc_gpo_finder(csv_row)
  p tuf = l_desc_tuf_finder(csv_row, product)
  p hdmi = l_desc_hdmi_finder(csv_row, product)
  p data = l_desc_data_finder(csv_row, product)
  p lead = l_desc_lead_finder(csv_row)
  p j_coupler = l_desc_j_coupler_finder(csv_row)
  p three_pin = l_desc_3_pin_finder(csv_row)
  p three_pin_to = l_desc_3_pin_to_finder(csv_row)

  # model in COL with GPOs || TUF & DATA & HDMI & Lead # 3PIN or J Coupler

  long_description = "#{model} #{colour} with #{gpos} #{tuf} #{data} #{hdmi} #{lead} and #{j_coupler} #{three_pin} #{three_pin_to}".strip.gsub(
    '  ', ' '
  )
end

## Long Description START ##

def l_desc_gpo_finder(csv_row)
  # #TO DO: add UK EU CH logic
  gpos = find_gpo(csv_row)
  gpos == 0 ? nil : "#{gpos} GPO"
end

def l_desc_lead_finder(csv_row)
  lead = find_lead_l(csv_row)
  lead == 0 ? nil : "#{lead}m Lead"
end

def l_desc_j_coupler_finder(csv_row)
  jc = find_jc(csv_row)
  jc == true ? 'J Coupler' : nil
end

def l_desc_3_pin_finder(csv_row)
  three_pin = find_3_pin(csv_row)
  three_pin == true ? '3 Pin Plug' : nil
end

def l_desc_3_pin_to_finder(csv_row)
  three_pin = find_3_pin_to(csv_row)
  three_pin == true ? '3 Pin Plug with Thermal Overload' : nil
end

def l_desc_tuf_finder(_csv_row, product)
  if product.tuf > 0
    tuf = product.tuf
    "#{tuf} TUF USB Charger"
  elsif product.tuf_r > 0
    tuf = product.tuf_r
    "#{tuf} TUF-R USB Charger"
  end
end

def l_desc_hdmi_finder(_csv_row, product)
  if product.hdmi_cut > 0
    hdmi = product.hdmi_cut
    "#{hdmi} HDMI Cutouts"
  elsif product.hdmi_f > 0
    hdmi = product.hdmi_f
    "#{hdmi} HDMI Flyleads"
  elsif product.hdmi_coupler > 0
    hdmi = product.hdmi_coupler
    "#{hdmi} HDMI Couplers"
  end
end

def l_desc_data_finder(_csv_row, product)
  if product.data_cut > 0
    data = product.data_cut
    "#{data} DATA Cutouts"
  elsif product.data_f > 0
    data = product.data_f
    "#{data} DATA Flyleads"
  elsif product.data_coupler > 0
    data = product.data_coupler
    "#{data} DATA Couplers"
  end
end

### Description End #####

##### Sockets Start ####

# def find_sockets(csv_row) # All Socket Products
#   find_gpo(csv_row)
#   find_tufr(csv_row)
#   find_tuf(csv_row)
# end

### sockets parts ####

def find_code(csv_row)
  model = csv_row.join.scan(/\b\d{6}\b/)
  puts "Code = #{model}"
  model.join.to_i
end

# 2500 5.0m 5m 0.8
def find_lead_l(csv_row)
  model = csv_row.join.scan(/\b\d+\.\d\b|\b\d+\.\dm\b|\b\dm\b|\b\d{3,4}\b/i).join.downcase.chomp('m')
  # binding.pry
  lead = model.to_f
  puts "I found #{lead} lead lenght"
  lead > 99 ? lead / 1000.to_f : lead.to_f
end

# find number of AU_GPOS
def find_gpo(csv_row)
  model = csv_row.join.scan(/\d+G\b/)
  # > "14G".scan(/\d+|\D+/) ["14", "G"]
  gpos = model.join.scan(/\d+|\D+/)[0].to_i
  puts "I found #{gpos} GPO AU Sockets"
  gpos
end

# find number of TUF-R
def find_tufr(csv_row)
  model = csv_row.join.scan(/\d+TUFR\b|TUFR\b/)
  tufrs = model.join.scan(/\d+|\D+/)[0].to_i
  puts "I found #{tufrs} TUF-R Sockets"
  tufrs
end

# find number of TUF
def find_tuf(csv_row)
  model = csv_row.join.scan(/\d+TUF\b/)
  tufs = model.join.scan(/\d+|\D+/)[0].to_i
  puts "I found #{tufs} TUF Sockets"
  tufs
end

## need to find watts grep(/JC/).any?
def find_pd(csv_row)
  model = csv_row.grep(/\bPD\b/).any?
  puts "I found PD = #{model}"
  model
end

##
def find_3_pin(csv_row)
  model = csv_row.grep(/\b3pp|3PIN\b/i).any?
  puts "I found 3 PIN plug AU = #{model}"
  model
end

##
def find_3_pin_to(csv_row)
  model = csv_row.grep(%r{\b3pp&T/O|3PT/O\b}i).any?
  puts "I found 3 PIN Thermal OL AU = #{model}"
  model
end

## HDMI START ##

def find_hdmi_w_cutout(csv_row)
  model = csv_row.join.scan(/\d+HDC\b|HDC\b/)
  hdmi_cut = model.join.scan(/\d+|\D+/)[0].to_i
  puts "I found #{hdmi_cut} HDMI Cutout"
  hdmi_cut
end

def find_hdmi_w_flylead(csv_row)
  model = csv_row.join.scan(/\d+HDF\b|HDF\b/)
  hdmi_f = model.join.scan(/\d+|\D+/)[0].to_i
  puts "I found #{hdmi_f} HDMI Fly leads"
  hdmi_f
end

def find_hdmi_w_coupler(csv_row)
  model = csv_row.join.scan(/\d+HDC\b|HDC\b/)
  hdmi_c = model.join.scan(/\d+|\D+/)[0].to_i
  puts "I found #{hdmi_c} HDMI Coupler"
  hdmi_c
end

## HDMI END ##

## DATA START ##

def find_data_w_cutout(csv_row)
  # find AUNZ \d+D\s\bAUNZ\b|\d+D\b|D\b
  model = csv_row.join.scan(/\d+D\b|D\b/)
  data_cut = model.join.scan(/\d+|\D+/)[0].to_i
  puts "I found #{data_cut} data Cutout"
  data_cut
end

def find_data_w_flylead(csv_row)
  model = csv_row.join.scan(/\d+DF\b|DF\b/)
  data_f = model.join.scan(/\d+|\D+/)[0].to_i
  puts "I found #{data_f} data Fly leads"
  data_f
end

def find_data_w_coupler(csv_row)
  model = csv_row.join.scan(/\d+DC\b|DC\b/)
  data_c = model.join.scan(/\d+|\D+/)[0].to_i
  puts "I found #{data_c} data Coupler"
  data_c
end

## DATA END ##

# find J Coupler
def find_jc(csv_row)
  model = csv_row.grep(/\bJC\b/).any?
  puts "I found JC = #{model}"
  model
end

## COLOUR START ##

def find_white(csv_row)
  model = csv_row.grep(/\bWHT|WHITE\b/).any?
  puts "I found white = #{model}"
  model
end

def find_black(csv_row)
  model = csv_row.grep(/\bBLK|BK|BLACK\bb/).any?
  puts "I found black = #{model}"
  model
end

def find_natural(csv_row)
  model = csv_row.grep(/\bNA\b/).any?
  puts "I found natural ano =  #{model}"
  model
end

## COLOUR END ##

#### END SOCKETS PARTS ####

dawn_csv('win_test.csv')
