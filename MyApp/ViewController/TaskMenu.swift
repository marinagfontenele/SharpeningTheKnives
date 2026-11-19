//
//  TaskMenu.swift
//  MyApp
//
//  Created by Marina Gomes Fontenele on 18/11/26.
//

import UIKit

enum TaskMenu {
    static func contextMenuConfiguration(onDelete: @escaping () -> Void) -> UIContextMenuConfiguration {
        UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let deleteAction = UIAction(
                title: "Apagar tarefa",
                image: UIImage(systemName: "trash"),
                attributes: .destructive
            ) { _ in
                onDelete()
            }

            return UIMenu(children: [deleteAction])
        }
    }
}
