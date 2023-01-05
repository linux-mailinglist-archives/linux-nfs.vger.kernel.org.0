Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA165F489
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 20:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjAETdx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 14:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjAETdg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 14:33:36 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CAE6452
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 11:31:21 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d15so40387923pls.6
        for <linux-nfs@vger.kernel.org>; Thu, 05 Jan 2023 11:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QiTr6GUNBEbH6MymGJ8OQkKcYvmurJan7es7FuzDCto=;
        b=m9N7G3A2fe9YiMbqU7B7dWxegJmNWd0dqenHKTrHnFgEn8gQ1PbpMSEpD+8Yrlnuty
         8EtJkeCQolbfiwn+daIqIjz2uGo5MgwRXd5trN5gfCZX+exkpm0IscXepgcR6o5xaaPE
         AVvvQLI8+tQxEzZW0cPGkA51KTXYXni61I6W3z0sOMj+1MO6mU5ezFGUaoYb5IDJ5/nC
         OS+V8SfMopqeYfHyZyZbZ6j6zdkaVFPIiMmWWC+deATG5u/Irkvw2jnSqobkCFvrHAMX
         ZEOEutnymem3HVO24Xsk5ilVKufJZm2nIZ4yXA8Ms1w8oFMgq+k1nAH1wXuULdnWpA49
         GXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiTr6GUNBEbH6MymGJ8OQkKcYvmurJan7es7FuzDCto=;
        b=ZN3hN4Zqvs7uq5nl1s+ZUU2aTUCchztj7IXvd/Rv+Xzh7YbKfcYbbS1kXSPTk9Wn21
         oytgqSsTnrMgdRiuuIgXcwjBmg4PCrBEyyosRD1dIPapJNZeGzqa8N62t3mlus73HW64
         PbZlVpDgE6eEFAQflxp7AqUZa0XiIUSC0jtZ3/G56Zy0VJ/NPBQyvzYtFD5T+WqedlUk
         VsmTUeJ0Q0wSxQhKarrF++JS5x4armWgDZlKKk5pRcVmcAB4+J7WKw8PAefsuq6esv5U
         blco9rInlXNPjrZnEqBsV+CjF8v+S4eNg0406t80gHPOMukNcBVJwcrvt3hmnPVfpDfg
         6Wfw==
X-Gm-Message-State: AFqh2koy109Hdwhi6VtMNY/l/lxU/F+1YB1NUb7HcP+TqJDf1uc337GU
        soJ5qHXpzYeo3/RenodaHnLhAlPcQJVkM+w+jmI=
X-Google-Smtp-Source: AMrXdXtDFlizCimb+BsNBRzA1v8XhVtKmd05EchrDhcMxJfSigKChxAg8b/cI8OdgvozcK8Pa/NRofOjye++mon+6Dg=
X-Received: by 2002:a17:902:bc49:b0:192:7a9d:ca49 with SMTP id
 t9-20020a170902bc4900b001927a9dca49mr2101483plz.97.1672947075844; Thu, 05 Jan
 2023 11:31:15 -0800 (PST)
MIME-Version: 1.0
References: <1671411353-31165-1-git-send-email-dai.ngo@oracle.com>
 <28572446-B32A-461F-A9C1-E60F79B985D3@oracle.com> <CAN-5tyEL1FvvCMgg=NWrHcAvLdXFKZQ_p1T8gRhH9hUoD3jPhA@mail.gmail.com>
 <667E8EAA-32BB-491F-80FE-B5A37770995E@oracle.com>
In-Reply-To: <667E8EAA-32BB-491F-80FE-B5A37770995E@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 5 Jan 2023 14:31:04 -0500
Message-ID: <CAN-5tyFbj8V9wpT-GeW4KT8+kTUtyRsdE53eMW31GBRcsg4bTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] NFSD: enhance inter-server copy cleanup
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 5, 2023 at 12:18 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jan 5, 2023, at 11:10 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Tue, Jan 3, 2023 at 11:14 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Dec 18, 2022, at 7:55 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >>>
> >>> Currently nfsd4_setup_inter_ssc returns the vfsmount of the source
> >>> server's export when the mount completes. After the copy is done
> >>> nfsd4_cleanup_inter_ssc is called with the vfsmount of the source
> >>> server and it searches nfsd_ssc_mount_list for a matching entry
> >>> to do the clean up.
> >>>
> >>> The problems with this approach are (1) the need to search the
> >>> nfsd_ssc_mount_list and (2) the code has to handle the case where
> >>> the matching entry is not found which looks ugly.
> >>>
> >>> The enhancement is instead of nfsd4_setup_inter_ssc returning the
> >>> vfsmount, it returns the nfsd4_ssc_umount_item which has the
> >>> vfsmount embedded in it. When nfsd4_cleanup_inter_ssc is called
> >>> it's passed with the nfsd4_ssc_umount_item directly to do the
> >>> clean up so no searching is needed and there is no need to handle
> >>> the 'not found' case.
> >>>
> >>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >>> ---
> >>> V2: fix compile error when CONFIG_NFSD_V4_2_INTER_SSC not defined.
> >>>   Reported by kernel test robot.
> >>
> >> Hello Dai - I've looked at this, nothing to comment on so far. I
> >> plan to go over it again sometime this week.
> >>
> >> I'd like to hear from others before applying it.
> >
> > I have looked at it and logically it seems ok to me.
>
> Thanks! May I add Reviewed-by: ?

Ok by me.
>
>
> > I have tested it
> > (sorta. i'm rarely able to finish). But I keep running into the other
> > problem (nfsd4_state_shrinker_count soft lockup that's been already
> > reported). I find it interesting that only my destination server hits
> > the problem (but not the source server). I don't believe this patch
> > has anything to do with this problem, but I found it interesting that
> > ssc testing seems to trigger it 100%.
>
> Good data point. But Mike says you can revert the delegation recall
> patches to make things stable enough to test, if you'd like to try.

I thought there was a way to disable giving out delegations (but
perhaps that's not an option) and if it were I wonder if that helps.
In the meanwhile I'll try reverting the patch Mike suggested.

>
>
> >>> fs/nfsd/nfs4proc.c      | 94 +++++++++++++++++++------------------------------
> >>> fs/nfsd/xdr4.h          |  2 +-
> >>> include/linux/nfs_ssc.h |  2 +-
> >>> 3 files changed, 38 insertions(+), 60 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >>> index b79ee65ae016..6515b00520bc 100644
> >>> --- a/fs/nfsd/nfs4proc.c
> >>> +++ b/fs/nfsd/nfs4proc.c
> >>> @@ -1295,15 +1295,15 @@ extern void nfs_sb_deactive(struct super_block *sb);
> >>> * setup a work entry in the ssc delayed unmount list.
> >>> */
> >>> static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
> >>> -             struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
> >>> +             struct nfsd4_ssc_umount_item **nsui)
> >>> {
> >>>      struct nfsd4_ssc_umount_item *ni = NULL;
> >>>      struct nfsd4_ssc_umount_item *work = NULL;
> >>>      struct nfsd4_ssc_umount_item *tmp;
> >>>      DEFINE_WAIT(wait);
> >>> +     __be32 status = 0;
> >>>
> >>> -     *ss_mnt = NULL;
> >>> -     *retwork = NULL;
> >>> +     *nsui = NULL;
> >>>      work = kzalloc(sizeof(*work), GFP_KERNEL);
> >>> try_again:
> >>>      spin_lock(&nn->nfsd_ssc_lock);
> >>> @@ -1326,12 +1326,12 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
> >>>                      finish_wait(&nn->nfsd_ssc_waitq, &wait);
> >>>                      goto try_again;
> >>>              }
> >>> -             *ss_mnt = ni->nsui_vfsmount;
> >>> +             *nsui = ni;
> >>>              refcount_inc(&ni->nsui_refcnt);
> >>>              spin_unlock(&nn->nfsd_ssc_lock);
> >>>              kfree(work);
> >>>
> >>> -             /* return vfsmount in ss_mnt */
> >>> +             /* return vfsmount in (*nsui)->nsui_vfsmount */
> >>>              return 0;
> >>>      }
> >>>      if (work) {
> >>> @@ -1339,10 +1339,11 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
> >>>              refcount_set(&work->nsui_refcnt, 2);
> >>>              work->nsui_busy = true;
> >>>              list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
> >>> -             *retwork = work;
> >>> -     }
> >>> +             *nsui = work;
> >>> +     } else
> >>> +             status = nfserr_resource;
> >>>      spin_unlock(&nn->nfsd_ssc_lock);
> >>> -     return 0;
> >>> +     return status;
> >>> }
> >>>
> >>> static void nfsd4_ssc_update_dul_work(struct nfsd_net *nn,
> >>> @@ -1371,7 +1372,7 @@ static void nfsd4_ssc_cancel_dul_work(struct nfsd_net *nn,
> >>> */
> >>> static __be32
> >>> nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>> -                    struct vfsmount **mount)
> >>> +                     struct nfsd4_ssc_umount_item **nsui)
> >>> {
> >>>      struct file_system_type *type;
> >>>      struct vfsmount *ss_mnt;
> >>> @@ -1382,7 +1383,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>>      char *ipaddr, *dev_name, *raw_data;
> >>>      int len, raw_len;
> >>>      __be32 status = nfserr_inval;
> >>> -     struct nfsd4_ssc_umount_item *work = NULL;
> >>>      struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> >>>
> >>>      naddr = &nss->u.nl4_addr;
> >>> @@ -1390,6 +1390,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>>                                       naddr->addr_len,
> >>>                                       (struct sockaddr *)&tmp_addr,
> >>>                                       sizeof(tmp_addr));
> >>> +     *nsui = NULL;
> >>>      if (tmp_addrlen == 0)
> >>>              goto out_err;
> >>>
> >>> @@ -1432,10 +1433,10 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>>              goto out_free_rawdata;
> >>>      snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
> >>>
> >>> -     status = nfsd4_ssc_setup_dul(nn, ipaddr, &work, &ss_mnt);
> >>> +     status = nfsd4_ssc_setup_dul(nn, ipaddr, nsui);
> >>>      if (status)
> >>>              goto out_free_devname;
> >>> -     if (ss_mnt)
> >>> +     if ((*nsui)->nsui_vfsmount)
> >>>              goto out_done;
> >>>
> >>>      /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
> >>> @@ -1443,15 +1444,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>>      module_put(type->owner);
> >>>      if (IS_ERR(ss_mnt)) {
> >>>              status = nfserr_nodev;
> >>> -             if (work)
> >>> -                     nfsd4_ssc_cancel_dul_work(nn, work);
> >>> +             nfsd4_ssc_cancel_dul_work(nn, *nsui);
> >>>              goto out_free_devname;
> >>>      }
> >>> -     if (work)
> >>> -             nfsd4_ssc_update_dul_work(nn, work, ss_mnt);
> >>> +     nfsd4_ssc_update_dul_work(nn, *nsui, ss_mnt);
> >>> out_done:
> >>>      status = 0;
> >>> -     *mount = ss_mnt;
> >>>
> >>> out_free_devname:
> >>>      kfree(dev_name);
> >>> @@ -1474,8 +1472,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>> */
> >>> static __be32
> >>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> >>> -                   struct nfsd4_compound_state *cstate,
> >>> -                   struct nfsd4_copy *copy, struct vfsmount **mount)
> >>> +             struct nfsd4_compound_state *cstate, struct nfsd4_copy *copy)
> >>> {
> >>>      struct svc_fh *s_fh = NULL;
> >>>      stateid_t *s_stid = &copy->cp_src_stateid;
> >>> @@ -1488,7 +1485,8 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> >>>      if (status)
> >>>              goto out;
> >>>
> >>> -     status = nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
> >>> +     status = nfsd4_interssc_connect(copy->cp_src, rqstp,
> >>> +                             &copy->ss_nsui);
> >>>      if (status)
> >>>              goto out;
> >>>
> >>> @@ -1506,61 +1504,42 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> >>> }
> >>>
> >>> static void
> >>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
> >>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *filp,
> >>>                      struct nfsd_file *dst)
> >>> {
> >>> -     bool found = false;
> >>>      long timeout;
> >>> -     struct nfsd4_ssc_umount_item *tmp;
> >>> -     struct nfsd4_ssc_umount_item *ni = NULL;
> >>>      struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
> >>>
> >>>      nfs42_ssc_close(filp);
> >>>      nfsd_file_put(dst);
> >>>      fput(filp);
> >>>
> >>> -     if (!nn) {
> >>> -             mntput(ss_mnt);
> >>> -             return;
> >>> -     }
> >>>      spin_lock(&nn->nfsd_ssc_lock);
> >>>      timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> >>> -     list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
> >>> -             if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
> >>> -                     list_del(&ni->nsui_list);
> >>> -                     /*
> >>> -                      * vfsmount can be shared by multiple exports,
> >>> -                      * decrement refcnt. If the count drops to 1 it
> >>> -                      * will be unmounted when nsui_expire expires.
> >>> -                      */
> >>> -                     refcount_dec(&ni->nsui_refcnt);
> >>> -                     ni->nsui_expire = jiffies + timeout;
> >>> -                     list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
> >>> -                     found = true;
> >>> -                     break;
> >>> -             }
> >>> -     }
> >>> +     list_del(&ni->nsui_list);
> >>> +     /*
> >>> +      * vfsmount can be shared by multiple exports,
> >>> +      * decrement refcnt. If the count drops to 1 it
> >>> +      * will be unmounted when nsui_expire expires.
> >>> +      */
> >>> +     refcount_dec(&ni->nsui_refcnt);
> >>> +     ni->nsui_expire = jiffies + timeout;
> >>> +     list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
> >>>      spin_unlock(&nn->nfsd_ssc_lock);
> >>> -     if (!found) {
> >>> -             mntput(ss_mnt);
> >>> -             return;
> >>> -     }
> >>> }
> >>>
> >>> #else /* CONFIG_NFSD_V4_2_INTER_SSC */
> >>>
> >>> static __be32
> >>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> >>> -                   struct nfsd4_compound_state *cstate,
> >>> -                   struct nfsd4_copy *copy,
> >>> -                   struct vfsmount **mount)
> >>> +                     struct nfsd4_compound_state *cstate,
> >>> +                     struct nfsd4_copy *copy)
> >>> {
> >>> -     *mount = NULL;
> >>>      return nfserr_inval;
> >>> }
> >>>
> >>> static void
> >>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
> >>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *filp,
> >>>                      struct nfsd_file *dst)
> >>> {
> >>> }
> >>> @@ -1700,7 +1679,7 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
> >>>      memcpy(dst->cp_src, src->cp_src, sizeof(struct nl4_server));
> >>>      memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
> >>>      memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
> >>> -     dst->ss_mnt = src->ss_mnt;
> >>> +     dst->ss_nsui = src->ss_nsui;
> >>> }
> >>>
> >>> static void cleanup_async_copy(struct nfsd4_copy *copy)
> >>> @@ -1749,8 +1728,8 @@ static int nfsd4_do_async_copy(void *data)
> >>>      if (nfsd4_ssc_is_inter(copy)) {
> >>>              struct file *filp;
> >>>
> >>> -             filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
> >>> -                                   &copy->stateid);
> >>> +             filp = nfs42_ssc_open(copy->ss_nsui->nsui_vfsmount,
> >>> +                             &copy->c_fh, &copy->stateid);
> >>>              if (IS_ERR(filp)) {
> >>>                      switch (PTR_ERR(filp)) {
> >>>                      case -EBADF:
> >>> @@ -1764,7 +1743,7 @@ static int nfsd4_do_async_copy(void *data)
> >>>              }
> >>>              nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
> >>>                                     false);
> >>> -             nfsd4_cleanup_inter_ssc(copy->ss_mnt, filp, copy->nf_dst);
> >>> +             nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
> >>>      } else {
> >>>              nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> >>>                                     copy->nf_dst->nf_file, false);
> >>> @@ -1790,8 +1769,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >>>                      status = nfserr_notsupp;
> >>>                      goto out;
> >>>              }
> >>> -             status = nfsd4_setup_inter_ssc(rqstp, cstate, copy,
> >>> -                             &copy->ss_mnt);
> >>> +             status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
> >>>              if (status)
> >>>                      return nfserr_offload_denied;
> >>>      } else {
> >>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> >>> index 0eb00105d845..36c3340c1d54 100644
> >>> --- a/fs/nfsd/xdr4.h
> >>> +++ b/fs/nfsd/xdr4.h
> >>> @@ -571,7 +571,7 @@ struct nfsd4_copy {
> >>>      struct task_struct      *copy_task;
> >>>      refcount_t              refcount;
> >>>
> >>> -     struct vfsmount         *ss_mnt;
> >>> +     struct nfsd4_ssc_umount_item *ss_nsui;
> >>>      struct nfs_fh           c_fh;
> >>>      nfs4_stateid            stateid;
> >>> };
> >>> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
> >>> index 75843c00f326..22265b1ff080 100644
> >>> --- a/include/linux/nfs_ssc.h
> >>> +++ b/include/linux/nfs_ssc.h
> >>> @@ -53,6 +53,7 @@ static inline void nfs42_ssc_close(struct file *filep)
> >>>      if (nfs_ssc_client_tbl.ssc_nfs4_ops)
> >>>              (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
> >>> }
> >>> +#endif
> >>>
> >>> struct nfsd4_ssc_umount_item {
> >>>      struct list_head nsui_list;
> >>> @@ -66,7 +67,6 @@ struct nfsd4_ssc_umount_item {
> >>>      struct vfsmount *nsui_vfsmount;
> >>>      char nsui_ipaddr[RPC_MAX_ADDRBUFLEN + 1];
> >>> };
> >>> -#endif
> >>>
> >>> /*
> >>> * NFS_FS
> >>> --
> >>> 2.9.5
> >>>
> >>
> >> --
> >> Chuck Lever
>
> --
> Chuck Lever
>
>
>
