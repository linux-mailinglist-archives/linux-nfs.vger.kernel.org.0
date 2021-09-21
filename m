Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D7F4137E6
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Sep 2021 18:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhIUQ7r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Sep 2021 12:59:47 -0400
Received: from p3plsmtpa06-08.prod.phx3.secureserver.net ([173.201.192.109]:54156
        "EHLO p3plsmtpa06-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhIUQ7r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Sep 2021 12:59:47 -0400
Received: from [192.168.0.100] ([173.76.240.186])
        by :SMTPAUTH: with ESMTPSA
        id Sj60mFwS1dAq3Sj61mo0TO; Tue, 21 Sep 2021 09:58:17 -0700
X-CMAE-Analysis: v=2.4 cv=OfpdsjfY c=1 sm=1 tr=0 ts=614a0f29
 a=jWrLioA5F7WmVvax94MGYQ==:117 a=jWrLioA5F7WmVvax94MGYQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=yPCof4ZbAAAA:8 a=AX-A9a7WQrxAEr7IkYUA:9
 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v2] xprtrdma: Provide a buffer to pad Write chunks of
 unaligned length
To:     Chuck Lever <chuck.lever@oracle.com>, kolga@netapp.com
Cc:     linux-nfs@vger.kernel.org
References: <163198229142.4159.3151965308454175921.stgit@morisot.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <d69234ec-4688-e5d1-17c3-247841d47d16@talpey.com>
Date:   Tue, 21 Sep 2021 12:58:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <163198229142.4159.3151965308454175921.stgit@morisot.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPA1+/XbWHO+epktJmb+0tPgVKdnu9gRNHScRVRNGQWzdDHLVw7mV00CrzDprmB/wtedCu+kinnWV4e/FnBlTYoYVxPCvYwB5GT9aQZFWFyYrGoEdaN7
 MeBK5nVwPdxiFPxSI33+QK1/sbjXah5uo6pNquyCSfFxRJFzwVE2pKry5wfl9AwoO0e1uHTagXypjemvfg7dyCVB4Yub+jEKTWfVSt6UKZ4a7RWgdr0hiLpq
 xZInFUOzLqZS3GnTwWgI4g==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/18/2021 12:26 PM, Chuck Lever wrote:
> This is a buffer to be left persistently registered while a
> connection is up. Connection tear-down will automatically DMA-unmap,
> invalidate, and dereg the MR. A persistently registered buffer has
> no-cost to provide, and it can never be elided into the RDMA segment
> that backs the data payload.

I'm confused by this last sentence. Why is "no-cost" important?
And, "elided" means to omit, so the word "into" is unexpected.

Why not just say it's a small preregistered buffer of zero bytes,
to be used when padding is required for rpc's on this connection?

I do have one additional question below.

Fix otherwise looks good, you can add my R-B
Reviewed-By: Tom Talpey <tom@talpey.com>


> 
> An RPC that provisions a Write chunk with a non-aligned length now
> uses this MR rather than the tail buffer of the RPC's rq_rcv_buf.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   include/trace/events/rpcrdma.h  |   13 ++++++++++---
>   net/sunrpc/xprtrdma/frwr_ops.c  |   35 +++++++++++++++++++++++++++++++++++
>   net/sunrpc/xprtrdma/rpc_rdma.c  |   32 +++++++++++++++++++++++---------
>   net/sunrpc/xprtrdma/verbs.c     |    1 +
>   net/sunrpc/xprtrdma/xprt_rdma.h |    5 +++++
>   5 files changed, 74 insertions(+), 12 deletions(-)
> 
> Changes since v1:
> - Reverse the sense of the new re_implicit_roundup check
> - Simplify the hunk in rpcrdma_convert_iovs()
> 
> 
> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
> index bd55908c1bef..c71e106c9cd4 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -375,10 +375,16 @@ DECLARE_EVENT_CLASS(xprtrdma_mr_class,
>   
>   	TP_fast_assign(
>   		const struct rpcrdma_req *req = mr->mr_req;
> -		const struct rpc_task *task = req->rl_slot.rq_task;
>   
> -		__entry->task_id = task->tk_pid;
> -		__entry->client_id = task->tk_client->cl_clid;
> +		if (req) {
> +			const struct rpc_task *task = req->rl_slot.rq_task;
> +
> +			__entry->task_id = task->tk_pid;
> +			__entry->client_id = task->tk_client->cl_clid;
> +		} else {
> +			__entry->task_id = 0;
> +			__entry->client_id = -1;
> +		}
>   		__entry->mr_id  = mr->mr_ibmr->res.id;
>   		__entry->nents  = mr->mr_nents;
>   		__entry->handle = mr->mr_handle;
> @@ -639,6 +645,7 @@ TRACE_EVENT(xprtrdma_nomrs_err,
>   DEFINE_RDCH_EVENT(read);
>   DEFINE_WRCH_EVENT(write);
>   DEFINE_WRCH_EVENT(reply);
> +DEFINE_WRCH_EVENT(wp);
>   
>   TRACE_DEFINE_ENUM(rpcrdma_noch);
>   TRACE_DEFINE_ENUM(rpcrdma_noch_pullup);
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
> index 229fcc9a9064..6726fbbdd4a3 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -654,3 +654,38 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
>   	 */
>   	rpcrdma_unpin_rqst(req->rl_reply);
>   }
> +
> +/**
> + * frwr_wp_create - Create an MR for padding Write chunks
> + * @r_xprt: transport resources to use
> + *
> + * Return 0 on success, negative errno on failure.
> + */
> +int frwr_wp_create(struct rpcrdma_xprt *r_xprt)
> +{
> +	struct rpcrdma_ep *ep = r_xprt->rx_ep;
> +	struct rpcrdma_mr_seg seg;
> +	struct rpcrdma_mr *mr;
> +
> +	mr = rpcrdma_mr_get(r_xprt);
> +	if (!mr)
> +		return -EAGAIN;
> +	mr->mr_req = NULL;
> +	ep->re_write_pad_mr = mr;
> +
> +	seg.mr_len = XDR_UNIT;
> +	seg.mr_page = virt_to_page(ep->re_write_pad);
> +	seg.mr_offset = offset_in_page(ep->re_write_pad);
> +	if (IS_ERR(frwr_map(r_xprt, &seg, 1, true, xdr_zero, mr)))
> +		return -EIO;
> +	trace_xprtrdma_mr_fastreg(mr);
> +
> +	mr->mr_cqe.done = frwr_wc_fastreg;
> +	mr->mr_regwr.wr.next = NULL;
> +	mr->mr_regwr.wr.wr_cqe = &mr->mr_cqe;
> +	mr->mr_regwr.wr.num_sge = 0;
> +	mr->mr_regwr.wr.opcode = IB_WR_REG_MR;
> +	mr->mr_regwr.wr.send_flags = 0;
> +
> +	return ib_post_send(ep->re_id->qp, &mr->mr_regwr.wr, NULL);
> +}
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> index c335c1361564..678586cb2328 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -255,15 +255,7 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
>   		page_base = 0;
>   	}
>   
> -	if (type == rpcrdma_readch)
> -		goto out;
> -
> -	/* When encoding a Write chunk, some servers need to see an
> -	 * extra segment for non-XDR-aligned Write chunks. The upper
> -	 * layer provides space in the tail iovec that may be used
> -	 * for this purpose.
> -	 */
> -	if (type == rpcrdma_writech && r_xprt->rx_ep->re_implicit_roundup)
> +	if (type == rpcrdma_readch || type == rpcrdma_writech)
>   		goto out;
>   
>   	if (xdrbuf->tail[0].iov_len)
> @@ -405,6 +397,7 @@ static int rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt,
>   				     enum rpcrdma_chunktype wtype)
>   {
>   	struct xdr_stream *xdr = &req->rl_stream;
> +	struct rpcrdma_ep *ep = r_xprt->rx_ep;
>   	struct rpcrdma_mr_seg *seg;
>   	struct rpcrdma_mr *mr;
>   	int nsegs, nchunks;
> @@ -443,6 +436,27 @@ static int rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt,
>   		nsegs -= mr->mr_nents;
>   	} while (nsegs);
>   
> +	/* The pad MR is already registered, and is not chained on
> +	 * rl_registered. Thus the Reply handler does not invalidate it.
> +	 *
> +	 * To avoid accidental remote invalidation of this MR, it is
> +	 * not used when remote invalidation is enabled. Servers that
> +	 * support remote invalidation are known not to write into
> +	 * Write chunk pad segments.
> +	 */

The words "known not to write" sound ominous. Why not simply register
the pad MR as remote read, without remote write, and close the door?

Tom.

> +	if (!ep->re_implicit_roundup &&
> +	    xdr_pad_size(rqst->rq_rcv_buf.page_len)) {
> +		if (encode_rdma_segment(xdr, ep->re_write_pad_mr) < 0)
> +			return -EMSGSIZE;
> +
> +		trace_xprtrdma_chunk_wp(rqst->rq_task, ep->re_write_pad_mr,
> +					nsegs);
> +		r_xprt->rx_stats.write_chunk_count++;
> +		r_xprt->rx_stats.total_rdma_request += mr->mr_length;
> +		nchunks++;
> +		nsegs -= mr->mr_nents;
> +	}
> +
>   	/* Update count of segments in this Write chunk */
>   	*segcount = cpu_to_be32(nchunks);
>   
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 649c23518ec0..7fa55f219638 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -551,6 +551,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
>   		goto out;
>   	}
>   	rpcrdma_mrs_create(r_xprt);
> +	frwr_wp_create(r_xprt);
>   
>   out:
>   	trace_xprtrdma_connect(r_xprt, rc);
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> index 5d231d94e944..c71e6e1b82b9 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -68,12 +68,14 @@
>   /*
>    * RDMA Endpoint -- connection endpoint details
>    */
> +struct rpcrdma_mr;
>   struct rpcrdma_ep {
>   	struct kref		re_kref;
>   	struct rdma_cm_id 	*re_id;
>   	struct ib_pd		*re_pd;
>   	unsigned int		re_max_rdma_segs;
>   	unsigned int		re_max_fr_depth;
> +	struct rpcrdma_mr	*re_write_pad_mr;
>   	bool			re_implicit_roundup;
>   	enum ib_mr_type		re_mrtype;
>   	struct completion	re_done;
> @@ -97,6 +99,8 @@ struct rpcrdma_ep {
>   	unsigned int		re_inline_recv;	/* negotiated */
>   
>   	atomic_t		re_completion_ids;
> +
> +	char			re_write_pad[XDR_UNIT];
>   };
>   
>   /* Pre-allocate extra Work Requests for handling reverse-direction
> @@ -535,6 +539,7 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
>   void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs);
>   void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
>   void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
> +int frwr_wp_create(struct rpcrdma_xprt *r_xprt);
>   
>   /*
>    * RPC/RDMA protocol calls - xprtrdma/rpc_rdma.c
> 
> 
> 
