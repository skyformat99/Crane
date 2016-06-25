/*
 * CraneDataModel.hpp
 *
 *  Created on: Jun 24, 2016
 *      Author: adonai
 */

#ifndef CRANEDATAMODEL_HPP_
#define CRANEDATAMODEL_HPP_

#include <QObject>
#include <bb/cascades/DataModel>

using namespace bb::cascades;

class CraneDataModel : public DataModel
{
    Q_OBJECT
public:
    Q_INVOKABLE virtual bool hasChildren( QVariantList const & indexPath );
    Q_INVOKABLE virtual int childCount( QVariantList const & indexPath );
    Q_INVOKABLE virtual QString itemType( QVariantList const & indexPath );
    Q_INVOKABLE virtual QVariant data( QVariantList const & indexPath );
    CraneDataModel( QObject *parent = NULL );
    virtual ~CraneDataModel();
};

class CraneFilteredDataModel : public DataModel
{
    Q_OBJECT
public:
    Q_INVOKABLE virtual bool hasChildren( QVariantList const & indexPath );
    Q_INVOKABLE virtual int childCount( QVariantList const & indexPath );
    Q_INVOKABLE virtual QString itemType( QVariantList const & indexPath );
    Q_INVOKABLE virtual QVariant data( QVariantList const & indexPath );
    CraneFilteredDataModel( bb::cascades::DataModel *data_model, QObject *parent = NULL );
    virtual ~CraneFilteredDataModel();

private:
    bb::cascades::DataModel *m_pDataModel;
};

#endif /* CRANEDATAMODEL_HPP_ */