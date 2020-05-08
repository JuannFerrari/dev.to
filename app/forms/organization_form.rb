class OrganizationForm < YAAF::Form
  attr_accessor :organization_attributes, :organization_membership, :current_user
  after_save :create_organization_membership

  def initialize(attributes)
    super(attributes.except(:current_user))
    @models = [organization]
    @current_user = attributes[:current_user]
    @tab = "organization"
  end

  def organization
    @organization ||= Organization.new(organization_attributes)
  end

  private

  def create_organization_membership
    @organization_membership = OrganizationMembership.create!(organization: @organization,
                                                              user: current_user,
                                                              type_of_user: "admin")
  end
end
