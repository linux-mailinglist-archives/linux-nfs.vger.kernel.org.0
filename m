Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5ED0AF157
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2019 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfIJTAh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Sep 2019 15:00:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38932 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfIJTAh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Sep 2019 15:00:37 -0400
Received: by mail-io1-f68.google.com with SMTP id d25so40063542iob.6
        for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2019 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7L3xHxf6ChAQcQVYx/1HkmySUWaZzSNUSgIiOR9T50=;
        b=YF9ckAJK4I3Nqlx4Eqf3yGJ3yFf64yM38cMIbTMDhS5GOJndA1+myjh4uA9g65j3MS
         ACciJmPJaBMrgyCvDZ5/Q1KZEgOQJohRe0ztU29qkxoMeqrdkNZ6F8PRFdtgTWnsP4q3
         2NhV5wTj38xlZBWoMeSLiuar4fmu2pXVVIu65x0nX6hEEzaQaG3nkJETZ9psp4NtOwoD
         CVOZcBO8x+tqTIviS8Hmh2GttmcPsCwCCIYrGSW4N5fDJKzITK99Qwqy2dMgWZivU+uc
         YRi4OS+1upKUypdAsIaNTdI68knXwr7haXTmZ5w1WfcQdfHglrd4x69BuZ6O4QibDlS1
         8MyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7L3xHxf6ChAQcQVYx/1HkmySUWaZzSNUSgIiOR9T50=;
        b=nWWrSkeit1hUIZGrNCsI2ciGc9IDXUh33BNTTx6IbuRp+K6M8wQNLhK5axDTJEkKZN
         N5RZiRnnxLy1V7Dx/ZkKeGlrz6cLpeo/ARJX1nImOrlUBF9ruLQUe+DOPO9JCLU0N7MF
         5ubqCzF+wxainRtE3/oMvW7z5gMT1kMfXQoW9G241OBr/DIpl+/EL6eGAPPfSZBLdAkC
         ef/yJ3B64GH9+zRuiTUKmIjs5sIRdlXVyQI+/rdHu3RJxYRvn9SXU/gPgr1rRpIVN/8z
         fWdxlrpLk/YcH1eXBojwwsp5gVZ0uX3vLbUET8MwQ2jqA+6t+YgjgNozmIJxd1b5MKGj
         +RIg==
X-Gm-Message-State: APjAAAWx11tfjlAvTCVJc28a2yrl288SLtDGLve0j7B/x3ICXrgWgmNb
        PR9z6++VP0sDgS3plT3AkV8lL34+pfBDxhnqK4KRzYat
X-Google-Smtp-Source: APXvYqxnWO7oOGId3H9s8mSFRBkffpN7koVaFZsEjF+iguqAH9NybZfWqHhzH6Uv6E2wQmWNHqwQgLH/BDctzIzMDW4=
X-Received: by 2002:a5d:8902:: with SMTP id b2mr26033938ion.135.1568142035137;
 Tue, 10 Sep 2019 12:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <1567518908-1720-1-git-send-email-alex@zadara.com> <20190906161236.GF17204@fieldses.org>
In-Reply-To: <20190906161236.GF17204@fieldses.org>
From:   Alex Lyakas <alex@zadara.com>
Date:   Tue, 10 Sep 2019 22:00:24 +0300
Message-ID: <CAOcd+r0GRaXP3bes2xw6CFJmPJDTfAAMB7j6G3gzCVKDTC8Sgw@mail.gmail.com>
Subject: Re: [RFC-PATCH] nfsd: provide a procfs entry to release stateids of a
 particular local filesystem
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, Shyam Kaushik <shyam@zadara.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

Thanks for reviewing the patch.

I addressed your comments, and ran the patch through checkpatch.pl.
Patch v2 is on its way.

On Fri, Sep 6, 2019 at 7:12 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Sep 03, 2019 at 04:55:08PM +0300, Alex Lyakas wrote:
> > This patch addresses the following issue:
>
> Thanks for the patch and the good explanation!
>
> I'd rather we just call nfs4_release_stateids() from write_unlock_fs().
>
> That modifies the behavior of the existing unlock_filesystem interface,
> so, yes, adding a new file would be the more conservative approach.
>
> But really I think that the only use of unlock_filesystem is to allow
> unmounting, and the fact that it only handles NLM locks is just a bug
> that we should fix.
>
> You'll want to cover delegations as well.  And probably pNFS layouts.
> It'd be OK to do that incrementally in followup patches.
Unfortunately, I don't have much understanding of what these are, and
how to cover them)
>
> Style nits:
>
> I assume all the print statements are just for temporary debugging.
I left only two prints with pr_info, which give some indication that
the operation has started, and whether it did anything useful. Rest of
the prints are with pr_debug.
>
> Try to keep lines to 80 characters.  I'd break the inner loop of
> nfs4_release_stateids() into a separate nfs4_release_client_stateids(sb,
> clp).
>
> --b.
>
> > - Create two local file systems FS1 and FS2 on the server machine S.
> > - Export both FS1 and FS2 through nfsd to the same nfs client, running on client machine C.
> > - On C, mount both exported file systems and start writing files to both of them.
> > - After few minutes, on server machine S, un-export FS1 only.
> > - Do not unmount FS1 on the client machine C prior to un-exporting.
> > - Also, FS2 remains exported to C.
> > - Now we want to unmount FS1 on the server machine S, but we fail, because there are still open files on FS1 held by nfsd.
> >
> > Debugging this issue showed the following root cause: there is a nfs4_client entry for the client C.
> > This entry has two nfs4_openowners, for FS1 and FS2, although FS1 was un-exported.
> > Looking at the stateids of both openowners, we see that they have stateids of kind NFS4_OPEN_STID,
> > and each stateid is holding a nfs4_file. The reason we cannot unmount FS1, is because we still have
> > an openowner for FS1, holding open-stateids, which hold open files on FS1.
> >
> > The laundromat doesn't help in this case, because it can only decide per-nfs4_client that it should be purged.
> > But in this case, since FS2 is still exported to C, there is no reason to purge the nfs4_client.
> >
> > This situation remains until we un-export FS2 as well.
> > Then the whole nfs4_client is purged, and all the files get closed, and we can unmount both FS1 and FS2.
> >
> > This patch allows user-space to tell nfsd to release stateids of a particular local filesystem.
> > After that, it is possible to unmount the local filesystem.
> >
> > This patch is based on kernel 4.14.99, which we currently use.
> > That's why marking it as RFC.
> >
> > Signed-off-by: Alex Lyakas <alex@zadara.com>
> > ---
> >  fs/nfsd/nfs4state.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  fs/nfsd/nfsctl.c    |  46 ++++++++++++++++++++++
> >  fs/nfsd/state.h     |   2 +
> >  3 files changed, 154 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 3cf0b2e..4081753 100755
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
> > @@ -7072,6 +7074,109 @@ static u64 nfsd_find_all_delegations(struct nfs4_client *clp, u64 max,
> >  #endif /* CONFIG_NFSD_FAULT_INJECTION */
> >
> >  /*
> > + * Attempts to release the stateids that have open files on the specified superblock.
> > + */
> > +void
> > +nfs4_release_stateids(struct super_block * sb)
> > +{
> > +     struct nfsd_net *nn = net_generic(current->nsproxy->net_ns, nfsd_net_id);
> > +     struct nfs4_client *clp = NULL;
> > +     struct nfs4_openowner *oo = NULL, *oo_next = NULL;
> > +     LIST_HEAD(openowner_reaplist);
> > +     unsigned int n_openowners = 0;
> > +
> > +     if (!nfsd_netns_ready(nn))
> > +             return;
> > +
> > +     pr_info("=== Release stateids for sb=%p ===\n", sb);
> > +
> > +     spin_lock(&nn->client_lock);
> > +     list_for_each_entry(clp, &nn->client_lru, cl_lru) {
> > +             char cl_addr[INET6_ADDRSTRLEN] = {'\0'};
> > +
> > +             rpc_ntop((struct sockaddr*)&clp->cl_addr, cl_addr, sizeof(cl_addr));
> > +             pr_debug("Looking at client=%p/%s cl_clientid=%u:%u refcnt=%d\n",
> > +                          clp, cl_addr, clp->cl_clientid.cl_boot, clp->cl_clientid.cl_id,
> > +                          atomic_read(&clp->cl_refcount));
> > +
> > +             spin_lock(&clp->cl_lock);
> > +             list_for_each_entry_safe(oo, oo_next, &clp->cl_openowners, oo_perclient) {
> > +                     struct nfs4_ol_stateid *stp = NULL;
> > +                     bool found_my_sb = false, found_other_sb = false;
> > +                     struct super_block *other_sb = NULL;
> > +
> > +                     pr_debug(" Openowner %p %.*s\n", oo, oo->oo_owner.so_owner.len, oo->oo_owner.so_owner.data);
> > +                     pr_debug(" oo_close_lru=%s oo_last_closed_stid=%p refcnt=%d so_is_open_owner=%u\n",
> > +                                  list_empty(&oo->oo_close_lru) ? "N" : "Y", oo->oo_last_closed_stid,
> > +                                  atomic_read(&oo->oo_owner.so_count), oo->oo_owner.so_is_open_owner);
> > +
> > +                     list_for_each_entry(stp, &oo->oo_owner.so_stateids, st_perstateowner) {
> > +                             struct nfs4_file *fp = NULL;
> > +                             struct file *filp = NULL;
> > +                             struct super_block *f_sb = NULL;
> > +                             if (stp->st_stid.sc_file == NULL)
> > +                                     continue;
> > +
> > +                             fp = stp->st_stid.sc_file;
> > +                             filp = find_any_file(fp);
> > +                             if (filp != NULL)
> > +                                     f_sb = file_inode(filp)->i_sb;
> > +                             pr_debug("   filp=%p sb=%p my_sb=%p\n", filp, f_sb, sb);
> > +                             if (f_sb == sb) {
> > +                                     found_my_sb = true;
> > +                             } else {
> > +                                     found_other_sb = true;
> > +                                     other_sb = f_sb;
> > +                             }
> > +                             if (filp != NULL)
> > +                                     fput(filp);
> > +                     }
> > +
> > +                     /* openowner does not have files from needed fs, skip it */
> > +                     if (!found_my_sb)
> > +                             continue;
> > +
> > +                     /*
> > +                      * we do not expect same openowhner having open files from more than one fs.
> > +                      * but if it happens, we cannot release this openowner.
> > +                      */
> > +                     if (found_other_sb) {
> > +                             pr_warn(" client=%p/%s openowner %p %.*s has files from sb=%p but also from sb=%p, skipping it!\n",
> > +                                         clp, cl_addr, oo, oo->oo_owner.so_owner.len, oo->oo_owner.so_owner.data, sb, other_sb);
> > +                             continue;
> > +                     }
> > +
> > +                     /*
> > +                      * Each OPEN stateid holds a refcnt on the openowner (and LOCK stateid holds a refcnt on the lockowner).
> > +                      * This refcnt is dropped when nfs4_free_ol_stateid is called, which calls nfs4_put_stateowner.
> > +                      * The last refcnt drop, unhashes and frees the openowner.
> > +                      * As a result, after we free the last stateid, the openowner will be also be freed.
> > +                      * But we still need the openowner to be around, because we need to call release_last_closed_stateid(),
> > +                      * which is what release_openowner() does (we are doing equivalent of that).
> > +                      * So we need to grab an extra refcnt for the openowner here.
> > +                      */
> > +                     nfs4_get_stateowner(&oo->oo_owner);
> > +
> > +                     /* see: nfsd_collect_client_openowners(), nfsd_foreach_client_openowner() */
> > +                     unhash_openowner_locked(oo);
> > +                     /*
> > +                      * By incrementing cl_refcount under "nn->client_lock" we, hopefully, protect that client from being killed via mark_client_expired_locked().
> > +                      * We increment cl_refcount once per each openowner.
> > +                      */
> > +                     atomic_inc(&clp->cl_refcount);
> > +                     list_add(&oo->oo_perclient, &openowner_reaplist);
> > +                     ++n_openowners;
> > +             }
> > +             spin_unlock(&clp->cl_lock);
> > +     }
> > +     spin_unlock(&nn->client_lock);
> > +
> > +     pr_info("Collected %u openowners for removal (sb=%p)\n", n_openowners, sb);
> > +
> > +     nfsd_reap_openowners(&openowner_reaplist);
> > +}
> > +
> > +/*
> >   * Since the lifetime of a delegation isn't limited to that of an open, a
> >   * client may quite reasonably hang on to a delegation as long as it has
> >   * the inode cached.  This becomes an obvious problem the first time a
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 4824363..8b38186 100755
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -37,6 +37,7 @@ enum {
> >       NFSD_Fh,
> >       NFSD_FO_UnlockIP,
> >       NFSD_FO_UnlockFS,
> > +     NFSD_FO_ReleaseStateIds,
> >       NFSD_Threads,
> >       NFSD_Pool_Threads,
> >       NFSD_Pool_Stats,
> > @@ -64,6 +65,7 @@ enum {
> >  static ssize_t write_filehandle(struct file *file, char *buf, size_t size);
> >  static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size);
> >  static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size);
> > +static ssize_t write_release_stateids(struct file *file, char *buf, size_t size);
> >  static ssize_t write_threads(struct file *file, char *buf, size_t size);
> >  static ssize_t write_pool_threads(struct file *file, char *buf, size_t size);
> >  static ssize_t write_versions(struct file *file, char *buf, size_t size);
> > @@ -81,6 +83,7 @@ static ssize_t (*write_op[])(struct file *, char *, size_t) = {
> >       [NFSD_Fh] = write_filehandle,
> >       [NFSD_FO_UnlockIP] = write_unlock_ip,
> >       [NFSD_FO_UnlockFS] = write_unlock_fs,
> > +     [NFSD_FO_ReleaseStateIds] = write_release_stateids,
> >       [NFSD_Threads] = write_threads,
> >       [NFSD_Pool_Threads] = write_pool_threads,
> >       [NFSD_Versions] = write_versions,
> > @@ -328,6 +331,47 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
> >  }
> >
> >  /**
> > + * write_release_stateids - Release stateids of a local file system
> > + *
> > + * Experimental.
> > + *
> > + * Input:
> > + *                   buf:    '\n'-terminated C string containing the
> > + *                           absolute pathname of a local file system
> > + *                   size:   length of C string in @buf
> > + * Output:
> > + *   On success:     returns zero if all openowners were released
> > + *   On error:       return code is negative errno value
> > + */
> > +static ssize_t write_release_stateids(struct file *file, char *buf, size_t size)
> > +{
> > +     struct path path;
> > +     char *fo_path = NULL;
> > +     int error = 0;
> > +
> > +     /* sanity check */
> > +     if (size == 0)
> > +             return -EINVAL;
> > +
> > +     if (buf[size-1] != '\n')
> > +             return -EINVAL;
> > +
> > +     fo_path = buf;
> > +     error = qword_get(&buf, fo_path, size);
> > +     if (error < 0)
> > +             return -EINVAL;
> > +
> > +     error = kern_path(fo_path, 0, &path);
> > +     if (error)
> > +             return error;
> > +
> > +     nfs4_release_stateids(path.dentry->d_sb);
> > +
> > +     path_put(&path);
> > +     return 0;
> > +}
> > +
> > +/**
> >   * write_filehandle - Get a variable-length NFS file handle by path
> >   *
> >   * On input, the buffer contains a '\n'-terminated C string comprised of
> > @@ -1167,6 +1211,8 @@ static int nfsd_fill_super(struct super_block * sb, void * data, int silent)
> >                                       &transaction_ops, S_IWUSR|S_IRUSR},
> >               [NFSD_FO_UnlockFS] = {"unlock_filesystem",
> >                                       &transaction_ops, S_IWUSR|S_IRUSR},
> > +             [NFSD_FO_ReleaseStateIds] = {"release_stateids",
> > +                                     &transaction_ops, S_IWUSR|S_IRUSR},
> >               [NFSD_Fh] = {"filehandle", &transaction_ops, S_IWUSR|S_IRUSR},
> >               [NFSD_Threads] = {"threads", &transaction_ops, S_IWUSR|S_IRUSR},
> >               [NFSD_Pool_Threads] = {"pool_threads", &transaction_ops, S_IWUSR|S_IRUSR},
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
