class Entrada < ApplicationRecord
  # Associations
  belongs_to :estoque

  # Validations
  validates :data, :documento, :numero, :quantidade, :preco_unitario, :preco_total, :estoque, presence: true
  validates :quantidade, :preco_unitario, :preco_total, numericality: true

  # Callback
   after_create :after_create_entrada
   after_destroy :after_destroy_entrada

  # Private Methods
  private

  def after_create_entrada
    preco_total = self.quantidade * self.preco_unitario
    self.update(preco_total: preco_total)
    custo_medio = (((self.estoque.estoque_saldo * self.preco_unitario) + (self.quantidade * self.preco_unitario)) / (self.estoque.estoque_saldo + self.quantidade))
    estoque_saldo = self.estoque.estoque_saldo + self.quantidade
    custo_total = estoque_saldo * custo_medio
    self.estoque.update(custo_medio: custo_medio, estoque_saldo: estoque_saldo, custo_total: custo_total)
  end

  def after_destroy_entrada
    estoque_saldo = self.estoque.estoque_saldo - self.quantidade
    custo_total = estoque_saldo * self.estoque.custo_medio  
    self.estoque.update(estoque_saldo: estoque_saldo, custo_total: custo_total)
  end
end
