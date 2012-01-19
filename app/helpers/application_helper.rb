module ApplicationHelper

  def page_title(artefact, publication=nil)
    if publication
      title = [publication.alternative_title, publication.title].find(&:present?)
      title = "Video - #{title}" if request.format.video?
    end

    [title, artefact.section, 'GOV.UK'].select(&:present?).join(" | ")
  end

  def wrapper_class(publication = nil)
    services = %W[transaction local_transaction place]

    if publication and request.format.video?
      publication.type + ' video-guide'
    elsif publication and publication.type
      publication.type + (services.include?(publication.type) ? ' service' : '')
    else
      ''
    end
  end

  def section_meta_tags(artefact)
    return '' if artefact.nil? or artefact.section.blank?
    tag(:meta, {name: 'x-section-name', content: artefact.section}, true) +
    tag(:meta, {name: 'x-section-link', content: "/browse/#{artefact.section.parameterize}"}, true)
  end
end
