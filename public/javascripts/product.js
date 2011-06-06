/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var product={};
Ext.onReady(function(){
    Ext.QuickTips.init();
   
    product.init_grid();
    
});
product.manageWin = function(){
    var win;
    product.formPanel = new Ext.FormPanel({
        url:'products/create',
        frame:true,
        defaults: {
            width: 230
        },
        items: [
        {
            fieldLabel: 'name',
            name: 'name',
            xtype: 'textfield'
        },{
            fieldLabel: 'Detail',
            name: 'detail',
            xtype: 'textfield'
        }
        ],
        buttons: [{
            text: 'Save',
            handler:function(){
                this.getForm().submit();
            }
        },{
            text: 'Cancel',
            handler:function(){
                product.formPanel.getForm().reset();
                win.hide();
            }
        }]

    });
    if(!win){
        win = new Ext.Window({
            title:'Add Product',
            layout:'fit',
            width:500,
            height:300,
            modal:true,
            closeAction:'hide',
            plain: true,
            items:[
            product.formPanel
            ]
        })
        win.show();
    }
}
product.init_grid = function() {
    product.store = new Ext.data.Store({
        proxy: new Ext.data.HttpProxy({
            api: {
                read : 'products',
                create : 'products/create',
                update: 'products/update',
                destroy: 'products/destroy'
            }
        }),

        reader: new Ext.data.JsonReader({
            root: 'Products',
            totalProperty: 'Total',
            id: 'id'
        }, [
        {
            name: 'id',
            mapping: 'id'
        },{
            name: 'name',
            mapping: 'name'
        },{
            name: 'detail',
            mapping: 'detail'
        },{
            name: 'product_type',
            mapping: 'product_type'
        },{
            name: 'spec',
            mapping: 'spec'
        }
        ]),
        writer : new Ext.data.JsonWriter({
            encode: false
        }),
        restful: true,
        // turn on remote sorting
        remoteSort: true
    });

    product.cm = new Ext.grid.ColumnModel
    ([{
        header: "Name",
        dataIndex: 'name',
        width: 150,
        sortable: true
    },{
        header: "Detail",
        dataIndex: 'detail',
        width: 75,
        sortable:true
    },{
        header: "Product Type",
        dataIndex: 'product_type',
        width: 100,
        sortable:true
    },{
        header: "Spec",
        dataIndex: 'spec',
        width: 150,
        sortable:true
    }]);

    product.cm.defaultSortable = true;

    product.grid = new Ext.grid.GridPanel({
        store:product.store,
        colModel:product.cm,
        loadMask: true,
        width:500,
        height:400,
        title:'Products',
        renderTo:'products_grid',
        frame: true,
        stripeRows: true,
        tbar: [{
            text: 'Add',
            iconCls: 'silk-add',
            handler: function(){
                product.onAdd();
            }
        }, '-', {
            text: 'Edit',
            iconCls: 'silk-edit',
            handler: function(){
                product.onEdit();
            }
        }, {
            text: 'Delete',
            iconCls: 'silk-delete',
            handler: function(){
                product.onDelete();
            }
        }, '-'
        ],
        bbar: new Ext.PagingToolbar({
            pageSize: 10,
            store: product.store,
            displayInfo: true,
            displayMsg: 'Displaying topics {0} - {1} of {2}',
            emptyMsg: "No topics to display"
        })
    });    
    product.store.load({
        params:{
            start:0,
            limit:10
        }
    });
    /**
     * onAdd
     */
    product.onAdd = function() {
        product.manageWin();
    }
    /**
     * onEdit
     */
    product.onEdit = function() {

    }
    /**
     * onDelete
     */
    product.onDelete = function() {
    //        var rec = userGrid.getSelectionModel().getSelected();
    //        if (!rec) {
    //            return false;
    //        }
    //        userGrid.store.remove(rec);
    }

}

