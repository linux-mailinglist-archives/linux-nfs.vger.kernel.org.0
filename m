Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D2379B89
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2019 23:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbfG2Vvz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jul 2019 17:51:55 -0400
Received: from fieldses.org ([173.255.197.46]:40680 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388897AbfG2Vvz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Jul 2019 17:51:55 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id BBD6DABE; Mon, 29 Jul 2019 17:51:54 -0400 (EDT)
Date:   Mon, 29 Jul 2019 17:51:54 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     neilb@suse.com, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] SUNRPC: Track writers of the 'channel' file to
 improve cache_listeners_exist
Message-ID: <20190729215154.GI20723@fieldses.org>
References: <20190725185421.GA15073@fieldses.org>
 <1564180381-9916-1-git-send-email-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564180381-9916-1-git-send-email-dwysocha@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 26, 2019 at 06:33:01PM -0400, Dave Wysochanski wrote:
> The sunrpc cache interface is susceptible to being fooled by a rogue
> process just reading a 'channel' file.  If this happens the kernel
> may think a valid daemon exists to service the cache when it does not.
> For example, the following may fool the kernel:
> cat /proc/net/rpc/auth.unix.gid/channel
> 
> Change the tracking of readers to writers when considering whether a
> listener exists as all valid daemon processes either open a channel
> file O_RDWR or O_WRONLY.  While this does not prevent a rogue process
> from "stealing" a message from the kernel, it does at least improve
> the kernels perception of whether a valid process servicing the cache
> exists.
> 
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  include/linux/sunrpc/cache.h |  6 +++---
>  net/sunrpc/cache.c           | 12 ++++++++----
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
> index c7f38e8..f7d086b 100644
> --- a/include/linux/sunrpc/cache.h
> +++ b/include/linux/sunrpc/cache.h
> @@ -107,9 +107,9 @@ struct cache_detail {
>  	/* fields for communication over channel */
>  	struct list_head	queue;
>  
> -	atomic_t		readers;		/* how many time is /chennel open */
> -	time_t			last_close;		/* if no readers, when did last close */
> -	time_t			last_warn;		/* when we last warned about no readers */
> +	atomic_t		writers;		/* how many time is /channel open */
> +	time_t			last_close;		/* if no writers, when did last close */
> +	time_t			last_warn;		/* when we last warned about no writers */
>  
>  	union {
>  		struct proc_dir_entry	*procfs;
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 6f1528f..a6a6190 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -373,7 +373,7 @@ void sunrpc_init_cache_detail(struct cache_detail *cd)
>  	spin_lock(&cache_list_lock);
>  	cd->nextcheck = 0;
>  	cd->entries = 0;
> -	atomic_set(&cd->readers, 0);
> +	atomic_set(&cd->writers, 0);
>  	cd->last_close = 0;
>  	cd->last_warn = -1;
>  	list_add(&cd->others, &cache_list);
> @@ -1029,11 +1029,13 @@ static int cache_open(struct inode *inode, struct file *filp,
>  		}
>  		rp->offset = 0;
>  		rp->q.reader = 1;
> -		atomic_inc(&cd->readers);
> +
>  		spin_lock(&queue_lock);
>  		list_add(&rp->q.list, &cd->queue);
>  		spin_unlock(&queue_lock);
>  	}
> +	if (filp->f_mode & FMODE_WRITE)
> +		atomic_inc(&cd->writers);

This patch would be even simpler if we just modified the condition of
the preceding if clause:

-	if (filp->f_mode & FMODE_READ) {
+	if (filp->f_mode & FMODE_WRITE) {

and then we could drop the following chunk completely.

Is there any reason not to do that?

Or if the resulting behavior isn't right for write-only openers, we
could make the condition ((filp->f_mode & FMODE_READ) && (filp->f_mode &
FMODE_WRITE)).

--b.

>  	filp->private_data = rp;
>  	return 0;
>  }
> @@ -1062,8 +1064,10 @@ static int cache_release(struct inode *inode, struct file *filp,
>  		filp->private_data = NULL;
>  		kfree(rp);
>  
> +	}
> +	if (filp->f_mode & FMODE_WRITE) {
> +		atomic_dec(&cd->writers);
>  		cd->last_close = seconds_since_boot();
> -		atomic_dec(&cd->readers);
>  	}
>  	module_put(cd->owner);
>  	return 0;
> @@ -1171,7 +1175,7 @@ static void warn_no_listener(struct cache_detail *detail)
>  
>  static bool cache_listeners_exist(struct cache_detail *detail)
>  {
> -	if (atomic_read(&detail->readers))
> +	if (atomic_read(&detail->writers))
>  		return true;
>  	if (detail->last_close == 0)
>  		/* This cache was never opened */
> -- 
> 1.8.3.1
