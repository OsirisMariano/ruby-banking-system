require 'date'
require 'json'

class ContaBancaria
  attr_accessor :nome, :sobrenome, :senha, :saldo, :historico

  def initialize(nome, sobrenome, senha, saldo = 0.0, historico = [])
    @nome = nome
    @sobrenome = sobrenome
    @senha = senha
    @saldo = saldo
    @historico = historico
  end

  def self.carregar_todas
     caminho = "dados_bancarios.json"
     return [] unless File.exist?(caminho)

     arquivo = File.read(caminho)
     return [] if arquivo.strip.empty?

     dados_brutos = JSON.parse(arquivo)

     dados_brutos.map do |dados|
      new(
        dados['nome'],
        dados['sobrenome'],
        dados['senha'],
        dados['saldo'].to_f,
        dados['historico']
      )
     end
  end

  def self.salvar_todas(lista_de_contas)
    dados = lista_de_contas.map do |conta|
      {
        nome: conta.nome,
        sobrenome: conta.sobrenome,
        senha: conta.senha,
        saldo: conta.saldo,
        historico: conta.historico
      }
    end

    File.open("dados_bancarios.json", "w") do |arquivo|
      arquivo.write(JSON.pretty_generate(dados))
    end
  end

  def exibir_resumo
    puts "Titular: #{@nome} #{@sobrenome} | Saldo Atual: R$ #{format('%.2f', @saldo)}"
  end

  def depositar(valor)
    if valor > 0
      @saldo += valor
      registrar_no_historico("Depósito", "+", valor, "\e[32m")
      puts "Depósito de R$ #{format('%.2f', valor)} realizado!"
    else
      puts "Valor inválido!"
    end
  end

  def sacar(valor)
    if valor <= 0 || valor > @saldo
      puts "Erro: Valor inválido ou saldo insuficiente."
      return
    end

    print "Digite sua senha: "
    return puts "Senha Incorreta!" if gets.chomp != @senha

    @saldo -= valor
    registrar_no_historico("Saque", "-", valor, "\e[31m")
    puts "Saque realizado!"
  end

  # --- MÉTODOS DE TRANSFERÊNCIA (PÚBLICOS) ---
  
  def transferir(valor, conta_destino)
    if valor <= 0 || valor > @saldo
      puts "Erro: Valor inválido ou saldo insuficiente."
      return false
    end

    print "Confirme sua senha para transferir R$ #{format('%.2f', valor)}: "
    if gets.chomp != @senha
      puts "Senha incorreta! Operação cancelada."
      return false
    end

    @saldo -= valor
    # Notifica a outra conta para receber o valor
    conta_destino.receber_transferencia(valor, "#{@nome} #{@sobrenome}")
    
    # Registra no meu histórico
    registrar_no_historico("Transf. Env.", "-", valor, "\e[31m")
    
    puts "Transferência realizada com sucesso para #{conta_destino.nome}!"
    true
  end

  def receber_transferencia(valor, nome_origem)
    @saldo += valor
    registrar_no_historico("Transf. Rec.", "+", valor, "\e[32m")
  end

  # --- TUDO ABAIXO DE PRIVATE É SÓ PARA USO INTERNO ---
  private

  def registrar_no_historico(tipo, sinal, valor, cor)
    data_hora = Time.now.strftime('%d/%m/%Y %H:%M')
    
    col_tipo = tipo.ljust(15)
    col_valor = "#{sinal} R$ #{format('%.2f', valor)}".rjust(18)

    # tipo_formatado = tipo.ljust(12)
    # simbolo = "#{sinal} R$".ljust(5)
    # valor_f = format('%.2f', valor).rjust(10)
    
    @historico << "#{data_hora} | #{cor}#{col_tipo}\e[0m | #{cor}#{col_valor}\e[0m"
  end
end