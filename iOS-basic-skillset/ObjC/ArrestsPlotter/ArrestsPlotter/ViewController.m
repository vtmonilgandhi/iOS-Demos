//
//  ViewController.m
//  ArrestsPlotter
//
//  Created by Monil Gandhi on 10/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <MKMapViewDelegate>

@end

@implementation ViewController

@synthesize mapView;

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.mapView.delegate = self;
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
  [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];

  // Add an annotation
  MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
  point.coordinate = userLocation.coordinate;
  point.title = @"Where am I?";
  point.subtitle = @"I'm here!!!";

  [self.mapView addAnnotation:point];
}

@end
