import bb.cascades 1.2
import bb.system 1.2
import bb.data 1.0

TabbedPane
{
    property int number_of_threads;
    property int number_of_downloads;
    property string downloads_directory;
    
    onCreationCompleted: {
        number_of_threads = settings.max_thread;
        number_of_downloads = settings.max_download;
        downloads_directory = settings.location
    }
    id: root
    showTabsOnActionBar: true
    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
        
        }
        settingsAction: SettingsActionItem {
            onTriggered: {
                var settings = settingsPage.createObject();
                navPane.push( settings )
            }
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: settingsPage
            source: "asset:///settings.qml"
        }
    ]
    Tab
    {
        id: homepageTab
        title: "Downloads"
        imageSource: "asset:///images/home.png"
        NavigationPane
        {
            id: navPane
            onPopTransitionEnded: {
                number_of_threads = settings.max_thread;
                number_of_downloads = settings.max_download;
                downloads_directory = settings.location

                page.destroy()
            }
            function status( message )
            {
                system_toast.body = message
                system_toast.show();
            }
            Page
            {
                titleBar: TitleBar {
                    title: "Crane Download Manager"
                    appearance: TitleBarAppearance.Default
                    kind: TitleBarKind.Default
                    dismissAction: ActionItem {
                        imageSource: "asset:///images/5_content_new.png"
                        onTriggered: {
                            addNewDownload.show()
                        }
                    }
                }
                attachedObjects: [
                    SystemPrompt {
                        id: addNewDownload
                        body: "Enter website address"
                        title: "New Download"
                        onFinished: {
                            switch( value ){
                                case SystemUiResult.ConfirmButtonSelection :
                                    download_manager.addNewUrl( addNewDownload.inputFieldTextEntry(), number_of_threads, 
                                        number_of_downloads, downloads_directory );
                                    break;
                                default :
                                    break;
                            }
                        }
                    },
                    SystemToast {
                        id: system_toast
                    }
                ]
                onCreationCompleted: {
                    download_manager.status.connect( navPane.status );
                    download_manager.error.connect( navPane.status );
                }
                actions: [
                    ActionItem {
                        title: "All"
                        imageSource: "asset:///images/add.png"
                    },
                    ActionItem {
                        title: "Documents"
                        imageSource: "asset:///images/doc.png"
                    },
                    ActionItem {
                        title: "Images"
                        imageSource: "asset:///images/picture.png"
                    },
                    ActionItem {
                        title: "Music"
                        imageSource: "asset:///images/music.png"
                    },
                    ActionItem {
                        title: "Video"
                        imageSource: "asset:///images/video.png"
                    },
                    ActionItem {
                        title: "Programs"
                    },
                    ActionItem {
                        title: "Archives"
                    },
                    ActionItem {
                        title: "Others"
                        imageSource: "asset:///images/other.png"
                    }
                ]
                Container {
                    topPadding: 20
                    rightPadding: 20
                    leftPadding: 20
                    Container {
                        SegmentedControl
                        {
                            id: segmented_filter
                            onCreationCompleted: {
                                segmented_filter.selectedIndex = 1;
                            }
                            onSelectedIndexChanged: {
                                model_.changeView( selectedIndex );
                            }
                            Option 
                            {
                                id: queueOption
                                text: "Queue"
                            }
                            Option
                            {
                                id: finishedOption
                                text: "Finished"
                            }
                        }
                    }
                    ListView {
                        id: list_view
                        
                        dataModel: model_
                        
                        listItemComponents: [
                            ListItemComponent {
                                type: "item"
                                StandardListItem {

                                    title: ListItemData.file_name;
                                    description: ListItemData.downloaded_size + "bytes"
                                    status: ListItemData.status
                                    imageSource: "asset:///images/music.png"
                                    
                                    contextActions: [
                                        ActionSet {
                                            DeleteActionItem {
                                                onTriggered: {
                                                    
                                                }
                                            }
                                        }
                                    ]
                                }
                            }
                        ]
                        onTriggered: {
                            list_view.clearSelection()
//                            list_view.toggleSelection( indexPath )
                            select( indexPath )
                        }
                    }
                }
            }
        }
    }
}