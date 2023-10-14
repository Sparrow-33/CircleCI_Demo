import { LightningElement, api } from 'lwc';

export default class Child1 extends LightningElement {
    @api movie;

    handleClick() {
        const movieId = this.movie.Id;
        const movieClickEvent = new CustomEvent('movieclick', { detail: this.movie });
        this.dispatchEvent(movieClickEvent);
    }

}