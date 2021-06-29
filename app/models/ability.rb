class Ability
  include CanCan::Ability

  def initialize(usuario)
    if usuario
      if usuario.perfil == 'Colaborador'
        can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
        can :manage, Entrada
        can :manage, Requisicao
        can :read, Estoque
        can :read, Grupo
      elsif usuario.perfil == 'Gerente'
        can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
        can :manage, Entrada
        can :manage, Requisicao
        can :manage, Estoque
        can :manage, Grupo
       elsif usuario.perfil == 'Administrador'
        can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"  
        can :read, Entrada
        can :read, Requisicao
        can :read, Estoque
        can :read, Grupo
        can :manage, Usuario
      end
    end
  end
end
