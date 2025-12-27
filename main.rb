def limpar_tela
  # O comando para limpar a tela depende do sistema operacional
  Gem.win_platform? ? system('cls') : system('clear')
end

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

def depositar(saldo_atual)
  print "\nQuanto você deseja depositar? R$ "
  valor = gets.chomp.to_f # .to_f converte para Float (número com centavos)

  if valor > 0
    novo_saldo = saldo_atual + valor # Criamos a variável aqui
    puts "Depósito de R$ #{format('%.2f', valor)} realizado com sucesso!"
    return novo_saldo
  else
    puts "Valor inválido para depósito."
    return saldo_atual
  end
end

def sacar(saldo_atual)
  print "\nQuanto você deseja sacar? R$ "
  valor = gets.chomp.to_f

  if valor > 0 && valor <= saldo_atual
    novo_saldo = saldo_atual - valor
    puts " Saque de R$ #{format('%2.f', valor)} realizado com sucesso!"
    return novo_saldo
  elsif valor > saldo_atual
    puts "Saldo insuficiente para realizar esse saque."
    return saldo_atual
  else
    puts "Valro inválido para saque."
    return saldo_atual
  end
end

# --- TESTE DO PROGRAMA ---
puts "Bem-vindo ao Ruby Bank"

nome_do_cliente = cadastrar_usuario
saldo = 0.0
historico = [] # Nosso Array para guardar as movimentações
opcao = 0

while opcao !=4
  limpar_tela
  puts "Olá, #{nome_do_cliente}! Seu saldo atual é R$ #{format('%.2f', saldo)}"
  opcao = exibir_menu_principal

  case opcao
  when 1
    puts "\n Detalhes da Conta:"
    puts "\n Seu saldo é R$ #{format('%.2f', saldo)}"
    # -- PAUSA AQUI --
    print "\nPressione ENTER para voltar ao menu ..."
    gets
  when 2
    saldo = depositar(saldo)
    # -- PAUSA AQUI --
    print "\nPressione ENTER para continuar ..."
    gets
    saldo = depositar(saldo)
  when 3
     saldo = sacar(saldo)
     # -- PAUSA AQUI --
     print "\nPressione ENTER para continuar ..."
     gets
  when 4
    puts "\nObrigado por usar o Ruby Bank, #{nome_do_cliente}! Até a próxima."
  else
    puts "\nOpção inválida! Tente novamente."
    sleep(1) # Pausa de 1 segundo para o usuário ler o erros
  end
end


# O programa para aqui e espera você digitar a opção
opcao_escolhida = exibir_menu_principal
