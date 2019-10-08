Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C79D01E2
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2019 22:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfJHUD6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Oct 2019 16:03:58 -0400
Received: from fieldses.org ([173.255.197.46]:47282 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730101AbfJHUD5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 8 Oct 2019 16:03:57 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id BEB7C1C21; Tue,  8 Oct 2019 16:03:56 -0400 (EDT)
Date:   Tue, 8 Oct 2019 16:03:56 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] svcrdma: Improve DMA mapping trace points
Message-ID: <20191008200356.GA9151@fieldses.org>
References: <20191004135745.2510.93924.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004135745.2510.93924.stgit@manet.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 04, 2019 at 09:58:20AM -0400, Chuck Lever wrote:
> Capture the total size of Sends, the size of DMA map and the
> matching DMA unmap to ensure operation is correct.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/trace/events/rpcrdma.h        |   30 +++++++++++++++++++++++-------
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c |    8 ++++++--
>  2 files changed, 29 insertions(+), 9 deletions(-)
> 
> Hey Bruce-
> 
> Please consider this patch for v5.5. Thanks!

Applied, thanks!

--b.

> 
> 
> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
> index a138306..9dd7680 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -1498,31 +1498,47 @@
>   ** Server-side RDMA API events
>   **/
>  
> -TRACE_EVENT(svcrdma_dma_map_page,
> +DECLARE_EVENT_CLASS(svcrdma_dma_map_class,
>  	TP_PROTO(
>  		const struct svcxprt_rdma *rdma,
> -		const void *page
> +		u64 dma_addr,
> +		u32 length
>  	),
>  
> -	TP_ARGS(rdma, page),
> +	TP_ARGS(rdma, dma_addr, length),
>  
>  	TP_STRUCT__entry(
> -		__field(const void *, page);
> +		__field(u64, dma_addr)
> +		__field(u32, length)
>  		__string(device, rdma->sc_cm_id->device->name)
>  		__string(addr, rdma->sc_xprt.xpt_remotebuf)
>  	),
>  
>  	TP_fast_assign(
> -		__entry->page = page;
> +		__entry->dma_addr = dma_addr;
> +		__entry->length = length;
>  		__assign_str(device, rdma->sc_cm_id->device->name);
>  		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
>  	),
>  
> -	TP_printk("addr=%s device=%s page=%p",
> -		__get_str(addr), __get_str(device), __entry->page
> +	TP_printk("addr=%s device=%s dma_addr=%llu length=%u",
> +		__get_str(addr), __get_str(device),
> +		__entry->dma_addr, __entry->length
>  	)
>  );
>  
> +#define DEFINE_SVC_DMA_EVENT(name)					\
> +		DEFINE_EVENT(svcrdma_dma_map_class, svcrdma_##name,	\
> +				TP_PROTO(				\
> +					const struct svcxprt_rdma *rdma,\
> +					u64 dma_addr,			\
> +					u32 length			\
> +				),					\
> +				TP_ARGS(rdma, dma_addr, length))
> +
> +DEFINE_SVC_DMA_EVENT(dma_map_page);
> +DEFINE_SVC_DMA_EVENT(dma_unmap_page);
> +
>  TRACE_EVENT(svcrdma_dma_map_rwctx,
>  	TP_PROTO(
>  		const struct svcxprt_rdma *rdma,
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> index 6fdba72..f3f1080 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> @@ -233,11 +233,15 @@ void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
>  	/* The first SGE contains the transport header, which
>  	 * remains mapped until @ctxt is destroyed.
>  	 */
> -	for (i = 1; i < ctxt->sc_send_wr.num_sge; i++)
> +	for (i = 1; i < ctxt->sc_send_wr.num_sge; i++) {
>  		ib_dma_unmap_page(device,
>  				  ctxt->sc_sges[i].addr,
>  				  ctxt->sc_sges[i].length,
>  				  DMA_TO_DEVICE);
> +		trace_svcrdma_dma_unmap_page(rdma,
> +					     ctxt->sc_sges[i].addr,
> +					     ctxt->sc_sges[i].length);
> +	}
>  
>  	for (i = 0; i < ctxt->sc_page_count; ++i)
>  		put_page(ctxt->sc_pages[i]);
> @@ -490,6 +494,7 @@ static int svc_rdma_dma_map_page(struct svcxprt_rdma *rdma,
>  	dma_addr_t dma_addr;
>  
>  	dma_addr = ib_dma_map_page(dev, page, offset, len, DMA_TO_DEVICE);
> +	trace_svcrdma_dma_map_page(rdma, dma_addr, len);
>  	if (ib_dma_mapping_error(dev, dma_addr))
>  		goto out_maperr;
>  
> @@ -499,7 +504,6 @@ static int svc_rdma_dma_map_page(struct svcxprt_rdma *rdma,
>  	return 0;
>  
>  out_maperr:
> -	trace_svcrdma_dma_map_page(rdma, page);
>  	return -EIO;
>  }
>  
