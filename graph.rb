require 'redwood'
require 'awesome_print'

image_prefix = "conf-"

dockerfiles = Dir["./*/Dockerfile"]

tree = Redwood::Tree.new

dockerfiles.map do |dockerfile|
  image = File.basename(File.dirname(dockerfile))
  from_line = File.readlines(dockerfile).select { |line| line =~ /FROM/i }.first.strip
  from_image = from_line.sub "FROM ", ""
  from_image = from_image.sub image_prefix, ""

  tree.add image, from_image
end

puts tree.order.join " "
