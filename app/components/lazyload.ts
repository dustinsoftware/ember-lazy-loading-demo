import Component from '@ember/component';
import { Moment } from 'moment'; // this line causes moment to be included in the main vendor instead of lazily loaded

function mapTime(moment: Moment) {
  return moment.format('HH:mm:ss');
}
export default class Lazyload extends Component.extend({
  // anything which *must* be merged to prototype here
}) {
  currentTime?: string;

  didInsertElement() {
    import('moment')
      .then(moment => moment.default())
      .then(moment => {
        this.set('currentTime', mapTime(moment));
      });
  }
  // normal class body definition here
}
