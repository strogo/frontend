module ApplicationHelper
  def assemble_publication_title(publication)
    return '' if publication.nil?

    title = ''
    if publication and publication.alternative_title.blank?
      title << publication.title.to_s
    elsif publication
      title << publication.alternative_title.to_s
    end
    title << ' | '
    title
  end

  def page_title(artefact, publication = nil)
    ''.tap do |title|
      title << 'Video - ' if request.format.video?
      title << assemble_publication_title(publication) if publication

      unless artefact.section.blank?
        title << artefact.section
        title << ' | '
      end

      title << 'www.gov.uk'
    end
  end

  def wrapper_class(publication = nil)
    if publication and request.format.video?
      publication.type + ' video-guide'
    elsif publication
      publication.type
    else
      ''
    end
  end
end
