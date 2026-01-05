require 'date'
require 'json'

class ContaBancaria
  attr_accessor :nome, :sobrenome, :saldo, :historico

  def initialize(nome, sobrenome, senha, saldo = 0.0, historico = [])
    @nome = nome
    @sobrenome = sobrenome
    @senha = senha
    @saldo = saldo
    @historico = []
  end

  def salvar_em_json
    dados = {
      nome: @nome,
      sobrenome: @sobrenome,
      senha: @senha,
      saldo: @saldo,
      historico: @historico
    }
    File.open("dados_bancarios.json", "w") do |arquivo|
      arquivo.write(JSON.pretty_generate(dados))
    end
  end

  def self.carregar_de_json
    caminho = "dados_bancarios.json"
    return nil unless File.exist?(caminho)

    arquivo = File.read(caminho)
    dados = JSON.parse(arquivo)

    new(
      dados['nome'],
      dados['sobrenome'],
      dados['senha'],
      dados['saldo'].to_f,
      dados['historico']
    )
  end

  # --- Adicione este método aqui dentro! ---
  def exibir_resumo
    puts "Titular: #{@nome} #{@sobrenome} | Saldo Atual: R$ #{format('%.2f', @saldo)}"
  end

  def depositar(valor)
    if valor <= 0
      puts "❌ Erro: O valor deve ser positivo."
      return
    end

    @saldo += valor
    registrar_no_historico("Depósito", "+", valor, "\e[32m")
    puts "✅ Depósito de R$ #{format('%.2f', valor)} realizado!"
  end

  def sacar(valor)
    if valor <= 0 || valor > @saldo
      puts "❌ Erro: Valor inválido ou saldo insuficiente."
      return
    end

    print "Digite sua senha: "
    return puts "❌ Senha incorreta!" if gets.chomp != @senha

    @saldo -= valor
    registrar_no_historico("Saque", "-", valor, "\e[31m")
    puts "✅ Saque realizado!"
  end

  # Um método privado (uso interno) para não repetir código de alinhamento
  private

  def registrar_no_historico(tipo, sinal, valor, cor)
    data_hora = DateTime.now.strftime('%d/%m/%Y %H:%M')
    tipo_formatado = tipo.ljust(10)
    simbolo = "#{sinal} R$".ljust(5)
    valor_f = format('%.2f', valor).rjust(10)
    
    @historico << "#{cor}#{data_hora} - #{tipo_formatado} #{simbolo}#{valor_f}\e[0m"
  end
end