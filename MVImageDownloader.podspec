Pod::Spec.new do |spec|

  spec.name         = "MVImageDownloader"
  spec.version      = "1.0.0"
  spec.summary      = "A simple Image Downloader that has memory caching capability."
  spec.description  = <<-DESC
The image downloader is a customizable image request handler. It handles asynchronous images and avoids duplicate download of the same url.
                   DESC

  spec.homepage     = "https://www.mindvalley.com"
  spec.license      = "MIT"
  spec.author       = { "kelvin lee wei sern" => "leeweisern@gmail.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/leeweisern/MVImageDownloader.git", :tag => "1.0.0" }
  spec.source_files  = "MVImageDownloader/**/*.swift"
  swift_version  = "5.0"

end
