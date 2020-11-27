# frozen_string_literal: true

# author: ERAMOTO Masaya

module FileReader
  def read_file_content(path, allow_empty = false)
    # these are currently ResourceSkipped to maintain consistency with the resource
    # pre-refactor (which used skip_resource). These should likely be changed to
    # ResourceFailed during a major version bump.
    file = inspec.file(path)
    raise Inspec::Exceptions::ResourceSkipped, "Can't find file: #{path}" unless file.file?

    raw_content = file.content
    raise Inspec::Exceptions::ResourceSkipped, "Can't read file: #{path}" if raw_content.nil?

    raise Inspec::Exceptions::ResourceSkipped, "File is empty: #{path}" if !allow_empty && raw_content.empty?

    raw_content
  end
end
