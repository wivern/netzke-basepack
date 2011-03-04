{
  initComponent: function() {
    this.recordConfig = [];

    Ext.each(this.columns, function(column){
      // Config for Record (Model)
      var extraConfig = {};
      if (column.attrType == 'datetime') {
        extraConfig.type = 'date';
        extraConfig.dateFormat = 'Y-m-d g:i:s';
      };
      this.recordConfig.push(Ext.apply({name: column.name, defaultValue: column.defaultValue}, extraConfig));

      // Extra default configuration
      this.setDefaultEditor(column);

      // Required
      column.dataIndex = column.name;
    }, this);

    // Record constructor
    this.Row = Ext.data.Record.create(this.recordConfig);

    // Column model
    this.cm = new Ext.grid.ColumnModel(this.columns);

    delete this.columns;

    // DirectProxy that uses our Ext.direct provider
    this.proxy = new Ext.data.DirectProxy({directFn: Netzke.providers[this.id].getData});

    // Data store
    this.store = this.buildStore();

    // Load eventual inline data
    if (this.inlineData) {
      this.store.loadData(this.inlineData);
    }

    // Selection model
    if (!this.sm) this.sm = new Ext.grid.RowSelectionModel();

    // Call super
    Netzke.classes.MongoGrid.superclass.initComponent.call(this);
  },

  buildStore: function() {
    return new Ext.data.Store({
      pruneModifiedRecords: true,
      proxy: this.proxy,
      reader: new Ext.data.ArrayReader({root: "data", totalProperty: "total", successProperty: "success", id:0}, this.Row),
      remoteSort: true,
      listeners:{'loadexception':{
        fn:this.loadExceptionHandler,
        scope:this
      }}
    });
  },

  // private
  setDefaultEditor: function(c) {
    c.editor = c.editor || {xtype: 'textfield'};
  }

}