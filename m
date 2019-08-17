Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B215090BF5
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2019 03:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfHQBnb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Aug 2019 21:43:31 -0400
Received: from fieldses.org ([173.255.197.46]:36180 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfHQBnb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 16 Aug 2019 21:43:31 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A80A763F; Fri, 16 Aug 2019 21:43:30 -0400 (EDT)
Date:   Fri, 16 Aug 2019 21:43:30 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] svcrdma: Remove svc_rdma_wq
Message-ID: <20190817014330.GA14789@fieldses.org>
References: <156599209136.1245.654792745471627630.stgit@seurat29.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156599209136.1245.654792745471627630.stgit@seurat29.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks!  Applying both for 5.4.

--b.

On Fri, Aug 16, 2019 at 05:48:36PM -0400, Chuck Lever wrote:
> Clean up: the system workqueue will work just as well.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc_rdma.h          |    1 -
>  net/sunrpc/xprtrdma/svc_rdma.c           |    7 -------
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |    3 ++-
>  3 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
> index 981f0d726ad4..edb39900fe04 100644
> --- a/include/linux/sunrpc/svc_rdma.h
> +++ b/include/linux/sunrpc/svc_rdma.h
> @@ -200,7 +200,6 @@ extern struct svc_xprt_class svc_rdma_bc_class;
>  #endif
>  
>  /* svc_rdma.c */
> -extern struct workqueue_struct *svc_rdma_wq;
>  extern int svc_rdma_init(void);
>  extern void svc_rdma_cleanup(void);
>  
> diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
> index abdb3004a1e3..97bca509a391 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma.c
> @@ -73,8 +73,6 @@ atomic_t rdma_stat_rq_prod;
>  atomic_t rdma_stat_sq_poll;
>  atomic_t rdma_stat_sq_prod;
>  
> -struct workqueue_struct *svc_rdma_wq;
> -
>  /*
>   * This function implements reading and resetting an atomic_t stat
>   * variable through read/write to a proc file. Any write to the file
> @@ -230,7 +228,6 @@ static struct ctl_table svcrdma_root_table[] = {
>  void svc_rdma_cleanup(void)
>  {
>  	dprintk("SVCRDMA Module Removed, deregister RPC RDMA transport\n");
> -	destroy_workqueue(svc_rdma_wq);
>  	if (svcrdma_table_header) {
>  		unregister_sysctl_table(svcrdma_table_header);
>  		svcrdma_table_header = NULL;
> @@ -246,10 +243,6 @@ int svc_rdma_init(void)
>  	dprintk("\tmax_bc_requests  : %u\n", svcrdma_max_bc_requests);
>  	dprintk("\tmax_inline       : %d\n", svcrdma_max_req_size);
>  
> -	svc_rdma_wq = alloc_workqueue("svc_rdma", 0, 0);
> -	if (!svc_rdma_wq)
> -		return -ENOMEM;
> -
>  	if (!svcrdma_table_header)
>  		svcrdma_table_header =
>  			register_sysctl_table(svcrdma_root_table);
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 4d3db6ee7f09..30dbbc77ad16 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -630,8 +630,9 @@ static void svc_rdma_free(struct svc_xprt *xprt)
>  {
>  	struct svcxprt_rdma *rdma =
>  		container_of(xprt, struct svcxprt_rdma, sc_xprt);
> +
>  	INIT_WORK(&rdma->sc_work, __svc_rdma_free);
> -	queue_work(svc_rdma_wq, &rdma->sc_work);
> +	schedule_work(&rdma->sc_work);
>  }
>  
>  static int svc_rdma_has_wspace(struct svc_xprt *xprt)
