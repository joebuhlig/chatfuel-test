export default function(){
  this.route('chatfuel', function(){
    this.route('confirm', {path: '/confirm' }, function(){
      this.route('show', {path: '/'});
    });
  });
};