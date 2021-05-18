Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1B1387E48
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 19:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351059AbhERRS2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 13:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238824AbhERRS2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 13:18:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C3CC061573
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 10:17:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h16so12122383edr.6
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxuQ/mvfQ0pPmWpLApykzmf2gqVQ4pNhb4e2H2Kj8bU=;
        b=uAFMKENJXHscr/Zlr0ZLLX/9ZXU6UbE12Ghts/4W1ELKKDTXWmMRZe5evlwR+Z0RmF
         zVwYwy8lwsPwtsZ+jeefTfJnufXXeuwUYtVzJ2he43Zg73/H7Vk8Su3eniIQ+Kxj58Nu
         qohPGelTUnzdbVsg+wW39IY0uPL0H+FsVRSSEPUvvVJkjy15MS7uEtZCDfb0s1pvFeGw
         12qFrC2Ged7xdPAZyZSzV2QsaRDrfOVWKbOF4qyfe79Ay0DDEoG990Xm9upq8LBz5reB
         7vxp+o7vWGOcvqbbW/7Wvb0mxT4HzUda2+unwjN3ooSJk9Z5xV6IYwUN+P1iw7TO8yU+
         unWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxuQ/mvfQ0pPmWpLApykzmf2gqVQ4pNhb4e2H2Kj8bU=;
        b=tc0dJdMthNqIyCPYuKtzUYeXLixhl69N3fI8SPfEojoyZZ0gNUfQ/T3njFu1LHBXw0
         9V0OsNGJq3ayRspdIGCMVIJyHLF71bBQc10Ok5SI9hYZBzxHPcR+8wgNXvVX7/xcDoOK
         cPSIqZRQirjyoQWQv8sBxqCoLbgwyv+vycalPOwAK4I7X2NawGfPz/tN0c/V42+Vxwrf
         1hd4j+pYrLeRepRN0K2iGUe7PgDg93cJRJ/wXwVkcFvx3Nzq/Odty8H0PAB/4h6wPwDa
         YUu0TQCDCH6bW5sjRICFuJKs01Y9D492KdCkWL950J93NHew0rc0meFZFiXbEBB5Jpi7
         lUIA==
X-Gm-Message-State: AOAM532b98qO3m0xAXqqaqLI5S42JxaNPZQ02yVzmaC9+NuCBayXTZLB
        T0SM/4Ob2mX1BLmnNTWy7Mco1EQzbrn4pDPLEXk=
X-Google-Smtp-Source: ABdhPJyYInhXi/45q9lZemWiaK2a5UmrzU10XWL/T/soAKbAlLOXmyu22HOhxce2AAr8NpeAt/hJtVSpQQ/szTzGg3Q=
X-Received: by 2002:a05:6402:354b:: with SMTP id f11mr8433184edd.139.1621358227555;
 Tue, 18 May 2021 10:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210517224330.9201-1-dai.ngo@oracle.com> <20210517224330.9201-2-dai.ngo@oracle.com>
In-Reply-To: <20210517224330.9201-2-dai.ngo@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 18 May 2021 13:16:56 -0400
Message-ID: <CAN-5tyGYhmy_dgKV_7xuPFJjyY_wsjDcun_TrDK_vidmVG1ZXg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dai,

General review comments inline

On Mon, May 17, 2021 at 6:43 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>
> Currently the source's export is mounted and unmounted on every
> inter-server copy operation. This patch is an enhancement to delay
> the unmount of the source export for a certain period of time to
> eliminate the mount and unmount overhead on subsequent copy operations.
>
> After a copy operation completes, a delayed task is scheduled to
> unmount the export after a configurable idle time. Each time the
> export is being used again, its expire time is extended to allow
> the export to remain mounted.
>
> The unmount task and the mount operation of the copy request are
> synced to make sure the export is not unmounted while it's being
> used.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/netns.h         |   5 ++
>  fs/nfsd/nfs4proc.c      | 216 +++++++++++++++++++++++++++++++++++++++++++++++-
>  fs/nfsd/nfs4state.c     |   8 ++
>  fs/nfsd/nfsd.h          |   6 ++
>  fs/nfsd/nfssvc.c        |   3 +
>  include/linux/nfs_ssc.h |  16 ++++
>  6 files changed, 250 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index c330f5bd0cf3..6018e5050cb4 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -21,6 +21,7 @@
>
>  struct cld_net;
>  struct nfsd4_client_tracking_ops;
> +struct nfsd4_ssc_umount;
>
>  enum {
>         /* cache misses due only to checksum comparison failures */
> @@ -176,6 +177,10 @@ struct nfsd_net {
>         unsigned int             longest_chain_cachesize;
>
>         struct shrinker         nfsd_reply_cache_shrinker;
> +
> +       spinlock_t              nfsd_ssc_lock;
> +       struct nfsd4_ssc_umount *nfsd_ssc_umount;
> +
>         /* utsname taken from the process that starts the server */
>         char                    nfsd_name[UNX_MAXNODENAME+1];
>  };
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index dd9f38d072dd..892ad72d87ae 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -55,6 +55,99 @@ module_param(inter_copy_offload_enable, bool, 0644);
>  MODULE_PARM_DESC(inter_copy_offload_enable,
>                  "Enable inter server to server copy offload. Default: false");
>
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +static int nfsd4_ssc_umount_timeout = 900000;          /* default to 15 mins */
> +module_param(nfsd4_ssc_umount_timeout, int, 0644);
> +MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
> +               "idle msecs before unmount export from source server");
> +
> +void nfsd4_ssc_expire_umount(struct nfsd_net *nn)

Why should this be in nfs4proc.c when it's used in nfs4state.c only?

> +{
> +       bool do_wakeup = false;
> +       struct nfsd4_ssc_umount_item *ni = 0;
> +       struct nfsd4_ssc_umount_item *tmp;
> +       struct nfsd4_ssc_umount *nu;
> +
> +       spin_lock(&nn->nfsd_ssc_lock);
> +       if (!nn->nfsd_ssc_umount) {
> +               spin_unlock(&nn->nfsd_ssc_lock);
> +               return;
> +       }
> +       nu = nn->nfsd_ssc_umount;
> +       list_for_each_entry_safe(ni, tmp, &nu->nsu_list, nsui_list) {
> +               if (time_after(jiffies, ni->nsui_expire)) {
> +                       if (refcount_read(&ni->nsui_refcnt) > 0)
> +                               continue;
> +
> +                       /* mark being unmount */
> +                       ni->nsui_busy = true;
> +                       spin_unlock(&nn->nfsd_ssc_lock);
> +                       mntput(ni->nsui_vfsmount);
> +                       spin_lock(&nn->nfsd_ssc_lock);
> +
> +                       /* waiters need to start from begin of list */
> +                       list_del(&ni->nsui_list);
> +                       kfree(ni);
> +
> +                       /* wakeup ssc_connect waiters */
> +                       do_wakeup = true;
> +                       continue;
> +               }
> +               break;

mnt1, mnt2, mnt3  added all at the same time. mnt1, mnt3 only used
once during the expiration time. mnt2 is being used continuously.
expiration time comes. delayed mnt1 is processed. mnt2 is next on the
list and it's not expired so code quits. mnt3 will not be umounted
until mnt2 expires. I think the break is wrong.

> +       }
> +       if (!list_empty(&nu->nsu_list)) {
> +               ni = list_first_entry(&nu->nsu_list,
> +                       struct nfsd4_ssc_umount_item, nsui_list);
> +               nu->nsu_expire = ni->nsui_expire;
> +       } else
> +               nu->nsu_expire = 0;
> +
> +       if (do_wakeup)
> +               wake_up_all(&nu->nsu_waitq);
> +       spin_unlock(&nn->nfsd_ssc_lock);
> +}
> +
> +/*
> + * This is called when nfsd is being shutdown, after all inter_ssc
> + * cleanup were done, to destroy the ssc delayed unmount list.
> + */
> +void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn)
> +{
> +       struct nfsd4_ssc_umount_item *ni = 0;
> +       struct nfsd4_ssc_umount_item *tmp;
> +       struct nfsd4_ssc_umount *nu;
> +
> +       spin_lock(&nn->nfsd_ssc_lock);
> +       if (!nn->nfsd_ssc_umount) {
> +               spin_unlock(&nn->nfsd_ssc_lock);
> +               return;
> +       }
> +       nu = nn->nfsd_ssc_umount;
> +       nn->nfsd_ssc_umount = 0;
> +       list_for_each_entry_safe(ni, tmp, &nu->nsu_list, nsui_list) {
> +               list_del(&ni->nsui_list);
> +               spin_unlock(&nn->nfsd_ssc_lock);
> +               mntput(ni->nsui_vfsmount);
> +               kfree(ni);
> +               spin_lock(&nn->nfsd_ssc_lock);
> +       }
> +       spin_unlock(&nn->nfsd_ssc_lock);
> +       kfree(nu);

General question to maybe Bruce: can nfsd_net go away while a compound
is using it ? I hope not.  I can't quite think thru the scenario where
we started the async copy task but then somehow nfsd_net is going away
before async_copy is done and if there is anything we need to take
care of. I think the net shutdown would not find anything to free so
it would just return. And the copy's cleanup would not find a nfsd_net
and so it would right away unmount. This is more of thinking out loud
but I'd like somebody else to confirm I'm correct that we are OK here.

> +}
> +
> +void nfsd4_ssc_init_umount_work(struct nfsd_net *nn)
> +{
> +       nn->nfsd_ssc_umount = kzalloc(sizeof(struct nfsd4_ssc_umount),
> +                                       GFP_KERNEL);
> +       if (!nn->nfsd_ssc_umount)
> +               return;
> +       spin_lock_init(&nn->nfsd_ssc_lock);
> +       INIT_LIST_HEAD(&nn->nfsd_ssc_umount->nsu_list);
> +       init_waitqueue_head(&nn->nfsd_ssc_umount->nsu_waitq);
> +}
> +EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
> +#endif
> +
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>  #include <linux/security.h>
>
> @@ -1181,6 +1274,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>         char *ipaddr, *dev_name, *raw_data;
>         int len, raw_len;
>         __be32 status = nfserr_inval;
> +       struct nfsd4_ssc_umount_item *ni = 0;
> +       struct nfsd4_ssc_umount_item *work = NULL;
> +       struct nfsd4_ssc_umount_item *tmp;
> +       struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> +       struct nfsd4_ssc_umount *nu;
> +       DEFINE_WAIT(wait);
>
>         naddr = &nss->u.nl4_addr;
>         tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
> @@ -1229,12 +1328,76 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>                 goto out_free_rawdata;
>         snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>
> +       work = kzalloc(sizeof(*work), GFP_KERNEL);
> +try_again:
> +       spin_lock(&nn->nfsd_ssc_lock);
> +       if (!nn->nfsd_ssc_umount) {
> +               spin_unlock(&nn->nfsd_ssc_lock);
> +               kfree(work);
> +               work = NULL;
> +               goto skip_dul;
> +       }
> +       nu = nn->nfsd_ssc_umount;
> +       list_for_each_entry_safe(ni, tmp, &nu->nsu_list, nsui_list) {
> +               if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
> +                       continue;
> +               /* found a match */
> +               if (ni->nsui_busy) {
> +                       /*  wait - and try again */
> +                       prepare_to_wait(&nu->nsu_waitq, &wait,
> +                               TASK_INTERRUPTIBLE);
> +                       spin_unlock(&nn->nfsd_ssc_lock);
> +
> +                       /* allow 20secs for mount/unmount for now - revisit */
> +                       if (signal_pending(current) ||
> +                                       (schedule_timeout(20*HZ) == 0)) {
> +                               status = nfserr_eagain;
> +                               kfree(work);
> +                               goto out_free_devname;
> +                       }
> +                       finish_wait(&nu->nsu_waitq, &wait);
> +                       goto try_again;
> +               }
> +               ss_mnt = ni->nsui_vfsmount;
> +               if (refcount_read(&ni->nsui_refcnt) == 0)
> +                       refcount_set(&ni->nsui_refcnt, 1);
> +               else
> +                       refcount_inc(&ni->nsui_refcnt);
> +               spin_unlock(&nn->nfsd_ssc_lock);
> +               kfree(work);
> +               goto out_done;
> +       }
> +       /* create new entry, set busy, insert list, clear busy after mount */
> +       if (work) {
> +               strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
> +               refcount_set(&work->nsui_refcnt, 1);
> +               work->nsui_busy = true;
> +               list_add_tail(&work->nsui_list, &nu->nsu_list);
> +       }
> +       spin_unlock(&nn->nfsd_ssc_lock);
> +skip_dul:
> +
>         /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>         ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
>         module_put(type->owner);
> -       if (IS_ERR(ss_mnt))
> +       if (IS_ERR(ss_mnt)) {
> +               if (work) {
> +                       spin_lock(&nn->nfsd_ssc_lock);
> +                       list_del(&work->nsui_list);
> +                       wake_up_all(&nu->nsu_waitq);
> +                       spin_unlock(&nn->nfsd_ssc_lock);
> +                       kfree(work);
> +               }
>                 goto out_free_devname;
> -
> +       }
> +       if (work) {
> +               spin_lock(&nn->nfsd_ssc_lock);
> +               work->nsui_vfsmount = ss_mnt;
> +               work->nsui_busy = false;
> +               wake_up_all(&nu->nsu_waitq);
> +               spin_unlock(&nn->nfsd_ssc_lock);
> +       }
> +out_done:
>         status = 0;
>         *mount = ss_mnt;
>
> @@ -1301,10 +1464,55 @@ static void
>  nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>                         struct nfsd_file *dst)
>  {
> +       bool found = false;
> +       bool resched = false;
> +       long timeout;
> +       struct nfsd4_ssc_umount_item *tmp;
> +       struct nfsd4_ssc_umount_item *ni = 0;
> +       struct nfsd4_ssc_umount *nu;
> +       struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
> +
>         nfs42_ssc_close(src->nf_file);
> -       fput(src->nf_file);
>         nfsd_file_put(dst);
> -       mntput(ss_mnt);
> +       fput(src->nf_file);
> +
> +       if (!nn) {
> +               mntput(ss_mnt);
> +               return;
> +       }
> +       spin_lock(&nn->nfsd_ssc_lock);
> +       if (!nn->nfsd_ssc_umount) {
> +               /* delayed unmount list not setup */
> +               spin_unlock(&nn->nfsd_ssc_lock);
> +               mntput(ss_mnt);
> +               return;
> +       }
> +       nu = nn->nfsd_ssc_umount;
> +       timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> +       list_for_each_entry_safe(ni, tmp, &nu->nsu_list, nsui_list) {
> +               if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
> +                       list_del(&ni->nsui_list);
> +                       /*
> +                        * vfsmount can be shared by multiple exports,
> +                        * decrement refcnt and schedule delayed task
> +                        * if it drops to 0.
> +                        */
> +                       if (refcount_dec_and_test(&ni->nsui_refcnt))
> +                               resched = true;
> +                       ni->nsui_expire = jiffies + timeout;
> +                       list_add_tail(&ni->nsui_list, &nu->nsu_list);
> +                       found = true;
> +                       break;
> +               }
> +       }
> +       if (!found) {
> +               spin_unlock(&nn->nfsd_ssc_lock);
> +               mntput(ss_mnt);
> +               return;
> +       }
> +       if (resched && !nu->nsu_expire)
> +               nu->nsu_expire = ni->nsui_expire;
> +       spin_unlock(&nn->nfsd_ssc_lock);
>  }
>
>  #else /* CONFIG_NFSD_V4_2_INTER_SSC */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 97447a64bad0..0cdc898f06c9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5459,6 +5459,11 @@ nfs4_laundromat(struct nfsd_net *nn)
>                 list_del_init(&nbl->nbl_lru);
>                 free_blocked_lock(nbl);
>         }
> +
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +       /* service the inter-copy delayed unmount list */
> +       nfsd4_ssc_expire_umount(nn);
> +#endif
>  out:
>         new_timeo = max_t(time64_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>         return new_timeo;
> @@ -7398,6 +7403,9 @@ nfs4_state_shutdown_net(struct net *net)
>
>         nfsd4_client_tracking_exit(net);
>         nfs4_state_destroy_net(net);
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +       nfsd4_ssc_shutdown_umount(nn);
> +#endif
>         mntput(nn->nfsd_mnt);
>  }
>
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 8bdc37aa2c2e..cf86d9010974 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -483,6 +483,12 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
>  extern int nfsd4_is_junction(struct dentry *dentry);
>  extern int register_cld_notifier(void);
>  extern void unregister_cld_notifier(void);
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
> +extern void nfsd4_ssc_expire_umount(struct nfsd_net *nn);
> +extern void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn);
> +#endif
> +
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
>  {
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 6de406322106..ce89a8fe07ff 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -403,6 +403,9 @@ static int nfsd_startup_net(int nrservs, struct net *net, const struct cred *cre
>         if (ret)
>                 goto out_filecache;
>
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +       nfsd4_ssc_init_umount_work(nn);
> +#endif
>         nn->nfsd_net_up = true;
>         return 0;
>
> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
> index f5ba0fbff72f..18afe62988b5 100644
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
> @@ -52,6 +53,21 @@ static inline void nfs42_ssc_close(struct file *filep)
>         if (nfs_ssc_client_tbl.ssc_nfs4_ops)
>                 (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>  }
> +
> +struct nfsd4_ssc_umount_item {
> +       struct list_head nsui_list;
> +       bool nsui_busy;
> +       refcount_t nsui_refcnt;
> +       unsigned long nsui_expire;
> +       struct vfsmount *nsui_vfsmount;
> +       char nsui_ipaddr[RPC_MAX_ADDRBUFLEN];
> +};
> +
> +struct nfsd4_ssc_umount {
> +       struct list_head nsu_list;
> +       unsigned long nsu_expire;
> +       wait_queue_head_t nsu_waitq;
> +};
>  #endif
>
>  /*
> --
> 2.9.5
>
