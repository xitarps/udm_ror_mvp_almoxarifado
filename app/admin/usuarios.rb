ActiveAdmin.register Usuario do

  menu priority: 6, label: "Usuários"

  permit_params :nome, :perfil, :status, :email, :password, :password_confirmation

  config.batch_actions = false

  config.per_page = 10

  config.sort_order = 'nome_asc'

  filter :id, label: 'ID'
  filter :nome, label: 'NOME'
  filter :perfil, as: :select, label: 'PERFIL'
  filter :email, label: 'EMAIL'
  filter :status, as: :select, collection: Usuario.status, label: 'STATUS'

  index title: "Usuários" do
    selectable_column
    column "ID", :id
    column "NOME", :nome
    column "PERFIL", :perfil
    column "EMAIL", :email
    column "STATUS", :status
    actions

  end

  show title: :nome do
    panel "Usuário" do
     attributes_table_for usuario do 

        row("ID") { usuario.id }
        row("NOME") { usuario.nome }
        row("PERFIL") { usuario.perfil }
        row("EMAIL") { usuario.email }
        row("STATUS") { usuario.status }

     end
    end
  end

  form title: "Usuário" do |f|
    f.inputs do
      f.input :nome
      f.input :perfil
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :status
    end
    f.actions
  end

end
