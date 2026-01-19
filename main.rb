require_relative 'conta_bancaria'
require_relative 'sistema'

# 1. Carregamos a LISTA completa de contas do JSON
contas_no_sistema = ContaBancaria.carregar_todas

limpar_tela
puts "=== Bem-vindo ao Ruby Bank Multiuser ==="

# 2. SISTEMA DE LOGIN / CADASTRO
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

    # Busca a conta pelo nome e senha
    conta_logada = contas_no_sistema.find { |c| c.nome == nome_login && c.senha == senha_login }
    
    puts "⚠️ Usuário ou senha incorretos!" unless conta_logada

  when 2
    # Lógica de Cadastro
    nome, sobrenome, email, telefone, senha = cadastrar_usuario
    
    # Criamos o objeto e adicionamos na lista global
    nova_conta = ContaBancaria.new(nome, sobrenome, senha)
    contas_no_sistema << nova_conta
    
    # Login automático após cadastro
    conta_logada = nova_conta
    puts "✅ Conta criada com sucesso!"

  when 3
    exit
  else
    puts "Opção inválida!"
  end
end

# 3. LOOP PRINCIPAL (Interface do Usuário Logado)
opcao = 0
while opcao != 6
  limpar_tela
  puts "Logado como: #{conta_logada.nome} #{conta_logada.sobrenome}"
  
  # Certifique-se que exibir_menu_principal no sistema.rb vai até a opção 6
  opcao = exibir_menu_principal

  case opcao
  when 1
    conta_logada.exibir_resumo
    puts "\nPressione Enter para continuar..."
    gets
  when 2
    valor = ler_valor_valido("Valor do depósito: ")
    conta_logada.depositar(valor)
    puts "\nPressione Enter para continuar..."
    gets
  when 3
    valor = ler_valor_valido("Valor do saque: ")
    conta_logada.sacar(valor)
    puts "\nPressione Enter para continuar..."
    gets
  when 4
    limpar_tela
    cabecalho("EXTRATO BANCARIO")
    largura_interna = 60


    if conta_logada.historico.empty?
      puts "║" + " ".center(largura_interna) + "║"
      puts "║" + "Nenhum movimento encontrado.".center(largura_interna) + "║"
    else
      conta_logada.historico.each do |linha_hist|
        puts "║ " + alinhar_extrado(linha_hist, largura_interna - 2) + " ║"
      end
    end

    puts "╠#{linha(largura_interna)}╣"
    saldo_texto = "Saldo Atual: R$ #{format('%.2f', conta_logada.saldo)}"
    puts "║" + centralizar_com_cores(saldo_texto, largura_interna) + "║"
    puts "╚#{linha(largura_interna)}╝"
    puts "\nPressione Enter para voltar ao menu..."
    gets
  when 5
    # LÓGICA DE TRANSFERÊNCIA
    print "Digite o nome do favorecido (Exatamente como cadastrado): "
    nome_destino = gets.chomp
    
    # Busca favorecido ignorando a si próprio
    favorecido = contas_no_sistema.find { |c| c.nome == nome_destino && c != conta_logada }

    if favorecido
      valor = ler_valor_valido("Valor da transferência: ")
      # Chama o método de transferência da classe
      if conta_logada.transferir(valor, favorecido)
        # Salva imediatamente após transferência bem-sucedida para garantir integridade
        ContaBancaria.salvar_todas(contas_no_sistema)
      end
    else
      puts "❌ Erro: Favorecido não encontrado ou nome inválido."
    end
    puts "\nPressione Enter para continuar..."
    gets
  when 6
    # SALVAMENTO FINAL E SAÍDA
    ContaBancaria.salvar_todas(contas_no_sistema)
    puts "✅ Seus dados foram salvos. Até logo!"
  else
    puts "⚠️ Opção inválida!"
    puts "\nPressione Enter para tentar novamente..."
    gets
  end
end