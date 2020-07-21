require 'open-uri'
# require 'prawn'
# require 'prawn/fast_png'
include Rails.application.routes.url_helpers

class Sequence < ApplicationRecord
  has_many :asana_instances
  has_many :asanas, :through => :asana_instances
  belongs_to :user

  def generate_pdf
    asana_instances = self.asana_instances
    sequence_name = self.name
    created_at = self.created_at
    img_size = 115
    img_padding_right = 25
    img_padding_bottom = 55
    img_margin_bottom = 10
    page_one_top = 670
    subsequent_page_top = 700
    poses_per_line = 4
    lines_per_page = 4
    poses_per_page = poses_per_line * lines_per_page

    pdf = Prawn::Document.new
    pdf.text sequence_name, align: :center, color: "333333", size: 24
    pdf.text(
      "Created " + created_at.strftime("%m/%d/%Y"),
      align: :center,
      color: "555555",
      size: 12
    )
    asana_instances.each_with_index do |asana_instance, index|
      url = rails_blob_url(asana_instance.asana.thumbnail, host: 'localhost:8000')
      png_file = open(url)
      image = Magick::Image.read(png_file.path)[0]
      image.format = "JPG"
      # system "convert -flatten #{image.filename} #{image.filename}"

      page_index = index / poses_per_page
      page_top = page_index > 0 ? subsequent_page_top : page_one_top
      pdf.start_new_page if index != 0 && index % poses_per_page == 0
      x = (index % poses_per_line) * (img_size + img_padding_right)
      y = page_top - ((img_size + img_padding_bottom) * ((index - (page_index * poses_per_page)) / poses_per_line))
      pdf.image StringIO.new(image.to_blob), at: [x, y],fit: [img_size, img_size]
      pdf.text_box(
        asana_instance.notes,
        at: [x, y - (img_size - img_margin_bottom)],
        width: img_size,
        height: img_padding_bottom - img_margin_bottom,
        size: 9
      )
    end
    pdf.render
  end
end
