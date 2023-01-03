//
//  ViewController.swift
//  CameraFilter
//
//  Created by Monil Gandhi on 31/12/20.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var applyFilterButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let photosVC = navC.viewControllers.first as? PhotosCollectionViewController else { fatalError("Error") }
        photosVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
    }
    
    @IBAction func applyFilterButtonPressed() {
        guard let sourceImage = self.photoImageView.image else {
            return
        }
        
        FiltersService().applyFilter(to: sourceImage)
            .subscribe(onNext: { filterdImage in
                DispatchQueue.main.async {
                    self.photoImageView.image = filterdImage
                }
            }).disposed(by: disposeBag)
    }
    
    func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.photoImageView.contentMode = .scaleAspectFit
        self.applyFilterButton.isHidden = false
    }
}

