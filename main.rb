require_relative 'conta_bancaria'
require_relative 'sistema'

# 1. Carregamos a LISTA completa de contas do JSON
contas_no_sistema = ContaBancaria.carregar_todas

limpar_tela
puts "=== Bem-vindo ao Ruby Bank Multiuser ==="

# 2. SISTEMA DE LOGIN / CADASTRO
# Precisamos definir QUEM está operando o banco
conta_logada = nil

until conta_logada
  puts "\n1. Acessar Minha Conta"
  puts "2. Abrir Nova Conta"
  puts "3. Sair"
  print "Escolha: "
  opcao_inicial = gets.chomp.to_i

  case opcao_inicial
  when 1
    # Lógica de Login
    print "Nome do Titular: "
    nome_login = gets.chomp
    print "Senha: "
    senha_login = gets.chomp

    # Procuramos na lista se existe alguém com esse nome e senha
    conta_logada = contas_no_sistema.find { |c| c.nome == nome_login && c.senha == senha_login }
    
    puts "⚠️ Usuário ou senha incorretos!" unless conta_logada

  when 2
    # Lógica de Cadastro (Usando seu formulário do sistema.rb)
    nome, sobrenome, email, telefone, senha = cadastrar_usuario
    
    # Criamos o objeto e adicionamos na nossa lista
    nova_conta = ContaBancaria.new(nome, sobrenome, senha)
    contas_no_sistema << nova_conta
    
    # Já logamos o usuário novo automaticamente
    conta_logada = nova_conta
    puts "✅ Conta criada com sucesso!"

  when 3
    exit # Encerra o programa
  end
end

# 3. LOOP PRINCIPAL (Só chega aqui se houver uma 'conta_logada')
opcao = 0
while opcao != 5
  limpar_tela
  puts "Logado como: #{conta_logada.nome} #{conta_logada.sobrenome}"
  
  opcao = exibir_menu_principal

  case opcao
  when 1
    conta_logada.exibir_resumo # Usa o método da sua classe
    puts "\nPressione Enter..."
    gets
  when 2
    valor = ler_valor_valido("Valor do depósito: ")
    conta_logada.depositar(valor)
    puts "\nPressione Enter..."
    gets
  when 3
    valor = ler_valor_valido("Valor do saque: ")
    conta_logada.sacar(valor)
    puts "\nPressione Enter..."
    gets
  when 4
    puts "--- Histórico ---"
    if conta_logada.historico.empty?
      puts "Nenhuma movimentação encontrada."
    else
      conta_logada.historico.each { |linha| puts linha }
    end
    puts "-----------------"
    puts "\nSaldo autal: R$ #{format('%.2f', conta_logada.saldo)}"
    puts "\nPressione Enter para voltar..."
    gets
  when 5
    # IMPORTANTE: Ao sair, salvamos a LISTA INTEIRA de contas
    ContaBancaria.salvar_todas(contas_no_sistema)
    puts "Dados salvos. Até logo!"
  end
end