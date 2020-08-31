Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43327258095
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Aug 2020 20:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgHaSQr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Aug 2020 14:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgHaSQp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Aug 2020 14:16:45 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2DDC061573
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 11:16:44 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c8so2720887edv.5
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pABY7iB+FljjWRJyfVBQFQXgsPzk1/2R7fsq2sYyxCE=;
        b=YdHCSfT83d/KWClGnY/Bfy2PCowU6xJelDWJOX/9G3W7EtoTrO7RAA1jufDBtBRMnl
         pUP/Aa86NO4kFN707D7n7BlTwC2zVebOjRAThNJ8wsMuzqHDnVVAXNABL+pC+92lY5CQ
         RU79qVvpxbrdXW9/Oo/nAH9PSA7yneyqyYAbebX1f09NoNReAHYkfbqXyBCSZkdSabem
         IBnMbqLNKhJwusBCVz4EChRrv2jqw/MyD13lnHNfzkzXvHFHDjayTqihEAoCmyTLN6hy
         IoDVtax8xzp2h79/Lo/m51KCU/7D3HjW33+HlHHTZKxc65scU2Js/J1o86vrlVEOFvmR
         5hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pABY7iB+FljjWRJyfVBQFQXgsPzk1/2R7fsq2sYyxCE=;
        b=sdid660tYcf7c31HlCvjb4+Hnbu5RZa9DzP9p17eHnkCONB7/o+sEGYPkyfHWAL9/Z
         bhG/QZlYQVK+I9K/o6G83Wok2pT39y4K72LoZxQumbXowp8j/yjxzpMSziClprRBCm+w
         KKnbRW+E+YCmzbkAF65buaYVWQoQxdn381KErGO+moryRGXwuXH+jNHF3+0+qyDhyOOA
         zDrodLBrNXFtt/+0Nwf64U4hEWugbELdu3MFZbDrhZlR59rr3l3Hbmh2LzOqDuJZOv7y
         Vc9TAjkzmNY2P+Q6c1AN3Y3Rt5TDxJVbs0I4c+V1dRMKrXzz/tbty35+8ZQaOPBBXxHE
         od3w==
X-Gm-Message-State: AOAM533pjORIIHBwYyvIqab0tvTnOJIcy4BA4RXDkQoYLGqo01DAPqfL
        SWA4y8rafsQClQ7AT2tYbRm5jERMz1SChlmtANc=
X-Google-Smtp-Source: ABdhPJz7Hx5rQFvYCyv/ia7YTnSRNOxTssJMCs4quOWnlTaihzLGrFNfHPy5LY7AjlVdPos5pwJL952+S4cmk0T8DUY=
X-Received: by 2002:a50:fe0a:: with SMTP id f10mr2210293edt.264.1598897802719;
 Mon, 31 Aug 2020 11:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
 <20200817165310.354092-3-Anna.Schumaker@Netapp.com> <20200828212521.GA33226@pick.fieldses.org>
 <20200828215627.GB33226@pick.fieldses.org>
In-Reply-To: <20200828215627.GB33226@pick.fieldses.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 31 Aug 2020 14:16:26 -0400
Message-ID: <CAFX2Jfn3LN9Zc-=4mAm1mQ3k8PN6C1yF4xqh6B-yyXCxFnp7hQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 28, 2020 at 5:56 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Fri, Aug 28, 2020 at 05:25:21PM -0400, J. Bruce Fields wrote:
> > On Mon, Aug 17, 2020 at 12:53:07PM -0400, schumaker.anna@gmail.com wrote:
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > This patch adds READ_PLUS support for returning a single
> > > NFS4_CONTENT_DATA segment to the client. This is basically the same as
> > > the READ operation, only with the extra information about data segments.
> > >
> > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > ---
> > >  fs/nfsd/nfs4proc.c | 17 ++++++++++
> > >  fs/nfsd/nfs4xdr.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++--
> > >  2 files changed, 98 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index a09c35f0f6f0..9630d33211f2 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -2523,6 +2523,16 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > >     return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
> > >  }
> > >
> > > +static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > > +{
> > > +   u32 maxcount = svc_max_payload(rqstp);
> > > +   u32 rlen = min(op->u.read.rd_length, maxcount);
> > > +   /* enough extra xdr space for encoding either a hole or data segment. */
> > > +   u32 segments = 1 + 2 + 2;
> > > +
> > > +   return (op_encode_hdr_size + 2 + segments + XDR_QUADLEN(rlen)) * sizeof(__be32);
> >
> > I'm not sure I understand this calculation.
> >
> > In the final code, there's no fixed limit on the number of segments
> > returned by a single READ_PLUS op, right?
>
> I think the worst-case overhead to represent a hole is around 50 bytes.
>
> So as long as we don't encode any holes less than that, then we can just
> use rlen as an upper bound.
>
> We really don't want to bother encoding small holes.  I doubt
> filesystems want to bother with them either.  Do they give us any
> guarantees as to the minimum size of a hole?

The minimum size seems to be PAGE_SIZE from everything I've seen.

>
> --b.
>
> >
> > --b.
> >
> > > +}
> > > +
> > >  static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > >  {
> > >     u32 maxcount = 0, rlen = 0;
> > > @@ -3059,6 +3069,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
> > >             .op_name = "OP_COPY",
> > >             .op_rsize_bop = nfsd4_copy_rsize,
> > >     },
> > > +   [OP_READ_PLUS] = {
> > > +           .op_func = nfsd4_read,
> > > +           .op_release = nfsd4_read_release,
> > > +           .op_name = "OP_READ_PLUS",
> > > +           .op_rsize_bop = nfsd4_read_plus_rsize,
> > > +           .op_get_currentstateid = nfsd4_get_readstateid,
> > > +   },
> > >     [OP_SEEK] = {
> > >             .op_func = nfsd4_seek,
> > >             .op_name = "OP_SEEK",
> > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > index 6a1c0a7fae05..9af92f538000 100644
> > > --- a/fs/nfsd/nfs4xdr.c
> > > +++ b/fs/nfsd/nfs4xdr.c
> > > @@ -1957,7 +1957,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
> > >     [OP_LAYOUTSTATS]        = (nfsd4_dec)nfsd4_decode_notsupp,
> > >     [OP_OFFLOAD_CANCEL]     = (nfsd4_dec)nfsd4_decode_offload_status,
> > >     [OP_OFFLOAD_STATUS]     = (nfsd4_dec)nfsd4_decode_offload_status,
> > > -   [OP_READ_PLUS]          = (nfsd4_dec)nfsd4_decode_notsupp,
> > > +   [OP_READ_PLUS]          = (nfsd4_dec)nfsd4_decode_read,
> > >     [OP_SEEK]               = (nfsd4_dec)nfsd4_decode_seek,
> > >     [OP_WRITE_SAME]         = (nfsd4_dec)nfsd4_decode_notsupp,
> > >     [OP_CLONE]              = (nfsd4_dec)nfsd4_decode_clone,
> > > @@ -4367,6 +4367,85 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
> > >             return nfserr_resource;
> > >     p = xdr_encode_hyper(p, os->count);
> > >     *p++ = cpu_to_be32(0);
> > > +   return nfserr;
> > > +}
> > > +
> > > +static __be32
> > > +nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> > > +                       struct nfsd4_read *read,
> > > +                       unsigned long maxcount,  u32 *eof)
> > > +{
> > > +   struct xdr_stream *xdr = &resp->xdr;
> > > +   struct file *file = read->rd_nf->nf_file;
> > > +   int starting_len = xdr->buf->len;
> > > +   __be32 nfserr;
> > > +   __be32 *p, tmp;
> > > +   __be64 tmp64;
> > > +
> > > +   /* Content type, offset, byte count */
> > > +   p = xdr_reserve_space(xdr, 4 + 8 + 4);
> > > +   if (!p)
> > > +           return nfserr_resource;
> > > +
> > > +   read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
> > > +   if (read->rd_vlen < 0)
> > > +           return nfserr_resource;
> > > +
> > > +   nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> > > +                       resp->rqstp->rq_vec, read->rd_vlen, &maxcount, eof);
> > > +   if (nfserr)
> > > +           return nfserr;
> > > +
> > > +   tmp = htonl(NFS4_CONTENT_DATA);
> > > +   write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> > > +   tmp64 = cpu_to_be64(read->rd_offset);
> > > +   write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> > > +   tmp = htonl(maxcount);
> > > +   write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> > > +   return nfs_ok;
> > > +}
> > > +
> > > +static __be32
> > > +nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> > > +                  struct nfsd4_read *read)
> > > +{
> > > +   unsigned long maxcount;
> > > +   struct xdr_stream *xdr = &resp->xdr;
> > > +   struct file *file;
> > > +   int starting_len = xdr->buf->len;
> > > +   int segments = 0;
> > > +   __be32 *p, tmp;
> > > +   u32 eof;
> > > +
> > > +   if (nfserr)
> > > +           return nfserr;
> > > +   file = read->rd_nf->nf_file;
> > > +
> > > +   /* eof flag, segment count */
> > > +   p = xdr_reserve_space(xdr, 4 + 4);
> > > +   if (!p)
> > > +           return nfserr_resource;
> > > +   xdr_commit_encode(xdr);
> > > +
> > > +   maxcount = svc_max_payload(resp->rqstp);
> > > +   maxcount = min_t(unsigned long, maxcount,
> > > +                    (xdr->buf->buflen - xdr->buf->len));
> > > +   maxcount = min_t(unsigned long, maxcount, read->rd_length);
> > > +
> > > +   eof = read->rd_offset >= i_size_read(file_inode(file));
> > > +   if (!eof) {
> > > +           nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
> > > +           segments++;
> > > +   }
> > > +
> > > +   if (nfserr)
> > > +           xdr_truncate_encode(xdr, starting_len);
> > > +   else {
> > > +           tmp = htonl(eof);
> > > +           write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> > > +           tmp = htonl(segments);
> > > +           write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> > > +   }
> > >
> > >     return nfserr;
> > >  }
> > > @@ -4509,7 +4588,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
> > >     [OP_LAYOUTSTATS]        = (nfsd4_enc)nfsd4_encode_noop,
> > >     [OP_OFFLOAD_CANCEL]     = (nfsd4_enc)nfsd4_encode_noop,
> > >     [OP_OFFLOAD_STATUS]     = (nfsd4_enc)nfsd4_encode_offload_status,
> > > -   [OP_READ_PLUS]          = (nfsd4_enc)nfsd4_encode_noop,
> > > +   [OP_READ_PLUS]          = (nfsd4_enc)nfsd4_encode_read_plus,
> > >     [OP_SEEK]               = (nfsd4_enc)nfsd4_encode_seek,
> > >     [OP_WRITE_SAME]         = (nfsd4_enc)nfsd4_encode_noop,
> > >     [OP_CLONE]              = (nfsd4_enc)nfsd4_encode_noop,
> > > --
> > > 2.28.0
> > >
>
