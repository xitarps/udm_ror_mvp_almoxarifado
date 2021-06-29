class Estoque < ApplicationRecord
  # Associations
  belongs_to :grupo
  has_many :entradas
  has_many :requisicoes

  # Validations
  validates :tipo, :descricao, :unidade, :estoque_minimo, :estoque_maximo, :estoque_reposicao, :status, :grupo, presence: true
  validates :estoque_minimo, :estoque_maximo, :estoque_reposicao, :estoque_saldo, :custo_medio, :custo_total, numericality: true

  # Enumerators
  enum tipo: [:'Alimentos e Bebidas', :'Diversos']
  enum status: [:Ativo, :Inativo]

  # Virtual Attributes
  def to_s
    "#{descricao}"
  end
end
