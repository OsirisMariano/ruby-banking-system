require_relative 'conta_bancaria'
require_relative 'sistema'
#require_relative 'operacoes'

# 1. Criamos o objeto único
minha_conta = ContaBancaria.new("João", "Silva", "1111", 500.0)
minha_conta.exibir_resumo

limpar_tela
puts "Bem-vindo ao Ruby Bank"
minha_conta.exibir_resumo # Agora chamamos o comportamento do objeto

opcao = 0

while opcao != 5
  limpar_tela
  # 2. CHAMADA CORRETA: O nome do método no seu sistema.rb é exibir_menu_principal
  opcao = exibir_menu_principal

  case opcao
  when 1
    minha_conta.exibir_resumo
    print "\nPressione ENTER para continuar..."
    gets
  when 2
    valor = ler_valor_valido("Quanto deseja depositar? R$ ")
    minha_conta.depositar(valor)
    print "\nPressione ENTER para continuar..."
    gets
  when 3
    valor = ler_valor_valido("Quanto deseja sacar? R$ ")
    minha_conta.sacar(valor)
    print "\nPressione ENTER para continuar..."
    gets
  when 4
    # O método exibir_extrato está no seu sistema.rb e recebe o histórico do objeto
    # Mas aqui vai uma dica de Senior: que tal mover o extrato para dentro da classe depois?
    puts "\n--- EXTRATO DETALHADO ---"
    minha_conta.historico.each { |h| puts h }
    print "\nPressione ENTER para continuar..."
    gets
  when 5
    puts "Obrigado por usar o Ruby Bank! Salvando dados..."
    # Aqui usaríamos sua função salvar_dados
  else
    puts "⚠️ Opção inválida!"
  end
end