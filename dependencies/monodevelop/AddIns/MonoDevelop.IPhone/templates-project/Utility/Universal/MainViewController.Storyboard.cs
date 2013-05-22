using System;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace ${Namespace}
{
	public partial class MainViewController : UIViewController
	{
		static bool UserInterfaceIdiomIsPhone {
			get { return UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Phone; }
		}
		
		UIPopoverController flipsidePopoverController;
		
		public MainViewController (IntPtr handle) : base (handle)
		{
			// Custom initialization
		}
		
		public override bool ShouldAutorotateToInterfaceOrientation (UIInterfaceOrientation toInterfaceOrientation)
		{
			// Return true for supported orientations
			if (UserInterfaceIdiomIsPhone) {
				return (toInterfaceOrientation != UIInterfaceOrientation.PortraitUpsideDown);
			} else {
				return true;
			}
		}
		
		public override void DidReceiveMemoryWarning ()
		{
			// Releases the view if it doesn't have a superview.
			base.DidReceiveMemoryWarning ();
			
			// Release any cached data, images, etc that aren't in use.
		}
		
		#region View lifecycle
		
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			
			// Perform any additional setup after loading the view, typically from a nib.
		}
		
		public override void ViewWillAppear (bool animated)
		{
			base.ViewWillAppear (animated);
		}
		
		public override void ViewDidAppear (bool animated)
		{
			base.ViewDidAppear (animated);
		}
		
		public override void ViewWillDisappear (bool animated)
		{
			base.ViewWillDisappear (animated);
		}
		
		public override void ViewDidDisappear (bool animated)
		{
			base.ViewDidDisappear (animated);
		}
		
		#endregion
		
		partial void showInfo (NSObject sender)
		{
			if (UserInterfaceIdiomIsPhone) {
				var controller = new FlipsideViewController () {
					ModalTransitionStyle = UIModalTransitionStyle.FlipHorizontal,
				};
				
				controller.Done += delegate {
					this.DismissModalViewControllerAnimated (true);
				};
				
				this.PresentModalViewController (controller, true);
			} else {
				if (flipsidePopoverController == null) {
					var controller = new FlipsideViewController ();
					flipsidePopoverController = new UIPopoverController (controller);
					controller.Done += delegate {
						flipsidePopoverController.Dismiss (true);
					};
				}
				
				if (flipsidePopoverController.PopoverVisible) {
					flipsidePopoverController.Dismiss (true);
				} else {
					flipsidePopoverController.PresentFromBarButtonItem ((UIBarButtonItem)sender, UIPopoverArrowDirection.Any, true);
				}
			}
		}
	}
}
