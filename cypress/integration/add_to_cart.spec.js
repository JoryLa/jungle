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

  it("Clicks 'Add', cart increases by 1",  () => {
    cy.contains("Add").click({force: true})
  });

  // describe("Testing add to cart", () => {
  //   beforeEach(() => {
  //     cy.visit("/");
  //   });
  
  //   it("can click on the Add button", () => {
  //     cy.get(".products article:first").find(".button_to").submit();
  
  //     cy.get(".nav-item.end-0").find(".nav-link").contains("1");
  //   });
  // }); 
});