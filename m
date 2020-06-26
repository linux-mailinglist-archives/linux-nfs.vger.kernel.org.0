Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0A520BAE2
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 23:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgFZVCo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 17:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFZVCn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 17:02:43 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF13C03E979
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 14:02:43 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1CAA3793C; Fri, 26 Jun 2020 17:02:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1CAA3793C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1593205363;
        bh=2H++016mKc1mRzfJwULFYwZyVDGRZ6F0J93lbad4g+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=izabAbT5ujmqfEyxWvEbBiQApkl/j2s/HxsnVj2Qe7vXCbv2e4FmyIjMeYqXSUUl2
         YBwLro++pNc0LCR72cV8HY6z5CIVfw/2AiTplO+WiTyRoFWmq1XmXAbGv4n3/tkNCU
         z9AVDxcK8v1rMOSCEfPxeokCaTGLuu6YK11P4TZo=
Date:   Fri, 26 Jun 2020 17:02:43 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Doug Nazar <nazard@nazar.ca>
Cc:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>
Subject: Re: Strange segmentation violations of rpc.gssd in Debian Buster
Message-ID: <20200626210243.GD11850@fieldses.org>
References: <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
 <20200620170316.GH1514@fieldses.org>
 <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
 <20200622223628.GC11051@fieldses.org>
 <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
 <1527b158-3404-168c-8908-de4b8a709ccd@nazar.ca>
 <e9de5046e7734e728e64b386314a5d2e@tu-berlin.de>
 <c1c314fd-1855-cf04-3ec5-5f6eb35719a5@nazar.ca>
 <20200626194622.GB11850@fieldses.org>
 <3eb80b1f-e4d3-e87c-aacd-34dc28637948@nazar.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eb80b1f-e4d3-e87c-aacd-34dc28637948@nazar.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 26, 2020 at 04:15:46PM -0400, Doug Nazar wrote:
> On 2020-06-26 15:46, J. Bruce Fields wrote:
> >So, yeah, either a reference count or a deep copy is probably all that's
> >needed, in alloc_upcall_info() and at the end of handle_krb5_upcall().
> 
> Slightly more complex, to handle the error cases & event tear-down
> but this seems to work. I'm not sure how much of a hot spot this is
> so I just went with a global mutex. Strangely there was an existing
> unused mutex & thread_started flag.
> 
> Survives basic testing but I don't have a reproducer. Maybe blocking
> access to the kdc. If I get time I'll try to setup a test
> environment.

Thanks, looks good.  The only thing I wonder about:

> @@ -359,9 +357,37 @@ out:
>  	free(port);
>  }
>  
> +/* Actually frees clp and fields that might be used from other
> + * threads if was last reference.
> + */
> +static void
> +gssd_free_client(struct clnt_info *clp)
> +{
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
> +	free(clp->relpath);
> +	free(clp->servicename);
> +	free(clp->servername);
> +	free(clp->protocol);
> +	free(clp);
> +}
> +
> +/* Called when removing from clnt_list to tear down event handling.
> + * Will then free clp if was last reference.
> + */
>  static void
>  gssd_destroy_client(struct clnt_info *clp)
>  {
> +	printerr(3, "destroying client %s\n", clp->relpath);
> +
>  	if (clp->krb5_fd >= 0) {
>  		close(clp->krb5_fd);

Unless I'm missing something--an upcall thread could still be using this
file descriptor.

If we're particularly unlucky, we could do a new open in a moment and
reuse this file descriptor number, and then then writes in do_downcall()
could end up going to some other random file.

I think we want these closes done by gssd_free_client() in the !refcnt
case?

--b.

>  		event_del(&clp->krb5_ev);
> @@ -373,11 +399,7 @@ gssd_destroy_client(struct clnt_info *clp)
>  	}
>  
>  	inotify_rm_watch(inotify_fd, clp->wd);
> -	free(clp->relpath);
> -	free(clp->servicename);
> -	free(clp->servername);
> -	free(clp->protocol);
> -	free(clp);
> +	gssd_free_client(clp);
>  }
>  
>  static void gssd_scan(void);
> @@ -416,11 +438,21 @@ static struct clnt_upcall_info *alloc_upcall_info(struct clnt_info *clp)
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
> @@ -438,13 +470,13 @@ gssd_clnt_gssd_cb(int UNUSED(fd), short UNUSED(which), void *data)
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
> @@ -461,12 +493,12 @@ gssd_clnt_krb5_cb(int UNUSED(fd), short UNUSED(which), void *data)
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
> @@ -501,6 +533,7 @@ gssd_get_clnt(struct topdir *tdi, const char *name)
>  	clp->name = clp->relpath + strlen(tdi->name) + 1;
>  	clp->krb5_fd = -1;
>  	clp->gssd_fd = -1;
> +	clp->refcount = 1;
>  
>  	TAILQ_INSERT_HEAD(&tdi->clnt_list, clp, list);
>  	return clp;
> @@ -651,7 +684,7 @@ gssd_scan_topdir(const char *name)
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

