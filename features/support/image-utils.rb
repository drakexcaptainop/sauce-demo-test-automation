require 'mini_magick'
require 'digest'
require 'uri'

class ImageDataComparer
  def fetch_image(url)
    resp = URI.open(url)
    return MiniMagick::Image.open(resp)
  end

  def image_hex_hash_from_url(url)
    image = fetch_image( url )
    raw_pixel_bytes = image.get_pixels.flatten.pack('C*')
    return Digest::MD5.hexdigest( raw_pixel_bytes )
  end
end