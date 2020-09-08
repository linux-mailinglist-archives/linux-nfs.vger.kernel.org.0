Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30FB261DD4
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 21:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbgIHTm4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 15:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730878AbgIHTmx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 15:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599594170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYa+/2NQEGObzktuRoAa/ABpYIl8iKp01aOiBmsWZ9A=;
        b=fh7pIH+1przGA8ryuA0aMMTbYKKtgH3O2TXY0++aEkUD9SE7NFri/fn9sK3wP3H+HxcBpu
        WWb3Gt/y3Kgv53138WtEaZDLUJlK2q3rfvQdokSJ9rEOPIJIu+hatdhnBKmKn/O7p9QRgx
        xqv3AclJuoH9AkAL3lJ+KvgFBRQy1vE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-5fo4YrNdPhGz5VtE3ZWOxQ-1; Tue, 08 Sep 2020 15:42:48 -0400
X-MC-Unique: 5fo4YrNdPhGz5VtE3ZWOxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E3CA1007C87;
        Tue,  8 Sep 2020 19:42:47 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-115-66.rdu2.redhat.com [10.10.115.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0E7A27CC3;
        Tue,  8 Sep 2020 19:42:46 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id B65B5120478; Tue,  8 Sep 2020 15:42:45 -0400 (EDT)
Date:   Tue, 8 Sep 2020 15:42:45 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     schumaker.anna@gmail.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Anna.Schumaker@netapp.com
Subject: Re: [PATCH v5 2/5] NFSD: Add READ_PLUS data support
Message-ID: <20200908194245.GB6256@pick.fieldses.org>
References: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
 <20200908162559.509113-3-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908162559.509113-3-Anna.Schumaker@Netapp.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 08, 2020 at 12:25:56PM -0400, schumaker.anna@gmail.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> This patch adds READ_PLUS support for returning a single
> NFS4_CONTENT_DATA segment to the client. This is basically the same as
> the READ operation, only with the extra information about data segments.
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> ---
> v5: Fix up nfsd4_read_plus_rsize() calculation
> ---
>  fs/nfsd/nfs4proc.c | 20 +++++++++++
>  fs/nfsd/nfs4xdr.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 101 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index eaf50eafa935..0a3df5f10501 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2591,6 +2591,19 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
>  	return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
>  }
>  
> +static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> +{
> +	u32 maxcount = svc_max_payload(rqstp);
> +	u32 rlen = min(op->u.read.rd_length, maxcount);
> +	/*
> +	 * Worst case is a single large data segment, so make
> +	 * sure we have enough room to encode that
> +	 */

After the last patch we allow an unlimited number of segments.  So a
zillion 1-byte segments is also possible, and is a worse case.

Possible ways to avoid that kind of thing:

	- when encoding, stop and return a short read if the xdr-encoded
	  result would exceed the limit calculated here.
	- round SEEK_HOLE results up to the nearest (say) 512 bytes, and
	  SEEK_DATA result down to the nearest 512 bytes.  May also need
	  some logic to avoid encoding 0-length segments.
	- talk to linux-fsdevel, see if we can get a minimum hole
	  alignment guarantee from filesystems.

I'm thinking #1 is simplest.

--b.

> +	u32 seg_len = 1 + 2 + 1;
> +
> +	return (op_encode_hdr_size + 2 + seg_len + XDR_QUADLEN(rlen)) * sizeof(__be32);
> +}
> +
>  static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
>  {
>  	u32 maxcount = 0, rlen = 0;
> @@ -3163,6 +3176,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_name = "OP_COPY",
>  		.op_rsize_bop = nfsd4_copy_rsize,
>  	},
> +	[OP_READ_PLUS] = {
> +		.op_func = nfsd4_read,
> +		.op_release = nfsd4_read_release,
> +		.op_name = "OP_READ_PLUS",
> +		.op_rsize_bop = nfsd4_read_plus_rsize,
> +		.op_get_currentstateid = nfsd4_get_readstateid,
> +	},
>  	[OP_SEEK] = {
>  		.op_func = nfsd4_seek,
>  		.op_name = "OP_SEEK",
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 0be194de4888..26d12e3edf33 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2173,7 +2173,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
>  	[OP_LAYOUTSTATS]	= (nfsd4_dec)nfsd4_decode_notsupp,
>  	[OP_OFFLOAD_CANCEL]	= (nfsd4_dec)nfsd4_decode_offload_status,
>  	[OP_OFFLOAD_STATUS]	= (nfsd4_dec)nfsd4_decode_offload_status,
> -	[OP_READ_PLUS]		= (nfsd4_dec)nfsd4_decode_notsupp,
> +	[OP_READ_PLUS]		= (nfsd4_dec)nfsd4_decode_read,
>  	[OP_SEEK]		= (nfsd4_dec)nfsd4_decode_seek,
>  	[OP_WRITE_SAME]		= (nfsd4_dec)nfsd4_decode_notsupp,
>  	[OP_CLONE]		= (nfsd4_dec)nfsd4_decode_clone,
> @@ -4597,6 +4597,85 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
>  		return nfserr_resource;
>  	p = xdr_encode_hyper(p, os->count);
>  	*p++ = cpu_to_be32(0);
> +	return nfserr;
> +}
> +
> +static __be32
> +nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> +			    struct nfsd4_read *read,
> +			    unsigned long maxcount,  u32 *eof)
> +{
> +	struct xdr_stream *xdr = &resp->xdr;
> +	struct file *file = read->rd_nf->nf_file;
> +	int starting_len = xdr->buf->len;
> +	__be32 nfserr;
> +	__be32 *p, tmp;
> +	__be64 tmp64;
> +
> +	/* Content type, offset, byte count */
> +	p = xdr_reserve_space(xdr, 4 + 8 + 4);
> +	if (!p)
> +		return nfserr_resource;
> +
> +	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
> +	if (read->rd_vlen < 0)
> +		return nfserr_resource;
> +
> +	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> +			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount, eof);
> +	if (nfserr)
> +		return nfserr;
> +
> +	tmp = htonl(NFS4_CONTENT_DATA);
> +	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> +	tmp64 = cpu_to_be64(read->rd_offset);
> +	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> +	tmp = htonl(maxcount);
> +	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> +	return nfs_ok;
> +}
> +
> +static __be32
> +nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> +		       struct nfsd4_read *read)
> +{
> +	unsigned long maxcount;
> +	struct xdr_stream *xdr = &resp->xdr;
> +	struct file *file;
> +	int starting_len = xdr->buf->len;
> +	int segments = 0;
> +	__be32 *p, tmp;
> +	u32 eof;
> +
> +	if (nfserr)
> +		return nfserr;
> +	file = read->rd_nf->nf_file;
> +
> +	/* eof flag, segment count */
> +	p = xdr_reserve_space(xdr, 4 + 4);
> +	if (!p)
> +		return nfserr_resource;
> +	xdr_commit_encode(xdr);
> +
> +	maxcount = svc_max_payload(resp->rqstp);
> +	maxcount = min_t(unsigned long, maxcount,
> +			 (xdr->buf->buflen - xdr->buf->len));
> +	maxcount = min_t(unsigned long, maxcount, read->rd_length);
> +
> +	eof = read->rd_offset >= i_size_read(file_inode(file));
> +	if (!eof) {
> +		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
> +		segments++;
> +	}
> +
> +	if (nfserr)
> +		xdr_truncate_encode(xdr, starting_len);
> +	else {
> +		tmp = htonl(eof);
> +		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> +		tmp = htonl(segments);
> +		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> +	}
>  
>  	return nfserr;
>  }
> @@ -4974,7 +5053,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
>  	[OP_LAYOUTSTATS]	= (nfsd4_enc)nfsd4_encode_noop,
>  	[OP_OFFLOAD_CANCEL]	= (nfsd4_enc)nfsd4_encode_noop,
>  	[OP_OFFLOAD_STATUS]	= (nfsd4_enc)nfsd4_encode_offload_status,
> -	[OP_READ_PLUS]		= (nfsd4_enc)nfsd4_encode_noop,
> +	[OP_READ_PLUS]		= (nfsd4_enc)nfsd4_encode_read_plus,
>  	[OP_SEEK]		= (nfsd4_enc)nfsd4_encode_seek,
>  	[OP_WRITE_SAME]		= (nfsd4_enc)nfsd4_encode_noop,
>  	[OP_CLONE]		= (nfsd4_enc)nfsd4_encode_noop,
> -- 
> 2.28.0
> 

