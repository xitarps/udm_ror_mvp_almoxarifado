class Grupo < ApplicationRecord
    # Associations
    has_many :estoques

    # Validations
    validates :nome, :status, presence: true

    # Enumerators
    enum status: [:Ativo, :Inativo]

    # Virtual Attributes
    def to_s
        "#{nome}"
    end
end
