class Secure
  require "digest"

  def self.encrypt_md5(text)
    Digest::MD5.hexdigest text
  end
end