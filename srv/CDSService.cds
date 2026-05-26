using { CDSView as mycds } from '../db/CDSView';

service CDSService @(path: 'CDSService') {

    entity ProductSet as projection on mycds.ProductView{
        *,
        virtual soldCount : Integer
    };
    entity POItemSet as projection on mycds.ItemView;

}
