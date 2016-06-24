/*
 * DownloadManager.hpp
 *
 *  Created on: Jun 17, 2016
 *      Author: Joshua
 */

#ifndef DOWNLOADMANAGER_HPP_
#define DOWNLOADMANAGER_HPP_

#include <QObject>
#include <QNetworkReply>
#include <QFile>
#include <QDate>
#include <QThread>
#include <QDebug>

#include "Download.hpp"

struct DownloadManager: public QObject
{
    Q_OBJECT

public slots:
    void finishedHandler( QString );
    void errorHandler( QString );
    void downloadStartedHandler( QString url );
signals:
    void error( QString );
    void finished( QString );
    void status( QString );
public:
    static QMap<QString, DownloadComponent*>   active_download_list;
    static QList<QString>                      inactive_downloads;
    static unsigned int                        max_number_of_downloads;
    static unsigned int                        max_number_of_threads;
public:
    DownloadManager( QObject *parent = NULL );
    virtual ~DownloadManager();
};

struct CraneDownloader : public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE static void addNewUrl( QString const & url, unsigned int threads, unsigned int download_limit,
                QString directory = QString() );
    CraneDownloader();
signals:
    void error( QString );
    void status( QString );
public slots:
    void errorHandler( QString );
    void statusHandler( QString );
};
#endif /* DOWNLOADMANAGER_HPP_ */
