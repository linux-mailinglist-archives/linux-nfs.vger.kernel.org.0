Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA6211612E
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2019 09:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfLHIlm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Dec 2019 03:41:42 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39207 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfLHIll (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Dec 2019 03:41:41 -0500
Received: by mail-il1-f194.google.com with SMTP id a7so10027724ild.6
        for <linux-nfs@vger.kernel.org>; Sun, 08 Dec 2019 00:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JzW9qT/P4OC6/hYb/dvE3Iq9a6LzONnRUbuoGuMNr4s=;
        b=1ibvLZaeuUEGc9862huqAgPnILWY15NbxZ41r+mFzdVrDh2rY2enBx77QbrZPlidOf
         f/G17+FgGXRQxmzGBjKI2KnNMYJv8vfTYzXnR2kmK3KQaulmD8oryp+AVsqGFLEjkF5R
         bMlQ+UmBij4VV4jf7IhZACu/vPWhQeZE1ZRCkXu33L1zD0gyQCuSyD/lqn+GZhbawx1E
         rIePZJcLGfhqKG8RNtiQWHdIy3/DJlYGBa71EbnXtjb0DQxbFxEqkyfHPZiZ3YyGGMfQ
         XysJiNyU5AsWhMAs4k+B2/9VggFVX2/mhKw9wNc1Ob97+ago4CnvCSHJ9uyry4Cqmm8U
         E71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JzW9qT/P4OC6/hYb/dvE3Iq9a6LzONnRUbuoGuMNr4s=;
        b=Q+X295WIAQsQsB+Kdlfyn07lJHUUNHNjRY3yAPtyhvQkDhdUZPuzaaH8Lc/PWg8nPz
         SgR+s+81JB1bmfQYJ95W1q8VaWRYquWbhwqUQz/5jrqarWaRMrZEVeGnUsrsnsq2T+Nh
         UtjKwMhcebtol6o2HH0CzzgWGN/r//AYhLT4T4duK2dfDG+La3x/j7pdZT7I1lrxBSe3
         WjaADMgiznhez3NWROoWA2xvxCg1IdUrGQG11kw9aelyx4AqhQJ8cFw7y6aizJJnFmEf
         4Etc+WytenqyAEpaF1x0IHsvTJF1jGC4NGv8QhefKE52wVZeb+YU1kfAF7LvrQ7PoT3v
         Jyjw==
X-Gm-Message-State: APjAAAU+SWbpM6ly85tHlDzTf0qNl4w1fqLHvCS1ftCDSktfWKLdIimh
        Mj2puMNFKlmQl6OixjJ/V4ywYqMAhjnXcexuJgbW7g==
X-Google-Smtp-Source: APXvYqyOvMLq2TWORsu5O70bnNXMOmnhLZZKhTa5Oa1a7eux5z7qvBSN/2HsUN87burw6fiU/BhyDFC83MtMZbuVJyo=
X-Received: by 2002:a92:906:: with SMTP id y6mr22672165ilg.157.1575794500248;
 Sun, 08 Dec 2019 00:41:40 -0800 (PST)
MIME-Version: 1.0
References: <1568142147-21974-1-git-send-email-alex@zadara.com> <20191205160015.GC22402@fieldses.org>
In-Reply-To: <20191205160015.GC22402@fieldses.org>
From:   Alex Lyakas <alex@zadara.com>
Date:   Sun, 8 Dec 2019 10:41:29 +0200
Message-ID: <CAOcd+r272sRYo==owcG90WT3MwrqWXJkSu7UADegmfPQWG2K3A@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: provide a procfs entry to release stateids of a
 particular local filesystem
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, Shyam Kaushik <shyam@zadara.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

Thank you reviewing the patch.


On Thu, Dec 5, 2019 at 6:00 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Sep 10, 2019 at 10:02:27PM +0300, Alex Lyakas wrote:
> > This patch addresses the following issue:
> > - Create two local file systems FS1 and FS2 on the server machine S.
> > - Export both FS1 and FS2 through nfsd to the same nfs client,
> >   running on client machine C.
> > - On C, mount both exported file systems and start writing files
> >   to both of them.
> > - After few minutes, on server machine S, un-export FS1 only.
> > - Do not unmount FS1 on the client machine C prior to un-exporting.
> > - Also, FS2 remains exported to C.
> > - Now we want to unmount FS1 on the server machine S, but we fail,
> >   because there are still open files on FS1 held by nfsd.
> >
> > Debugging this issue showed the following root cause:
> > there is a nfs4_client entry for the client C.
> > This entry has two nfs4_openowners, for FS1 and FS2,
> > although FS1 was un-exported. Looking at the stateids of both openowners,
> > we see that they have stateids of kind NFS4_OPEN_STID,
> > and each stateid is holding a nfs4_file. The reason we cannot unmount FS1,
> > is because we still have an openowner for FS1,
> > holding open-stateids, which hold open files on FS1.
> >
> > The laundromat doesn't help in this case,
> > because it can only decide per-nfs4_client that it should be purged.
> > But in this case, since FS2 is still exported to C,
> > there is no reason to purge the nfs4_client.
> >
> > This situation remains until we un-export FS2 as well.
> > Then the whole nfs4_client is purged, and all the files get closed,
> > and we can unmount both FS1 and FS2.
> >
> > This patch allows user-space to tell nfsd to release stateids
> > of a particular local filesystem. After that, it is possible
> > to unmount the local filesystem.
> >
> > This patch is based on kernel 4.14.99, which we currently use.
> >
> > Signed-off-by: Alex Lyakas <alex@zadara.com>
> > ---
> >  fs/nfsd/nfs4state.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  fs/nfsd/nfsctl.c    |   1 +
> >  fs/nfsd/state.h     |   2 +
> >  3 files changed, 147 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 3cf0b2e..6bd593d5 100755
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6481,13 +6481,13 @@ struct nfs4_client_reclaim *
> >       return nfs_ok;
> >  }
> >
> > -#ifdef CONFIG_NFSD_FAULT_INJECTION
> >  static inline void
> >  put_client(struct nfs4_client *clp)
> >  {
> >       atomic_dec(&clp->cl_refcount);
>
> Note the client reference counting has changed upstream, renaming this
> refcount to cl_rpc_users and introducing a second cl_ref.  I'm not sure
> the fault injection code's use of this reference count was ever really
> completely correct, this will need a closer review.

As I mentioned in the original patch
https://patchwork.kernel.org/patch/11107525/
the fault injection code had an issue with openowner's refcount. This
is addressed by the current patch.
However, as I also mentioned, with the current patch we still see
something that looks like a reproducible memory corruption in the iSER
initiator. Not sure how this is related, but the corruption happens
always in the same place, which suggests that the current patch only
uncovers an existing issue. We were hoping that community review of
this patch would help.

Regarding the upstream kernel, it is a significant effort for us to
test and provide patches for the upstream kernel. This patch is based
on 4.14.99, which is a long-term kernel.

>
> >  }
> >
> > +#ifdef CONFIG_NFSD_FAULT_INJECTION
> >  static struct nfs4_client *
> >  nfsd_find_client(struct sockaddr_storage *addr, size_t addr_size)
> >  {
> > @@ -6811,6 +6811,7 @@ static u64 nfsd_foreach_client_lock(struct nfs4_client *clp, u64 max,
> >
> >       return count;
> >  }
> > +#endif /* CONFIG_NFSD_FAULT_INJECTION */
> >
> >  static void
> >  nfsd_reap_openowners(struct list_head *reaplist)
> > @@ -6826,6 +6827,7 @@ static u64 nfsd_foreach_client_lock(struct nfs4_client *clp, u64 max,
> >       }
> >  }
> >
> > +#ifdef CONFIG_NFSD_FAULT_INJECTION
> >  u64
> >  nfsd_inject_forget_client_openowners(struct sockaddr_storage *addr,
> >                                    size_t addr_size)
> > @@ -7071,6 +7073,147 @@ static u64 nfsd_find_all_delegations(struct nfs4_client *clp, u64 max,
> >  }
> >  #endif /* CONFIG_NFSD_FAULT_INJECTION */
> >
> > +
> > +/*
> > + * For a particular nfs4_client attempts to release the stateids
> > + * that have open files on the specified superblock.
> > + */
> > +static void
> > +nfs4_release_client_stateids(struct super_block *sb,
> > +                             struct nfs4_client *clp, const char *cl_addr,
> > +                             struct list_head *oo_reaplist,
> > +                             unsigned int *n_openowners)
> > +{
> > +     struct nfs4_openowner *oo = NULL, *oo_next = NULL;
> > +
> > +     spin_lock(&clp->cl_lock);
> > +     list_for_each_entry_safe(oo, oo_next, &clp->cl_openowners,
> > +                                                     oo_perclient) {
> > +             struct nfs4_ol_stateid *stp = NULL;
> > +             bool found_my_sb = false, found_other_sb = false;
> > +             struct super_block *other_sb = NULL;
> > +
> > +             pr_debug(" Openowner %p %.*s\n", oo, oo->oo_owner.so_owner.len,
> > +                          oo->oo_owner.so_owner.data);
> > +             pr_debug(" oo_close_lru=%s oo_last_closed_stid=%p refcnt=%d so_is_open_owner=%u\n",
> > +                          list_empty(&oo->oo_close_lru) ? "N" : "Y",
> > +                          oo->oo_last_closed_stid,
> > +                          atomic_read(&oo->oo_owner.so_count),
> > +                          oo->oo_owner.so_is_open_owner);
>
> There's a ton of debugging printk's, understandable for development code
> but when posting it'd be helpful to pare this down to the ones that you
> think will be most useful in the field.
>
I was hoping to leave them all, as they are all pr_debug, which may
not even be compiled in, to my understanding.

> > +
> > +             list_for_each_entry(stp, &oo->oo_owner.so_stateids,
> > +                                                     st_perstateowner) {
> > +                     struct nfs4_file *fp = NULL;
> > +                     struct file *filp = NULL;
> > +                     struct super_block *f_sb = NULL;
> > +
> > +                     if (stp->st_stid.sc_file == NULL)
> > +                             continue;
> > +
> > +                     fp = stp->st_stid.sc_file;
> > +                     filp = find_any_file(fp);
> > +                     if (filp != NULL)
> > +                             f_sb = file_inode(filp)->i_sb;
> > +                     pr_debug("   filp=%p sb=%p my_sb=%p\n", filp, f_sb, sb);
> > +                     if (f_sb == sb) {
> > +                             found_my_sb = true;
> > +                     } else {
> > +                             found_other_sb = true;
> > +                             other_sb = f_sb;
> > +                     }
> > +                     if (filp != NULL)
> > +                             fput(filp);
> > +             }
> > +
> > +             /* openowner does not have files from needed fs, skip it */
> > +             if (!found_my_sb)
> > +                     continue;
> > +
> > +             /*
> > +              * we do not expect same openowhner having open files
> > +              * from more than one fs. but if it happens, we cannot
> > +              * release this openowner.
> > +              */
>
> The linux client may not do that, but I don't see any requirement in the
> protocol that openowners be per-filesystem, so I think we have to handle
> this case.  Is there a reason you think it's not safe to free individual
> stateids?
My patch was modelled after "nfsd_inject_forget_client_openowners",
which releases openowners. If you we saying that openowners can cross
different file systems, then, I agree, this needs to be handled.


>
> > +             if (found_other_sb) {
> > +                     pr_warn(" client=%p/%s openowner %p %.*s has files from sb=%p but also from sb=%p, skipping it!\n",
> > +                                 clp, cl_addr, oo, oo->oo_owner.so_owner.len,
> > +                                 oo->oo_owner.so_owner.data, sb, other_sb);
> > +                     continue;
> > +             }
> > +
> > +             /*
> > +              * Each OPEN stateid holds a refcnt on the openowner
> > +              * (and LOCK stateid holds a refcnt on the lockowner).
> > +              * This refcnt is dropped when nfs4_free_ol_stateid is called,
> > +              * which calls nfs4_put_stateowner. The last refcnt drop
> > +              * unhashes and frees the openowner. As a result,
> > +              * after we free the last stateid, the openowner will
> > +              * be also be freed. But we still need the openowner to be
> > +              * around, because we need to call
> > +              * release_last_closed_stateid(), which is what
> > +              * release_openowner() does.
> > +              * So we need to grab an extra refcnt for the openowner here.
> > +              */
> > +             nfs4_get_stateowner(&oo->oo_owner);
> > +
> > +             /*
> > +              * see: nfsd_collect_client_openowners(),
> > +              * nfsd_foreach_client_openowner()
> > +              */
> > +             unhash_openowner_locked(oo);
> > +             /*
> > +              * By incrementing cl_refcount under "nn->client_lock" we,
> > +              * hopefully, protect that client from being killed via
> > +              * mark_client_expired_locked().
> > +              * We increment cl_refcount once per each openowner.
> > +              */
> > +             atomic_inc(&clp->cl_refcount);
> > +             list_add(&oo->oo_perclient, oo_reaplist);
> > +             ++(*n_openowners);
> > +     }
> > +     spin_unlock(&clp->cl_lock);
> > +}
> > +
> > +/*
> > + * Attempts to release the stateids that have open files
> > + * on the specified superblock.
> > + */
> > +void
> > +nfs4_release_stateids(struct super_block *sb)
> > +{
> > +     struct nfsd_net *nn = net_generic(current->nsproxy->net_ns,
> > +                                                             nfsd_net_id);
> > +     struct nfs4_client *clp = NULL;
> > +     LIST_HEAD(openowner_reaplist);
> > +     unsigned int n_openowners = 0;
> > +
> > +     if (!nfsd_netns_ready(nn))
> > +             return;
> > +
> > +     pr_info("=== Release stateids for sb=%p ===\n", sb);
> > +
> > +     spin_lock(&nn->client_lock);
>
> I wonder how long it make to walk all the state of every client on a
> large server, and if it's going to cause problems to hold this lock that
> long.

Bottom line this issue happens to us in production, and it would be
good for us to have it resolved. With our limited nfsd understanding,
do you believe anybody from the community could help?

Thanks,
Alex.


>
> --b.
>
> > +     list_for_each_entry(clp, &nn->client_lru, cl_lru) {
> > +             char cl_addr[INET6_ADDRSTRLEN] = {'\0'};
> > +
> > +             rpc_ntop((struct sockaddr *)&clp->cl_addr,
> > +                          cl_addr, sizeof(cl_addr));
> > +             pr_debug("Checking client=%p/%s cl_clientid=%u:%u refcnt=%d\n",
> > +                          clp, cl_addr, clp->cl_clientid.cl_boot,
> > +                          clp->cl_clientid.cl_id,
> > +                          atomic_read(&clp->cl_refcount));
> > +
> > +             nfs4_release_client_stateids(sb, clp, cl_addr,
> > +                                     &openowner_reaplist, &n_openowners);
> > +     }
> > +     spin_unlock(&nn->client_lock);
> > +
> > +     pr_info("Collected %u openowners for removal (sb=%p)\n",
> > +                 n_openowners, sb);
> > +
> > +     nfsd_reap_openowners(&openowner_reaplist);
> > +}
> > +
> >  /*
> >   * Since the lifetime of a delegation isn't limited to that of an open, a
> >   * client may quite reasonably hang on to a delegation as long as it has
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 4824363..5514184 100755
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -322,6 +322,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
> >        * 3.  Is that directory the root of an exported file system?
> >        */
> >       error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
> > +     nfs4_release_stateids(path.dentry->d_sb);
> >
> >       path_put(&path);
> >       return error;
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 86aa92d..acee094 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -632,6 +632,8 @@ extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(const char *name,
> >                                                       struct nfsd_net *nn);
> >  extern bool nfs4_has_reclaimed_state(const char *name, struct nfsd_net *nn);
> >
> > +extern void nfs4_release_stateids(struct super_block *sb);
> > +
> >  struct nfs4_file *find_file(struct knfsd_fh *fh);
> >  void put_nfs4_file(struct nfs4_file *fi);
> >  static inline void get_nfs4_file(struct nfs4_file *fi)
> > --
> > 1.9.1
