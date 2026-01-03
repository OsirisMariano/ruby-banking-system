require_relative 'sistema'
require_relative 'operacoes'

# --- TESTE DO PROGRAMA ---
puts "Bem-vindo ao Ruby Bank"

nome, sobrenome, email, telefone, senha, saldo, historico = carregar_dados

if nome.nil?
  nome, sobrenome, email, telefone, senha = cadastrar_usuario

  saldo = 0.0
  historico = []

  salvar_dados(nome, sobrenome, email, telefone, senha, saldo, historico)
else
  puts "Bem-vindo de volta, #{nome}!"
end

nome_do_cliente = nome
opcao = 0

while opcao != 5
  limpar_tela
  puts "Olá, #{nome_do_cliente}! Seu saldo atual é R$ #{format('%.2f', saldo)}"
  opcao = exibir_menu_principal

  case opcao
  when 1 # CONSULTAR SALDO (Ajustado para apenas exibir)
    puts "\n--- Detalhes da Conta ---"
    puts "Cliente: #{nome} #{sobrenome}"
    puts "Saldo Atual: R$ #{format('%.2f', saldo)}"
    print "\nPressione ENTER para voltar ao menu ..."
    gets

  when 2 # DEPÓSITO (Agora com a lógica completa)
    # 1. Pergunta e valida
    valor = ler_valor_valido("Quanto deseja depositar? R$ ")
    
    # 2. Executa a operação
    saldo = depositar(saldo, historico, valor)
    
    # 3. Salva no arquivo
    salvar_dados(nome, sobrenome, email, telefone, senha, saldo, historico)
    
    print "\nPressione ENTER para continuar ..."
    gets

  when 3 # SAQUE
    # 1. Pergunta e valida o valor numérico
    valor = ler_valor_valido("Quanto deseja sacar? R$ ")

    # 2. Executa a operação (dentro do 'sacar' ele pedirá a senha)
    saldo = sacar(saldo, historico, senha, valor)
    
    # 3. Salva no arquivo
    salvar_dados(nome, sobrenome, email, telefone, senha, saldo, historico)
    
    print "\nPressione ENTER para continuar ..."
    gets
  when 4
    limpar_tela
    puts "\e[34m" + "="*40 + "\e[0m"
    puts "\e[1;34m EXTRADO BANCÁRIO \e[0m"
    puts "\e[34m" + "="*40 + "\e[0m"

    if historico.empty?
      puts "Nenhuma movimentação realizada."
    else
      historico.each do |movimentação|
        puts "#{movimentação}"
      end
    end
    puts "\e[34m" + "="*40 + "\e[0m"
    print "\nPressione ENTER para voltar ao menu ..."
    gets
  when 5
    puts "\nObrigado por usar o Ruby Bank, #{nome_do_cliente}! Até a próxima."
  else
    puts "\nOpção inválida! Tente novamente."
    sleep(1) # Pausa de 1 segundo para o usuário ler o erros
  end
end