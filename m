Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00EE5A9F71
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 20:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiIASxm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiIASxg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 14:53:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC4A95E62
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 11:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D6DEB828F0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 18:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6A0C433B5
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 18:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662058413;
        bh=GfMeomvV0eKE2x9wgjK+kIOmvOJNyrdvetmlWKVMYuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fHqcI/9BWj0y6OJfsWIw19ZlFI84LEVxJUrRtFzjXtpEi3CQthuAMvxPqlUkNMeHm
         2zlh4RsqzplQF8x2oRsx+uPVNXsIefVbapdoI85r41wrqekIoWvMUjXyCDgPCYXsQ1
         NnVjhsKC5tZFC4xdzcDKsFzyvwAkPYhYN0cgaSNs3f1ePYntBHXaV2VLX2RkHFnA+i
         YyeVH0UdYVZMGztOOkeA40/kP/izWzx3ji+TXvs467gu4n66j7B9Lc+c6G7OHPpU2L
         CFDwq4K3ygjKSdSnaShUZV/tsnSECT5oHou5jRSJlYV6J5Vtuudfknven5YsoJNv8N
         CzSj/lN42q6DQ==
Received: by mail-wm1-f49.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso1892799wmh.5
        for <linux-nfs@vger.kernel.org>; Thu, 01 Sep 2022 11:53:32 -0700 (PDT)
X-Gm-Message-State: ACgBeo1NUNhhmpsEt6oINDpQWbJTSuzCW9y1bfafyrEjvkvyxWeSEgvT
        NBUsLFScZ9R6FK1HeN2SUZXsaLc/7HyY7vrpyVg=
X-Google-Smtp-Source: AA6agR5HbUspNs8WpzA9LEx6NNSP3aPvXrfDHzPzR/8kI0PA/f7X3XBwfxcSORTNepkVuTp7NXGn4ENphKdqQdY1QMM=
X-Received: by 2002:a05:600c:28c8:b0:3a8:40bb:be4c with SMTP id
 h8-20020a05600c28c800b003a840bbbe4cmr359167wmd.28.1662058411548; Thu, 01 Sep
 2022 11:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220901180503.1347290-1-anna@kernel.org> <c38f77a54257fcf8c59b6e628cc13679fb3fb48d.camel@hammerspace.com>
 <50a371e51b76469671ede8d47201eb8d01dd5720.camel@hammerspace.com>
In-Reply-To: <50a371e51b76469671ede8d47201eb8d01dd5720.camel@hammerspace.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 1 Sep 2022 14:53:15 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfn7Yuihiy8XOaRnrfeosRgR0536hZ9Tps8AtL78tj+Yjw@mail.gmail.com>
Message-ID: <CAFX2Jfn7Yuihiy8XOaRnrfeosRgR0536hZ9Tps8AtL78tj+Yjw@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: Update mode bits after ALLOCATE and DEALLOCATE
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "cuiyue-fnst@fujitsu.com" <cuiyue-fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 1, 2022 at 2:47 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Thu, 2022-09-01 at 14:22 -0400, Trond Myklebust wrote:
> > On Thu, 2022-09-01 at 14:05 -0400, Anna Schumaker wrote:
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > The fallocate call invalidates suid and sgid bits as part of normal
> > > operation. We need to mark the mode bits as invalid when using
> > > fallocate
> > > with an suid so these will be updated the next time the user looks
> > > at
> > > them.
> > >
> > > This fixes xfstests generic/683 and generic/684.
> > >
> > > Reported-by: Yue Cui <cuiyue-fnst@fujitsu.com>
> > > Fixes: 913eca1aea87 ("NFS: Fallocate should use the
> > > nfs4_fattr_bitmap")
> > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > ---
> > >  fs/nfs/internal.h  | 25 +++++++++++++++++++++++++
> > >  fs/nfs/nfs42proc.c | 13 ++++++++++++-
> > >  fs/nfs/write.c     | 25 -------------------------
> > >  3 files changed, 37 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> > > index 27c720d71b4e..898dd95bc7a7 100644
> > > --- a/fs/nfs/internal.h
> > > +++ b/fs/nfs/internal.h
> > > @@ -606,6 +606,31 @@ static inline gfp_t nfs_io_gfp_mask(void)
> > >         return GFP_KERNEL;
> > >  }
> > >
> > > +/*
> > > + * Special version of should_remove_suid() that ignores
> > > capabilities.
> > > + */
> > > +static inline int nfs_should_remove_suid(const struct inode
> > > *inode)
> > > +{
> > > +       umode_t mode = inode->i_mode;
> > > +       int kill = 0;
> > > +
> > > +       /* suid always must be killed */
> > > +       if (unlikely(mode & S_ISUID))
> > > +               kill = ATTR_KILL_SUID;
> > > +
> > > +       /*
> > > +        * sgid without any exec bits is just a mandatory locking
> > > mark; leave
> > > +        * it alone.  If some exec bits are set, it's a real sgid;
> > > kill it.
> > > +        */
> > > +       if (unlikely((mode & S_ISGID) && (mode & S_IXGRP)))
> > > +               kill |= ATTR_KILL_SGID;
> > > +
> > > +       if (unlikely(kill && S_ISREG(mode)))
> > > +               return kill;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  /* unlink.c */
> > >  extern struct rpc_task *
> > >  nfs_async_rename(struct inode *old_dir, struct inode *new_dir,
> > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > index 068c45b3bc1a..23023ddf75d1 100644
> > > --- a/fs/nfs/nfs42proc.c
> > > +++ b/fs/nfs/nfs42proc.c
> > > @@ -56,6 +56,7 @@ static int _nfs42_proc_fallocate(struct
> > > rpc_message
> > > *msg, struct file *filep,
> > >         struct nfs42_falloc_res res = {
> > >                 .falloc_server  = server,
> > >         };
> > > +       unsigned int invalid = 0;
> > >         int status;
> > >
> > >         msg->rpc_argp = &args;
> > > @@ -78,10 +79,20 @@ static int _nfs42_proc_fallocate(struct
> > > rpc_message *msg, struct file *filep,
> > >
> > >         status = nfs4_call_sync(server->client, server, msg,
> > >                                 &args.seq_args, &res.seq_res, 0);
> > > +
> > > +       if (!res.falloc_fattr->valid)
> > > +               invalid |= NFS_INO_INVALID_ATTR;
>
> Oh wait... We shouldn't need this.^^^^^^^^^
> nfs_post_op_update_inode_force_wcc() will do the right thing for you
> here.

Sure. I can remove that and put everything under the "if (status == 0)".

Anna

>
> > > +       if (nfs_should_remove_suid(inode))
> > > +               invalid |= NFS_INO_INVALID_MODE;
> > > +       if (invalid) {
> > > +               spin_lock(&inode->i_lock);
> > > +               nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
> > > +               spin_unlock(&inode->i_lock);
> > > +       }
> >
> > This all really wants to go into the 'if (status == 0)' below.
> > > +
> > >         if (status == 0)
> > >                 status = nfs_post_op_update_inode_force_wcc(inode,
> > >
> > > res.falloc_fattr);
> > > -
> > >         if (msg->rpc_proc ==
> > > &nfs4_procedures[NFSPROC4_CLNT_ALLOCATE])
> > >                 trace_nfs4_fallocate(inode, &args, status);
> > >         else
> > > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > > index 1843fa235d9b..f41d24b54fd1 100644
> > > --- a/fs/nfs/write.c
> > > +++ b/fs/nfs/write.c
> > > @@ -1496,31 +1496,6 @@ void nfs_commit_prepare(struct rpc_task
> > > *task,
> > > void *calldata)
> > >         NFS_PROTO(data->inode)->commit_rpc_prepare(task, data);
> > >  }
> > >
> > > -/*
> > > - * Special version of should_remove_suid() that ignores
> > > capabilities.
> > > - */
> > > -static int nfs_should_remove_suid(const struct inode *inode)
> > > -{
> > > -       umode_t mode = inode->i_mode;
> > > -       int kill = 0;
> > > -
> > > -       /* suid always must be killed */
> > > -       if (unlikely(mode & S_ISUID))
> > > -               kill = ATTR_KILL_SUID;
> > > -
> > > -       /*
> > > -        * sgid without any exec bits is just a mandatory locking
> > > mark; leave
> > > -        * it alone.  If some exec bits are set, it's a real sgid;
> > > kill it.
> > > -        */
> > > -       if (unlikely((mode & S_ISGID) && (mode & S_IXGRP)))
> > > -               kill |= ATTR_KILL_SGID;
> > > -
> > > -       if (unlikely(kill && S_ISREG(mode)))
> > > -               return kill;
> > > -
> > > -       return 0;
> > > -}
> > > -
> > >  static void nfs_writeback_check_extend(struct nfs_pgio_header
> > > *hdr,
> > >                 struct nfs_fattr *fattr)
> > >  {
> >
> > Otherwise, looks OK.
> >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
