ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    columns do

      column do

        panel "Solicitação de Compras" do

          table_for Estoque.order("tipo asc, grupo_id asc, descricao asc")
                           .where("status = 0 and estoque_saldo < estoque_reposicao and estoque_reposicao > 0") do

            column("Tipo") { |estoque| estoque.tipo }
            column("Id") { |estoque| estoque.grupo.id }
            column("Grupo") { |estoque| link_to(estoque.grupo.nome, admin_grupo_path(estoque.grupo)) }
            column("Perecível") { |estoque| estoque.perecivel }
            column("Id") { |estoque| estoque.id }
            column("Item") { |estoque| link_to(estoque.descricao, admin_estoque_path(estoque)) }
            column("Referência") { |estoque| estoque.codigo }
            column("Unidade") { |estoque| estoque.unidade }
            column("Saldo") { |estoque| number_with_precision estoque.estoque_saldo, precision: 4 }
            column("Mínimo") { |estoque| number_with_precision estoque.estoque_minimo, precision: 4 }
            column("Reposição") { |estoque| number_with_precision estoque.estoque_reposicao, precision: 4 }
            column("Custo Médio") { |estoque| number_to_currency estoque.custo_medio }
            column("Custo Total") { |estoque| number_to_currency (estoque.custo_total) }
          end
          tr :class => "odd" do
            td "========================", :style => "text-align: right;"
          end
          br
          tr :class => "odd" do
            td "Itens:", :style => "text-align: right;"
            td Estoque.where("status = 0 and estoque_saldo < estoque_reposicao and estoque_reposicao > 0").count()
          end
          br
          tr :class => "odd" do
            td "Reposição:", :style => "text-align: right;"
            td number_with_precision Estoque.where("status = 0 and estoque_saldo < estoque_reposicao and estoque_reposicao > 0").sum(:estoque_reposicao), precision: 4
          end
          br
          tr :class => "odd" do
            td "Custo:", :style => "text-align: right;"
            td number_to_currency Estoque.where("status = 0 and estoque_saldo < estoque_reposicao and estoque_reposicao > 0").sum(:custo_total)
          end
          br
          tr :class => "odd" do
            td "========================", :style => "text-align: right;"
          end
         end
      end
    end
  end # content
end
