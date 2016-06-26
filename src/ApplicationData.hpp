/*
 * ApplicationData.hpp
 *
 *  Created on: Jun 26, 2016
 *      Author: adonai
 */

#ifndef APPLICATIONDATA_HPP_
#define APPLICATIONDATA_HPP_

#include <QObject>
#include "DownloadInfo.hpp"

class ApplicationData : public QObject
{
    Q_OBJECT
public:
    ApplicationData( QObject *parent = NULL );
    virtual ~ApplicationData();

    static DownloadInfo application_housekeeping_info;
};

#endif /* APPLICATIONDATA_HPP_ */
