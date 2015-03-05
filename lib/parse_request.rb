class Request

  def initialize(file)
    @file = file
    @first_line = file.split("\n")[0].split(' ')
  end

  def verb
    @first_line[0]
  end

  def path
    @first_line[1]
  end

  def version
    @first_line[2]
  end

  def query_string
    path[(path.index('?') + 1)..path.length]
  end

  def headers
    input = @file.split("\n")
    input.delete_at(0)

    headers = {}
    input.each do |raw_header|
      split_header = raw_header.split(': ')
      if split_header[0] == nil
        return headers
      else
        headers[split_header[0]] = split_header[1]
      end
    end

    headers
  end

  def params
    params = {}

    query_string.split('&').each do |raw_param|
      split_param = raw_param.split('=')
      params[split_param[0]] = split_param[1]
    end

    last_line = @file.split("\n")[-1]
    if last_line.include?('&')
      last_line.split('&').each do |raw_param|
        split_param = raw_param.split('=')
        params[split_param[0]] = split_param[1]
      end
    end

    params
  end

end
