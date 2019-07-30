Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8E079D96
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2019 02:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfG3Atp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jul 2019 20:49:45 -0400
Received: from fieldses.org ([173.255.197.46]:40808 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfG3Ato (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Jul 2019 20:49:44 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 7CD632010; Mon, 29 Jul 2019 20:49:44 -0400 (EDT)
Date:   Mon, 29 Jul 2019 20:49:44 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Neil F Brown <nfbrown@suse.com>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] SUNRPC: Track writers of the 'channel' file to
 improve cache_listeners_exist
Message-ID: <20190730004944.GA24355@fieldses.org>
References: <20190725185421.GA15073@fieldses.org>
 <1564180381-9916-1-git-send-email-dwysocha@redhat.com>
 <20190729215154.GI20723@fieldses.org>
 <8736iomlsy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736iomlsy.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 30, 2019 at 10:02:37AM +1000, NeilBrown wrote:
> On Mon, Jul 29 2019,  J. Bruce Fields  wrote:
> 
> > On Fri, Jul 26, 2019 at 06:33:01PM -0400, Dave Wysochanski wrote:
> >> The sunrpc cache interface is susceptible to being fooled by a rogue
> >> process just reading a 'channel' file.  If this happens the kernel
> >> may think a valid daemon exists to service the cache when it does not.
> >> For example, the following may fool the kernel:
> >> cat /proc/net/rpc/auth.unix.gid/channel
> >> 
> >> Change the tracking of readers to writers when considering whether a
> >> listener exists as all valid daemon processes either open a channel
> >> file O_RDWR or O_WRONLY.  While this does not prevent a rogue process
> >> from "stealing" a message from the kernel, it does at least improve
> >> the kernels perception of whether a valid process servicing the cache
> >> exists.
> >> 
> >> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> >> ---
> >>  include/linux/sunrpc/cache.h |  6 +++---
> >>  net/sunrpc/cache.c           | 12 ++++++++----
> >>  2 files changed, 11 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
> >> index c7f38e8..f7d086b 100644
> >> --- a/include/linux/sunrpc/cache.h
> >> +++ b/include/linux/sunrpc/cache.h
> >> @@ -107,9 +107,9 @@ struct cache_detail {
> >>  	/* fields for communication over channel */
> >>  	struct list_head	queue;
> >>  
> >> -	atomic_t		readers;		/* how many time is /chennel open */
> >> -	time_t			last_close;		/* if no readers, when did last close */
> >> -	time_t			last_warn;		/* when we last warned about no readers */
> >> +	atomic_t		writers;		/* how many time is /channel open */
> >> +	time_t			last_close;		/* if no writers, when did last close */
> >> +	time_t			last_warn;		/* when we last warned about no writers */
> >>  
> >>  	union {
> >>  		struct proc_dir_entry	*procfs;
> >> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> >> index 6f1528f..a6a6190 100644
> >> --- a/net/sunrpc/cache.c
> >> +++ b/net/sunrpc/cache.c
> >> @@ -373,7 +373,7 @@ void sunrpc_init_cache_detail(struct cache_detail *cd)
> >>  	spin_lock(&cache_list_lock);
> >>  	cd->nextcheck = 0;
> >>  	cd->entries = 0;
> >> -	atomic_set(&cd->readers, 0);
> >> +	atomic_set(&cd->writers, 0);
> >>  	cd->last_close = 0;
> >>  	cd->last_warn = -1;
> >>  	list_add(&cd->others, &cache_list);
> >> @@ -1029,11 +1029,13 @@ static int cache_open(struct inode *inode, struct file *filp,
> >>  		}
> >>  		rp->offset = 0;
> >>  		rp->q.reader = 1;
> >> -		atomic_inc(&cd->readers);
> >> +
> >>  		spin_lock(&queue_lock);
> >>  		list_add(&rp->q.list, &cd->queue);
> >>  		spin_unlock(&queue_lock);
> >>  	}
> >> +	if (filp->f_mode & FMODE_WRITE)
> >> +		atomic_inc(&cd->writers);
> >
> > This patch would be even simpler if we just modified the condition of
> > the preceding if clause:
> >
> > -	if (filp->f_mode & FMODE_READ) {
> > +	if (filp->f_mode & FMODE_WRITE) {
> >
> > and then we could drop the following chunk completely.
> >
> > Is there any reason not to do that?
> 
> I can see how this would be tempting, but I think the reason not to do
> that is it is ... wrong.
> 
> The bulk of the code is for setting up context to support reading, so it
> really should be conditional on FMODE_READ.
> We always want to set that up, because if a process opens for read, and
> not write, we want to respond properly to read requests.  This is useful
> for debugging.

How is it useful for debugging?

--b.

> I think this patch from Dave is good.  A process opening for read might
> just be inquisitive.  A program opening for write is making more of a
> commitment to being involved in managing the cache.
> 
>  Reviewed-by: NeilBrown <neilb@suse.com>
> 
> Thanks,
> NeilBrown
> 
> 
> >
> > Or if the resulting behavior isn't right for write-only openers, we
> > could make the condition ((filp->f_mode & FMODE_READ) && (filp->f_mode &
> > FMODE_WRITE)).
> >
> > --b.
> >
> >>  	filp->private_data = rp;
> >>  	return 0;
> >>  }
> >> @@ -1062,8 +1064,10 @@ static int cache_release(struct inode *inode, struct file *filp,
> >>  		filp->private_data = NULL;
> >>  		kfree(rp);
> >>  
> >> +	}
> >> +	if (filp->f_mode & FMODE_WRITE) {
> >> +		atomic_dec(&cd->writers);
> >>  		cd->last_close = seconds_since_boot();
> >> -		atomic_dec(&cd->readers);
> >>  	}
> >>  	module_put(cd->owner);
> >>  	return 0;
> >> @@ -1171,7 +1175,7 @@ static void warn_no_listener(struct cache_detail *detail)
> >>  
> >>  static bool cache_listeners_exist(struct cache_detail *detail)
> >>  {
> >> -	if (atomic_read(&detail->readers))
> >> +	if (atomic_read(&detail->writers))
> >>  		return true;
> >>  	if (detail->last_close == 0)
> >>  		/* This cache was never opened */
> >> -- 
> >> 1.8.3.1


