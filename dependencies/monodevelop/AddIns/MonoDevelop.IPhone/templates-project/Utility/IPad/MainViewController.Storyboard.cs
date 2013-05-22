using System;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace ${Namespace}
{
	public partial class MainViewController : UIViewController
	{
		UIPopoverController flipsidePopoverController;
		
		public MainViewController (IntPtr handle) : base (handle)
		{
			// Custom initialization
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
		
		[Action("togglePopover:")]
		public void togglePopover (NSObject sender)
		{
			if (flipsidePopoverController != null) {
				flipsidePopoverController.Dismiss (true);
				flipsidePopoverController = null;
			} else {
				// TODO: iOS5 Segue support missing ?
			}
		}
		
		partial void showInfo (NSObject sender)
		{
		}
	}
}
