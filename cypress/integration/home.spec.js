describe('Jungle App', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/')
    // cy.request('/cypress_rails_reset_state')
  })

  it('visits home page', () => {
    cy.visit('http://localhost:3000/')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });



});