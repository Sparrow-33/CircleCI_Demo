import { LightningElement, track } from 'lwc';
import getMovies  from '@salesforce/apex/Movies.getMovies'
import getMovieById from '@salesforce/apex/Movies.getMovieById'

export default class Parent extends LightningElement {

    @track movies = [];
    
    @track selectedMovie;
    connectedCallback() {
        this.getMoviesApex();

    }

    getMoviesApex() {
        getMovies()
        .then(result => {
           this.movies = result;
        })
        .catch(error => {
            console.error(error);
        });
    }

    handleMovieClick(event) {
        this.selectedMovie = event.detail;
        console.log(this.selectedMovie);
    }

    // getMovieByIdApex(id) {
    //     console.log('getMovieByIdApex', id)
    //     getMovieById(id)
    //     .then(
    //         result => {
    //             console.log('The click result ', result);
    //         }
    //     )
    //     .catch(error => {
    //         console.error(error);
    //     })
    // }

}