class Response

  def initialize(file)
    @file = file
    @first_line = file.split("\n")[0].split(' ')
  end

  def version
    @first_line[0]
  end

  def status
    @first_line[1]
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

  def body
    @file.split("\n")[(@file.split("\n").index('') + 1)..-1].join()
  end

end
