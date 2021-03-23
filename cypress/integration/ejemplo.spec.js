< reference types = "cypress" / >

    import Chance from 'chance';
const chance = new Chance();

describe('inicio', () > {

    const email = chance.email();
    const pass = 'password';

    beforeEach(() => {
    cy.visit('http://localhost:8080/Mamas/');
})
it('has a title', () => {
    cy.contains('Welcome');
    expect(2).to.equal(2);
})
    





})