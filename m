Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99972632E4
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Sep 2020 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbgIIQxk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Sep 2020 12:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730939AbgIIQxf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Sep 2020 12:53:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3A0C061573
        for <linux-nfs@vger.kernel.org>; Wed,  9 Sep 2020 09:53:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z22so4556604ejl.7
        for <linux-nfs@vger.kernel.org>; Wed, 09 Sep 2020 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snpdJa8IBy01ZPM2bsTR1z2qbOmy44Bnyd/h1RTnFXQ=;
        b=QXMhBtJByRcyCYV372I9aBbU4ualy4wX3nIJFbe1nxJDloQ76NBJGpmhVUGmSuAsi0
         dPXufn0dk9S4Nlq49VgQer8DAJjR+feE7eOTBW+sAVAGoM5QQEt/0Fv+TfhjsODBP0dI
         eqm/AWN14Yx3mSuDKzPwiGN42csrnPBh69nhpm17dtQcO+/5NR5sun3HtBr+GYu8lsVO
         2m0gtiHPhMItZpmdM8nCNHXa1Teu9AIt2GPEVMjPwy/PnPhON65U3sQxq1dWut7FWei9
         LSsPDFXIbgpId8TmmOR6zJYkt6c49m2CZoor9L66h/uFteVcj60JmQ2g/A5NSs+aebZH
         U1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snpdJa8IBy01ZPM2bsTR1z2qbOmy44Bnyd/h1RTnFXQ=;
        b=HPBqJIbpeEBY+yS2PqHsFX82wC8QViOicVY9JoQkBUMmhNSn+I/aTkm6In7rRwFQ3z
         xisn0GbaSejUSzHoopuod4tXBswc+hSh7lqb6huLEGr5HlYhi7AJXYIM/L7nMTdjvwNs
         aIB0LIOjVc9g3PKD6R2XmEqnSC38yFlhLeAtTiif7lf53p0xMTp02RMu/bcAXJASIb6H
         3qFF2CF9TZkhhGDkD8BZDhOuM7saHqoPXs78K4HRYQJDvuZ9oCBH2ZlM159erQKssFHy
         3dKSaMu1HDbse0AGmv4X3J2kmEwjPzv0OHjIUbA5bjGK7RF5Ror+Admsc24KPJsiW7Gc
         1QsQ==
X-Gm-Message-State: AOAM531gr0B2aZEROQbC5gkODR/mSfQiTmaZgYIRHYl/VjCLc1/lKPTK
        LEB8dmuJjuHIjLMOHGDkwwGSH5jF/r5Tze61VBNp24V1
X-Google-Smtp-Source: ABdhPJxVn5xUHNS/Pb/ypwG8ySMITsCe60DZDeT1r345q4Tjk38lT4ohNmEFTHmaOh1Rzgny3hbY5NWECORYda4QrH8=
X-Received: by 2002:a17:906:b090:: with SMTP id x16mr4573651ejy.46.1599670413892;
 Wed, 09 Sep 2020 09:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
 <20200908162559.509113-3-Anna.Schumaker@Netapp.com> <20200908194245.GB6256@pick.fieldses.org>
In-Reply-To: <20200908194245.GB6256@pick.fieldses.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 9 Sep 2020 12:53:18 -0400
Message-ID: <CAFX2Jfkt0Qv1oO6iEr21N3zjkvE7VyKQQ47g2vQ4PHV6xmgrSg@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] NFSD: Add READ_PLUS data support
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 8, 2020 at 3:42 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Tue, Sep 08, 2020 at 12:25:56PM -0400, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > This patch adds READ_PLUS support for returning a single
> > NFS4_CONTENT_DATA segment to the client. This is basically the same as
> > the READ operation, only with the extra information about data segments.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > ---
> > v5: Fix up nfsd4_read_plus_rsize() calculation
> > ---
> >  fs/nfsd/nfs4proc.c | 20 +++++++++++
> >  fs/nfsd/nfs4xdr.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 101 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index eaf50eafa935..0a3df5f10501 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2591,6 +2591,19 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> >       return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
> >  }
> >
> > +static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > +{
> > +     u32 maxcount = svc_max_payload(rqstp);
> > +     u32 rlen = min(op->u.read.rd_length, maxcount);
> > +     /*
> > +      * Worst case is a single large data segment, so make
> > +      * sure we have enough room to encode that
> > +      */
>
> After the last patch we allow an unlimited number of segments.  So a
> zillion 1-byte segments is also possible, and is a worse case.
>
> Possible ways to avoid that kind of thing:
>
>         - when encoding, stop and return a short read if the xdr-encoded
>           result would exceed the limit calculated here.

Doesn't this happen automatically through calls to xdr_reserve_space()?

>         - round SEEK_HOLE results up to the nearest (say) 512 bytes, and
>           SEEK_DATA result down to the nearest 512 bytes.  May also need
>           some logic to avoid encoding 0-length segments.
>         - talk to linux-fsdevel, see if we can get a minimum hole
>           alignment guarantee from filesystems.
>
> I'm thinking #1 is simplest.
>
> --b.
>
> > +     u32 seg_len = 1 + 2 + 1;
> > +
> > +     return (op_encode_hdr_size + 2 + seg_len + XDR_QUADLEN(rlen)) * sizeof(__be32);
> > +}
> > +
> >  static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> >  {
> >       u32 maxcount = 0, rlen = 0;
> > @@ -3163,6 +3176,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
> >               .op_name = "OP_COPY",
> >               .op_rsize_bop = nfsd4_copy_rsize,
> >       },
> > +     [OP_READ_PLUS] = {
> > +             .op_func = nfsd4_read,
> > +             .op_release = nfsd4_read_release,
> > +             .op_name = "OP_READ_PLUS",
> > +             .op_rsize_bop = nfsd4_read_plus_rsize,
> > +             .op_get_currentstateid = nfsd4_get_readstateid,
> > +     },
> >       [OP_SEEK] = {
> >               .op_func = nfsd4_seek,
> >               .op_name = "OP_SEEK",
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 0be194de4888..26d12e3edf33 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -2173,7 +2173,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
> >       [OP_LAYOUTSTATS]        = (nfsd4_dec)nfsd4_decode_notsupp,
> >       [OP_OFFLOAD_CANCEL]     = (nfsd4_dec)nfsd4_decode_offload_status,
> >       [OP_OFFLOAD_STATUS]     = (nfsd4_dec)nfsd4_decode_offload_status,
> > -     [OP_READ_PLUS]          = (nfsd4_dec)nfsd4_decode_notsupp,
> > +     [OP_READ_PLUS]          = (nfsd4_dec)nfsd4_decode_read,
> >       [OP_SEEK]               = (nfsd4_dec)nfsd4_decode_seek,
> >       [OP_WRITE_SAME]         = (nfsd4_dec)nfsd4_decode_notsupp,
> >       [OP_CLONE]              = (nfsd4_dec)nfsd4_decode_clone,
> > @@ -4597,6 +4597,85 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
> >               return nfserr_resource;
> >       p = xdr_encode_hyper(p, os->count);
> >       *p++ = cpu_to_be32(0);
> > +     return nfserr;
> > +}
> > +
> > +static __be32
> > +nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> > +                         struct nfsd4_read *read,
> > +                         unsigned long maxcount,  u32 *eof)
> > +{
> > +     struct xdr_stream *xdr = &resp->xdr;
> > +     struct file *file = read->rd_nf->nf_file;
> > +     int starting_len = xdr->buf->len;
> > +     __be32 nfserr;
> > +     __be32 *p, tmp;
> > +     __be64 tmp64;
> > +
> > +     /* Content type, offset, byte count */
> > +     p = xdr_reserve_space(xdr, 4 + 8 + 4);
> > +     if (!p)
> > +             return nfserr_resource;
> > +
> > +     read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
> > +     if (read->rd_vlen < 0)
> > +             return nfserr_resource;
> > +
> > +     nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> > +                         resp->rqstp->rq_vec, read->rd_vlen, &maxcount, eof);
> > +     if (nfserr)
> > +             return nfserr;
> > +
> > +     tmp = htonl(NFS4_CONTENT_DATA);
> > +     write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> > +     tmp64 = cpu_to_be64(read->rd_offset);
> > +     write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> > +     tmp = htonl(maxcount);
> > +     write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> > +     return nfs_ok;
> > +}
> > +
> > +static __be32
> > +nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> > +                    struct nfsd4_read *read)
> > +{
> > +     unsigned long maxcount;
> > +     struct xdr_stream *xdr = &resp->xdr;
> > +     struct file *file;
> > +     int starting_len = xdr->buf->len;
> > +     int segments = 0;
> > +     __be32 *p, tmp;
> > +     u32 eof;
> > +
> > +     if (nfserr)
> > +             return nfserr;
> > +     file = read->rd_nf->nf_file;
> > +
> > +     /* eof flag, segment count */
> > +     p = xdr_reserve_space(xdr, 4 + 4);
> > +     if (!p)
> > +             return nfserr_resource;
> > +     xdr_commit_encode(xdr);
> > +
> > +     maxcount = svc_max_payload(resp->rqstp);
> > +     maxcount = min_t(unsigned long, maxcount,
> > +                      (xdr->buf->buflen - xdr->buf->len));
> > +     maxcount = min_t(unsigned long, maxcount, read->rd_length);
> > +
> > +     eof = read->rd_offset >= i_size_read(file_inode(file));
> > +     if (!eof) {
> > +             nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
> > +             segments++;
> > +     }
> > +
> > +     if (nfserr)
> > +             xdr_truncate_encode(xdr, starting_len);
> > +     else {
> > +             tmp = htonl(eof);
> > +             write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> > +             tmp = htonl(segments);
> > +             write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> > +     }
> >
> >       return nfserr;
> >  }
> > @@ -4974,7 +5053,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
> >       [OP_LAYOUTSTATS]        = (nfsd4_enc)nfsd4_encode_noop,
> >       [OP_OFFLOAD_CANCEL]     = (nfsd4_enc)nfsd4_encode_noop,
> >       [OP_OFFLOAD_STATUS]     = (nfsd4_enc)nfsd4_encode_offload_status,
> > -     [OP_READ_PLUS]          = (nfsd4_enc)nfsd4_encode_noop,
> > +     [OP_READ_PLUS]          = (nfsd4_enc)nfsd4_encode_read_plus,
> >       [OP_SEEK]               = (nfsd4_enc)nfsd4_encode_seek,
> >       [OP_WRITE_SAME]         = (nfsd4_enc)nfsd4_encode_noop,
> >       [OP_CLONE]              = (nfsd4_enc)nfsd4_encode_noop,
> > --
> > 2.28.0
> >
>
