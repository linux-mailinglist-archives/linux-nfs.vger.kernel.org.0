Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478B728067E
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 20:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgJASZW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 14:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgJASZW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 14:25:22 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E31C0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 11:25:20 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g4so6706072edk.0
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 11:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eu48F29p4N8zbgxpWXhOr/e84QySfOIaZsSTj0F0bCs=;
        b=YmjH6oWgHsLX0r5TpfB9JWgWjEyVSBwQ1gWq6Hgc5uMUSXX0lVijfKo3z+EdwWsVic
         AWuvCTyODdstwAxaDDBq/bTLJPAziUn9+mINfEt07XKtTHYGGbnpX+66sMoiZsFQhb3k
         VvvtNjrMQg+VWfKBoMUhN+YC9qG7fKScaFhqF+8WaQW0DN0iCah1KVDF7Drwry7WVwiR
         bFqOC4ahYByIov5A+2adI2ir312q6mqidY7CmkU9xg9nVVI0n+lewX853lMUfwGQmhnV
         jwxS9c594ChUNoOrPALudXYJlYsUzeY4kmDhOjMC1aYr8BNdoMyplcc6TPTXiMcFevR3
         l2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eu48F29p4N8zbgxpWXhOr/e84QySfOIaZsSTj0F0bCs=;
        b=tu5a/vL00WZtlowKGUVrEdyHyC2cDXKWzuK6mvJPZj7pcZrwl4Isg3J+rBh1JKw1tY
         im3yODAGBKVOVWMa6ZYp4uTNLWLE3vI5fwAwFEBwg/bABqirfbnIjoR5u2xef0T3vBmn
         bs6MjM+WFHKnEYP0mzOBc11wbuH/0fvgpu0pu02lebnrC/huOzanf9h1WDzIaqkX6/SO
         /F3Vqo+u7TW8+eOktraiHGyr/IzDVwb3yQGlf8V9vimxPKvCWEogAhIkkEdWQ6MVchyX
         2qZKdLJrG0ZrmZxVAK44w5oNhSPpPfQmIxLecVOM+8IxqdMWhT42AcyaCQpHXN1DbUgP
         ZFEg==
X-Gm-Message-State: AOAM532uGDUE9kNg82tfZGscjxbn/cEZPQmcPlzHGFhC+ngkSmgd2o1n
        H7PJOhIlU+3oDVadsBbQFB8GD1BM+EtyIimbbrHDAH7LtQA=
X-Google-Smtp-Source: ABdhPJzgK3v06oVmVuW2lsZHOXanOFlG4pLfy3foxyMRvChBej4jrPx9V4p4C0biYJJ5JjrfluvFKrvbrZoQXN4LpuE=
X-Received: by 2002:a05:6402:18d:: with SMTP id r13mr9334987edv.267.1601576718764;
 Thu, 01 Oct 2020 11:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200914210508.7701-1-olga.kornievskaia@gmail.com> <ed267a2c190101c53a2d409f7a6b1530ae50e72d.camel@hammerspace.com>
In-Reply-To: <ed267a2c190101c53a2d409f7a6b1530ae50e72d.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 1 Oct 2020 14:25:07 -0400
Message-ID: <CAN-5tyGk6qwC+g+qB8QeTGTXrRUdD7ar5cvRjd9DAyzNO-GzvA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4: make cache consistency bitmask dynamic
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 1, 2020 at 1:14 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Hi Olga,
>
> On Mon, 2020-09-14 at 17:05 -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Client uses static bitmask for GETATTR on CLOSE/WRITE/DELEGRETURN
> > and ignores the fact that it might have some attributes marked
> > invalid in its cache. Compared to v3 where all attributes are
> > retrieved in postop attributes, v4's cache is frequently out of
> > sync and leads to standalone GETATTRs being sent to the server.
> >
> > Instead, in addition to the minimum cache consistency attributes
> > also check cache_validity and adjust the GETATTR request accordingly.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs4proc.c       | 45 ++++++++++++++++++++++++++++++++++++++-
> > --
> >  include/linux/nfs_xdr.h |  6 +++---
> >  2 files changed, 45 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 6e95c85fe395..d7434a3697d9 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -107,6 +107,9 @@ static int nfs41_test_stateid(struct nfs_server
> > *, nfs4_stateid *,
> >  static int nfs41_free_stateid(struct nfs_server *, const
> > nfs4_stateid *,
> >               const struct cred *, bool);
> >  #endif
> > +static void nfs4_bitmask_adjust(__u32 *bitmask, struct inode *inode,
> > +             struct nfs_server *server,
> > +             struct nfs4_label *label);
> >
> >  #ifdef CONFIG_NFS_V4_SECURITY_LABEL
> >  static inline struct nfs4_label *
> > @@ -3632,9 +3635,10 @@ static void nfs4_close_prepare(struct rpc_task
> > *task, void *data)
> >
> >       if (calldata->arg.fmode == 0 || calldata->arg.fmode ==
> > FMODE_READ) {
> >               /* Close-to-open cache consistency revalidation */
> > -             if (!nfs4_have_delegation(inode, FMODE_READ))
> > +             if (!nfs4_have_delegation(inode, FMODE_READ)) {
> >                       calldata->arg.bitmask = NFS_SERVER(inode)-
> > >cache_consistency_bitmask;
> > -             else
> > +                     nfs4_bitmask_adjust(calldata->arg.bitmask,
> > inode, NFS_SERVER(inode), NULL);
> > +             } else
> >                       calldata->arg.bitmask = NULL;
> >       }
> >
> > @@ -5360,6 +5364,38 @@ bool
> > nfs4_write_need_cache_consistency_data(struct nfs_pgio_header *hdr)
> >       return nfs4_have_delegation(hdr->inode, FMODE_READ) == 0;
> >  }
> >
> > +static void nfs4_bitmask_adjust(__u32 *bitmask, struct inode *inode,
> > +                             struct nfs_server *server,
> > +                             struct nfs4_label *label)
> > +{
> > +
> > +     unsigned long cache_validity = READ_ONCE(NFS_I(inode)-
> > >cache_validity);
> > +
> > +     if ((cache_validity & NFS_INO_INVALID_DATA) ||
> > +             (cache_validity & NFS_INO_REVAL_PAGECACHE) ||
> > +             (cache_validity & NFS_INO_REVAL_FORCED) ||
> > +             (cache_validity & NFS_INO_INVALID_OTHER))
> > +             nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server,
> > label), inode);
> > +
> > +     if (cache_validity & NFS_INO_INVALID_ATIME)
> > +             bitmask[1] |= FATTR4_WORD1_TIME_ACCESS;
> > +     if (cache_validity & NFS_INO_INVALID_ACCESS)
> > +             bitmask[0] |= FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER |
> > +                             FATTR4_WORD1_OWNER_GROUP;
> > +     if (cache_validity & NFS_INO_INVALID_ACL)
> > +             bitmask[0] |= FATTR4_WORD0_ACL;
> > +     if (cache_validity & NFS_INO_INVALID_LABEL)
> > +             bitmask[2] |= FATTR4_WORD2_SECURITY_LABEL;
> > +     if (cache_validity & NFS_INO_INVALID_CTIME)
> > +             bitmask[0] |= FATTR4_WORD0_CHANGE;
> > +     if (cache_validity & NFS_INO_INVALID_MTIME)
> > +             bitmask[1] |= FATTR4_WORD1_TIME_MODIFY;
> > +     if (cache_validity & NFS_INO_INVALID_SIZE)
> > +             bitmask[0] |= FATTR4_WORD0_SIZE;
> > +     if (cache_validity & NFS_INO_INVALID_BLOCKS)
> > +             bitmask[1] |= FATTR4_WORD1_SPACE_USED;
>
> If we hold a delegation (which we could do when called
> from nfs4_proc_write_setup()) then we only want to get extra attributes
> if the NFS_INO_REVAL_FORCED flag is also set.

If we hold a delegation then nfs4_write_need_cache_consistency_data()
would be true and no getattr would be added (or need to be adjusted).
Am I mis-reading your comment?

> > +}
> > +
> >  static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
> >                                 struct rpc_message *msg,
> >                                 struct rpc_clnt **clnt)
> > @@ -5369,8 +5405,10 @@ static void nfs4_proc_write_setup(struct
> > nfs_pgio_header *hdr,
> >       if (!nfs4_write_need_cache_consistency_data(hdr)) {
> >               hdr->args.bitmask = NULL;
> >               hdr->res.fattr = NULL;
> > -     } else
> > +     } else {
> >               hdr->args.bitmask = server->cache_consistency_bitmask;
> > +             nfs4_bitmask_adjust(hdr->args.bitmask, hdr->inode,
> > server, NULL);
> > +     }
> >
> >       if (!hdr->pgio_done_cb)
> >               hdr->pgio_done_cb = nfs4_write_done_cb;
> > @@ -6406,6 +6444,7 @@ static int _nfs4_proc_delegreturn(struct inode
> > *inode, const struct cred *cred,
> >       data->args.fhandle = &data->fh;
> >       data->args.stateid = &data->stateid;
> >       data->args.bitmask = server->cache_consistency_bitmask;
> > +     nfs4_bitmask_adjust(data->args.bitmask, inode, server, NULL);
> >       nfs_copy_fh(&data->fh, NFS_FH(inode));
> >       nfs4_stateid_copy(&data->stateid, stateid);
> >       data->res.fattr = &data->fattr;
> > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > index 9408f3252c8e..bafbf6695796 100644
> > --- a/include/linux/nfs_xdr.h
> > +++ b/include/linux/nfs_xdr.h
> > @@ -525,7 +525,7 @@ struct nfs_closeargs {
> >       struct nfs_seqid *      seqid;
> >       fmode_t                 fmode;
> >       u32                     share_access;
> > -     const u32 *             bitmask;
> > +     u32 *                   bitmask;
> >       struct nfs4_layoutreturn_args *lr_args;
> >  };
> >
> > @@ -608,7 +608,7 @@ struct nfs4_delegreturnargs {
> >       struct nfs4_sequence_args       seq_args;
> >       const struct nfs_fh *fhandle;
> >       const nfs4_stateid *stateid;
> > -     const u32 * bitmask;
> > +     u32 * bitmask;
> >       struct nfs4_layoutreturn_args *lr_args;
> >  };
> >
> > @@ -648,7 +648,7 @@ struct nfs_pgio_args {
> >       union {
> >               unsigned int            replen;                 /*
> > used by read */
> >               struct {
> > -                     const u32 *             bitmask;        /*
> > used by write */
> > +                     u32 *                   bitmask;        /*
> > used by write */
> >                       enum nfs3_stable_how    stable;         /*
> > used by write */
> >               };
> >       };
>
> Otherwise this looks good. Thanks!
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
