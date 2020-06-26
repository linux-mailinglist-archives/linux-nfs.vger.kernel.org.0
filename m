Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E49220BBC7
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 23:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgFZVoC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 17:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZVoC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 17:44:02 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92912C03E979
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 14:44:02 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CCD84799E; Fri, 26 Jun 2020 17:44:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CCD84799E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1593207841;
        bh=0Ybu9gHcBFf1lukpeDsCP3DRO2CsZlVXS2RV02FflG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmFdLsQN1cxjZa+JjtzxZ4oZhPRyW9spnwRa+3VmCm/PYHZxsxP3j6u+zB/RIe4n2
         2Qh+PXxqtrhDyWuSi8KiZdOPZa33l50fMNPA5Q9zOgJR7+qj1L/ygu5Zv61Tj3FtjV
         4MceivjVtz3oNkd95V7Qg/fC+pyqZMiw2kaRHUzI=
Date:   Fri, 26 Jun 2020 17:44:01 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Doug Nazar <nazard@nazar.ca>
Cc:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>
Subject: Re: [PATCH v2] Re: Strange segmentation violations of rpc.gssd in
 Debian Buster
Message-ID: <20200626214401.GE11850@fieldses.org>
References: <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
 <20200622223628.GC11051@fieldses.org>
 <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
 <1527b158-3404-168c-8908-de4b8a709ccd@nazar.ca>
 <e9de5046e7734e728e64b386314a5d2e@tu-berlin.de>
 <c1c314fd-1855-cf04-3ec5-5f6eb35719a5@nazar.ca>
 <20200626194622.GB11850@fieldses.org>
 <3eb80b1f-e4d3-e87c-aacd-34dc28637948@nazar.ca>
 <20200626210243.GD11850@fieldses.org>
 <bebca60d-09e4-f118-c195-c6245e6496fb@nazar.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bebca60d-09e4-f118-c195-c6245e6496fb@nazar.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 26, 2020 at 05:30:15PM -0400, Doug Nazar wrote:
> On 2020-06-26 17:02, J. Bruce Fields wrote:
> >Unless I'm missing something--an upcall thread could still be using this
> >file descriptor.
> >
> >If we're particularly unlucky, we could do a new open in a moment and
> >reuse this file descriptor number, and then then writes in do_downcall()
> >could end up going to some other random file.
> >
> >I think we want these closes done by gssd_free_client() in the !refcnt
> >case?
> 
> Makes sense. I was thinking more that it was an abort situation and
> we shouldn't be sending any data to the kernel but re-use is
> definitely a concern.
> 
> I've split it so that we are removed from the event loop in
> destroy() but the close happens in free().

Looks good to me.  Steve?

--b.

> 
> Doug
> 

> From 8ef49081e8a42bfa05bb63265cd4f951e2b23413 Mon Sep 17 00:00:00 2001
> From: Doug Nazar <nazard@nazar.ca>
> Date: Fri, 26 Jun 2020 16:02:04 -0400
> Subject: [PATCH] gssd: Refcount struct clnt_info to protect multithread usage
> 
> Struct clnt_info is shared with the various upcall threads so
> we need to ensure that it stays around even if the client dir
> gets removed.
> 
> Reported-by: Sebastian Kraus <sebastian.kraus@tu-berlin.de>
> Signed-off-by: Doug Nazar <nazard@nazar.ca>
> ---
>  utils/gssd/gssd.c      | 67 ++++++++++++++++++++++++++++++++----------
>  utils/gssd/gssd.h      |  5 ++--
>  utils/gssd/gssd_proc.c |  4 +--
>  3 files changed, 55 insertions(+), 21 deletions(-)
> 
> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> index 588da0fb..b40c3220 100644
> --- a/utils/gssd/gssd.c
> +++ b/utils/gssd/gssd.c
> @@ -90,9 +90,7 @@ char *ccachedir = NULL;
>  /* Avoid DNS reverse lookups on server names */
>  static bool avoid_dns = true;
>  static bool use_gssproxy = false;
> -int thread_started = false;
> -pthread_mutex_t pmutex = PTHREAD_MUTEX_INITIALIZER;
> -pthread_cond_t pcond = PTHREAD_COND_INITIALIZER;
> +pthread_mutex_t clp_lock = PTHREAD_MUTEX_INITIALIZER;
>  
>  TAILQ_HEAD(topdir_list_head, topdir) topdir_list;
>  
> @@ -359,20 +357,28 @@ out:
>  	free(port);
>  }
>  
> +/* Actually frees clp and fields that might be used from other
> + * threads if was last reference.
> + */
>  static void
> -gssd_destroy_client(struct clnt_info *clp)
> +gssd_free_client(struct clnt_info *clp)
>  {
> -	if (clp->krb5_fd >= 0) {
> +	int refcnt;
> +
> +	pthread_mutex_lock(&clp_lock);
> +	refcnt = --clp->refcount;
> +	pthread_mutex_unlock(&clp_lock);
> +	if (refcnt > 0)
> +		return;
> +
> +	printerr(3, "freeing client %s\n", clp->relpath);
> +
> +	if (clp->krb5_fd >= 0)
>  		close(clp->krb5_fd);
> -		event_del(&clp->krb5_ev);
> -	}
>  
> -	if (clp->gssd_fd >= 0) {
> +	if (clp->gssd_fd >= 0)
>  		close(clp->gssd_fd);
> -		event_del(&clp->gssd_ev);
> -	}
>  
> -	inotify_rm_watch(inotify_fd, clp->wd);
>  	free(clp->relpath);
>  	free(clp->servicename);
>  	free(clp->servername);
> @@ -380,6 +386,24 @@ gssd_destroy_client(struct clnt_info *clp)
>  	free(clp);
>  }
>  
> +/* Called when removing from clnt_list to tear down event handling.
> + * Will then free clp if was last reference.
> + */
> +static void
> +gssd_destroy_client(struct clnt_info *clp)
> +{
> +	printerr(3, "destroying client %s\n", clp->relpath);
> +
> +	if (clp->krb5_fd >= 0)
> +		event_del(&clp->krb5_ev);
> +
> +	if (clp->gssd_fd >= 0)
> +		event_del(&clp->gssd_ev);
> +
> +	inotify_rm_watch(inotify_fd, clp->wd);
> +	gssd_free_client(clp);
> +}
> +
>  static void gssd_scan(void);
>  
>  static int
> @@ -416,11 +440,21 @@ static struct clnt_upcall_info *alloc_upcall_info(struct clnt_info *clp)
>  	info = malloc(sizeof(struct clnt_upcall_info));
>  	if (info == NULL)
>  		return NULL;
> +
> +	pthread_mutex_lock(&clp_lock);
> +	clp->refcount++;
> +	pthread_mutex_unlock(&clp_lock);
>  	info->clp = clp;
>  
>  	return info;
>  }
>  
> +void free_upcall_info(struct clnt_upcall_info *info)
> +{
> +	gssd_free_client(info->clp);
> +	free(info);
> +}
> +
>  /* For each upcall read the upcall info into the buffer, then create a
>   * thread in a detached state so that resources are released back into
>   * the system without the need for a join.
> @@ -438,13 +472,13 @@ gssd_clnt_gssd_cb(int UNUSED(fd), short UNUSED(which), void *data)
>  	info->lbuflen = read(clp->gssd_fd, info->lbuf, sizeof(info->lbuf));
>  	if (info->lbuflen <= 0 || info->lbuf[info->lbuflen-1] != '\n') {
>  		printerr(0, "WARNING: %s: failed reading request\n", __func__);
> -		free(info);
> +		free_upcall_info(info);
>  		return;
>  	}
>  	info->lbuf[info->lbuflen-1] = 0;
>  
>  	if (start_upcall_thread(handle_gssd_upcall, info))
> -		free(info);
> +		free_upcall_info(info);
>  }
>  
>  static void
> @@ -461,12 +495,12 @@ gssd_clnt_krb5_cb(int UNUSED(fd), short UNUSED(which), void *data)
>  			sizeof(info->uid)) < (ssize_t)sizeof(info->uid)) {
>  		printerr(0, "WARNING: %s: failed reading uid from krb5 "
>  			 "upcall pipe: %s\n", __func__, strerror(errno));
> -		free(info);
> +		free_upcall_info(info);
>  		return;
>  	}
>  
>  	if (start_upcall_thread(handle_krb5_upcall, info))
> -		free(info);
> +		free_upcall_info(info);
>  }
>  
>  static struct clnt_info *
> @@ -501,6 +535,7 @@ gssd_get_clnt(struct topdir *tdi, const char *name)
>  	clp->name = clp->relpath + strlen(tdi->name) + 1;
>  	clp->krb5_fd = -1;
>  	clp->gssd_fd = -1;
> +	clp->refcount = 1;
>  
>  	TAILQ_INSERT_HEAD(&tdi->clnt_list, clp, list);
>  	return clp;
> @@ -651,7 +686,7 @@ gssd_scan_topdir(const char *name)
>  		if (clp->scanned)
>  			continue;
>  
> -		printerr(3, "destroying client %s\n", clp->relpath);
> +		printerr(3, "orphaned client %s\n", clp->relpath);
>  		saveprev = clp->list.tqe_prev;
>  		TAILQ_REMOVE(&tdi->clnt_list, clp, list);
>  		gssd_destroy_client(clp);
> diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
> index f4f59754..d33e4dff 100644
> --- a/utils/gssd/gssd.h
> +++ b/utils/gssd/gssd.h
> @@ -63,12 +63,10 @@ extern unsigned int 		context_timeout;
>  extern unsigned int rpc_timeout;
>  extern char			*preferred_realm;
>  extern pthread_mutex_t ple_lock;
> -extern pthread_cond_t pcond;
> -extern pthread_mutex_t pmutex;
> -extern int thread_started;
>  
>  struct clnt_info {
>  	TAILQ_ENTRY(clnt_info)	list;
> +	int			refcount;
>  	int			wd;
>  	bool			scanned;
>  	char			*name;
> @@ -94,6 +92,7 @@ struct clnt_upcall_info {
>  
>  void handle_krb5_upcall(struct clnt_upcall_info *clp);
>  void handle_gssd_upcall(struct clnt_upcall_info *clp);
> +void free_upcall_info(struct clnt_upcall_info *info);
>  
>  
>  #endif /* _RPC_GSSD_H_ */
> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> index 8fe6605b..05c1da64 100644
> --- a/utils/gssd/gssd_proc.c
> +++ b/utils/gssd/gssd_proc.c
> @@ -730,7 +730,7 @@ handle_krb5_upcall(struct clnt_upcall_info *info)
>  	printerr(2, "\n%s: uid %d (%s)\n", __func__, info->uid, clp->relpath);
>  
>  	process_krb5_upcall(clp, info->uid, clp->krb5_fd, NULL, NULL, NULL);
> -	free(info);
> +	free_upcall_info(info);
>  }
>  
>  void
> @@ -830,6 +830,6 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
>  out:
>  	free(upcall_str);
>  out_nomem:
> -	free(info);
> +	free_upcall_info(info);
>  	return;
>  }
> -- 
> 2.26.2
> 

