Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6680161BEB
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Feb 2020 20:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgBQTwZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Feb 2020 14:52:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55433 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728463AbgBQTwZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Feb 2020 14:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581969144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OYa1xLbBdVkjhfn1oHJzWeDuG1+VY3u7mTUDcNvoQ1Q=;
        b=dXIHns32mmMv1NYjnhqFAgNTwGgSALybYyLLfAeEEvgswGYuc9VEsg4VHDfbYlZJh1ehQM
        N766umN/W3xrg9stSZye+wlem1w/Ijxlf2F8ZBzkJrwTHPQPCLCLxP+ZFneDo7S24Or490
        AqOj2Cibty/Gw5tPM1qmwCFze8VtQGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-aAot19yBO8Wg6fRU0ygDCQ-1; Mon, 17 Feb 2020 14:52:22 -0500
X-MC-Unique: aAot19yBO8Wg6fRU0ygDCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 651EA107ACC5;
        Mon, 17 Feb 2020 19:52:21 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-123-47.rdu2.redhat.com [10.10.123.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 074875DA60;
        Mon, 17 Feb 2020 19:52:21 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 6DDB41201E0; Mon, 17 Feb 2020 14:52:19 -0500 (EST)
Date:   Mon, 17 Feb 2020 14:52:19 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <schumaker.anna@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH v2 1/4] NFSD: Return eof and maxcount to
 nfsd4_encode_read()
Message-ID: <20200217195219.GC71484@pick.fieldses.org>
References: <20200214211206.407725-1-Anna.Schumaker@Netapp.com>
 <20200214211206.407725-2-Anna.Schumaker@Netapp.com>
 <8293E6BD-F063-4872-848F-93196C87DA02@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8293E6BD-F063-4872-848F-93196C87DA02@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 14, 2020 at 05:20:37PM -0500, Chuck Lever wrote:
> 
> 
> > On Feb 14, 2020, at 4:12 PM, schumaker.anna@gmail.com wrote:
> > 
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > I want to reuse nfsd4_encode_readv() and nfsd4_encode_splice_read() in
> > READ_PLUS rather than reimplementing them. READ_PLUS returns a single
> > eof flag for the entire call and a separate maxcount for each data
> > segment, so we need to have the READ call encode these values in a
> > different place.
> 
> This probably collides pretty nastily with the fix I posted today for
> https://bugzilla.kernel.org/show_bug.cgi?id=198053 .
> 
> Can my fix go in first so that there is still opportunity to backport it?

Sure, makes sense.--b.

> 
> 
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> > fs/nfsd/nfs4xdr.c | 60 ++++++++++++++++++++---------------------------
> > 1 file changed, 26 insertions(+), 34 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 9761512674a0..45f0623f6488 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -3521,23 +3521,22 @@ nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr, struc
> > 
> > static __be32 nfsd4_encode_splice_read(
> > 				struct nfsd4_compoundres *resp,
> > -				struct nfsd4_read *read,
> > -				struct file *file, unsigned long maxcount)
> > +				struct nfsd4_read *read, struct file *file,
> > +				unsigned long *maxcount, u32 *eof)
> > {
> > 	struct xdr_stream *xdr = &resp->xdr;
> > 	struct xdr_buf *buf = xdr->buf;
> > -	u32 eof;
> > +	long len;
> > 	int space_left;
> > 	__be32 nfserr;
> > -	__be32 *p = xdr->p - 2;
> > 
> > 	/* Make sure there will be room for padding if needed */
> > 	if (xdr->end - xdr->p < 1)
> > 		return nfserr_resource;
> > 
> > +	len = *maxcount;
> > 	nfserr = nfsd_splice_read(read->rd_rqstp, read->rd_fhp,
> > -				  file, read->rd_offset, &maxcount, &eof);
> > -	read->rd_length = maxcount;
> > +				  file, read->rd_offset, maxcount, eof);
> > 	if (nfserr) {
> > 		/*
> > 		 * nfsd_splice_actor may have already messed with the
> > @@ -3548,24 +3547,21 @@ static __be32 nfsd4_encode_splice_read(
> > 		return nfserr;
> > 	}
> > 
> > -	*(p++) = htonl(eof);
> > -	*(p++) = htonl(maxcount);
> > -
> > -	buf->page_len = maxcount;
> > -	buf->len += maxcount;
> > -	xdr->page_ptr += (buf->page_base + maxcount + PAGE_SIZE - 1)
> > +	buf->page_len = *maxcount;
> > +	buf->len += *maxcount;
> > +	xdr->page_ptr += (buf->page_base + *maxcount + PAGE_SIZE - 1)
> > 							/ PAGE_SIZE;
> > 
> > 	/* Use rest of head for padding and remaining ops: */
> > 	buf->tail[0].iov_base = xdr->p;
> > 	buf->tail[0].iov_len = 0;
> > 	xdr->iov = buf->tail;
> > -	if (maxcount&3) {
> > -		int pad = 4 - (maxcount&3);
> > +	if (*maxcount&3) {
> > +		int pad = 4 - (*maxcount&3);
> > 
> > 		*(xdr->p++) = 0;
> > 
> > -		buf->tail[0].iov_base += maxcount&3;
> > +		buf->tail[0].iov_base += *maxcount&3;
> > 		buf->tail[0].iov_len = pad;
> > 		buf->len += pad;
> > 	}
> > @@ -3579,22 +3575,20 @@ static __be32 nfsd4_encode_splice_read(
> > }
> > 
> > static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
> > -				 struct nfsd4_read *read,
> > -				 struct file *file, unsigned long maxcount)
> > +				 struct nfsd4_read *read, struct file *file,
> > +				 unsigned long *maxcount, u32 *eof)
> > {
> > 	struct xdr_stream *xdr = &resp->xdr;
> > -	u32 eof;
> > 	int v;
> > 	int starting_len = xdr->buf->len - 8;
> > 	long len;
> > 	int thislen;
> > 	__be32 nfserr;
> > -	__be32 tmp;
> > 	__be32 *p;
> > 	u32 zzz = 0;
> > 	int pad;
> > 
> > -	len = maxcount;
> > +	len = *maxcount;
> > 	v = 0;
> > 
> > 	thislen = min_t(long, len, ((void *)xdr->end - (void *)xdr->p));
> > @@ -3616,22 +3610,15 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
> > 	}
> > 	read->rd_vlen = v;
> > 
> > -	len = maxcount;
> > +	len = *maxcount;
> > 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> > -			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount,
> > -			    &eof);
> > -	read->rd_length = maxcount;
> > +			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> > 	if (nfserr)
> > 		return nfserr;
> > -	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
> > +	xdr_truncate_encode(xdr, starting_len + 8 + ((*maxcount+3)&~3));
> > 
> > -	tmp = htonl(eof);
> > -	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);
> > -	tmp = htonl(maxcount);
> > -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> > -
> > -	pad = (maxcount&3) ? 4 - (maxcount&3) : 0;
> > -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 8 + maxcount,
> > +	pad = (*maxcount&3) ? 4 - (*maxcount&3) : 0;
> > +	write_bytes_to_xdr_buf(xdr->buf, starting_len + 8 + *maxcount,
> > 								&zzz, pad);
> > 	return 0;
> > 
> > @@ -3642,6 +3629,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
> > 		  struct nfsd4_read *read)
> > {
> > 	unsigned long maxcount;
> > +	u32 eof;
> > 	struct xdr_stream *xdr = &resp->xdr;
> > 	struct file *file;
> > 	int starting_len = xdr->buf->len;
> > @@ -3670,13 +3658,17 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
> > 
> > 	if (file->f_op->splice_read &&
> > 	    test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags))
> > -		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
> > +		nfserr = nfsd4_encode_splice_read(resp, read, file, &maxcount, &eof);
> > 	else
> > -		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
> > +		nfserr = nfsd4_encode_readv(resp, read, file, &maxcount, &eof);
> > 
> > 	if (nfserr)
> > 		xdr_truncate_encode(xdr, starting_len);
> > 
> > +	read->rd_length = maxcount;
> > +	*p++ = htonl(eof);
> > +	*p++ = htonl(maxcount);
> > +
> > 	return nfserr;
> > }
> > 
> > -- 
> > 2.25.0
> > 
> 
> --
> Chuck Lever
> 
> 
> 

