require 'open-uri'
include Rails.application.routes.url_helpers

class Sequence < ApplicationRecord
  has_many :asana_instances, :dependent => :destroy
  has_many :asanas, :through => :asana_instances
  has_many :likes
  has_many :liking_users, :through => :likes, :source => :user
  has_many :comments
  belongs_to :user
  delegate :username, :username, :to => :user

  def instances_by_layout
    layout = self.layout.map(&:to_i)
    self.asana_instances
      .sort_by{ |instance| layout.index(instance.id) || layout.length }
  end

  def like_by_user(user_id)
    self.likes.find_by_user_id(user_id)
  end

  def generate_pdf
    asana_instances = self.instances_by_layout
    sequence_name = self.name
    created_at = self.created_at
    img_size = 100
    img_padding_right = 45
    img_padding_bottom = 55
    img_margin_bottom = 0
    page_one_top = 670
    subsequent_page_top = 700
    poses_per_line = 4
    lines_per_page = 4
    poses_per_page = poses_per_line * lines_per_page
    name_size = 10
    name_overflow_threshold = 24

    pdf = Prawn::Document.new
    pdf.text sequence_name, align: :center, color: "333333", size: 24
    pdf.text(
      "Created " + created_at.strftime("%m/%d/%Y"),
      align: :center,
      color: "555555",
      size: 12
    )
    asana_instances.each_with_index do |asana_instance, index|
      notes_margin_top = asana_instance.asana.name.length >= name_overflow_threshold ?
        (name_size * 2.5) : (name_size * 1.5)
      url = rails_blob_url(asana_instance.asana.thumbnail, host: 'localhost:8000')
      png_file = open(url, &:read)

      # set trasnparent background to white and convert to jpg for performance
      img_list = Magick::ImageList.new
      img_list.from_blob(png_file)
      # create new "layer" with white background and size of original image
      image = img_list.reverse.flatten_images
      img_list.new_image(img_list.first.columns, img_list.first.rows) { self.background_color = "white" }
      image.format = "JPG"

      page_index = index / poses_per_page
      page_top = page_index > 0 ? subsequent_page_top : page_one_top
      pdf.start_new_page if index != 0 && index % poses_per_page == 0
      x = (index % poses_per_line) * (img_size + img_padding_right)
      y = page_top - ((img_size + img_padding_bottom) * ((index - (page_index * poses_per_page)) / poses_per_line))
      pdf.image StringIO.new(image.to_blob), at: [x, y],fit: [img_size, img_size]
      image.destroy!
      # tell ruby garbage collector to run as work around to cache management bug with RMagic
      GC.start
      pdf.formatted_text_box(
        [{
          text: asana_instance.asana.name,
          size: name_size,
          color: "555555",
        }],
        at: [x, y - (img_size + img_margin_bottom)],
        width: img_size + img_padding_right - 15,
        height: name_size,
        overflow: :expand,
        # style: :bold
      )
      if asana_instance.notes
        pdf.text_box(
          asana_instance.notes,
          at: [x, y - (img_size + img_margin_bottom + notes_margin_top)],
          width: img_size + 15,
          height: img_padding_bottom - img_margin_bottom - notes_margin_top,
          size: 9
        )
      end
    end
    pdf.render
  end
end
