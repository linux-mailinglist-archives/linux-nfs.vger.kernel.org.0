Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005FC2562E1
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Aug 2020 00:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgH1WTI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Aug 2020 18:19:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30733 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgH1WTH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Aug 2020 18:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598653145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDUiYPCuBNper0RUa09j95MO8Spu0FDmngXkbzpCePs=;
        b=iN2uNukvW+m1szqsQszsREM5egrID/ZMUzjiS/TGhA7gZabSqWH9DNw5IsxUh0/Mfmiqlq
        uc7+c9A3Cy3atEFgKJm6cs3kyFR9l+AnCeAjRzF0UOSJtezYpDzYKwKldjya7mbXv35dnU
        JVUo79fn89uxV89e5YtwSybD9OJcbvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-FE52JORwNyy76L-cpmuaZQ-1; Fri, 28 Aug 2020 18:19:01 -0400
X-MC-Unique: FE52JORwNyy76L-cpmuaZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B897D1DE08;
        Fri, 28 Aug 2020 22:19:00 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-119-133.rdu2.redhat.com [10.10.119.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72CF35B6B6;
        Fri, 28 Aug 2020 22:19:00 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 437E812045D; Fri, 28 Aug 2020 18:18:59 -0400 (EDT)
Date:   Fri, 28 Aug 2020 18:18:59 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     schumaker.anna@gmail.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Anna.Schumaker@netapp.com
Subject: Re: [PATCH v4 4/5] NFSD: Return both a hole and a data segment
Message-ID: <20200828221859.GC33226@pick.fieldses.org>
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
 <20200817165310.354092-5-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817165310.354092-5-Anna.Schumaker@Netapp.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 17, 2020 at 12:53:09PM -0400, schumaker.anna@gmail.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> But only one of each right now. We'll expand on this in the next patch.
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  fs/nfsd/nfs4xdr.c | 51 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 2fa39217c256..3f4860103b25 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4373,7 +4373,7 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
>  static __be32
>  nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
>  			    struct nfsd4_read *read,
> -			    unsigned long maxcount,  u32 *eof)
> +			    unsigned long *maxcount, u32 *eof)
>  {
>  	struct xdr_stream *xdr = &resp->xdr;
>  	struct file *file = read->rd_nf->nf_file;
> @@ -4384,19 +4384,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
>  	__be64 tmp64;
>  
>  	if (hole_pos > read->rd_offset)
> -		maxcount = min_t(unsigned long, maxcount, hole_pos - read->rd_offset);
> +		*maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
>  
>  	/* Content type, offset, byte count */
>  	p = xdr_reserve_space(xdr, 4 + 8 + 4);
>  	if (!p)
>  		return nfserr_resource;
>  
> -	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
> +	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
>  	if (read->rd_vlen < 0)
>  		return nfserr_resource;
>  
>  	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> -			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount, eof);
> +			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
>  	if (nfserr)
>  		return nfserr;
>  
> @@ -4404,7 +4404,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
>  	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
>  	tmp64 = cpu_to_be64(read->rd_offset);
>  	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> -	tmp = htonl(maxcount);
> +	tmp = htonl(*maxcount);
>  	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
>  	return nfs_ok;
>  }
> @@ -4412,11 +4412,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
>  static __be32
>  nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
>  			    struct nfsd4_read *read,
> -			    unsigned long maxcount, u32 *eof)
> +			    unsigned long *maxcount, u32 *eof)
>  {
>  	struct file *file = read->rd_nf->nf_file;
> +	loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);

Everywhere I see fs_llseek()s and i_size_read()s, I start wondering
where there might be races.  E.g.:

> +	unsigned long count;
>  	__be32 *p;
>  
> +	if (data_pos == -ENXIO)
> +		data_pos = i_size_read(file_inode(file));
> +	else if (data_pos <= read->rd_offset)
> +		return nfserr_resource;

I think that means a concurrent truncate would cause us to fail the
entire read, when I suspect the right thing to do is to return a short
(but successful) read.

--b.

> +	count = data_pos - read->rd_offset;
> +
>  	/* Content type, offset, byte count */
>  	p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
>  	if (!p)
> @@ -4424,9 +4432,10 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
>  
>  	*p++ = htonl(NFS4_CONTENT_HOLE);
>  	 p   = xdr_encode_hyper(p, read->rd_offset);
> -	 p   = xdr_encode_hyper(p, maxcount);
> +	 p   = xdr_encode_hyper(p, count);
>  
> -	*eof = (read->rd_offset + maxcount) >= i_size_read(file_inode(file));
> +	*eof = (read->rd_offset + count) >= i_size_read(file_inode(file));
> +	*maxcount = min_t(unsigned long, count, *maxcount);
>  	return nfs_ok;
>  }
>  
> @@ -4434,7 +4443,7 @@ static __be32
>  nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
>  		       struct nfsd4_read *read)
>  {
> -	unsigned long maxcount;
> +	unsigned long maxcount, count;
>  	struct xdr_stream *xdr = &resp->xdr;
>  	struct file *file;
>  	int starting_len = xdr->buf->len;
> @@ -4457,6 +4466,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	maxcount = min_t(unsigned long, maxcount,
>  			 (xdr->buf->buflen - xdr->buf->len));
>  	maxcount = min_t(unsigned long, maxcount, read->rd_length);
> +	count    = maxcount;
>  
>  	eof = read->rd_offset >= i_size_read(file_inode(file));
>  	if (eof)
> @@ -4465,13 +4475,26 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
>  	if (pos == -ENXIO)
>  		pos = i_size_read(file_inode(file));
> +	else if (pos < 0)
> +		pos = read->rd_offset;
>  
> -	if (pos > read->rd_offset) {
> -		maxcount = pos - read->rd_offset;
> -		nfserr = nfsd4_encode_read_plus_hole(resp, read, maxcount, &eof);
> +	if (pos == read->rd_offset) {
> +		maxcount = count;
> +		nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof);
> +		if (nfserr)
> +			goto out;
> +		count -= maxcount;
> +		read->rd_offset += maxcount;
>  		segments++;
> -	} else {
> -		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
> +	}
> +
> +	if (count > 0 && !eof) {
> +		maxcount = count;
> +		nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
> +		if (nfserr)
> +			goto out;
> +		count -= maxcount;
> +		read->rd_offset += maxcount;
>  		segments++;
>  	}
>  
> -- 
> 2.28.0
> 

