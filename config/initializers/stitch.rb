class StitchApplication < Stitch::Server
  def initialize
    super(:paths => ["app/assets/javascripts/app", "app/assets/javascripts/lib"])
  end
end

module Stitch
  class TmplCompiler < Stitch::Compiler
    extensions :tmpl

    def compile(path)
      content = File.read(path)
      %{var template = jQuery.template(#{content.to_json});
        module.exports = (function(data){ return jQuery.tmpl(template, data); });}
    end
  end
end