Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE363FCF17
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 23:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbhHaVZn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 17:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhHaVZm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 17:25:42 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D493C061575;
        Tue, 31 Aug 2021 14:24:47 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E6561912C; Tue, 31 Aug 2021 17:24:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E6561912C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1630445085;
        bh=Mzi3RUWw/ZXyF2uaRvpGiQJrJc0BTOPAim7neTBovxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0mRRvzHE7FPl1L746Tib95UhyIhBmrk2MYqRS04+DtqruXZ4epIvrMFIhmfvZao2
         H2pK62+5bgZjk0i8d6d856gNOUoFxDHcrKVs7CuqwhFbcDPZk2DeEb6dJTYlQp6KTt
         yCBWL4a9NEIFTpwfeEVmGU4O5AQfDRGSAyveS7Hg=
Date:   Tue, 31 Aug 2021 17:24:45 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 6/6] svcrdma: Pull Read chunks in
 ->xpo_argument_payload
Message-ID: <20210831212445.GC7585@fieldses.org>
References: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
 <163043674641.1415.15896010002221696600.stgit@klimt.1015granger.net>
 <20210831204044.GA7585@fieldses.org>
 <6D264615-3EC1-4EF8-A11B-77E192EE2383@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D264615-3EC1-4EF8-A11B-77E192EE2383@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 31, 2021 at 09:19:23PM +0000, Chuck Lever III wrote:
> 
> > On Aug 31, 2021, at 4:40 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > How does this deal with compounds with multiple writes?
> 
> Explained in the cover letter.

Whoops, I see now, thanks.--b.

> 
> 
> > We don't need to handle those efficiently, but we do need to handle
> > them.
> > 
> > --b.
> > 
> > On Tue, Aug 31, 2021 at 03:05:46PM -0400, Chuck Lever wrote:
> >> This enables the XDR decoder to figure out how the payload sink
> >> buffer needs to be aligned before setting up the RDMA Reads.
> >> Then re-alignment of large RDMA Read payloads can be avoided.
> >> 
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> include/linux/sunrpc/svc_rdma.h         |    6 +
> >> include/trace/events/rpcrdma.h          |   26 ++++++
> >> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   17 +++-
> >> net/sunrpc/xprtrdma/svc_rdma_rw.c       |  139 ++++++++++++++++++++++++++++---
> >> 4 files changed, 169 insertions(+), 19 deletions(-)
> >> 
> >> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
> >> index f660244cc8ba..8d80a759a909 100644
> >> --- a/include/linux/sunrpc/svc_rdma.h
> >> +++ b/include/linux/sunrpc/svc_rdma.h
> >> @@ -192,6 +192,12 @@ extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
> >> extern int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
> >> 				      struct svc_rqst *rqstp,
> >> 				      struct svc_rdma_recv_ctxt *head);
> >> +extern void svc_rdma_prepare_read_chunk(struct svc_rqst *rqstp,
> >> +					struct svc_rdma_recv_ctxt *head);
> >> +extern int svc_rdma_pull_read_chunk(struct svcxprt_rdma *rdma,
> >> +				    struct svc_rqst *rqstp,
> >> +				    struct svc_rdma_recv_ctxt *ctxt,
> >> +				    unsigned int offset, unsigned int length);
> >> 
> >> /* svc_rdma_sendto.c */
> >> extern void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma);
> >> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
> >> index 5954ce036173..30440cca321a 100644
> >> --- a/include/trace/events/rpcrdma.h
> >> +++ b/include/trace/events/rpcrdma.h
> >> @@ -2136,6 +2136,32 @@ TRACE_EVENT(svcrdma_sq_post_err,
> >> 	)
> >> );
> >> 
> >> +TRACE_EVENT(svcrdma_arg_payload,
> >> +	TP_PROTO(
> >> +		const struct svc_rqst *rqstp,
> >> +		unsigned int offset,
> >> +		unsigned int length
> >> +	),
> >> +
> >> +	TP_ARGS(rqstp, offset, length),
> >> +
> >> +	TP_STRUCT__entry(
> >> +		__field(u32, xid)
> >> +		__field(u32, offset)
> >> +		__field(u32, length)
> >> +	),
> >> +
> >> +	TP_fast_assign(
> >> +		__entry->xid = __be32_to_cpu(rqstp->rq_xid);
> >> +		__entry->offset = offset_in_page(offset);
> >> +		__entry->length = length;
> >> +	),
> >> +
> >> +	TP_printk("xid=0x%08x offset=%u length=%u",
> >> +		__entry->xid, __entry->offset, __entry->length
> >> +	)
> >> +);
> >> +
> >> #endif /* _TRACE_RPCRDMA_H */
> >> 
> >> #include <trace/define_trace.h>
> >> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> >> index 08a620b370ae..cd9c0fb1a470 100644
> >> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> >> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> >> @@ -838,12 +838,13 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
> >> 
> >> 	svc_rdma_get_inv_rkey(rdma_xprt, ctxt);
> >> 
> >> -	if (!pcl_is_empty(&ctxt->rc_read_pcl) ||
> >> -	    !pcl_is_empty(&ctxt->rc_call_pcl)) {
> >> +	if (!pcl_is_empty(&ctxt->rc_call_pcl) ||
> >> +	    ctxt->rc_read_pcl.cl_count > 1) {
> >> 		ret = svc_rdma_process_read_list(rdma_xprt, rqstp, ctxt);
> >> 		if (ret < 0)
> >> 			goto out_readfail;
> >> -	}
> >> +	} else if (ctxt->rc_read_pcl.cl_count == 1)
> >> +		svc_rdma_prepare_read_chunk(rqstp, ctxt);
> >> 
> >> 	rqstp->rq_xprt_ctxt = ctxt;
> >> 	rqstp->rq_prot = IPPROTO_MAX;
> >> @@ -887,5 +888,13 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
> >> int svc_rdma_argument_payload(struct svc_rqst *rqstp, unsigned int offset,
> >> 			      unsigned int length)
> >> {
> >> -	return 0;
> >> +	struct svc_rdma_recv_ctxt *ctxt = rqstp->rq_xprt_ctxt;
> >> +	struct svc_xprt *xprt = rqstp->rq_xprt;
> >> +	struct svcxprt_rdma *rdma =
> >> +		container_of(xprt, struct svcxprt_rdma, sc_xprt);
> >> +
> >> +	if (!pcl_is_empty(&ctxt->rc_call_pcl) ||
> >> +	    ctxt->rc_read_pcl.cl_count != 1)
> >> +		return 0;
> >> +	return svc_rdma_pull_read_chunk(rdma, rqstp, ctxt, offset, length);
> >> }
> >> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> >> index 29b7d477891c..5f03dfd2fa03 100644
> >> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> >> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> >> @@ -707,19 +707,24 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
> >> 
> >> 	len = segment->rs_length;
> >> 	sge_no = PAGE_ALIGN(info->ri_pageoff + len) >> PAGE_SHIFT;
> >> +
> >> +	trace_printk("pageoff=%u len=%u sges=%u\n",
> >> +		info->ri_pageoff, len, sge_no);
> >> +
> >> 	ctxt = svc_rdma_get_rw_ctxt(cc->cc_rdma, sge_no);
> >> 	if (!ctxt)
> >> 		return -ENOMEM;
> >> 	ctxt->rw_nents = sge_no;
> >> +	head->rc_page_count += sge_no;
> >> 
> >> 	sg = ctxt->rw_sg_table.sgl;
> >> 	for (sge_no = 0; sge_no < ctxt->rw_nents; sge_no++) {
> >> 		seg_len = min_t(unsigned int, len,
> >> 				PAGE_SIZE - info->ri_pageoff);
> >> 
> >> -		if (!info->ri_pageoff)
> >> -			head->rc_page_count++;
> >> -
> >> +		trace_printk("  page=%p seg_len=%u offset=%u\n",
> >> +			rqstp->rq_pages[info->ri_pageno], seg_len,
> >> +			info->ri_pageoff);
> >> 		sg_set_page(sg, rqstp->rq_pages[info->ri_pageno],
> >> 			    seg_len, info->ri_pageoff);
> >> 		sg = sg_next(sg);
> >> @@ -804,15 +809,14 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
> >> 	unsigned int page_no, numpages;
> >> 
> >> 	numpages = PAGE_ALIGN(info->ri_pageoff + remaining) >> PAGE_SHIFT;
> >> +	head->rc_page_count += numpages;
> >> +
> >> 	for (page_no = 0; page_no < numpages; page_no++) {
> >> 		unsigned int page_len;
> >> 
> >> 		page_len = min_t(unsigned int, remaining,
> >> 				 PAGE_SIZE - info->ri_pageoff);
> >> 
> >> -		if (!info->ri_pageoff)
> >> -			head->rc_page_count++;
> >> -
> >> 		dst = page_address(rqstp->rq_pages[info->ri_pageno]);
> >> 		memcpy(dst + info->ri_pageno, src + offset, page_len);
> >> 
> >> @@ -1092,15 +1096,8 @@ static noinline int svc_rdma_read_special(struct svc_rdma_read_info *info)
> >>  * @rqstp: set of pages to use as Read sink buffers
> >>  * @head: pages under I/O collect here
> >>  *
> >> - * The RPC/RDMA protocol assumes that the upper layer's XDR decoders
> >> - * pull each Read chunk as they decode an incoming RPC message.
> >> - *
> >> - * On Linux, however, the server needs to have a fully-constructed RPC
> >> - * message in rqstp->rq_arg when there is a positive return code from
> >> - * ->xpo_recvfrom. So the Read list is safety-checked immediately when
> >> - * it is received, then here the whole Read list is pulled all at once.
> >> - * The ingress RPC message is fully reconstructed once all associated
> >> - * RDMA Reads have completed.
> >> + * Handle complex Read chunk cases fully before svc_rdma_recvfrom()
> >> + * returns.
> >>  *
> >>  * Return values:
> >>  *   %1: all needed RDMA Reads were posted successfully,
> >> @@ -1159,3 +1156,115 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
> >> 	svc_rdma_read_info_free(info);
> >> 	return ret;
> >> }
> >> +
> >> +/**
> >> + * svc_rdma_prepare_read_chunk - Prepare rq_arg for Read chunk
> >> + * @rqstp: set of pages to use as Read sink buffers
> >> + * @head: pages under I/O collect here
> >> + *
> >> + * The Read chunk will be pulled when the upper layer's XDR
> >> + * decoder calls svc_decode_argument_payload(). In the meantime,
> >> + * fake up rq_arg.page_len and .len to reflect the size of the
> >> + * yet-to-be-pulled payload.
> >> + */
> >> +void svc_rdma_prepare_read_chunk(struct svc_rqst *rqstp,
> >> +				 struct svc_rdma_recv_ctxt *head)
> >> +{
> >> +	struct svc_rdma_chunk *chunk = pcl_first_chunk(&head->rc_read_pcl);
> >> +	unsigned int length = xdr_align_size(chunk->ch_length);
> >> +	struct xdr_buf *buf = &rqstp->rq_arg;
> >> +
> >> +	buf->tail[0].iov_base = buf->head[0].iov_base + chunk->ch_position;
> >> +	buf->tail[0].iov_len = buf->head[0].iov_len - chunk->ch_position;
> >> +	buf->head[0].iov_len = chunk->ch_position;
> >> +
> >> +	buf->page_len = length;
> >> +	buf->len += length;
> >> +	buf->buflen += length;
> >> +
> >> +	/*
> >> +	 * rq_respages starts after the last arg page. Note that we
> >> +	 * don't know the offset yet, so add an extra page as slack.
> >> +	 */
> >> +	length += PAGE_SIZE * 2 - 1;
> >> +	rqstp->rq_respages = &rqstp->rq_pages[length >> PAGE_SHIFT];
> >> +	rqstp->rq_next_page = rqstp->rq_respages + 1;
> >> +}
> >> +
> >> +/**
> >> + * svc_rdma_pull_read_chunk - Pull one Read chunk from the client
> >> + * @rdma: controlling RDMA transport
> >> + * @rqstp: set of pages to use as Read sink buffers
> >> + * @head: pages under I/O collect here
> >> + * @offset: offset of payload in file's page cache
> >> + * @length: size of payload, in bytes
> >> + *
> >> + * Once the upper layer's XDR decoder has decoded the length of
> >> + * the payload and it's offset, we can be clever about setting up
> >> + * the RDMA Read sink buffer so that the VFS does not have to
> >> + * re-align the payload once it is received.
> >> + *
> >> + * Caveat: To keep things simple, this is an optimization that is
> >> + *	   used only when there is a single Read chunk in the Read
> >> + *	   list.
> >> + *
> >> + * Return values:
> >> + *   %0: all needed RDMA Reads were posted successfully,
> >> + *   %-EINVAL: client provided the wrong chunk size,
> >> + *   %-ENOMEM: rdma_rw context pool was exhausted,
> >> + *   %-ENOTCONN: posting failed (connection is lost),
> >> + *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
> >> + */
> >> +int svc_rdma_pull_read_chunk(struct svcxprt_rdma *rdma, struct svc_rqst *rqstp,
> >> +			     struct svc_rdma_recv_ctxt *head,
> >> +			     unsigned int offset, unsigned int length)
> >> +{
> >> +	struct svc_rdma_read_info *info;
> >> +	struct svc_rdma_chunk_ctxt *cc;
> >> +	struct svc_rdma_chunk *chunk;
> >> +	int ret;
> >> +
> >> +	trace_svcrdma_arg_payload(rqstp, offset, length);
> >> +
> >> +	/* Sanity: the Requester must have provided enough
> >> +	 * bytes to fill the XDR opaque.
> >> +	 */
> >> +	chunk = pcl_first_chunk(&head->rc_read_pcl);
> >> +	if (length > chunk->ch_length)
> >> +		return -EINVAL;
> >> +
> >> +	info = svc_rdma_read_info_alloc(rdma);
> >> +	if (!info)
> >> +		return -ENOMEM;
> >> +	cc = &info->ri_cc;
> >> +	info->ri_rqst = rqstp;
> >> +	info->ri_readctxt = head;
> >> +	info->ri_pageno = 0;
> >> +	info->ri_pageoff = offset_in_page(offset);
> >> +	info->ri_totalbytes = 0;
> >> +
> >> +	ret = svc_rdma_build_read_chunk(info, chunk);
> >> +	if (ret < 0)
> >> +		goto out_err;
> >> +	rqstp->rq_arg.pages = &info->ri_rqst->rq_pages[0];
> >> +	rqstp->rq_arg.page_base = offset_in_page(offset);
> >> +	rqstp->rq_arg.buflen += offset_in_page(offset);
> >> +
> >> +	trace_svcrdma_post_read_chunk(&cc->cc_cid, cc->cc_sqecount);
> >> +	init_completion(&cc->cc_done);
> >> +	ret = svc_rdma_post_chunk_ctxt(cc);
> >> +	if (ret < 0)
> >> +		goto out_err;
> >> +
> >> +	ret = 0;
> >> +	wait_for_completion(&cc->cc_done);
> >> +	if (cc->cc_status != IB_WC_SUCCESS)
> >> +		ret = -EIO;
> >> +
> >> +	/* Ensure svc_rdma_recv_ctxt_put() does not try to release pages */
> >> +	head->rc_page_count = 0;
> >> +
> >> +out_err:
> >> +	svc_rdma_read_info_free(info);
> >> +	return ret;
> >> +}
> >> 
> 
> --
> Chuck Lever
> 
> 
