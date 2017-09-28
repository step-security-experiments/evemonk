EvemonkApp.Views.HeaderView = Backbone.View.extend({
    events: {
        'click .sign-in' : 'handle_click',
        'click .sign-up' : 'handle_click'
    },

    template: JST['header/show'],

    initialize: function () {
        this.listenTo(EvemonkApp.Events, 'user:sign_in', this.render);
        this.listenTo(EvemonkApp.Events, 'user:sign_out', this.render);
    },

    render: function () {
        this.$el.html(this.template(EvemonkApp.currentUser.toJSON()));

        return this;
    },

    handle_click: function (event) {
        event.preventDefault();

        Backbone.history.navigate(event.target.getAttribute('href'), { trigger: true });
    }
});
