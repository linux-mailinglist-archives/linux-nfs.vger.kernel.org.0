Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA3E29CABD
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 21:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829301AbgJ0Ux3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 16:53:29 -0400
Received: from fieldses.org ([173.255.197.46]:45906 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1829279AbgJ0Ux3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Oct 2020 16:53:29 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 38D976814; Tue, 27 Oct 2020 16:53:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 38D976814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603832007;
        bh=udMB4klfObKe+kmSusmH9Qgg92RhbS7M1xRkA4YrwDg=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=EkoKQssiwNf9h/QyoUSuYbUQB6WhcTBQbfItG4CJS6AOZ/TLO2TSYA69lcOQfkZ1U
         XjxvthfeCEzwLF5TytH2obu1Q63E5DujFcBYcGqgdtmZcaKBbxvAx7469GI5bYI8gE
         zFhS/yijbe3qp7DrDVhM2A3J+Y+N7PbMqgMwNK3A=
Date:   Tue, 27 Oct 2020 16:53:27 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 04/20] SUNRPC: Rename svc_encode_read_payload()
Message-ID: <20201027205327.GC4697@fieldses.org>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
 <160373845420.1886.3075276814923041440.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160373845420.1886.3075276814923041440.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 26, 2020 at 02:54:14PM -0400, Chuck Lever wrote:
> Clean up: "result payload" is a less confusing name for these
> payloads. "READ payload" reflects only the NFS usage.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c                        |    2 +-
>  include/linux/sunrpc/svc.h               |    6 +++---
>  include/linux/sunrpc/svc_rdma.h          |    4 ++--
>  include/linux/sunrpc/svc_xprt.h          |    4 ++--
>  net/sunrpc/svc.c                         |   11 ++++++-----
>  net/sunrpc/svcsock.c                     |    8 ++++----
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c    |    8 ++++----
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |    2 +-
>  8 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 833a2c64dfe8..7e24fb3ca36e 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3829,7 +3829,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
>  	read->rd_length = maxcount;
>  	if (nfserr)
>  		return nfserr;
> -	if (svc_encode_read_payload(resp->rqstp, starting_len + 8, maxcount))
> +	if (svc_encode_result_payload(resp->rqstp, starting_len + 8, maxcount))
>  		return nfserr_io;

Why does this call check for an error return while the
svc_encode_result_payload() calls in the next patch don't?

--b.

>  	xdr_truncate_encode(xdr, starting_len + 8 + xdr_align_size(maxcount));
>  
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 386628b36bc7..c220b734fa69 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -519,9 +519,9 @@ void		   svc_wake_up(struct svc_serv *);
>  void		   svc_reserve(struct svc_rqst *rqstp, int space);
>  struct svc_pool *  svc_pool_for_cpu(struct svc_serv *serv, int cpu);
>  char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
> -int		   svc_encode_read_payload(struct svc_rqst *rqstp,
> -					   unsigned int offset,
> -					   unsigned int length);
> +int		   svc_encode_result_payload(struct svc_rqst *rqstp,
> +					     unsigned int offset,
> +					     unsigned int length);
>  unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
>  					 struct page **pages,
>  					 struct kvec *first, size_t total);
> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
> index 9dc3a3b88391..2b870a3f391b 100644
> --- a/include/linux/sunrpc/svc_rdma.h
> +++ b/include/linux/sunrpc/svc_rdma.h
> @@ -207,8 +207,8 @@ extern void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
>  				    struct svc_rdma_recv_ctxt *rctxt,
>  				    int status);
>  extern int svc_rdma_sendto(struct svc_rqst *);
> -extern int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
> -				 unsigned int length);
> +extern int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned int offset,
> +				   unsigned int length);
>  
>  /* svc_rdma_transport.c */
>  extern struct svc_xprt_class svc_rdma_class;
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
> index aca35ab5cff2..92455e0d5244 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -21,8 +21,8 @@ struct svc_xprt_ops {
>  	int		(*xpo_has_wspace)(struct svc_xprt *);
>  	int		(*xpo_recvfrom)(struct svc_rqst *);
>  	int		(*xpo_sendto)(struct svc_rqst *);
> -	int		(*xpo_read_payload)(struct svc_rqst *, unsigned int,
> -					    unsigned int);
> +	int		(*xpo_result_payload)(struct svc_rqst *, unsigned int,
> +					      unsigned int);
>  	void		(*xpo_release_rqst)(struct svc_rqst *);
>  	void		(*xpo_detach)(struct svc_xprt *);
>  	void		(*xpo_free)(struct svc_xprt *);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index c211b607239e..b41500645c3f 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1622,7 +1622,7 @@ u32 svc_max_payload(const struct svc_rqst *rqstp)
>  EXPORT_SYMBOL_GPL(svc_max_payload);
>  
>  /**
> - * svc_encode_read_payload - mark a range of bytes as a READ payload
> + * svc_encode_result_payload - mark a range of bytes as a result payload
>   * @rqstp: svc_rqst to operate on
>   * @offset: payload's byte offset in rqstp->rq_res
>   * @length: size of payload, in bytes
> @@ -1630,12 +1630,13 @@ EXPORT_SYMBOL_GPL(svc_max_payload);
>   * Returns zero on success, or a negative errno if a permanent
>   * error occurred.
>   */
> -int svc_encode_read_payload(struct svc_rqst *rqstp, unsigned int offset,
> -			    unsigned int length)
> +int svc_encode_result_payload(struct svc_rqst *rqstp, unsigned int offset,
> +			      unsigned int length)
>  {
> -	return rqstp->rq_xprt->xpt_ops->xpo_read_payload(rqstp, offset, length);
> +	return rqstp->rq_xprt->xpt_ops->xpo_result_payload(rqstp, offset,
> +							   length);
>  }
> -EXPORT_SYMBOL_GPL(svc_encode_read_payload);
> +EXPORT_SYMBOL_GPL(svc_encode_result_payload);
>  
>  /**
>   * svc_fill_write_vector - Construct data argument for VFS write call
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index c2752e2b9ce3..b248f2349437 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -181,8 +181,8 @@ static void svc_set_cmsg_data(struct svc_rqst *rqstp, struct cmsghdr *cmh)
>  	}
>  }
>  
> -static int svc_sock_read_payload(struct svc_rqst *rqstp, unsigned int offset,
> -				 unsigned int length)
> +static int svc_sock_result_payload(struct svc_rqst *rqstp, unsigned int offset,
> +				   unsigned int length)
>  {
>  	return 0;
>  }
> @@ -635,7 +635,7 @@ static const struct svc_xprt_ops svc_udp_ops = {
>  	.xpo_create = svc_udp_create,
>  	.xpo_recvfrom = svc_udp_recvfrom,
>  	.xpo_sendto = svc_udp_sendto,
> -	.xpo_read_payload = svc_sock_read_payload,
> +	.xpo_result_payload = svc_sock_result_payload,
>  	.xpo_release_rqst = svc_udp_release_rqst,
>  	.xpo_detach = svc_sock_detach,
>  	.xpo_free = svc_sock_free,
> @@ -1123,7 +1123,7 @@ static const struct svc_xprt_ops svc_tcp_ops = {
>  	.xpo_create = svc_tcp_create,
>  	.xpo_recvfrom = svc_tcp_recvfrom,
>  	.xpo_sendto = svc_tcp_sendto,
> -	.xpo_read_payload = svc_sock_read_payload,
> +	.xpo_result_payload = svc_sock_result_payload,
>  	.xpo_release_rqst = svc_tcp_release_rqst,
>  	.xpo_detach = svc_tcp_sock_detach,
>  	.xpo_free = svc_sock_free,
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> index c3d588b149aa..c8411b4f3492 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> @@ -979,19 +979,19 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
>  }
>  
>  /**
> - * svc_rdma_read_payload - special processing for a READ payload
> + * svc_rdma_result_payload - special processing for a result payload
>   * @rqstp: svc_rqst to operate on
>   * @offset: payload's byte offset in @xdr
>   * @length: size of payload, in bytes
>   *
>   * Returns zero on success.
>   *
> - * For the moment, just record the xdr_buf location of the READ
> + * For the moment, just record the xdr_buf location of the result
>   * payload. svc_rdma_sendto will use that location later when
>   * we actually send the payload.
>   */
> -int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
> -			  unsigned int length)
> +int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned int offset,
> +			    unsigned int length)
>  {
>  	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
>  
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index fb044792b571..afba4e9d5425 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -80,7 +80,7 @@ static const struct svc_xprt_ops svc_rdma_ops = {
>  	.xpo_create = svc_rdma_create,
>  	.xpo_recvfrom = svc_rdma_recvfrom,
>  	.xpo_sendto = svc_rdma_sendto,
> -	.xpo_read_payload = svc_rdma_read_payload,
> +	.xpo_result_payload = svc_rdma_result_payload,
>  	.xpo_release_rqst = svc_rdma_release_rqst,
>  	.xpo_detach = svc_rdma_detach,
>  	.xpo_free = svc_rdma_free,
> 
