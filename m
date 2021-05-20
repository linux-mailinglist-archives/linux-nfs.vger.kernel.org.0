Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229EA38B876
	for <lists+linux-nfs@lfdr.de>; Thu, 20 May 2021 22:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbhETUfN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 16:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbhETUfM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 May 2021 16:35:12 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D92C061763
        for <linux-nfs@vger.kernel.org>; Thu, 20 May 2021 13:33:50 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 82F3C64B9; Thu, 20 May 2021 16:33:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 82F3C64B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621542829;
        bh=NApQNJdmca1X2UCg5nYDriAo8wjKJYoqIU0w2F+jWCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sb2p/YVix9uv/VdgM5LoxaIaCaJeUzk8GA2z82LdbhJFanf8KZCxk9mki41Js/hmv
         X8XLPPnF3T7gUOSNgZKbltouGfLjTfG6B/hGOaHn4XndU6iZIAb5p8PeJU9+hi3UPG
         +3KqiyUQ0KVE8QAfaeDVu8hRtGVjVSrL6ckVofGQ=
Date:   Thu, 20 May 2021 16:33:49 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     olga.kornievskaia@gmail.com, linux-nfs@vger.kernel.org,
        trondmy@hammerspace.com, chuck.lever@oracle.com
Subject: Re: [PATCH v6 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
Message-ID: <20210520203349.GA10415@fieldses.org>
References: <20210519204421.22869-1-dai.ngo@oracle.com>
 <20210519204421.22869-2-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519204421.22869-2-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 19, 2021 at 04:44:20PM -0400, Dai Ngo wrote:
> Currently the source's export is mounted and unmounted on every
> inter-server copy operation. This patch is an enhancement to delay
> the unmount of the source export for a certain period of time to
> eliminate the mount and unmount overhead on subsequent copy operations.
> 
> After a copy operation completes, a work entry is added to the
> delayed unmount list with an expiration time. This list is serviced
> by the laundromat thread to unmount the export of the expired entries.
> Each time the export is being used again, its expiration time is
> extended and the entry is re-inserted to the tail of the list.
> 
> The unmount task and the mount operation of the copy request are
> synced to make sure the export is not unmounted while it's being
> used.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/netns.h         |   6 +++
>  fs/nfsd/nfs4proc.c      | 105 ++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/nfsd/nfs4state.c     |  71 ++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsd.h          |   4 ++
>  fs/nfsd/nfssvc.c        |   3 ++
>  include/linux/nfs_ssc.h |  14 +++++++
>  6 files changed, 199 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index a75abeb1e698..935c1028c217 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -176,6 +176,12 @@ struct nfsd_net {
>  	unsigned int             longest_chain_cachesize;
>  
>  	struct shrinker		nfsd_reply_cache_shrinker;
> +
> +	/* tracking server-to-server copy mounts */
> +	spinlock_t              nfsd_ssc_lock;
> +	struct list_head        nfsd_ssc_mount_list;
> +	wait_queue_head_t       nfsd_ssc_waitq;
> +
>  	/* utsname taken from the process that starts the server */
>  	char			nfsd_name[UNX_MAXNODENAME+1];
>  };
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f4ce93d7f26e..9fa5b0a73814 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -55,6 +55,13 @@ module_param(inter_copy_offload_enable, bool, 0644);
>  MODULE_PARM_DESC(inter_copy_offload_enable,
>  		 "Enable inter server to server copy offload. Default: false");
>  
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +static int nfsd4_ssc_umount_timeout = 900000;		/* default to 15 mins */
> +module_param(nfsd4_ssc_umount_timeout, int, 0644);
> +MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
> +		"idle msecs before unmount export from source server");
> +#endif
> +
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>  #include <linux/security.h>
>  
> @@ -1181,6 +1188,11 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>  	char *ipaddr, *dev_name, *raw_data;
>  	int len, raw_len;
>  	__be32 status = nfserr_inval;
> +	struct nfsd4_ssc_umount_item *ni = 0;
> +	struct nfsd4_ssc_umount_item *work = NULL;
> +	struct nfsd4_ssc_umount_item *tmp;
> +	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	DEFINE_WAIT(wait);
>  
>  	naddr = &nss->u.nl4_addr;
>  	tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
> @@ -1229,12 +1241,65 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>  		goto out_free_rawdata;
>  	snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>  
> +	work = kzalloc(sizeof(*work), GFP_KERNEL);
> +try_again:
> +	spin_lock(&nn->nfsd_ssc_lock);
> +	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
> +		if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
> +			continue;
> +		/* found a match */
> +		if (ni->nsui_busy) {
> +			/*  wait - and try again */
> +			prepare_to_wait(&nn->nfsd_ssc_waitq, &wait,
> +				TASK_INTERRUPTIBLE);
> +			spin_unlock(&nn->nfsd_ssc_lock);
> +
> +			/* allow 20secs for mount/unmount for now - revisit */
> +			if (signal_pending(current) ||
> +					(schedule_timeout(20*HZ) == 0)) {
> +				status = nfserr_eagain;
> +				kfree(work);
> +				goto out_free_devname;
> +			}
> +			finish_wait(&nn->nfsd_ssc_waitq, &wait);
> +			goto try_again;
> +		}
> +		ss_mnt = ni->nsui_vfsmount;
> +		refcount_inc(&ni->nsui_refcnt);
> +		spin_unlock(&nn->nfsd_ssc_lock);
> +		kfree(work);
> +		goto out_done;
> +	}
> +	/* create new entry, set busy, insert list, clear busy after mount */
> +	if (work) {
> +		strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
> +		refcount_set(&work->nsui_refcnt, 2);
> +		work->nsui_busy = true;
> +		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
> +	}
> +	spin_unlock(&nn->nfsd_ssc_lock);
> +

We try to keep functions short.  This new code looks reasonably
self-contained, could you put it in its own function?

>  	/* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>  	ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
>  	module_put(type->owner);
> -	if (IS_ERR(ss_mnt))
> +	if (IS_ERR(ss_mnt)) {
> +		if (work) {
> +			spin_lock(&nn->nfsd_ssc_lock);
> +			list_del(&work->nsui_list);
> +			wake_up_all(&nn->nfsd_ssc_waitq);
> +			spin_unlock(&nn->nfsd_ssc_lock);
> +			kfree(work);
> +		}
>  		goto out_free_devname;
> -
> +	}
> +	if (work) {
> +		spin_lock(&nn->nfsd_ssc_lock);
> +		work->nsui_vfsmount = ss_mnt;
> +		work->nsui_busy = false;
> +		wake_up_all(&nn->nfsd_ssc_waitq);
> +		spin_unlock(&nn->nfsd_ssc_lock);
> +	}


Ditto.--b.

> +out_done:
>  	status = 0;
>  	*mount = ss_mnt;
>  
> @@ -1301,10 +1366,42 @@ static void
>  nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>  			struct nfsd_file *dst)
>  {
> +	bool found = false;
> +	long timeout;
> +	struct nfsd4_ssc_umount_item *tmp;
> +	struct nfsd4_ssc_umount_item *ni = 0;
> +	struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
> +
>  	nfs42_ssc_close(src->nf_file);
> -	fput(src->nf_file);
>  	nfsd_file_put(dst);
> -	mntput(ss_mnt);
> +	fput(src->nf_file);
> +
> +	if (!nn) {
> +		mntput(ss_mnt);
> +		return;
> +	}
> +	spin_lock(&nn->nfsd_ssc_lock);
> +	timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> +	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
> +		if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
> +			list_del(&ni->nsui_list);
> +			/*
> +			 * vfsmount can be shared by multiple exports,
> +			 * decrement refcnt. If the count drops to 1 it
> +			 * will be unmounted when nsui_expire expires.
> +			 */
> +			refcount_dec(&ni->nsui_refcnt);
> +			ni->nsui_expire = jiffies + timeout;
> +			list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
> +			found = true;
> +			break;
> +		}
> +	}
> +	spin_unlock(&nn->nfsd_ssc_lock);
> +	if (!found) {
> +		mntput(ss_mnt);
> +		return;
> +	}

Ditto here, let's keep nfsd4_cleanup_inter_ssc short and call out to
this new code.

--b.

>  }
>  
>  #else /* CONFIG_NFSD_V4_2_INTER_SSC */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b517a8794400..2484b59a3c29 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -44,6 +44,7 @@
>  #include <linux/jhash.h>
>  #include <linux/string_helpers.h>
>  #include <linux/fsnotify.h>
> +#include <linux/nfs_ssc.h>
>  #include "xdr4.h"
>  #include "xdr4cb.h"
>  #include "vfs.h"
> @@ -5457,6 +5458,69 @@ static bool state_expired(struct laundry_time *lt, time64_t last_refresh)
>  	return false;
>  }
>  
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +void nfsd4_ssc_init_umount_work(struct nfsd_net *nn)
> +{
> +	spin_lock_init(&nn->nfsd_ssc_lock);
> +	INIT_LIST_HEAD(&nn->nfsd_ssc_mount_list);
> +	init_waitqueue_head(&nn->nfsd_ssc_waitq);
> +}
> +EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
> +
> +/*
> + * This is called when nfsd is being shutdown, after all inter_ssc
> + * cleanup were done, to destroy the ssc delayed unmount list.
> + */
> +static void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn)
> +{
> +	struct nfsd4_ssc_umount_item *ni = 0;
> +	struct nfsd4_ssc_umount_item *tmp;
> +
> +	spin_lock(&nn->nfsd_ssc_lock);
> +	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
> +		list_del(&ni->nsui_list);
> +		spin_unlock(&nn->nfsd_ssc_lock);
> +		mntput(ni->nsui_vfsmount);
> +		kfree(ni);
> +		spin_lock(&nn->nfsd_ssc_lock);
> +	}
> +	spin_unlock(&nn->nfsd_ssc_lock);
> +}
> +
> +static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
> +{
> +	bool do_wakeup = false;
> +	struct nfsd4_ssc_umount_item *ni = 0;
> +	struct nfsd4_ssc_umount_item *tmp;
> +
> +	spin_lock(&nn->nfsd_ssc_lock);
> +	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
> +		if (time_after(jiffies, ni->nsui_expire)) {
> +			if (refcount_read(&ni->nsui_refcnt) > 1)
> +				continue;
> +
> +			/* mark being unmount */
> +			ni->nsui_busy = true;
> +			spin_unlock(&nn->nfsd_ssc_lock);
> +			mntput(ni->nsui_vfsmount);
> +			spin_lock(&nn->nfsd_ssc_lock);
> +
> +			/* waiters need to start from begin of list */
> +			list_del(&ni->nsui_list);
> +			kfree(ni);
> +
> +			/* wakeup ssc_connect waiters */
> +			do_wakeup = true;
> +			continue;
> +		}
> +		break;
> +	}
> +	if (do_wakeup)
> +		wake_up_all(&nn->nfsd_ssc_waitq);
> +	spin_unlock(&nn->nfsd_ssc_lock);
> +}
> +#endif
> +
>  static time64_t
>  nfs4_laundromat(struct nfsd_net *nn)
>  {
> @@ -5568,6 +5632,10 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		list_del_init(&nbl->nbl_lru);
>  		free_blocked_lock(nbl);
>  	}
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +	/* service the server-to-server copy delayed unmount list */
> +	nfsd4_ssc_expire_umount(nn);
> +#endif
>  out:
>  	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>  }
> @@ -7486,6 +7554,9 @@ nfs4_state_shutdown_net(struct net *net)
>  
>  	nfsd4_client_tracking_exit(net);
>  	nfs4_state_destroy_net(net);
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +	nfsd4_ssc_shutdown_umount(nn);
> +#endif
>  }
>  
>  void
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 14dbfa75059d..9664303afdaf 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -484,6 +484,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
>  extern int nfsd4_is_junction(struct dentry *dentry);
>  extern int register_cld_notifier(void);
>  extern void unregister_cld_notifier(void);
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
> +#endif
> +
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
>  {
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index dd5d69921676..ccb59e91011b 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -403,6 +403,9 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
>  	if (ret)
>  		goto out_filecache;
>  
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +	nfsd4_ssc_init_umount_work(nn);
> +#endif
>  	nn->nfsd_net_up = true;
>  	return 0;
>  
> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
> index f5ba0fbff72f..222ae8883e85 100644
> --- a/include/linux/nfs_ssc.h
> +++ b/include/linux/nfs_ssc.h
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/nfs_fs.h>
> +#include <linux/sunrpc/svc.h>
>  
>  extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
>  
> @@ -52,6 +53,19 @@ static inline void nfs42_ssc_close(struct file *filep)
>  	if (nfs_ssc_client_tbl.ssc_nfs4_ops)
>  		(*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>  }
> +
> +struct nfsd4_ssc_umount_item {
> +	struct list_head nsui_list;
> +	bool nsui_busy;
> +	/*
> +	 * nsui_refcnt inited to 2, 1 on list and 1 for consumer. Entry
> +	 * is removed when refcnt drops to 1 and nsui_expire expires.
> +	 */
> +	refcount_t nsui_refcnt;
> +	unsigned long nsui_expire;
> +	struct vfsmount *nsui_vfsmount;
> +	char nsui_ipaddr[RPC_MAX_ADDRBUFLEN];
> +};
>  #endif
>  
>  /*
> -- 
> 2.9.5
