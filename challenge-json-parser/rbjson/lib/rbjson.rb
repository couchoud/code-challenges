module TOKEN_TYPE
  LEFT_BRACE = 0
  RIGHT_BRACE = 1
  COMMA = 2
end
module ERROR_TYPE
  INVALID_INPUT = 'Invalid input'
end

class RBJSON

  def self.lexer(input)
    if input.empty?
      raise ERROR_TYPE::INVALID_INPUT
    end
    
    tokens = []
    current = 0

    while current < input.length
      char = input[current]
      case char
      when '{'
        tokens << { value: char, type: TOKEN_TYPE::LEFT_BRACE }
        current += 1
      when '}'
        tokens << { value: char, type: TOKEN_TYPE::RIGHT_BRACE}
        current += 1
      else
        current += 1
      end
    end

    return tokens

  end

  def self.parse(tokens = [])
    if tokens.empty?
      raise ERROR_TYPE::INVALID_INPUT
    end

    current = 0

    walk = Proc.new { 

      token = tokens[current]

      if token[:type] == TOKEN_TYPE::LEFT_BRACE

        node = {
          type: 'ObjectExpression',
          properties: []
        }
        
        token = tokens[current += 1] # token 1

        while (token[:type] != TOKEN_TYPE::RIGHT_BRACE)

          property = {
            type: 'Property',
            key: token,
            value: nil
          }
  
          token = tokens[current += 1]
          property[:value] = walk.call
          node[:properties] << property

          token = tokens[current += 1]
          if token[:type] == TOKEN_TYPE::COMMA
            token = tokens[current += 1]
          end
        end

        current += 1
        next node
      end

      if (token[:type] == TOKEN_TYPE::RIGHT_BRACE)
        current += 1
        next {
          type: 'ObjectExpression',
          properties: []
        }
      end
    }

    ast = {
      type: 'Program',
      body: []
    }

    while (current < tokens.length)
      ast[:body] << walk.call
    end

    puts ast

    return ast

  end

end