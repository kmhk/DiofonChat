//
//  PTEConsoleTableView.h
//  LumberjackConsole
//
//  Created by Ernesto Rivera on 2014/04/09.
//  Copyright (c) 2013-2017 PTEz.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

@class PTEConsoleLogger;

/**
 A UITableView DDLogger that displays searcheable log messages.
 
 - Supports colors for log levels.
 - Expands and collapses text.
 - Can be filtered according to log levels or text.
 - Can be minimized, maximized or used in any size in between.
 
 Simply add a PTEConsoleTableView to your view hierarchy or use
 [[PTEDashboard sharedDashboard] show].
 */
@interface PTEConsoleTableView : UITableView


@end

