import Component from '@ember/component';

function mapTime(moment: any) {
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
