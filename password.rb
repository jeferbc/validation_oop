class Password
  attr_accessor :password, :repeat_password, :validation

  def initialize
    @validation = Validation.new
  end

  def get_password(repeat=false)
    repeat ? @repeat_password = gets.chomp : @password = gets.chomp
  end

  def valid?
    @validation.validation(@password, @repeat_password)
  end

end
  class Validation
    def length? (password)
      if (password.length >= 8 && password.length <= 40)
        true
      else
        UI.length_error
        false
      end
    end

    def match? (password, repeat_password)
      return true if password == repeat_password
      UI.match_error
      false
    end

    def upper? (password)
      return  true if /[[:upper:]]/.match(password) != nil
      UI.capitalized_error
      false
    end

    def lower? (password)
      return  true if /[[:lower:]]/.match(password) != nil
      UI.downcase_error
      false
    end

    def has_number? (password)
      return true if password.count("0-9") > 0
      UI.number_error
      false
    end

    def has_spaces? (password)
      return true if password.index(" ") == nil
      UI.spaces_error
      false
    end

    def validation (password, repeat_password)
      match?(password, repeat_password) && length?(password) && upper?(password) && lower?(password) && has_number?(password) && has_spaces?(password)
    end
  end

class UI
  def self.password
    puts 'Ingrese contraseña'
  end
  def self.repeat_password
    puts 'Repita contraseña'
  end
  def self.length_error
    puts "La contraseña debe tener entre 8 y 40 caracteres"
  end
  def self.match_error
    puts "Las contraseñas deben ser iguales"
  end
  def self.capitalized_error
    puts "Debe tener al menos una mayuscula"
  end
  def self.downcase_error
    puts "Debe tener al menos una minuscula"
  end
  def self.number_error
    puts "Debe tener al menos un numero"
  end
  def self.spaces_error
    puts "No debe tener espacios"
  end
  def self.success
    puts "Contraseña creada correctamente"
  end
end

password = Password.new
validation = false
while (!validation)
  UI.password
  password_user = password.get_password
  UI.repeat_password
  repeat_password = password.get_password(true)
  validation = password.valid?
end
UI.success
