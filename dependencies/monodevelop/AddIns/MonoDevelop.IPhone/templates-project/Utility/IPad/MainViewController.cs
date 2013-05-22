using System;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace ${Namespace}
{
	public partial class MainViewController : UIViewController
	{
		UIPopoverController flipsidePopoverController;
		
		public MainViewController () : base ("MainViewController", null)
		{
			// Custom initialization
		}
		
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			
			// Perform any additional setup after loading the view, typically from a nib.
		}
		
		public override bool ShouldAutorotateToInterfaceOrientation (UIInterfaceOrientation toInterfaceOrientation)
		{
			// Return true for supported orientations
			return true;
		}
		
		public override void DidReceiveMemoryWarning ()
		{
			// Releases the view if it doesn't have a superview.
			base.DidReceiveMemoryWarning ();
			
			// Release any cached data, images, etc that aren't in use.
		}
		
		partial void showInfo (NSObject sender)
		{
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
