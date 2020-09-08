Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92859261E4D
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 21:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbgIHTul (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 15:50:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30888 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731688AbgIHTt4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 15:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599594589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BoQkrQD3zJw+iZHVYYy4aaPsS+RrlD9OOvRr1gBChD8=;
        b=CCr1c9x8Kn7+tRxc288ivtTj3z0rSlfB4aCzuBdEp25dBaRpOAT3WoQoWWCYOZbizmjjFg
        C2JT/jL0SYqdMBAHmYt/8EulNhzxukqLjVEJn2s2cY0vzZbZ6/ADTaSF3osUHY+G8sHCwG
        371oB3czWPG5FQCUxANWRfaMBD0P+xE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-BgC_EC3yND670zdOJc4ciQ-1; Tue, 08 Sep 2020 15:49:47 -0400
X-MC-Unique: BgC_EC3yND670zdOJc4ciQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 961B085C705;
        Tue,  8 Sep 2020 19:49:46 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-115-66.rdu2.redhat.com [10.10.115.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1192B27CC3;
        Tue,  8 Sep 2020 19:49:46 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 72FE01204AE; Tue,  8 Sep 2020 15:49:44 -0400 (EDT)
Date:   Tue, 8 Sep 2020 15:49:44 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     schumaker.anna@gmail.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Anna.Schumaker@netapp.com
Subject: Re: [PATCH v5 4/5] NFSD: Return both a hole and a data segment
Message-ID: <20200908194944.GC6256@pick.fieldses.org>
References: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
 <20200908162559.509113-5-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908162559.509113-5-Anna.Schumaker@Netapp.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 08, 2020 at 12:25:58PM -0400, schumaker.anna@gmail.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> But only one of each right now. We'll expand on this in the next patch.
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> v5: If we've already encoded a segment, then return a short read if
>     later segments return an error for some reason.
> ---
>  fs/nfsd/nfs4xdr.c | 54 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 45159bd9e9a4..856606263c1d 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4603,7 +4603,7 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
>  static __be32
>  nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
>  			    struct nfsd4_read *read,
> -			    unsigned long maxcount,  u32 *eof)
> +			    unsigned long *maxcount, u32 *eof)
>  {
>  	struct xdr_stream *xdr = &resp->xdr;
>  	struct file *file = read->rd_nf->nf_file;
> @@ -4614,19 +4614,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
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
> @@ -4634,7 +4634,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
>  	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
>  	tmp64 = cpu_to_be64(read->rd_offset);
>  	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> -	tmp = htonl(maxcount);
> +	tmp = htonl(*maxcount);
>  	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
>  	return nfs_ok;
>  }
> @@ -4642,11 +4642,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
>  static __be32
>  nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
>  			    struct nfsd4_read *read,
> -			    unsigned long maxcount, u32 *eof)
> +			    unsigned long *maxcount, u32 *eof)
>  {
>  	struct file *file = read->rd_nf->nf_file;
> +	loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
> +	unsigned long count;
>  	__be32 *p;
>  
> +	if (data_pos == -ENXIO)
> +		data_pos = i_size_read(file_inode(file));
> +	else if (data_pos <= read->rd_offset)
> +		return nfserr_resource;

I think there's still a race here:

	vfs_llseek(.,0,SEEK_HOLE) returns 1024
	read 1024 bytes of data
					another process fills the hole
	vfs_llseek(.,1024,SEEK_DATA) returns 1024
	code above returns nfserr_resource

We end up returning an error to the client when we should have just
returned more data.

--b.

> +	count = data_pos - read->rd_offset;
> +
>  	/* Content type, offset, byte count */
>  	p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
>  	if (!p)
> @@ -4654,9 +4662,10 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
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
> @@ -4664,7 +4673,7 @@ static __be32
>  nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
>  		       struct nfsd4_read *read)
>  {
> -	unsigned long maxcount;
> +	unsigned long maxcount, count;
>  	struct xdr_stream *xdr = &resp->xdr;
>  	struct file *file;
>  	int starting_len = xdr->buf->len;
> @@ -4687,6 +4696,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	maxcount = min_t(unsigned long, maxcount,
>  			 (xdr->buf->buflen - xdr->buf->len));
>  	maxcount = min_t(unsigned long, maxcount, read->rd_length);
> +	count    = maxcount;
>  
>  	eof = read->rd_offset >= i_size_read(file_inode(file));
>  	if (eof)
> @@ -4695,24 +4705,38 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
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
>  out:
> -	if (nfserr)
> +	if (nfserr && segments == 0)
>  		xdr_truncate_encode(xdr, starting_len);
>  	else {
>  		tmp = htonl(eof);
>  		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
>  		tmp = htonl(segments);
>  		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> +		nfserr = nfs_ok;
>  	}
>  
>  	return nfserr;
> -- 
> 2.28.0
> 

