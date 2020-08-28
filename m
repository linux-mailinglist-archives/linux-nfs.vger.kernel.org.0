Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ABA2562B0
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Aug 2020 23:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgH1V4h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Aug 2020 17:56:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53737 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726033AbgH1V4g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Aug 2020 17:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598651793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nrk7MUEDKXmKLWobamPhjhluiBvwMeY0GFopdnUIv5w=;
        b=iTWTrFPOL1cHIrTfwB3uO1OHXXDxOOLG34ZZZbYcyK9cIPmxZEfCMnUwwO331AUDC5b2h1
        CzlBeIrZTNVLSyxKTITMzO0QENrlYVNo/M1hdfbsaX0jFriHMUmYu/M3yGEdSMCDR2sayM
        xfVUPogrJYMx/jty4gdmzC4CTH0S0pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-kIv7mIjwMZ-8SFE-vGzNRw-1; Fri, 28 Aug 2020 17:56:29 -0400
X-MC-Unique: kIv7mIjwMZ-8SFE-vGzNRw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A896B1800D41;
        Fri, 28 Aug 2020 21:56:28 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-119-133.rdu2.redhat.com [10.10.119.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D8BB5D99B;
        Fri, 28 Aug 2020 21:56:28 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 3F63112045D; Fri, 28 Aug 2020 17:56:27 -0400 (EDT)
Date:   Fri, 28 Aug 2020 17:56:27 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     schumaker.anna@gmail.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Anna.Schumaker@netapp.com
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
Message-ID: <20200828215627.GB33226@pick.fieldses.org>
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
 <20200817165310.354092-3-Anna.Schumaker@Netapp.com>
 <20200828212521.GA33226@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828212521.GA33226@pick.fieldses.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 28, 2020 at 05:25:21PM -0400, J. Bruce Fields wrote:
> On Mon, Aug 17, 2020 at 12:53:07PM -0400, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > This patch adds READ_PLUS support for returning a single
> > NFS4_CONTENT_DATA segment to the client. This is basically the same as
> > the READ operation, only with the extra information about data segments.
> > 
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 17 ++++++++++
> >  fs/nfsd/nfs4xdr.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 98 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index a09c35f0f6f0..9630d33211f2 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2523,6 +2523,16 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> >  	return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
> >  }
> >  
> > +static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > +{
> > +	u32 maxcount = svc_max_payload(rqstp);
> > +	u32 rlen = min(op->u.read.rd_length, maxcount);
> > +	/* enough extra xdr space for encoding either a hole or data segment. */
> > +	u32 segments = 1 + 2 + 2;
> > +
> > +	return (op_encode_hdr_size + 2 + segments + XDR_QUADLEN(rlen)) * sizeof(__be32);
> 
> I'm not sure I understand this calculation.
> 
> In the final code, there's no fixed limit on the number of segments
> returned by a single READ_PLUS op, right?

I think the worst-case overhead to represent a hole is around 50 bytes. 

So as long as we don't encode any holes less than that, then we can just
use rlen as an upper bound.

We really don't want to bother encoding small holes.  I doubt
filesystems want to bother with them either.  Do they give us any
guarantees as to the minimum size of a hole?

--b.

> 
> --b.
> 
> > +}
> > +
> >  static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> >  {
> >  	u32 maxcount = 0, rlen = 0;
> > @@ -3059,6 +3069,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
> >  		.op_name = "OP_COPY",
> >  		.op_rsize_bop = nfsd4_copy_rsize,
> >  	},
> > +	[OP_READ_PLUS] = {
> > +		.op_func = nfsd4_read,
> > +		.op_release = nfsd4_read_release,
> > +		.op_name = "OP_READ_PLUS",
> > +		.op_rsize_bop = nfsd4_read_plus_rsize,
> > +		.op_get_currentstateid = nfsd4_get_readstateid,
> > +	},
> >  	[OP_SEEK] = {
> >  		.op_func = nfsd4_seek,
> >  		.op_name = "OP_SEEK",
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 6a1c0a7fae05..9af92f538000 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -1957,7 +1957,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
> >  	[OP_LAYOUTSTATS]	= (nfsd4_dec)nfsd4_decode_notsupp,
> >  	[OP_OFFLOAD_CANCEL]	= (nfsd4_dec)nfsd4_decode_offload_status,
> >  	[OP_OFFLOAD_STATUS]	= (nfsd4_dec)nfsd4_decode_offload_status,
> > -	[OP_READ_PLUS]		= (nfsd4_dec)nfsd4_decode_notsupp,
> > +	[OP_READ_PLUS]		= (nfsd4_dec)nfsd4_decode_read,
> >  	[OP_SEEK]		= (nfsd4_dec)nfsd4_decode_seek,
> >  	[OP_WRITE_SAME]		= (nfsd4_dec)nfsd4_decode_notsupp,
> >  	[OP_CLONE]		= (nfsd4_dec)nfsd4_decode_clone,
> > @@ -4367,6 +4367,85 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
> >  		return nfserr_resource;
> >  	p = xdr_encode_hyper(p, os->count);
> >  	*p++ = cpu_to_be32(0);
> > +	return nfserr;
> > +}
> > +
> > +static __be32
> > +nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> > +			    struct nfsd4_read *read,
> > +			    unsigned long maxcount,  u32 *eof)
> > +{
> > +	struct xdr_stream *xdr = &resp->xdr;
> > +	struct file *file = read->rd_nf->nf_file;
> > +	int starting_len = xdr->buf->len;
> > +	__be32 nfserr;
> > +	__be32 *p, tmp;
> > +	__be64 tmp64;
> > +
> > +	/* Content type, offset, byte count */
> > +	p = xdr_reserve_space(xdr, 4 + 8 + 4);
> > +	if (!p)
> > +		return nfserr_resource;
> > +
> > +	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
> > +	if (read->rd_vlen < 0)
> > +		return nfserr_resource;
> > +
> > +	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> > +			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount, eof);
> > +	if (nfserr)
> > +		return nfserr;
> > +
> > +	tmp = htonl(NFS4_CONTENT_DATA);
> > +	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> > +	tmp64 = cpu_to_be64(read->rd_offset);
> > +	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> > +	tmp = htonl(maxcount);
> > +	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> > +	return nfs_ok;
> > +}
> > +
> > +static __be32
> > +nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> > +		       struct nfsd4_read *read)
> > +{
> > +	unsigned long maxcount;
> > +	struct xdr_stream *xdr = &resp->xdr;
> > +	struct file *file;
> > +	int starting_len = xdr->buf->len;
> > +	int segments = 0;
> > +	__be32 *p, tmp;
> > +	u32 eof;
> > +
> > +	if (nfserr)
> > +		return nfserr;
> > +	file = read->rd_nf->nf_file;
> > +
> > +	/* eof flag, segment count */
> > +	p = xdr_reserve_space(xdr, 4 + 4);
> > +	if (!p)
> > +		return nfserr_resource;
> > +	xdr_commit_encode(xdr);
> > +
> > +	maxcount = svc_max_payload(resp->rqstp);
> > +	maxcount = min_t(unsigned long, maxcount,
> > +			 (xdr->buf->buflen - xdr->buf->len));
> > +	maxcount = min_t(unsigned long, maxcount, read->rd_length);
> > +
> > +	eof = read->rd_offset >= i_size_read(file_inode(file));
> > +	if (!eof) {
> > +		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
> > +		segments++;
> > +	}
> > +
> > +	if (nfserr)
> > +		xdr_truncate_encode(xdr, starting_len);
> > +	else {
> > +		tmp = htonl(eof);
> > +		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> > +		tmp = htonl(segments);
> > +		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> > +	}
> >  
> >  	return nfserr;
> >  }
> > @@ -4509,7 +4588,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
> >  	[OP_LAYOUTSTATS]	= (nfsd4_enc)nfsd4_encode_noop,
> >  	[OP_OFFLOAD_CANCEL]	= (nfsd4_enc)nfsd4_encode_noop,
> >  	[OP_OFFLOAD_STATUS]	= (nfsd4_enc)nfsd4_encode_offload_status,
> > -	[OP_READ_PLUS]		= (nfsd4_enc)nfsd4_encode_noop,
> > +	[OP_READ_PLUS]		= (nfsd4_enc)nfsd4_encode_read_plus,
> >  	[OP_SEEK]		= (nfsd4_enc)nfsd4_encode_seek,
> >  	[OP_WRITE_SAME]		= (nfsd4_enc)nfsd4_encode_noop,
> >  	[OP_CLONE]		= (nfsd4_enc)nfsd4_encode_noop,
> > -- 
> > 2.28.0
> > 

