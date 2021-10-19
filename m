Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17603433B50
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 17:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJSP4B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 11:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhJSP4A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 11:56:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905A3C06161C
        for <linux-nfs@vger.kernel.org>; Tue, 19 Oct 2021 08:53:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i20so14468597edj.10
        for <linux-nfs@vger.kernel.org>; Tue, 19 Oct 2021 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmuuV5qKHxFimqer1zRCpOfQOa7vf8kWv0Zt/ENbDr8=;
        b=Z+XoG/FhKQYT2xNA0zonqHVLg9ROmLwrirJCEBIRBj+fCN4foaWq1iLr4uzKrDkSNx
         mi/+G7WeBsqzaHUrqXGAPzP7r99cFGf0+llZAFKajsrBLWrWmIIVLYnbxzqcY7jf8Ygn
         NgdXVYy5gtgWukbnW2UGug/Y0X2KWHQ3SQ6LD+KjrrSYXcd9lkiyBo6myh3hYvsTbayp
         cLdg9Nv479uXMfpvC0HxPnkBciOZsKmcrEfWLB2G9Ym7y6+VFh6kKzRlzpMrlUIA6rYk
         UecqszbvHB7+YXEvgqsMv5UOq8foTxG39uieJk+phDvG4kQqp7eYcp7MC77b4Uoa3T82
         f0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmuuV5qKHxFimqer1zRCpOfQOa7vf8kWv0Zt/ENbDr8=;
        b=mfMSqDlepDHsXtwyoSDH2v5jEYAm80dpzta/lQ53FFmmWPio4R6a5lBiYsWFfsodyw
         oJuErKN7uSa0OY42t6iNKibDalRMMLlAa7tlEzzfPp4NzpjmSuSjEkFX4JWyWUgKWCfp
         PH73Q9P/RGWjRq5PuBR9jHRZn1PACyhvPYvHF6Vq8tL4Ly89gs90Z/NnXlQCeVPmg79f
         ThRztDJn3fgZvTIhwx5BIYvrGmSBD8w/Y3EovuDwjLBAI3+GgcOi+C1aL68CdsNnCyBn
         lil6gPndfpRYANAXT1RWzrovfFYr2eulakyNm0YM7ZQdpijyDOoxF5CLPAKD1g3ZAsvL
         B2sg==
X-Gm-Message-State: AOAM531f/y2wAa+zUfrVKvR0+CjBZBDYfwb+gPM2GXGGPLWFO2Oc6qAy
        YybHTs/tyVlA+w4enemCZjqcSblZVutvmbPxJd9MqVuxMFrCMg==
X-Google-Smtp-Source: ABdhPJywkBCAjCV6YqZ8AKtF0RFGcAnJ/1sRnOg58+CcXRewzN7xVIbRoYnDJS7nSu0nTWLtA2/AxEQnVfqUL98FbEM=
X-Received: by 2002:a17:906:a2c9:: with SMTP id by9mr40131353ejb.305.1634658675541;
 Tue, 19 Oct 2021 08:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
 <20211018220314.85115-4-olga.kornievskaia@gmail.com> <7C2CC1B3-732D-43B4-82CE-932DF82DD14B@oracle.com>
In-Reply-To: <7C2CC1B3-732D-43B4-82CE-932DF82DD14B@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 19 Oct 2021 11:51:04 -0400
Message-ID: <CAN-5tyFYdod0ubGXgoJvM0wSJ+skYpmS+d8JEu942BXbfFcVDA@mail.gmail.com>
Subject: Re: [PATCH 3/7] NFSv4.2 add tracepoint to COPY
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 19, 2021 at 11:31 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Oct 18, 2021, at 6:03 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Add a tracepoint to the COPY operation.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> > fs/nfs/nfs42proc.c |   1 +
> > fs/nfs/nfs4trace.h | 101 +++++++++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 102 insertions(+)
> >
> > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > index c36824888601..a072cdaf7bdc 100644
> > --- a/fs/nfs/nfs42proc.c
> > +++ b/fs/nfs/nfs42proc.c
> > @@ -367,6 +367,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
> >
> >       status = nfs4_call_sync(dst_server->client, dst_server, &msg,
> >                               &args->seq_args, &res->seq_res, 0);
> > +     trace_nfs4_copy(src_inode, dst_inode, args, res, nss, status);
>
> There seems to be a lot of logic in _nfs42_proc_copy() that
> happens after this tracepoint. Are you sure this is the
> best placement, or do you want to capture failures that
> might happen in the subsequent logic?

I do believe this is the right place for the COPY tracepoint. There
are 3 more logical decisions after that. (1) dealing with synchronous
copy with an incorrect verifier -- perhaps that warrants a separate
tracepoints as a generic COPY doesn't capture verifier information at
all, (2) deals with completion of async copy but for that we have a
tracepoint in the callback, and (3) handling commit after copy but
that has a commit tracepoint in the COMMIT operation.

> >       if (status == -ENOTSUPP)
> >               dst_server->caps &= ~NFS_CAP_COPY;
> >       if (status)
> > diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> > index ba338ee4a82b..4beb59d78ff3 100644
> > --- a/fs/nfs/nfs4trace.h
> > +++ b/fs/nfs/nfs4trace.h
> > @@ -2540,6 +2540,107 @@ DECLARE_EVENT_CLASS(nfs4_sparse_event,
> > DEFINE_NFS4_SPARSE_EVENT(nfs4_fallocate);
> > DEFINE_NFS4_SPARSE_EVENT(nfs4_deallocate);
> >
> > +TRACE_EVENT(nfs4_copy,
> > +             TP_PROTO(
> > +                     const struct inode *src_inode,
> > +                     const struct inode *dst_inode,
> > +                     const struct nfs42_copy_args *args,
> > +                     const struct nfs42_copy_res *res,
> > +                     const struct nl4_server *nss,
> > +                     int error
> > +             ),
> > +
> > +             TP_ARGS(src_inode, dst_inode, args, res, nss, error),
> > +
> > +             TP_STRUCT__entry(
> > +                     __field(unsigned long, error)
> > +                     __field(u32, src_fhandle)
> > +                     __field(u32, src_fileid)
> > +                     __field(u32, dst_fhandle)
> > +                     __field(u32, dst_fileid)
> > +                     __field(dev_t, src_dev)
> > +                     __field(dev_t, dst_dev)
> > +                     __field(int, src_stateid_seq)
> > +                     __field(u32, src_stateid_hash)
> > +                     __field(int, dst_stateid_seq)
> > +                     __field(u32, dst_stateid_hash)
> > +                     __field(loff_t, src_offset)
> > +                     __field(loff_t, dst_offset)
> > +                     __field(bool, sync)
> > +                     __field(loff_t, len)
> > +                     __field(int, res_stateid_seq)
> > +                     __field(u32, res_stateid_hash)
> > +                     __field(loff_t, res_count)
> > +                     __field(bool, res_sync)
> > +                     __field(bool, res_cons)
> > +                     __field(bool, intra)
> > +             ),
> > +
> > +             TP_fast_assign(
> > +                     const struct nfs_inode *src_nfsi = NFS_I(src_inode);
> > +                     const struct nfs_inode *dst_nfsi = NFS_I(dst_inode);
> > +
> > +                     __entry->src_fileid = src_nfsi->fileid;
> > +                     __entry->src_dev = src_inode->i_sb->s_dev;
> > +                     __entry->src_fhandle = nfs_fhandle_hash(args->src_fh);
> > +                     __entry->src_offset = args->src_pos;
> > +                     __entry->dst_fileid = dst_nfsi->fileid;
> > +                     __entry->dst_dev = dst_inode->i_sb->s_dev;
> > +                     __entry->dst_fhandle = nfs_fhandle_hash(args->dst_fh);
> > +                     __entry->dst_offset = args->dst_pos;
> > +                     __entry->len = args->count;
> > +                     __entry->sync = args->sync;
> > +                     __entry->error = error < 0 ? -error : 0;
> > +                     __entry->src_stateid_seq =
> > +                             be32_to_cpu(args->src_stateid.seqid);
> > +                     __entry->src_stateid_hash =
> > +                             nfs_stateid_hash(&args->src_stateid);
> > +                     __entry->dst_stateid_seq =
> > +                             be32_to_cpu(args->dst_stateid.seqid);
> > +                     __entry->dst_stateid_hash =
> > +                             nfs_stateid_hash(&args->dst_stateid);
> > +                     __entry->res_stateid_seq = error < 0 ? 0 :
> > +                             be32_to_cpu(res->write_res.stateid.seqid);
> > +                     __entry->res_stateid_hash = error < 0 ? 0 :
> > +                             nfs_stateid_hash(&res->write_res.stateid);
> > +                     __entry->res_count = error < 0 ? 0 :
> > +                             res->write_res.count;
> > +                     __entry->res_sync = error < 0 ? 0 :
> > +                             res->synchronous;
> > +                     __entry->res_cons = error < 0 ? 0 :
> > +                             res->consecutive;
> > +                     __entry->intra = nss ? 0 : 1;
> > +             ),
>
> I have some general comments about the ternaries here
> and in some of the other patches.
>
> At the very least you should instead have a single check:
>
>         if (error) {
>                 /* record all the error values */
>         } else {
>                 /* record zeroes */
>         }
>
> Although, I recommend a different approach entirely,
> and that is to to have /two/ trace points: one for
> the success case and one for the error case. That
> way the error case can be enabled persistently, as
> appropriate, and the success case can be used for
> general debugging, which ought to be rare once the
> code is working well and we have good error reporting
> in user space.

I think I see what you are saying with having something like (in
nfs42proc.c in copy)
nfs4_call_sync()
if (status)
  trace_nfs4_copy_err()
else
  trace_nfs4_copy()

That would replace my checking for error and setting the field. I can
do that. But I'm not sure how to handle sharing of "call" arguments
that we'd want to display for both the error case tracepoint and
non-error case. If I'm missing an approach on how to can you please
share, or otherwise, in my revision I'd re-write using if (error)
approach and keep just a single tracepoint.

> In some instances (maybe not here in copy), the
> success tracepoint is completely unnecessary for
> everyday operation and can be omitted.
>
> What's your thought about that?
>
>
> > +
> > +             TP_printk(
> > +                     "error=%ld (%s) intra=%d src_fileid=%02x:%02x:%llu "
> > +                     "src_fhandle=0x%08x dst_fileid=%02x:%02x:%llu "
> > +                     "dst_fhandle=0x%08x src_stateid=%d:0x%08x "
> > +                     "dst_stateid=%d:0x%08x src_offset=%llu dst_offset=%llu "
> > +                     "len=%llu sync=%d cb_stateid=%d:0x%08x res_sync=%d "
> > +                     "res_cons=%d res_count=%llu",
> > +                     -__entry->error,
> > +                     show_nfsv4_errors(__entry->error),
> > +                     __entry->intra,
> > +                     MAJOR(__entry->src_dev), MINOR(__entry->src_dev),
> > +                     (unsigned long long)__entry->src_fileid,
> > +                     __entry->src_fhandle,
> > +                     MAJOR(__entry->dst_dev), MINOR(__entry->dst_dev),
> > +                     (unsigned long long)__entry->dst_fileid,
> > +                     __entry->dst_fhandle,
> > +                     __entry->src_stateid_seq, __entry->src_stateid_hash,
> > +                     __entry->dst_stateid_seq, __entry->dst_stateid_hash,
> > +                     __entry->src_offset,
> > +                     __entry->dst_offset,
> > +                     __entry->len,
> > +                     __entry->sync,
> > +                     __entry->res_stateid_seq, __entry->res_stateid_hash,
> > +                     __entry->res_sync,
> > +                     __entry->res_cons,
> > +                     __entry->res_count
> > +             )
> > +);
> > +
> > #endif /* CONFIG_NFS_V4_1 */
> >
> > #endif /* _TRACE_NFS4_H */
> > --
> > 2.27.0
> >
>
> --
> Chuck Lever
>
>
>
