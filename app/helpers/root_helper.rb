module RootHelper

  def guide_path(slug,part,edition)
    if edition
      publication_path(:slug=>slug,:part=>part,:edition=>edition) 
    else
      publication_path(:slug=>slug,:part=>part) 
    end
  end

  def transaction_path(slug,council,edition)
    unless council
      guide_path(slug,nil,edition)
    else
      if edition
        publication_path(:slug=>slug,:edition=>edition,:snac=>council)
      else
        publication_path(:slug=>slug,:snac=>council)
      end
    end
  end

  def council_lookup_path(slug)
    identify_council_path(:slug=>slug) 
  end

  def to_govspeak(field)
    Govspeak::Document.new(field || "").to_html.html_safe
  end

end
