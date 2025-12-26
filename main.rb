def cadastrar_usuario
  puts "--- Formulário de Cadastro ---"
  print "Digite seu nome: "
  nome = gets.chomp
  print "Digite seu sobrenome: "
  sobrenome = gets.chomp
  print "Digite seu email: "
  email = gets.chomp
  print "Digite sua telefone: "
  telefone = gets.chomp
  print "Digite seu data de nascimento: "
  data = gets.chomp

  puts "\nBem-vindo(a), #{nome} #{sobrenome}!"
  puts "Dados confirmados: #{email} | #{telefone}"

  # Retornamos o nome para usar no menu principal depois
  return nome
end

def exibir_menu_principal
  puts "\n--- Menu Principal ---"
  puts "1. Ver Saldo"
  puts "2. Depositar Dinheiro"
  puts "3. Sacar Dinheiro"
  puts "4. Sair"
  print "\nEscolha uma opção: "

  # Ele devolve (return) o número escolhido para o resto do programa
  return gets.chomp.to_i

end

# --- TESTE DO PROGRAMA ---
puts "Bem-vindo ao Ruby Bank"

nome_do_cliente = cadastrar_usuario

# O programa para aqui e espera você digitar a opção
opcao_escolhida = exibir_menu_principal

# ESTA LINHA É A QUE FAZ APARECER O NÚMERO:
puts "\nDEBUG: Você escolheu a opção #{opcao_escolhida}."