Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2181F380F72
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 20:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhENSOE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 14:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhENSOD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 14:14:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888FDC061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 11:12:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id c20so20589ejm.3
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyfSEDRvaz8xARJjeQ9YkC4bJCn0TumkkHBBF8XI5yw=;
        b=rF+KBcsszxHmHWD9qPK5JTBMwxlrqsG1jP3OgAxusyZmDOPYwEECxnU57XAxGZMap3
         qlE10BfOcdmaC2FldFW4YShTMSL7EuvBP4QN1aYZu00CMlFtLoDz+PSjL2a3U6ygLJeI
         O/+ObJJsKsS7erBmBF5yk+RjEDKN8a1naKd6CqUhnh/tAsl99Aw3ROO3Yu5b8VowSbUP
         F3DNMSwn7+TPan6MgN6HkCYy3uS4FEcTd2TT6xcuZ0bspfhbLB+GaDEgfpTDb8AcJAt4
         QESoAne9HYd7YR5ItGq7sNqI3lcgjs7ENNeYpBGqOlLglErtxF2ui6hv4WxMD0XhdbAW
         xTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyfSEDRvaz8xARJjeQ9YkC4bJCn0TumkkHBBF8XI5yw=;
        b=CgdSRAy548TEZHXckHaUgeseHGUpQaMK03/rovvFsx2H19DPjOA50ij+65M1zb7gOl
         /u6mD/MlxftxoqU/MwEzfM+kmeir2qoSeHzSQhHtrHiMpO5VKhV586RBrMMzHgpqAFoo
         d0xGbYaerfFVC1xdpFBJplcLHvK7q6lfK8V9aViPvN+UxEKBGSe+3jaEBtPGbDk4ewdr
         nYRYG4e87pQIilrfePfCIlXfQSjFPLZeE8a6rdesjsDSV9KpLk5zHL6koJYUnG4cNXN4
         /PMZTc48f2mTMxuOZ7RLdxZJEZMKIGZZyKwjhKzI0VShUjMIBgPUKYi540t6ilczyAwP
         ibKg==
X-Gm-Message-State: AOAM531qcNapUTufIevvmwZi7+bpAgv0fmrVRIFZrcEom3bX5kkqS0vT
        0mIOwHZSu6FTojIttcAa6A/YrIHCUvCT/7788hM=
X-Google-Smtp-Source: ABdhPJwu/WM/DPIQPuFLIgkwDt+PBFdcYLSov5sdcYV4HcN/0KXRvBCPNaW3BbyeE00oPEVSQDs1uRJrNm3gSw+uDWY=
X-Received: by 2002:a17:906:90cf:: with SMTP id v15mr50626210ejw.432.1621015970126;
 Fri, 14 May 2021 11:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210423205946.24407-1-dai.ngo@oracle.com> <20210423205946.24407-2-dai.ngo@oracle.com>
In-Reply-To: <20210423205946.24407-2-dai.ngo@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 14 May 2021 14:12:38 -0400
Message-ID: <CAN-5tyGS9z1+So-MAiWEX-a6-qCGxzm_mW82dt4DTV2E-SBKtg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 23, 2021 at 4:59 PM Dai Ngo <dai.ngo@oracle.com> wrote:
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
>  fs/nfsd/nfs4proc.c      | 178 ++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/nfsd/nfsd.h          |   4 ++
>  fs/nfsd/nfssvc.c        |   3 +
>  include/linux/nfs_ssc.h |  20 ++++++
>  4 files changed, 201 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index dd9f38d072dd..a4b110cbcab5 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -55,6 +55,81 @@ module_param(inter_copy_offload_enable, bool, 0644);
>  MODULE_PARM_DESC(inter_copy_offload_enable,
>                  "Enable inter server to server copy offload. Default: false");
>
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +static int nfsd4_ssc_umount_timeout = 900000;          /* default to 15 mins */
> +module_param(nfsd4_ssc_umount_timeout, int, 0644);
> +MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
> +               "idle msecs before unmount export from source server");
> +
> +static void nfsd4_ssc_expire_umount(struct work_struct *work);
> +static struct nfsd4_ssc_umount nfsd4_ssc_umount;
> +
> +/* nfsd4_ssc_umount.nsu_lock must be held */
> +static void nfsd4_scc_update_umnt_timo(void)
> +{
> +       struct nfsd4_ssc_umount_item *ni = 0;
> +
> +       cancel_delayed_work(&nfsd4_ssc_umount.nsu_umount_work);
> +       if (!list_empty(&nfsd4_ssc_umount.nsu_list)) {
> +               ni = list_first_entry(&nfsd4_ssc_umount.nsu_list,
> +                       struct nfsd4_ssc_umount_item, nsui_list);
> +               nfsd4_ssc_umount.nsu_expire = ni->nsui_expire;
> +               schedule_delayed_work(&nfsd4_ssc_umount.nsu_umount_work,
> +                       ni->nsui_expire - jiffies);
> +       } else
> +               nfsd4_ssc_umount.nsu_expire = 0;
> +}
> +
> +static void nfsd4_ssc_expire_umount(struct work_struct *work)
> +{
> +       bool do_wakeup = false;
> +       struct nfsd4_ssc_umount_item *ni = 0;
> +       struct nfsd4_ssc_umount_item *tmp;
> +
> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list, nsui_list) {
> +               if (time_after(jiffies, ni->nsui_expire)) {
> +                       if (refcount_read(&ni->nsui_refcnt) > 0)
> +                               continue;
> +
> +                       /* mark being unmount */
> +                       ni->nsui_busy = true;
> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +                       mntput(ni->nsui_vfsmount);
> +                       spin_lock(&nfsd4_ssc_umount.nsu_lock);
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

Wouldn't you be exiting your iteration loop as soon as you find a
delayed item that hasn't expired? What if other items on the list have
expired?

It looks like the general design is that work for doing umount is
triggered by doing some copy, right? And then it just keeps
rescheduling itself? Shouldn't we just be using the laundrymat instead
that wakes up and goes thru the list mounts that are put to be
unmounted and does so? Bruce previously had suggested using laundrymat
for cleaning up copynotify states on the source server. But if the
existing approach works for Bruce, I'm ok with it too.

> +       }
> +       nfsd4_scc_update_umnt_timo();
> +       if (do_wakeup)
> +               wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +}
> +
> +static DECLARE_DELAYED_WORK(nfsd4, nfsd4_ssc_expire_umount);
> +
> +void nfsd4_ssc_init_umount_work(void)
> +{
> +       if (nfsd4_ssc_umount.nsu_inited)
> +               return;
> +       INIT_DELAYED_WORK(&nfsd4_ssc_umount.nsu_umount_work,
> +               nfsd4_ssc_expire_umount);
> +       INIT_LIST_HEAD(&nfsd4_ssc_umount.nsu_list);
> +       spin_lock_init(&nfsd4_ssc_umount.nsu_lock);
> +       init_waitqueue_head(&nfsd4_ssc_umount.nsu_waitq);
> +       nfsd4_ssc_umount.nsu_inited = true;
> +}
> +EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
> +#endif
> +
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>  #include <linux/security.h>
>
> @@ -1181,6 +1256,9 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>         char *ipaddr, *dev_name, *raw_data;
>         int len, raw_len;
>         __be32 status = nfserr_inval;
> +       struct nfsd4_ssc_umount_item *ni = 0;
> +       struct nfsd4_ssc_umount_item *work, *tmp;
> +       DEFINE_WAIT(wait);
>
>         naddr = &nss->u.nl4_addr;
>         tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
> @@ -1229,12 +1307,68 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>                 goto out_free_rawdata;
>         snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>
> +       work = kzalloc(sizeof(*work), GFP_KERNEL);
> +try_again:
> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list, nsui_list) {
> +               if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
> +                       continue;
> +               /* found a match */
> +               if (ni->nsui_busy) {
> +                       /*  wait - and try again */
> +                       prepare_to_wait(&nfsd4_ssc_umount.nsu_waitq, &wait,
> +                               TASK_INTERRUPTIBLE);
> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +
> +                       /* allow 20secs for mount/unmount for now - revisit */
> +                       if (signal_pending(current) ||
> +                                       (schedule_timeout(20*HZ) == 0)) {
> +                               status = nfserr_eagain;
> +                               kfree(work);
> +                               goto out_free_devname;
> +                       }
> +                       finish_wait(&nfsd4_ssc_umount.nsu_waitq, &wait);
> +                       goto try_again;
> +               }
> +               ss_mnt = ni->nsui_vfsmount;
> +               if (refcount_read(&ni->nsui_refcnt) == 0)
> +                       refcount_set(&ni->nsui_refcnt, 1);
> +               else
> +                       refcount_inc(&ni->nsui_refcnt);
> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +               kfree(work);
> +               goto out_done;
> +       }
> +       /* create new entry, set busy, insert list, clear busy after mount */
> +       if (work) {
> +               strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
> +               refcount_set(&work->nsui_refcnt, 1);
> +               work->nsui_busy = true;
> +               list_add_tail(&work->nsui_list, &nfsd4_ssc_umount.nsu_list);
> +       }
> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +
>         /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>         ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
>         module_put(type->owner);
> -       if (IS_ERR(ss_mnt))
> +       if (IS_ERR(ss_mnt)) {
> +               if (work) {
> +                       spin_lock(&nfsd4_ssc_umount.nsu_lock);
> +                       list_del(&work->nsui_list);
> +                       wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +                       kfree(work);
> +               }
>                 goto out_free_devname;
> -
> +       }
> +       if (work) {
> +               spin_lock(&nfsd4_ssc_umount.nsu_lock);
> +               work->nsui_vfsmount = ss_mnt;
> +               work->nsui_busy = false;
> +               wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +       }
> +out_done:
>         status = 0;
>         *mount = ss_mnt;
>
> @@ -1301,10 +1435,46 @@ static void
>  nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>                         struct nfsd_file *dst)
>  {
> +       bool found = false;
> +       bool resched = false;
> +       long timeout;
> +       struct nfsd4_ssc_umount_item *tmp;
> +       struct nfsd4_ssc_umount_item *ni = 0;
> +
>         nfs42_ssc_close(src->nf_file);
> -       fput(src->nf_file);
>         nfsd_file_put(dst);
> -       mntput(ss_mnt);
> +       fput(src->nf_file);
> +
> +       timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list,
> +               nsui_list) {
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
> +                       list_add_tail(&ni->nsui_list, &nfsd4_ssc_umount.nsu_list);
> +                       found = true;
> +                       break;
> +               }
> +       }
> +       if (!found) {
> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
> +               mntput(ss_mnt);
> +               return;
> +       }
> +       if (resched && !nfsd4_ssc_umount.nsu_expire) {
> +               nfsd4_ssc_umount.nsu_expire = ni->nsui_expire;
> +               schedule_delayed_work(&nfsd4_ssc_umount.nsu_umount_work,
> +                               timeout);
> +       }
> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>  }
>
>  #else /* CONFIG_NFSD_V4_2_INTER_SSC */
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 8bdc37aa2c2e..b3bf8a5f4472 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -483,6 +483,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
>  extern int nfsd4_is_junction(struct dentry *dentry);
>  extern int register_cld_notifier(void);
>  extern void unregister_cld_notifier(void);
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +extern void nfsd4_ssc_init_umount_work(void);
> +#endif
> +
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
>  {
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 6de406322106..2558db55b88b 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -322,6 +322,9 @@ static int nfsd_startup_generic(int nrservs)
>         ret = nfs4_state_start();
>         if (ret)
>                 goto out_file_cache;
> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> +       nfsd4_ssc_init_umount_work();
> +#endif
>         return 0;
>
>  out_file_cache:
> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
> index f5ba0fbff72f..1e07be2a89fa 100644
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
> @@ -52,6 +53,25 @@ static inline void nfs42_ssc_close(struct file *filep)
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
> +       struct delayed_work nsu_umount_work;
> +       spinlock_t nsu_lock;
> +       unsigned long nsu_expire;
> +       wait_queue_head_t nsu_waitq;
> +       bool nsu_inited;
> +};
> +
>  #endif
>
>  /*
> --
> 2.9.5
>
