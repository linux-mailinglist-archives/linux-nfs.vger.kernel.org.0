Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C893507A1
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhCaTug (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:50:36 -0400
Received: from p3plsmtpa06-08.prod.phx3.secureserver.net ([173.201.192.109]:35227
        "EHLO p3plsmtpa06-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235995AbhCaTuY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 15:50:24 -0400
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id Rgr4lFsErdm6ZRgr5lyyVh; Wed, 31 Mar 2021 12:50:19 -0700
X-CMAE-Analysis: v=2.4 cv=U/hXscnu c=1 sm=1 tr=0 ts=6064d27b
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=yPCof4ZbAAAA:8 a=yTYRId3Au5PvlI6FS_AA:9
 a=V0NI_d-hTjy0sF2y:21 a=ao3K6xyw9NAz8GwF:21 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1 3/6] svcrdma: Single-stage RDMA Read
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
 <161702880518.5937.11588469087361545361.stgit@klimt.1015granger.net>
 <42ab6f1b-8809-b20b-4a7c-aad9cfa7145e@talpey.com>
 <B6AA803B-C72D-403D-A9F1-ECD887AF1D8D@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <b5d20a67-6c63-1e4c-e49f-a8285a501df0@talpey.com>
Date:   Wed, 31 Mar 2021 15:50:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <B6AA803B-C72D-403D-A9F1-ECD887AF1D8D@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGz05/nUn9IVPDA6hG+LT6zauZhNron8fqsnOftJOaH5jBDzOiapqGKl8IG/fHS29gLazPux204ZAAd5V9aCDOSRYkuOG+jJ53hClToKeEqF57ELsTD6
 j4KG2Ku/63iZ7cPr2aFmcceBozJa4awczCYEwyQz1/hDsPt1AVBYQdVWYaNwjRS+lW2VZlA7gztuoJOzT3Us9dEpmUTBERRosDtPuLMOJqaAXpHekJHtEFE9
 E0g/hLDeZFmcmWY6M7uSuzxd8ozLlvvshKyMQUeprvc=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

LGTM. With extra info in the patch description and
the comments changed/deleted:

Reviewed-By: Tom Talpey <tom@talpey.com>

On 3/31/2021 3:33 PM, Chuck Lever III wrote:
> 
> 
>> On Mar 31, 2021, at 2:34 PM, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 3/29/2021 10:40 AM, Chuck Lever wrote:
>>> Currently the generic RPC server layer calls svc_rdma_recvfrom()
>>> twice to retrieve an RPC message that uses Read chunks. I'm not
>>> exactly sure why this design was chosen originally.
>>
>> I'm not either, but remember the design was written over a decade
>> ago. I vaguely recall there was some bounce buffering for strange
>> memreg corner cases. The RDMA stack has improved greatly.
>>
>>> Instead, let's wait for the Read chunk completion inline in the
>>> first call to svc_rdma_recvfrom().
>>> The goal is to eliminate some page allocator churn.
>>> rdma_read_complete() replaces pages in the second svc_rqst by
>>> calling put_page() repeatedly while the upper layer waits for
>>> the request to be constructed, which adds unnecessary round-
>>> trip latency.
>>
>> Local API round-trip, right? Same wire traffic either way. In fact,
>> I don't see any Verbs changes too.
> 
> The rdma_read_complete() latency is incurred during the second call
> to svc_rdma_recvfrom().
> 
> That holds up the construction of each message with a Read chunk,
> since memory free operations need to complete first before the
> second svc_rdma_recvfrom() call can return.
> 
> It also holds up the next message in the queue because XPT_BUSY
> is held while the Read chunk and memory allocation is being
> dealt with.
> 
> Therefore it lengthens the NFS WRITE round-trip latency by
> inserting memory allocation operations (put_page()) in a hot path.
> 
> 
>> Some comments/question below.
>>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>   net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   10 +--
>>>   net/sunrpc/xprtrdma/svc_rdma_rw.c       |   96 +++++++++++--------------------
>>>   2 files changed, 39 insertions(+), 67 deletions(-)
>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>>> index 9cb5a09c4a01..b857a6805e95 100644
>>> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>>> @@ -853,6 +853,9 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>>>   	spin_unlock(&rdma_xprt->sc_rq_dto_lock);
>>>   	percpu_counter_inc(&svcrdma_stat_recv);
>>>   +	/* Start receiving the next incoming message */
>>
>> This comment confused me. This call just unblocks the xprt to move
>> to the next message, it does not necessarily "start". So IIUC, it
>> might be clearer to state "transport processing complete" or similar.
> 
> How about "/* Unblock the transport for the next receive */" ?
> 
> 
>>> +	svc_xprt_received(xprt);
>>> +
>>>   	ib_dma_sync_single_for_cpu(rdma_xprt->sc_pd->device,
>>>   				   ctxt->rc_recv_sge.addr, ctxt->rc_byte_len,
>>>   				   DMA_FROM_DEVICE);
>>> @@ -884,33 +887,28 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>>>   	rqstp->rq_xprt_ctxt = ctxt;
>>>   	rqstp->rq_prot = IPPROTO_MAX;
>>>   	svc_xprt_copy_addrs(rqstp, xprt);
>>> -	svc_xprt_received(xprt);
>>>   	return rqstp->rq_arg.len;
>>>     out_readlist:
>>>   	ret = svc_rdma_process_read_list(rdma_xprt, rqstp, ctxt);
>>>   	if (ret < 0)
>>>   		goto out_readfail;
>>> -	svc_xprt_received(xprt);
>>> -	return 0;
>>> +	goto complete;
>>>     out_err:
>>>   	svc_rdma_send_error(rdma_xprt, ctxt, ret);
>>>   	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
>>> -	svc_xprt_received(xprt);
>>>   	return 0;
>>>     out_readfail:
>>>   	if (ret == -EINVAL)
>>>   		svc_rdma_send_error(rdma_xprt, ctxt, ret);
>>>   	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
>>> -	svc_xprt_received(xprt);
>>>   	return ret;
>>>     out_backchannel:
>>>   	svc_rdma_handle_bc_reply(rqstp, ctxt);
>>>   out_drop:
>>>   	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
>>> -	svc_xprt_received(xprt);
>>>   	return 0;
>>>   }
>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
>>> index d7054e3a8e33..9163ab690288 100644
>>> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
>>> @@ -150,6 +150,8 @@ struct svc_rdma_chunk_ctxt {
>>>   	struct svcxprt_rdma	*cc_rdma;
>>>   	struct list_head	cc_rwctxts;
>>>   	int			cc_sqecount;
>>> +	enum ib_wc_status	cc_status;
>>> +	struct completion	cc_done;
>>>   };
>>>     static void svc_rdma_cc_cid_init(struct svcxprt_rdma *rdma,
>>> @@ -299,29 +301,15 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
>>>   	struct svc_rdma_chunk_ctxt *cc =
>>>   			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
>>>   	struct svcxprt_rdma *rdma = cc->cc_rdma;
>>> -	struct svc_rdma_read_info *info =
>>> -			container_of(cc, struct svc_rdma_read_info, ri_cc);
>>>     	trace_svcrdma_wc_read(wc, &cc->cc_cid);
>>>     	atomic_add(cc->cc_sqecount, &rdma->sc_sq_avail);
>>>   	wake_up(&rdma->sc_send_wait);
>>>   -	if (unlikely(wc->status != IB_WC_SUCCESS)) {
>>> -		set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
>>> -		svc_rdma_recv_ctxt_put(rdma, info->ri_readctxt);
>>> -	} else {
>>> -		spin_lock(&rdma->sc_rq_dto_lock);
>>> -		list_add_tail(&info->ri_readctxt->rc_list,
>>> -			      &rdma->sc_read_complete_q);
>>> -		/* Note the unlock pairs with the smp_rmb in svc_xprt_ready: */
>>> -		set_bit(XPT_DATA, &rdma->sc_xprt.xpt_flags);
>>> -		spin_unlock(&rdma->sc_rq_dto_lock);
>>> -
>>> -		svc_xprt_enqueue(&rdma->sc_xprt);
>>> -	}
>>> -
>>> -	svc_rdma_read_info_free(info);
>>> +	cc->cc_status = wc->status;
>>> +	complete(&cc->cc_done);
>>> +	return;
>>>   }
>>>     /* This function sleeps when the transport's Send Queue is congested.
>>> @@ -676,8 +664,8 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
>>>   	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
>>>   	struct svc_rdma_chunk_ctxt *cc = &info->ri_cc;
>>>   	struct svc_rqst *rqstp = info->ri_rqst;
>>> -	struct svc_rdma_rw_ctxt *ctxt;
>>>   	unsigned int sge_no, seg_len, len;
>>> +	struct svc_rdma_rw_ctxt *ctxt;
>>>   	struct scatterlist *sg;
>>>   	int ret;
>>>   @@ -693,8 +681,8 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
>>>   		seg_len = min_t(unsigned int, len,
>>>   				PAGE_SIZE - info->ri_pageoff);
>>>   -		head->rc_arg.pages[info->ri_pageno] =
>>> -			rqstp->rq_pages[info->ri_pageno];
>>> +		/* XXX: ri_pageno and rc_page_count might be exactly the same */
>>> +
>>
>> What is this comment conveying? It looks like a note-to-self that
>> resulted in deleting the prior line.
> 
> Yeah, pretty much. I think it is a reminder that one of those
> fields is superfluous and can be removed.
> 
> 
>> If the "XXX" notation is
>> still significant, it needs more detail on what needs to be
>> fixed in future.
> 
> Or it should be removed before this patch is merged.
> 
> 
>>>   		if (!info->ri_pageoff)
>>>   			head->rc_page_count++;
>>>   @@ -788,12 +776,10 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
>>>   		page_len = min_t(unsigned int, remaining,
>>>   				 PAGE_SIZE - info->ri_pageoff);
>>>   -		head->rc_arg.pages[info->ri_pageno] =
>>> -			rqstp->rq_pages[info->ri_pageno];
>>>   		if (!info->ri_pageoff)
>>>   			head->rc_page_count++;
>>>   -		dst = page_address(head->rc_arg.pages[info->ri_pageno]);
>>> +		dst = page_address(rqstp->rq_pages[info->ri_pageno]);
>>>   		memcpy(dst + info->ri_pageno, src + offset, page_len);
>>>     		info->ri_totalbytes += page_len;
>>> @@ -813,7 +799,7 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
>>>    * svc_rdma_read_multiple_chunks - Construct RDMA Reads to pull data item Read chunks
>>>    * @info: context for RDMA Reads
>>>    *
>>> - * The chunk data lands in head->rc_arg as a series of contiguous pages,
>>> + * The chunk data lands in rqstp->rq_arg as a series of contiguous pages,
>>>    * like an incoming TCP call.
>>>    *
>>>    * Return values:
>>> @@ -827,8 +813,8 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
>>>   {
>>>   	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
>>>   	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
>>> +	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
>>>   	struct svc_rdma_chunk *chunk, *next;
>>> -	struct xdr_buf *buf = &head->rc_arg;
>>>   	unsigned int start, length;
>>>   	int ret;
>>>   @@ -864,9 +850,9 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
>>>   	buf->len += info->ri_totalbytes;
>>>   	buf->buflen += info->ri_totalbytes;
>>>   -	head->rc_hdr_count = 1;
>>> -	buf->head[0].iov_base = page_address(head->rc_pages[0]);
>>> +	buf->head[0].iov_base = page_address(info->ri_rqst->rq_pages[0]);
>>>   	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, info->ri_totalbytes);
>>> +	buf->pages = &info->ri_rqst->rq_pages[1];
>>>   	buf->page_len = info->ri_totalbytes - buf->head[0].iov_len;
>>>   	return 0;
>>>   }
>>> @@ -875,9 +861,9 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
>>>    * svc_rdma_read_data_item - Construct RDMA Reads to pull data item Read chunks
>>>    * @info: context for RDMA Reads
>>>    *
>>> - * The chunk data lands in the page list of head->rc_arg.pages.
>>> + * The chunk data lands in the page list of rqstp->rq_arg.pages.
>>>    *
>>> - * Currently NFSD does not look at the head->rc_arg.tail[0] iovec.
>>> + * Currently NFSD does not look at the rqstp->rq_arg.tail[0] kvec.
>>>    * Therefore, XDR round-up of the Read chunk and trailing
>>>    * inline content must both be added at the end of the pagelist.
>>>    *
>>> @@ -891,7 +877,7 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
>>>   static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
>>>   {
>>>   	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
>>> -	struct xdr_buf *buf = &head->rc_arg;
>>> +	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
>>>   	struct svc_rdma_chunk *chunk;
>>>   	unsigned int length;
>>>   	int ret;
>>> @@ -901,8 +887,6 @@ static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
>>>   	if (ret < 0)
>>>   		goto out;
>>>   -	head->rc_hdr_count = 0;
>>> -
>>>   	/* Split the Receive buffer between the head and tail
>>>   	 * buffers at Read chunk's position. XDR roundup of the
>>>   	 * chunk is not included in either the pagelist or in
>>> @@ -921,7 +905,8 @@ static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
>>>   	 * Currently these chunks always start at page offset 0,
>>>   	 * thus the rounded-up length never crosses a page boundary.
>>>   	 */
>>> -	length = XDR_QUADLEN(info->ri_totalbytes) << 2;
>>> +	buf->pages = &info->ri_rqst->rq_pages[0];
>>> +	length = xdr_align_size(chunk->ch_length);
>>>   	buf->page_len = length;
>>>   	buf->len += length;
>>>   	buf->buflen += length;
>>> @@ -1033,8 +1018,7 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
>>>    * @info: context for RDMA Reads
>>>    *
>>>    * The start of the data lands in the first page just after the
>>> - * Transport header, and the rest lands in the page list of
>>> - * head->rc_arg.pages.
>>> + * Transport header, and the rest lands in rqstp->rq_arg.pages.
>>>    *
>>>    * Assumptions:
>>>    *	- A PZRC is never sent in an RDMA_MSG message, though it's
>>> @@ -1049,8 +1033,7 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
>>>    */
>>>   static noinline int svc_rdma_read_special(struct svc_rdma_read_info *info)
>>>   {
>>> -	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
>>> -	struct xdr_buf *buf = &head->rc_arg;
>>> +	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
>>>   	int ret;
>>>     	ret = svc_rdma_read_call_chunk(info);
>>> @@ -1060,35 +1043,15 @@ static noinline int svc_rdma_read_special(struct svc_rdma_read_info *info)
>>>   	buf->len += info->ri_totalbytes;
>>>   	buf->buflen += info->ri_totalbytes;
>>>   -	head->rc_hdr_count = 1;
>>> -	buf->head[0].iov_base = page_address(head->rc_pages[0]);
>>> +	buf->head[0].iov_base = page_address(info->ri_rqst->rq_pages[0]);
>>>   	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, info->ri_totalbytes);
>>> +	buf->pages = &info->ri_rqst->rq_pages[1];
>>>   	buf->page_len = info->ri_totalbytes - buf->head[0].iov_len;
>>>     out:
>>>   	return ret;
>>>   }
>>>   -/* Pages under I/O have been copied to head->rc_pages. Ensure they
>>> - * are not released by svc_xprt_release() until the I/O is complete.
>>> - *
>>> - * This has to be done after all Read WRs are constructed to properly
>>> - * handle a page that is part of I/O on behalf of two different RDMA
>>> - * segments.
>>> - *
>>> - * Do this only if I/O has been posted. Otherwise, we do indeed want
>>> - * svc_xprt_release() to clean things up properly.
>>> - */
>>> -static void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
>>> -				   const unsigned int start,
>>> -				   const unsigned int num_pages)
>>> -{
>>> -	unsigned int i;
>>> -
>>> -	for (i = start; i < num_pages + start; i++)
>>> -		rqstp->rq_pages[i] = NULL;
>>> -}
>>> -
>>>   /**
>>>    * svc_rdma_process_read_list - Pull list of Read chunks from the client
>>>    * @rdma: controlling RDMA transport
>>> @@ -1153,11 +1116,22 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
>>>   		goto out_err;
>>>     	trace_svcrdma_post_read_chunk(&cc->cc_cid, cc->cc_sqecount);
>>> +	init_completion(&cc->cc_done);
>>>   	ret = svc_rdma_post_chunk_ctxt(cc);
>>>   	if (ret < 0)
>>>   		goto out_err;
>>> -	svc_rdma_save_io_pages(rqstp, 0, head->rc_page_count);
>>> -	return 1;
>>> +
>>> +	ret = 1;
>>> +	wait_for_completion(&cc->cc_done);
>>> +	if (cc->cc_status != IB_WC_SUCCESS)
>>> +		ret = -EIO;
>>> +
>>> +	/* rq_respages starts after the last arg page */
>>> +	rqstp->rq_respages = &rqstp->rq_pages[head->rc_page_count];
>>> +	rqstp->rq_next_page = rqstp->rq_respages + 1;
>>> +
>>> +	/* Ensure svc_rdma_recv_ctxt_put() does not try to release pages */
>>> +	head->rc_page_count = 0;
>>>     out_err:
>>>   	svc_rdma_read_info_free(info);
> 
> --
> Chuck Lever
> 
> 
> 
> 
