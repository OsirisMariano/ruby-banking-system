require_relative 'sistema'
require_relative 'operacoes'

# --- TESTE DO PROGRAMA ---
puts "Bem-vindo ao Ruby Bank"

nome, sobrenome, email, telefone, saldo, historico = carregar_dados

if nome.nil?
  nome = cadastrar_usuario
  sobrenome = ""
  email = ""
  telefone = ""
  salvar_dados(nome, sobrenome, email, telefone, saldo, historico)
end

nome_do_cliente = nome
opcao = 0

while opcao != 5
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
    saldo = depositar(saldo, historico)
    salvar_dados(nome, sobrenome, email, telefone, saldo, historico)
    # -- PAUSA AQUI --
    print "\nPressione ENTER para continuar ..."
    gets
  when 3
     saldo = sacar(saldo, historico)
     salvar_dados(nome, sobrenome, email, telefone, saldo, historico)
     # -- PAUSA AQUI --
     print "\nPressione ENTER para continuar ..."
     gets
  when 4
    puts "\n--- Histórico de Movimentações ---"
    if historico.empty?
      puts "Nenhuma movimentação realizada."
    else
      historico.each do |movimentação|
        puts "#{movimentação}"
      end
    end
    print "\nPressione ENTER para voltar ao menu ..."
    gets
  when 5
    puts "\nObrigado por usar o Ruby Bank, #{nome_do_cliente}! Até a próxima."
  else
    puts "\nOpção inválida! Tente novamente."
    sleep(1) # Pausa de 1 segundo para o usuário ler o erros
  end
end