class UserDatatable < AjaxDatatablesRails::ActiveRecord

  extend Forwardable

  def_delegators :@view, :link_to, :user_path, :edit_user_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id:         { source: "User.id" },
      first_name: { source: "User.first_name", cond: :like, searchable: true, orderable: true },
      last_name:  { source: "User.last_name",  cond: :like, nulls_last: true },
      email:      { source: "User.email" },
      status:     { source: "User.status" },
      roles:      { source: "Role.role_name"},
      actions:    { source: "User.id" },
    }
  end

  def data
    records.map do |record|
      {
        id:         record.id,
        first_name: record.first_name,
        last_name:  record.last_name,
        email:      record.email,
        status:     record.status,
        roles:      record.roles.map{|role| role.role_name}.join(", "),
        actions:    "#{edit_link(record)}, #{show_link(record)}, #{delete_link(record)}".html_safe
      }
    end
  end

  def get_raw_records
    User.joins(:roles).all
  end

  def edit_link(record)

    link_to(
      '<i class="bi bi-pencil-fill" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Edit User"></i>'.html_safe,
      edit_user_path(record),
      class: 'btn btn-outline-dark'
    )

  end

  def show_link(record)

    link_to(
      '<i class="bi bi-eye-fill" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Show User"></i>'.html_safe,
      user_path(record),
      class: 'btn btn-outline-dark'
    )

  end

  def delete_link(record)

    link_to(
      '<i class="bi bi-trash-fill" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Delete User">'.html_safe,
      user_path(record),
      class: 'btn btn-outline-dark', data: {turbo_method: :delete, turbo_confirm: "Are you confirm to delete"}
    )

  end
end
