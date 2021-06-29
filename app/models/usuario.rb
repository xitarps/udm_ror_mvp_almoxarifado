class Usuario < ApplicationRecord
  validates :nome, :perfil, :status, presence: true
  enum perfil: [:Colaborador, :Gerente, :Administrador]
  enum status: [:Ativo, :Inativo] 
end
