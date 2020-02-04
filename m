Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581A9151F45
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2020 18:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBDRVz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Feb 2020 12:21:55 -0500
Received: from fieldses.org ([173.255.197.46]:37596 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbgBDRVz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Feb 2020 12:21:55 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 9B5261F65; Tue,  4 Feb 2020 12:21:54 -0500 (EST)
Date:   Tue, 4 Feb 2020 12:21:54 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3] nfsd: Fix NFSv4 READ on RDMA when using readv
Message-ID: <20200204172154.GB8763@fieldses.org>
References: <20200201195914.12238.15729.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201195914.12238.15729.stgit@bazille.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Feb 01, 2020 at 03:05:19PM -0500, Chuck Lever wrote:
> svcrdma expects that the payload falls precisely into the xdr_buf
> page vector. This does not seem to be the case for
> nfsd4_encode_readv().
> 
> This code is called only when fops->splice_read is missing or when
> RQ_SPLICE_OK is clear, so it's not a noticeable problem in many
> common cases.
> 
> Add new transport method: ->xpo_read_payload so that when a READ
> payload does not fit exactly in rq_res's page vector, the XDR
> encoder can inform the RPC transport exactly where that payload is,
> without the payload's XDR pad.
> 
> That way, when a Write chunk is present, the transport knows what
> byte range in the Reply message is supposed to be matched with the
> chunk.
> 
> Note that the Linux NFS server implementation of NFS/RDMA can
> currently handle only one Write chunk per RPC-over-RDMA message.
> This simplifies the implementation of this fix.
> 
> Fixes: b04209806384 ("nfsd4: allow exotic read compounds")
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=198053
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> 
> Hi Bruce-
> 
> This fix seems closer to being merge-able. I've tested it by wiring
> the NFSv4 READ Reply encoder to always use readv. I've run the git
> regression suite with NFSv3, NFSv4.0, and NFSv4.1 using all three
> flavors of Kerberos and sec=sys, all on NFS/RDMA.
> 
> Aside from a new no-op function call, the TCP path is not perturbed.
> 
> 
> Changes since RFC2:
> - Take Trond's suggestion to use xdr->buf->len
> - Squash fix down to a single patch

I liked them better split out.

This seems fine to me, though.

Could you ping me again in another week, after the merge window?

> @@ -3521,17 +3521,14 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
>  	u32 zzz = 0;
>  	int pad;
>  
> +	/* Ensure xdr_reserve_space skips past xdr->buf->head */

Could the comment explain why we're doing this?  (Maybe take some
language from the changelog.)

--b.

> +	if (xdr->iov == xdr->buf->head) {
> +		xdr->iov = NULL;
> +		xdr->end = xdr->p;
> +	}
> +
>  	len = maxcount;
>  	v = 0;
> -
> -	thislen = min_t(long, len, ((void *)xdr->end - (void *)xdr->p));
> -	p = xdr_reserve_space(xdr, (thislen+3)&~3);
> -	WARN_ON_ONCE(!p);
> -	resp->rqstp->rq_vec[v].iov_base = p;
> -	resp->rqstp->rq_vec[v].iov_len = thislen;
> -	v++;
> -	len -= thislen;
> -
>  	while (len) {
>  		thislen = min_t(long, len, PAGE_SIZE);
>  		p = xdr_reserve_space(xdr, (thislen+3)&~3);
> @@ -3550,6 +3547,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
>  	read->rd_length = maxcount;
>  	if (nfserr)
>  		return nfserr;
> +	svc_mark_read_payload(resp->rqstp, starting_len + 8, read->rd_length);
>  	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
>  
>  	tmp = htonl(eof);
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 1afe38eb33f7..e0610e0e34f7 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -517,6 +517,9 @@ int		   svc_register(const struct svc_serv *, struct net *, const int,
>  void		   svc_reserve(struct svc_rqst *rqstp, int space);
>  struct svc_pool *  svc_pool_for_cpu(struct svc_serv *serv, int cpu);
>  char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
> +void		   svc_mark_read_payload(struct svc_rqst *rqstp,
> +					 unsigned int pos,
> +					 unsigned long length);
>  unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
>  					 struct page **pages,
>  					 struct kvec *first, size_t total);
> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
> index 40f65888dd38..4fd3b8a16dfd 100644
> --- a/include/linux/sunrpc/svc_rdma.h
> +++ b/include/linux/sunrpc/svc_rdma.h
> @@ -137,6 +137,7 @@ struct svc_rdma_recv_ctxt {
>  	unsigned int		rc_page_count;
>  	unsigned int		rc_hdr_count;
>  	u32			rc_inv_rkey;
> +	unsigned long		rc_read_payload_length;
>  	struct page		*rc_pages[RPCSVC_MAXPAGES];
>  };
>  
> @@ -170,7 +171,8 @@ extern int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma,
>  				    struct svc_rqst *rqstp,
>  				    struct svc_rdma_recv_ctxt *head, __be32 *p);
>  extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
> -				     __be32 *wr_ch, struct xdr_buf *xdr);
> +				     __be32 *wr_ch, struct xdr_buf *xdr,
> +				     struct svc_rdma_recv_ctxt *rctxt);
>  extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
>  				     __be32 *rp_ch, bool writelist,
>  				     struct xdr_buf *xdr);
> @@ -189,6 +191,8 @@ extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
>  				  struct svc_rdma_send_ctxt *ctxt,
>  				  struct xdr_buf *xdr, __be32 *wr_lst);
>  extern int svc_rdma_sendto(struct svc_rqst *);
> +extern void svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int pos,
> +				  unsigned long length);
>  
>  /* svc_rdma_transport.c */
>  extern int svc_rdma_create_listen(struct svc_serv *, int, struct sockaddr *);
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
> index ea6f46be9cb7..d272acf7531f 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -21,6 +21,8 @@ struct svc_xprt_ops {
>  	int		(*xpo_has_wspace)(struct svc_xprt *);
>  	int		(*xpo_recvfrom)(struct svc_rqst *);
>  	int		(*xpo_sendto)(struct svc_rqst *);
> +	void		(*xpo_read_payload)(struct svc_rqst *, unsigned int,
> +					    unsigned long);
>  	void		(*xpo_release_rqst)(struct svc_rqst *);
>  	void		(*xpo_detach)(struct svc_xprt *);
>  	void		(*xpo_free)(struct svc_xprt *);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 187dd4e73d64..d4a0134f1ca1 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1637,6 +1637,20 @@ u32 svc_max_payload(const struct svc_rqst *rqstp)
>  EXPORT_SYMBOL_GPL(svc_max_payload);
>  
>  /**
> + * svc_mark_read_payload - mark a range of bytes as a READ payload
> + * @rqstp: svc_rqst to operate on
> + * @pos: payload's byte offset in the RPC Reply message
> + * @length: size of payload, in bytes
> + *
> + */
> +void svc_mark_read_payload(struct svc_rqst *rqstp, unsigned int pos,
> +			   unsigned long length)
> +{
> +	rqstp->rq_xprt->xpt_ops->xpo_read_payload(rqstp, pos, length);
> +}
> +EXPORT_SYMBOL_GPL(svc_mark_read_payload);
> +
> +/**
>   * svc_fill_write_vector - Construct data argument for VFS write call
>   * @rqstp: svc_rqst to operate on
>   * @pages: list of pages containing data payload
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 2934dd711715..fe045b3e7e08 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -279,6 +279,11 @@ static int svc_sendto(struct svc_rqst *rqstp, struct xdr_buf *xdr)
>  	return len;
>  }
>  
> +static void svc_sock_read_payload(struct svc_rqst *rqstp, unsigned int pos,
> +				  unsigned long length)
> +{
> +}
> +
>  /*
>   * Report socket names for nfsdfs
>   */
> @@ -653,6 +658,7 @@ static struct svc_xprt *svc_udp_create(struct svc_serv *serv,
>  	.xpo_create = svc_udp_create,
>  	.xpo_recvfrom = svc_udp_recvfrom,
>  	.xpo_sendto = svc_udp_sendto,
> +	.xpo_read_payload = svc_sock_read_payload,
>  	.xpo_release_rqst = svc_release_udp_skb,
>  	.xpo_detach = svc_sock_detach,
>  	.xpo_free = svc_sock_free,
> @@ -1171,6 +1177,7 @@ static struct svc_xprt *svc_tcp_create(struct svc_serv *serv,
>  	.xpo_create = svc_tcp_create,
>  	.xpo_recvfrom = svc_tcp_recvfrom,
>  	.xpo_sendto = svc_tcp_sendto,
> +	.xpo_read_payload = svc_sock_read_payload,
>  	.xpo_release_rqst = svc_release_skb,
>  	.xpo_detach = svc_tcp_sock_detach,
>  	.xpo_free = svc_sock_free,
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> index 393af8624f53..90f0a9ce7521 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -191,6 +191,7 @@ void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma *rdma)
>  
>  out:
>  	ctxt->rc_page_count = 0;
> +	ctxt->rc_read_payload_length = 0;
>  	return ctxt;
>  
>  out_empty:
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> index 467d40a1dffa..2cef19592565 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> @@ -484,18 +484,18 @@ static int svc_rdma_send_xdr_kvec(struct svc_rdma_write_info *info,
>  				     vec->iov_len);
>  }
>  
> -/* Send an xdr_buf's page list by itself. A Write chunk is
> - * just the page list. a Reply chunk is the head, page list,
> - * and tail. This function is shared between the two types
> - * of chunk.
> +/* Send an xdr_buf's page list by itself. A Write chunk is just
> + * the page list. A Reply chunk is @xdr's head, page list, and
> + * tail. This function is shared between the two types of chunk.
>   */
>  static int svc_rdma_send_xdr_pagelist(struct svc_rdma_write_info *info,
> -				      struct xdr_buf *xdr)
> +				      struct xdr_buf *xdr,
> +				      unsigned int length)
>  {
>  	info->wi_xdr = xdr;
>  	info->wi_next_off = 0;
>  	return svc_rdma_build_writes(info, svc_rdma_pagelist_to_sg,
> -				     xdr->page_len);
> +				     length);
>  }
>  
>  /**
> @@ -503,6 +503,7 @@ static int svc_rdma_send_xdr_pagelist(struct svc_rdma_write_info *info,
>   * @rdma: controlling RDMA transport
>   * @wr_ch: Write chunk provided by client
>   * @xdr: xdr_buf containing the data payload
> + * @rctxt: location in @xdr of the data payload
>   *
>   * Returns a non-negative number of bytes the chunk consumed, or
>   *	%-E2BIG if the payload was larger than the Write chunk,
> @@ -512,9 +513,11 @@ static int svc_rdma_send_xdr_pagelist(struct svc_rdma_write_info *info,
>   *	%-EIO if rdma_rw initialization failed (DMA mapping, etc).
>   */
>  int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
> -			      struct xdr_buf *xdr)
> +			      struct xdr_buf *xdr,
> +			      struct svc_rdma_recv_ctxt *rctxt)
>  {
>  	struct svc_rdma_write_info *info;
> +	unsigned int length;
>  	int ret;
>  
>  	if (!xdr->page_len)
> @@ -524,7 +527,12 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
>  	if (!info)
>  		return -ENOMEM;
>  
> -	ret = svc_rdma_send_xdr_pagelist(info, xdr);
> +	/* xdr->page_len is the chunk length, unless the upper layer
> +	 * has explicitly provided a payload length.
> +	 */
> +	length = rctxt->rc_read_payload_length ?
> +			rctxt->rc_read_payload_length : xdr->page_len;
> +	ret = svc_rdma_send_xdr_pagelist(info, xdr, length);
>  	if (ret < 0)
>  		goto out_err;
>  
> @@ -533,7 +541,7 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
>  		goto out_err;
>  
>  	trace_svcrdma_encode_write(xdr->page_len);
> -	return xdr->page_len;
> +	return length;
>  
>  out_err:
>  	svc_rdma_write_info_free(info);
> @@ -573,7 +581,8 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma, __be32 *rp_ch,
>  	 * client did not provide Write chunks.
>  	 */
>  	if (!writelist && xdr->page_len) {
> -		ret = svc_rdma_send_xdr_pagelist(info, xdr);
> +		ret = svc_rdma_send_xdr_pagelist(info, xdr,
> +						 xdr->page_len);
>  		if (ret < 0)
>  			goto out_err;
>  		consumed += xdr->page_len;
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> index a9ba040c70da..6f9b49b6768f 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> @@ -871,7 +871,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
>  
>  	if (wr_lst) {
>  		/* XXX: Presume the client sent only one Write chunk */
> -		ret = svc_rdma_send_write_chunk(rdma, wr_lst, xdr);
> +		ret = svc_rdma_send_write_chunk(rdma, wr_lst, xdr, rctxt);
>  		if (ret < 0)
>  			goto err2;
>  		svc_rdma_xdr_encode_write_list(rdma_resp, wr_lst, ret);
> @@ -913,3 +913,27 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
>  	ret = -ENOTCONN;
>  	goto out;
>  }
> +
> +/**
> + * svc_rdma_read_payload - mark where a READ payload sites
> + * @rqstp: svc_rqst to operate on
> + * @pos: payload's byte offset in the RPC Reply message
> + * @length: size of payload, in bytes
> + *
> + * For the moment, just record the xdr_buf location of the READ
> + * payload. svc_rdma_sendto will use that location later when
> + * we actually send the payload.
> + */
> +void svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int pos,
> +			   unsigned long length)
> +{
> +	struct svc_rdma_recv_ctxt *ctxt = rqstp->rq_xprt_ctxt;
> +
> +	/* XXX: Just one READ payload slot for now, since our
> +	 * transport implementation currently supports only one
> +	 * Write chunk. We assume the one READ payload always
> +	 * starts at the head<->pages boundary.
> +	 */
> +	WARN_ON(rqstp->rq_res.head[0].iov_len != pos);
> +	ctxt->rc_read_payload_length = length;
> +}
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 145a3615c319..f6aad2798063 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -82,6 +82,7 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
>  	.xpo_create = svc_rdma_create,
>  	.xpo_recvfrom = svc_rdma_recvfrom,
>  	.xpo_sendto = svc_rdma_sendto,
> +	.xpo_read_payload = svc_rdma_read_payload,
>  	.xpo_release_rqst = svc_rdma_release_rqst,
>  	.xpo_detach = svc_rdma_detach,
>  	.xpo_free = svc_rdma_free,
