class UserDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      id:         { source: "User.id" },
      first_name: { source: "User.first_name", cond: :like, searchable: true, orderable: true },
      last_name:  { source: "User.last_name",  cond: :like, nulls_last: true },
      email:      { source: "User.email" },
      status:     { source: "User.status" }
    }
  end

  def data
    records.map do |record|
      {
        id:         record.id,
        first_name: record.first_name,
        last_name:  record.last_name,
        email:      record.email,
        status:     record.status
      }
    end
  end

  def get_raw_records
    User.all
  end

end
