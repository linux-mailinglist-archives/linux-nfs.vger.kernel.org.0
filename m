Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743C8665D7B
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 15:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjAKOQ1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 09:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbjAKOQC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 09:16:02 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B3EF57
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 06:15:58 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v23so11997747plo.1
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 06:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=033l+iH9SmmH3YDXhVpm3b/E8HtYhK9QV2Vs7w8GZLI=;
        b=Ik+IE5cZKrFESoznBltxWq/InPPYjwIjM21/5H1/w0f4Ql4LQC5JJR+9f1jeRvePaa
         ZKMULtBECYvCj1gVaT+2g9Nc8wByqONVHH2TkB+qxoFddt+gBFkM2UihOjVHghjmJ+PK
         ClJyuvc1p9nzzaj49W0a0LfC1mLRdDlynJQlVfRxNUmETqvhDLbTHYOomwZBywlxLULK
         tO0BWX9MYRWp0AtstyuVxkt/mTMO82wir+nrrjylA6TG7gXfoP0/4M5LtGKa5C6Kyawe
         jHhYQXNTvJsVX4B9MdCEmZISnG5Sfg3Eng7YD5xaMkDhAiGwxWconAFqxCKrWYLHkpUF
         /x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=033l+iH9SmmH3YDXhVpm3b/E8HtYhK9QV2Vs7w8GZLI=;
        b=RbxYpkXB1xz/8JJER4vzhmDpvelrylOr4tsAaNnaFbSJkk+UFMIEYBusrCKXR1BXcb
         huwjN8QRQAlusqlLHI9Vp4YASRfZiAy48JcI7faZnd72gQQyBxpDBnMk2JhsP6X92IEP
         NJumhxX+zPn2M8TdVzfAZu1OkVRWUve1OyPZ3TEzI6u8wY9snN/CmzTQn5R8E9hGrz8f
         vthLKSEmK4VZNMyE9g5jOwBTUzF01Zf2OiZ3QydpK9niI+2lKZnFThrSDDYxa7gvpzKx
         4KxWoP2u+ta1fSbzgrytSlQgXymYKSOv+8aq4RiHcYNCX0yVB60Bix/aLWPUqBJsHj+U
         2VPA==
X-Gm-Message-State: AFqh2kqsy4yRu5jT2xjqHw/lvQAaDlx+ZSCo+WFWiKBDYqwEC7cpnpZx
        hNkeWqYoNKbr7rKN2VHpkan/QGngTQTeD13/LkngQGJU
X-Google-Smtp-Source: AMrXdXtN4aT+scA/7bA5ELMDgpPUk5/XYdKNH34Fx2Ibv5Jjwb4Kaft8zJDFVfXF+9h+LdLAtd2L/PeyxabprhctpCU=
X-Received: by 2002:a17:902:d1cb:b0:194:4768:937c with SMTP id
 g11-20020a170902d1cb00b001944768937cmr425053plb.125.1673446557235; Wed, 11
 Jan 2023 06:15:57 -0800 (PST)
MIME-Version: 1.0
References: <20230110184726.13380-1-mora@netapp.com> <525FDD70-D00A-40DD-9C2A-71048F4D612E@oracle.com>
In-Reply-To: <525FDD70-D00A-40DD-9C2A-71048F4D612E@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 11 Jan 2023 09:15:45 -0500
Message-ID: <CAN-5tyG_aefN8x1bzif7CTnv3_b3qf2V2mWk3c-Uu7MamFR2oA@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: add IO_ADVISE operation
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jorge Mora <jmora1300@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 10, 2023 at 2:04 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jan 10, 2023, at 1:47 PM, Jorge Mora <jmora1300@gmail.com> wrote:
> >
> > If multiple bits are set, select just one using a predetermined
> > order of precedence. If there are no bits which correspond to
> > any of the advice values (POSIX_FADV_*), the server simply
> > replies with NFS4ERR_UNION_NOTSUPP.
> >
> > If a client sends a bitmap mask with multiple words, ignore all
> > but the first word in the bitmap. The response is always the
> > same first word of the bitmap mask given in the request.
>
> Hi Jorge-
>
> I'd rather not add this operation just because it happens to be
> missing. Is there a reason you need it?

The motivation was to implement the not implement and hope to serve as
a foundation for others to expand on and do something. Also because
typically if we put in a client piece support there is supposed to be
server side as well.

> Does it provide some
> kind of performance benefit, for instance? The patch description
> really does need to provide this kind of rationale, and hopefully
> some performance measurements.
>
> Do the POSIX_FADV_* settings map to behavior that a client can
> expect in other server implementations?

I thought the purpose of IO_ADVISE is to advise but not expect. If the
server wants to do something with the knowledge it can.

> That is, do you expect
>  the proposed implementation below to interoperate properly?
>
>
> > Signed-off-by: Jorge Mora <mora@netapp.com>
> > ---
> > fs/nfsd/nfs4proc.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
> > fs/nfsd/nfs4xdr.c  | 27 +++++++++++++++++++--
> > fs/nfsd/xdr4.h     | 11 +++++++++
> > 3 files changed, 95 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 8beb2bc4c328..65179a3946f5 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -35,6 +35,7 @@
> > #include <linux/fs_struct.h>
> > #include <linux/file.h>
> > #include <linux/falloc.h>
> > +#include <linux/fadvise.h>
> > #include <linux/slab.h>
> > #include <linux/kthread.h>
> > #include <linux/namei.h>
> > @@ -1995,6 +1996,53 @@ nfsd4_deallocate(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >                              FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > }
> >
> > +static __be32
> > +nfsd4_io_advise(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > +             union nfsd4_op_u *u)
> > +{
> > +     struct nfsd4_io_advise *io_advise = &u->io_advise;
> > +     struct nfsd_file *nf;
> > +     __be32 status;
> > +     int advice;
> > +     int ret;
> > +
> > +     status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
> > +                                         &io_advise->stateid,
> > +                                         RD_STATE, &nf, NULL);
> > +     if (status) {
> > +             dprintk("NFSD: %s: couldn't process stateid!\n", __func__);
> > +             return status;
> > +     }
> > +
> > +     /*
> > +      * If multiple bits are set, select just one using the following
> > +      * order of precedence
> > +      */
> > +     if (io_advise->hints & NFS_IO_ADVISE4_NORMAL)
> > +             advice = POSIX_FADV_NORMAL;
> > +     else if (io_advise->hints & NFS_IO_ADVISE4_RANDOM)
> > +             advice = POSIX_FADV_RANDOM;
> > +     else if (io_advise->hints & NFS_IO_ADVISE4_SEQUENTIAL)
> > +             advice = POSIX_FADV_SEQUENTIAL;
> > +     else if (io_advise->hints & NFS_IO_ADVISE4_WILLNEED)
> > +             advice = POSIX_FADV_WILLNEED;
> > +     else if (io_advise->hints & NFS_IO_ADVISE4_DONTNEED)
> > +             advice = POSIX_FADV_DONTNEED;
> > +     else if (io_advise->hints & NFS_IO_ADVISE4_NOREUSE)
> > +             advice = POSIX_FADV_NOREUSE;
> > +     else {
> > +             status = nfserr_union_notsupp;
> > +             goto out;
> > +     }
> > +
> > +     ret = vfs_fadvise(nf->nf_file, io_advise->offset, io_advise->count, advice);
> > +     if (ret < 0)
> > +             status = nfserrno(ret);
> > +out:
> > +     nfsd_file_put(nf);
> > +     return status;
> > +}
> > +
> > static __be32
> > nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >          union nfsd4_op_u *u)
> > @@ -3096,6 +3144,12 @@ static u32 nfsd4_layoutreturn_rsize(const struct svc_rqst *rqstp,
> > #endif /* CONFIG_NFSD_PNFS */
> >
> >
> > +static u32 nfsd4_io_advise_rsize(const struct svc_rqst *rqstp,
> > +                              const struct nfsd4_op *op)
> > +{
> > +     return (op_encode_hdr_size + 2) * sizeof(__be32);
> > +}
> > +
> > static u32 nfsd4_seek_rsize(const struct svc_rqst *rqstp,
> >                           const struct nfsd4_op *op)
> > {
> > @@ -3479,6 +3533,11 @@ static const struct nfsd4_operation nfsd4_ops[] = {
> >               .op_name = "OP_DEALLOCATE",
> >               .op_rsize_bop = nfsd4_only_status_rsize,
> >       },
> > +     [OP_IO_ADVISE] = {
> > +             .op_func = nfsd4_io_advise,
> > +             .op_name = "OP_IO_ADVISE",
> > +             .op_rsize_bop = nfsd4_io_advise_rsize,
> > +     },
> >       [OP_CLONE] = {
> >               .op_func = nfsd4_clone,
> >               .op_flags = OP_MODIFIES_SOMETHING,
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index bcfeb1a922c0..8814c24047ff 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -1882,6 +1882,22 @@ nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
> >       return nfs_ok;
> > }
> >
> > +static __be32
> > +nfsd4_decode_io_advise(struct nfsd4_compoundargs *argp,
> > +                    struct nfsd4_io_advise *io_advise)
> > +{
> > +     __be32 status;
> > +
> > +     status = nfsd4_decode_stateid4(argp, &io_advise->stateid);
> > +     if (status)
> > +             return status;
> > +     if (xdr_stream_decode_u64(argp->xdr, &io_advise->offset) < 0)
> > +             return nfserr_bad_xdr;
> > +     if (xdr_stream_decode_u64(argp->xdr, &io_advise->count) < 0)
> > +             return nfserr_bad_xdr;
> > +     return nfsd4_decode_bitmap4(argp, &io_advise->hints, 1);
> > +}
> > +
> > static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
> >                                     struct nl4_server *ns)
> > {
> > @@ -2338,7 +2354,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
> >       [OP_COPY]               = (nfsd4_dec)nfsd4_decode_copy,
> >       [OP_COPY_NOTIFY]        = (nfsd4_dec)nfsd4_decode_copy_notify,
> >       [OP_DEALLOCATE]         = (nfsd4_dec)nfsd4_decode_fallocate,
> > -     [OP_IO_ADVISE]          = (nfsd4_dec)nfsd4_decode_notsupp,
> > +     [OP_IO_ADVISE]          = (nfsd4_dec)nfsd4_decode_io_advise,
> >       [OP_LAYOUTERROR]        = (nfsd4_dec)nfsd4_decode_notsupp,
> >       [OP_LAYOUTSTATS]        = (nfsd4_dec)nfsd4_decode_notsupp,
> >       [OP_OFFLOAD_CANCEL]     = (nfsd4_dec)nfsd4_decode_offload_status,
> > @@ -4948,6 +4964,13 @@ nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
> >       return nfserr;
> > }
> >
> > +static __be32
> > +nfsd4_encode_io_advise(struct nfsd4_compoundres *resp, __be32 nfserr,
> > +                    struct nfsd4_io_advise *io_advise)
> > +{
> > +     return nfsd4_encode_bitmap(resp->xdr, io_advise->hints, 0, 0);
> > +}
> > +
> > static __be32
> > nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
> >                 struct nfsd4_seek *seek)
> > @@ -5282,7 +5305,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
> >       [OP_COPY]               = (nfsd4_enc)nfsd4_encode_copy,
> >       [OP_COPY_NOTIFY]        = (nfsd4_enc)nfsd4_encode_copy_notify,
> >       [OP_DEALLOCATE]         = (nfsd4_enc)nfsd4_encode_noop,
> > -     [OP_IO_ADVISE]          = (nfsd4_enc)nfsd4_encode_noop,
> > +     [OP_IO_ADVISE]          = (nfsd4_enc)nfsd4_encode_io_advise,
> >       [OP_LAYOUTERROR]        = (nfsd4_enc)nfsd4_encode_noop,
> >       [OP_LAYOUTSTATS]        = (nfsd4_enc)nfsd4_encode_noop,
> >       [OP_OFFLOAD_CANCEL]     = (nfsd4_enc)nfsd4_encode_noop,
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index 0eb00105d845..9b8ba4d6e3ab 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -518,6 +518,16 @@ struct nfsd4_fallocate {
> >       u64             falloc_length;
> > };
> >
> > +struct nfsd4_io_advise {
> > +     /* request */
> > +     stateid_t       stateid;
> > +     loff_t          offset;
> > +     u64             count;
> > +
> > +     /* both */
> > +     u32             hints;
> > +};
> > +
> > struct nfsd4_clone {
> >       /* request */
> >       stateid_t       cl_src_stateid;
> > @@ -688,6 +698,7 @@ struct nfsd4_op {
> >               /* NFSv4.2 */
> >               struct nfsd4_fallocate          allocate;
> >               struct nfsd4_fallocate          deallocate;
> > +             struct nfsd4_io_advise          io_advise;
> >               struct nfsd4_clone              clone;
> >               struct nfsd4_copy               copy;
> >               struct nfsd4_offload_status     offload_status;
> > --
> > 2.31.1
> >
>
> --
> Chuck Lever
>
>
>
