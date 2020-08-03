Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8084623AD76
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 21:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgHCTln (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 15:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgHCTlm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 15:41:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD89C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 12:41:42 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a21so39873178ejj.10
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XCoy95YbafT72EqnjQESZeC5XCHvcLFSCFryv0PkM5c=;
        b=i6xTAziqqyREh0JFeOzWLhNlTMXurIy4dakq4WU3P6WTG1c3wJQAzueAUfEkUKyP33
         8N2xh+Oc2D43AFsvkF6fPHylnR3y7063AzqMQ5OsLwq5ehvmfIQsWfN9u5EyMGWVzp6j
         yajNmrBRG1bvFsmpgZKIu/uOXK7EyRyhGsV8gZwfrtam6eE28oy64lco2alMorGT+uCW
         0ULLVcSB5j74NkigsQSghi4lbRzl+AZK+g3ZZFSTIfYnyFm80iImaThuhKXpknvG0MVi
         MkUhVEy0a4L1+ifEJJe96NHKYVCe3HLROU8vQxodTqM2JZcbSiy027je94UsiIKqmJUc
         jIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCoy95YbafT72EqnjQESZeC5XCHvcLFSCFryv0PkM5c=;
        b=UVjXFE3j13RdAg9KZB92RsVlLnVdIxDHE11poCFov5UiDOPIaEpTvCaof9YwrUBLYR
         AGmFfC3+Sjv5hVIetAMqB+tcU7ZH4qOy2Hu70Jkl9lcLim+kF3bWWv1+j2xJRESTktDS
         WDxccsxDD5q7/uPQVIiaRvQvIH+O2mNJ1jJ+WS8fF4CsoLqqUtnOXflUe4i9b5mUNRFZ
         Q0C1UOiGbtoHfuzSKAv/tedgxyIwucF2kv2guSi+3DMj59Gu71ZDChSFqpEdLK43ZXkY
         0lpHn6S+C+oviA4lfUs8uO9xzLVd4hvtKkG7wXPrcl5M05MN/sVgGxw6tAYVCSzA18Dd
         zR/A==
X-Gm-Message-State: AOAM531HOXVWT8HnXbU2BtxXUxHmAnwwP4wu/XtU129SipETDot++mLs
        dVGmfYhO2JAIcsuFaACzzaNmjlkQGmjboK6486w=
X-Google-Smtp-Source: ABdhPJxU9ZW4lZzW5XkYl4OnkKmfJWLaaZPGGg/TmdKfvb45YYuTF2HREps6siMKRiHTofNgoD2WiNa6OZrvf7CdnCw=
X-Received: by 2002:a17:906:3449:: with SMTP id d9mr18602551ejb.460.1596483701044;
 Mon, 03 Aug 2020 12:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
 <20200803165954.1348263-4-Anna.Schumaker@Netapp.com> <5E30AC25-1249-4D91-A2B6-13A38DB2A253@oracle.com>
In-Reply-To: <5E30AC25-1249-4D91-A2B6-13A38DB2A253@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 3 Aug 2020 15:41:24 -0400
Message-ID: <CAFX2Jf=9SqLpfEa4NYaEenXZm7skWzUb7OCr1eNGUd1MoGVmmw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] NFSD: Add READ_PLUS data support
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Mon, Aug 3, 2020 at 3:19 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi Anna-
>
> > On Aug 3, 2020, at 12:59 PM, schumaker.anna@gmail.com wrote:
> >
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > This patch adds READ_PLUS support for returning a single
> > NFS4_CONTENT_DATA segment to the client. This is basically the same as
> > the READ operation, only with the extra information about data segments.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> > fs/nfsd/nfs4proc.c | 17 ++++++++++
> > fs/nfsd/nfs4xdr.c  | 85 ++++++++++++++++++++++++++++++++++++++++++++--
> > 2 files changed, 100 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index a09c35f0f6f0..9630d33211f2 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2523,6 +2523,16 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> >       return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
> > }
> >
> > +static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > +{
> > +     u32 maxcount = svc_max_payload(rqstp);
> > +     u32 rlen = min(op->u.read.rd_length, maxcount);
> > +     /* enough extra xdr space for encoding either a hole or data segment. */
> > +     u32 segments = 1 + 2 + 2;
> > +
> > +     return (op_encode_hdr_size + 2 + segments + XDR_QUADLEN(rlen)) * sizeof(__be32);
> > +}
> > +
> > static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > {
> >       u32 maxcount = 0, rlen = 0;
> > @@ -3059,6 +3069,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
> > index 6a1c0a7fae05..1d143bf02b83 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -1957,7 +1957,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
> >       [OP_LAYOUTSTATS]        = (nfsd4_dec)nfsd4_decode_notsupp,
> >       [OP_OFFLOAD_CANCEL]     = (nfsd4_dec)nfsd4_decode_offload_status,
> >       [OP_OFFLOAD_STATUS]     = (nfsd4_dec)nfsd4_decode_offload_status,
> > -     [OP_READ_PLUS]          = (nfsd4_dec)nfsd4_decode_notsupp,
> > +     [OP_READ_PLUS]          = (nfsd4_dec)nfsd4_decode_read,
> >       [OP_SEEK]               = (nfsd4_dec)nfsd4_decode_seek,
> >       [OP_WRITE_SAME]         = (nfsd4_dec)nfsd4_decode_notsupp,
> >       [OP_CLONE]              = (nfsd4_dec)nfsd4_decode_clone,
> > @@ -4367,6 +4367,87 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
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
>
> nfsd4_encode_read() has this:
>
> 3904         if (file->f_op->splice_read &&
> 3905             test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags))
> 3906                 nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
> 3907         else
> 3908                 nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
>
> So READ_PLUS never uses ->splice_read.
>
> readv is known to be less efficient than splice. Is there a measurable
> server performance impact (either latency or CPU utilization) when
> reading a file with no holes?

Good question, and I haven't measured that. For a while I was doing
the first read data segment with a splice, but that was having issues.
I should circle back and see if that's still a problem now that I've
fixed a bunch of other bugs.

>
>
> > +     if (nfserr)
> > +             return nfserr;
> > +     if (svc_encode_read_payload(resp->rqstp, starting_len + 16, maxcount))
> > +             return nfserr_io;
>
> Not sure you want a read_payload call here. This is to notify the
> transport that there is a section of the message that can be sent
> via RDMA, but READ_PLUS has no DDP-eligible data items; especially
> not holes!

Sure thing. I'll remove that for the next version.

Anna
>
> Although, the call is not likely to be much more than a no-op,
> since clients won't be providing any Write chunks for READ_PLUS.
>
>
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
> > }
> > @@ -4509,7 +4590,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
> >       [OP_LAYOUTSTATS]        = (nfsd4_enc)nfsd4_encode_noop,
> >       [OP_OFFLOAD_CANCEL]     = (nfsd4_enc)nfsd4_encode_noop,
> >       [OP_OFFLOAD_STATUS]     = (nfsd4_enc)nfsd4_encode_offload_status,
> > -     [OP_READ_PLUS]          = (nfsd4_enc)nfsd4_encode_noop,
> > +     [OP_READ_PLUS]          = (nfsd4_enc)nfsd4_encode_read_plus,
> >       [OP_SEEK]               = (nfsd4_enc)nfsd4_encode_seek,
> >       [OP_WRITE_SAME]         = (nfsd4_enc)nfsd4_encode_noop,
> >       [OP_CLONE]              = (nfsd4_enc)nfsd4_encode_noop,
> > --
> > 2.27.0
> >
>
> --
> Chuck Lever
>
>
>
