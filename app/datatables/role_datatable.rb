class RoleDatatable < AjaxDatatablesRails::ActiveRecord

  extend Forwardable

  def_delegators :@view, :link_to, :role_path, :edit_role_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id:           { source: "Role.id" },
      role_name:    { source: "Role.role_name", cond: :like, searchable: true, orderable: true },
      description:  { source: "Role.description",  cond: :like, nulls_last: true },
      actions:      { source: "Role.id" },
    }
  end

  def data
    records.map do |record|
      {
        id:           record.id,
        role_name:    record.role_name,
        description:  record.description,
        actions:      "#{edit_link(record)}, #{show_link(record)}, #{delete_link(record)}".html_safe
      }
    end
  end

  def get_raw_records
    Role.all
  end

  def edit_link(record)

    link_to(
      '<i class="bi bi-pencil-fill" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Edit Role"></i>'.html_safe,
      edit_role_path(record),
      class: 'btn btn-outline-dark'
    )

  end

  def show_link(record)

    link_to(
      '<i class="bi bi-eye-fill" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Show Role"></i>'.html_safe,
      role_path(record),
      class: 'btn btn-outline-dark'
    )

  end

  def delete_link(record)

    link_to(
      '<i class="bi bi-trash-fill" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Delete Role">'.html_safe,
      role_path(record),
      class: 'btn btn-outline-dark', data: {turbo_method: :delete, turbo_confirm: "Are you confirm to delete"}
    )

  end

end
