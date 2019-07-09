Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C530F63901
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2019 18:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfGIQB4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 12:01:56 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38028 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIQBz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Jul 2019 12:01:55 -0400
Received: by mail-vs1-f68.google.com with SMTP id k9so10962665vso.5
        for <linux-nfs@vger.kernel.org>; Tue, 09 Jul 2019 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVIhhQqoilEe5SZStNC9obgJ61kpTA2MhrJbfEiZEis=;
        b=BD3+jX73nKK9fyhamPnuvK3O9FVsawVqasr0hcpzpU0bhmXFtd3XZKQuvDmB3h+OEF
         72xBkRGhrLoAEgWr5mtzI98j9uv+rUNhtHo1x/57EIO233ih9INWdNIGBXh7kw7Hqyn/
         90nHSYReG5sFc49O/WcHCsMnab9VVT+RGKef76eipFiljAG1YdvSNBqGzd81vYVj5lwS
         gpztymH7jkb00R4ZJF8V6mjzotWoVS4Ae+T/R3nCG1k68LRG3YJonzSLW9xinLYbjTuV
         4uJ3m7btYGQcdH8EYdKxJvetwUKY7ahSIYhjdXi9yuZOBe8GiktrcE81v0RwGcro5Yqw
         qaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVIhhQqoilEe5SZStNC9obgJ61kpTA2MhrJbfEiZEis=;
        b=e1WZgEepquligINgiqj4GGfJpNOtbe2esSMLYcazgOCTM2zeX8f3poJN5ijyNsOvy6
         Jz9GqTlOJrRoAinDlAGh0yVvzGE3QhevZNMkd1wEZz2rX/pXnKaOkKSEhmbu6PYfVi+r
         p6arla3hUo93QloHecIeVDxIWbe4ryPGapRh5fskyqisy6Mbe7nEUFJa/eAqfn01RKUB
         noqfArEfCZeWbQLjBNG/tNcSsAJdYNLnCASnT3VECeCwDVLmJI7eJ9zvUaEgl+GqtETw
         nzSs/F8V2y7Q65IQWhF6tQVWWltpMBlE5fUkVHHUoYelSdQaF3FpQCV9E2FfhE1dV9n4
         v8aQ==
X-Gm-Message-State: APjAAAX2hb7/npUtupN1U0M7zvei5rGAXjrqOenSiG/K4CvSG7HG3D7M
        P42moGNI8//s5O4TIwGKj3I6Tca2gRDGh/sYuT/mbpE+
X-Google-Smtp-Source: APXvYqz08yQYEKykF5e/fmofsHOsCTf5+w+QgRmheryNr0sC202P0uHW0XIPRlZ8LOMhcAVA6XGKC8KTxx3AUGmjPT0=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr14740965vsd.215.1562688114375;
 Tue, 09 Jul 2019 09:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
 <20190708192444.12664-5-olga.kornievskaia@gmail.com> <564738e20abb53527a57ba8b43a0c76af3e613b8.camel@netapp.com>
In-Reply-To: <564738e20abb53527a57ba8b43a0c76af3e613b8.camel@netapp.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 9 Jul 2019 12:01:43 -0400
Message-ID: <CAN-5tyFUpEzTAhsMHGYuTjYjm_51y8Hy-tVyH59ezJ-o--VSpw@mail.gmail.com>
Subject: Re: [PATCH v10 04/12] NFS: inter ssc open
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 9, 2019 at 10:01 AM Schumaker, Anna
<Anna.Schumaker@netapp.com> wrote:
>
> Hi Olga,
>
> On Mon, 2019-07-08 at 15:24 -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > NFSv4.2 inter server to server copy requires the destination server
> > to
> > READ the data from the source server using the provided stateid and
> > file handle.
> >
> > Given an NFSv4 stateid and filehandle from the COPY operaion, provide
> > the
> > destination server with an NFS client function to create a struct
> > file
> > suitable for the destiniation server to READ the data to be copied.
>
> I'm curious if you've had a look at any of the open-by-filehandle code
> in fs/fhandle.c? I know none of it is exported right now, but if it can
> be reused then it would capture whatever filesystem notifications stuff
> needs to happen at the same time.
>

I'm not sure what you are suggesting here. The code there would
trigger an open which in this case we have to avoid and thus having
that  code to setup the data structure with the provided file handle.
> Anna
>
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > Signed-off-by: Andy Adamson <andros@netapp.com>
> > ---
> >  fs/nfs/nfs4_fs.h  |  7 ++++
> >  fs/nfs/nfs4file.c | 94
> > +++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/nfs/nfs4proc.c |  5 +--
> >  3 files changed, 103 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> > index d75fea7ecf12..ff1cd600f07f 100644
> > --- a/fs/nfs/nfs4_fs.h
> > +++ b/fs/nfs/nfs4_fs.h
> > @@ -311,6 +311,13 @@ extern int nfs4_set_rw_stateid(nfs4_stateid
> > *stateid,
> >               const struct nfs_open_context *ctx,
> >               const struct nfs_lock_context *l_ctx,
> >               fmode_t fmode);
> > +extern int nfs4_proc_getattr(struct nfs_server *server, struct
> > nfs_fh *fhandle,
> > +                          struct nfs_fattr *fattr, struct nfs4_label
> > *label,
> > +                          struct inode *inode);
> > +extern int update_open_stateid(struct nfs4_state *state,
> > +                             const nfs4_stateid *open_stateid,
> > +                             const nfs4_stateid *deleg_stateid,
> > +                             fmode_t fmode);
> >
> >  #if defined(CONFIG_NFS_V4_1)
> >  extern int nfs41_sequence_done(struct rpc_task *, struct
> > nfs4_sequence_res *);
> > diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> > index b9825d02443e..aab4d48764a7 100644
> > --- a/fs/nfs/nfs4file.c
> > +++ b/fs/nfs/nfs4file.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/file.h>
> >  #include <linux/falloc.h>
> >  #include <linux/nfs_fs.h>
> > +#include <linux/file.h>
> >  #include "delegation.h"
> >  #include "internal.h"
> >  #include "iostat.h"
> > @@ -282,6 +283,99 @@ static loff_t nfs42_remap_file_range(struct file
> > *src_file, loff_t src_off,
> >  out:
> >       return ret < 0 ? ret : count;
> >  }
> > +
> > +static int read_name_gen = 1;
> > +#define SSC_READ_NAME_BODY "ssc_read_%d"
> > +
> > +struct file *
> > +nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
> > +             nfs4_stateid *stateid)
> > +{
> > +     struct nfs_fattr fattr;
> > +     struct file *filep, *res;
> > +     struct nfs_server *server;
> > +     struct inode *r_ino = NULL;
> > +     struct nfs_open_context *ctx;
> > +     struct nfs4_state_owner *sp;
> > +     char *read_name;
> > +     int len, status = 0;
> > +
> > +     server = NFS_SERVER(ss_mnt->mnt_root->d_inode);
> > +
> > +     nfs_fattr_init(&fattr);
> > +
> > +     status = nfs4_proc_getattr(server, src_fh, &fattr, NULL, NULL);
> > +     if (status < 0) {
> > +             res = ERR_PTR(status);
> > +             goto out;
> > +     }
> > +
> > +     res = ERR_PTR(-ENOMEM);
> > +     len = strlen(SSC_READ_NAME_BODY) + 16;
> > +     read_name = kzalloc(len, GFP_NOFS);
> > +     if (read_name == NULL)
> > +             goto out;
> > +     snprintf(read_name, len, SSC_READ_NAME_BODY, read_name_gen++);
> > +
> > +     r_ino = nfs_fhget(ss_mnt->mnt_root->d_inode->i_sb, src_fh,
> > &fattr,
> > +                     NULL);
> > +     if (IS_ERR(r_ino)) {
> > +             res = ERR_CAST(r_ino);
> > +             goto out;
> > +     }
> > +
> > +     filep = alloc_file_pseudo(r_ino, ss_mnt, read_name, FMODE_READ,
> > +                                  r_ino->i_fop);
> > +     if (IS_ERR(filep)) {
> > +             res = ERR_CAST(filep);
> > +             goto out;
> > +     }
> > +     filep->f_mode |= FMODE_READ;
> > +
> > +     ctx = alloc_nfs_open_context(filep->f_path.dentry, filep-
> > >f_mode,
> > +                                     filep);
> > +     if (IS_ERR(ctx)) {
> > +             res = ERR_CAST(ctx);
> > +             goto out_filep;
> > +     }
> > +
> > +     res = ERR_PTR(-EINVAL);
> > +     sp = nfs4_get_state_owner(server, ctx->cred, GFP_KERNEL);
> > +     if (sp == NULL)
> > +             goto out_ctx;
> > +
> > +     ctx->state = nfs4_get_open_state(r_ino, sp);
> > +     if (ctx->state == NULL)
> > +             goto out_stateowner;
> > +
> > +     set_bit(NFS_OPEN_STATE, &ctx->state->flags);
> > +     memcpy(&ctx->state->open_stateid.other, &stateid->other,
> > +            NFS4_STATEID_OTHER_SIZE);
> > +     update_open_stateid(ctx->state, stateid, NULL, filep->f_mode);
> > +
> > +     nfs_file_set_open_context(filep, ctx);
> > +     put_nfs_open_context(ctx);
> > +
> > +     file_ra_state_init(&filep->f_ra, filep->f_mapping->host-
> > >i_mapping);
> > +     res = filep;
> > +out:
> > +     return res;
> > +out_stateowner:
> > +     nfs4_put_state_owner(sp);
> > +out_ctx:
> > +     put_nfs_open_context(ctx);
> > +out_filep:
> > +     fput(filep);
> > +     goto out;
> > +}
> > +EXPORT_SYMBOL_GPL(nfs42_ssc_open);
> > +void nfs42_ssc_close(struct file *filep)
> > +{
> > +     struct nfs_open_context *ctx = nfs_file_open_context(filep);
> > +
> > +     ctx->state->flags = 0;
> > +}
> > +EXPORT_SYMBOL_GPL(nfs42_ssc_close);
> >  #endif /* CONFIG_NFS_V4_2 */
> >
> >  const struct file_operations nfs4_file_operations = {
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 9bbd9bad5412..c898ce1bccc6 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -91,7 +91,6 @@ struct nfs4_opendata;
> >  static int _nfs4_recover_proc_open(struct nfs4_opendata *data);
> >  static int nfs4_do_fsinfo(struct nfs_server *, struct nfs_fh *,
> > struct nfs_fsinfo *);
> >  static void nfs_fixup_referral_attributes(struct nfs_fattr *fattr);
> > -static int nfs4_proc_getattr(struct nfs_server *, struct nfs_fh *,
> > struct nfs_fattr *, struct nfs4_label *label, struct inode *inode);
> >  static int _nfs4_proc_getattr(struct nfs_server *server, struct
> > nfs_fh *fhandle, struct nfs_fattr *fattr, struct nfs4_label *label,
> > struct inode *inode);
> >  static int nfs4_do_setattr(struct inode *inode, const struct cred
> > *cred,
> >                           struct nfs_fattr *fattr, struct iattr
> > *sattr,
> > @@ -1674,7 +1673,7 @@ static void nfs_state_clear_delegation(struct
> > nfs4_state *state)
> >       write_sequnlock(&state->seqlock);
> >  }
> >
> > -static int update_open_stateid(struct nfs4_state *state,
> > +int update_open_stateid(struct nfs4_state *state,
> >               const nfs4_stateid *open_stateid,
> >               const nfs4_stateid *delegation,
> >               fmode_t fmode)
> > @@ -3966,7 +3965,7 @@ static int _nfs4_proc_getattr(struct nfs_server
> > *server, struct nfs_fh *fhandle,
> >       return nfs4_call_sync(server->client, server, &msg,
> > &args.seq_args, &res.seq_res, 0);
> >  }
> >
> > -static int nfs4_proc_getattr(struct nfs_server *server, struct
> > nfs_fh *fhandle,
> > +int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh
> > *fhandle,
> >                               struct nfs_fattr *fattr, struct
> > nfs4_label *label,
> >                               struct inode *inode)
> >  {
