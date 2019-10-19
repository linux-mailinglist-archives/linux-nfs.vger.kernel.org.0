Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5BDADD9AF
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2019 18:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfJSQn0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Oct 2019 12:43:26 -0400
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net ([173.201.193.231]:50487
        "EHLO p3plsmtpa09-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbfJSQn0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Oct 2019 12:43:26 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Oct 2019 12:43:25 EDT
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id LrhziyD1ZMkfcLri1iwrfe; Sat, 19 Oct 2019 09:36:05 -0700
Subject: Re: [PATCH v1 6/6] xprtrdma: Pull up sometimes
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
 <20191017183152.2517.67599.stgit@oracle-102.nfsv4bat.org>
 <f5075a20-7c9a-773f-e76b-11cba1ab0f16@talpey.com>
 <E1BB2B60-6DE2-47FD-92BA-ED9011C51661@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <3ef2c12c-cc88-6ac6-25cd-99ef162f70a1@talpey.com>
Date:   Sat, 19 Oct 2019 12:36:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <E1BB2B60-6DE2-47FD-92BA-ED9011C51661@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHzKUSSLWdtqn03RmDQdMVz1AHZImFACXlAoESN68G2Uafx9QE1BKjwqVXAcvaFt8g9yXJu5dW5jmJ8TU/Pc2Kc0+Qs+8R3ArxOY6j/Lelpbt11CoGMo
 rQmBWl7KYbMW4cuNd1i6FeZp5UqM3Co9Igv+G3VvKzGsRqQ+7PWzB/44LoshopTTBlIIbXlGOSswsVho8ZhZORb3WL9o3H/lpJsaEOzW0OD+z0ijL69eCzLs
 FHxwf0tciYX647VjCemHXg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/18/2019 7:34 PM, Chuck Lever wrote:
> Hi Tom-
> 
>> On Oct 18, 2019, at 4:17 PM, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 10/17/2019 2:31 PM, Chuck Lever wrote:
>>> On some platforms, DMA mapping part of a page is more costly than
>>> copying bytes. Restore the pull-up code and use that when we
>>> think it's going to be faster. The heuristic for now is to pull-up
>>> when the size of the RPC message body fits in the buffer underlying
>>> the head iovec.
>>> Indeed, not involving the I/O MMU can help the RPC/RDMA transport
>>> scale better for tiny I/Os across more RDMA devices. This is because
>>> interaction with the I/O MMU is eliminated, as is handling a Send
>>> completion, for each of these small I/Os. Without the explicit
>>> unmapping, the NIC no longer needs to do a costly internal TLB shoot
>>> down for buffers that are just a handful of bytes.
>>
>> This is good stuff. Do you have any performance data for the new
>> strategy, especially latencies and local CPU cycles per byte?
> 
> Saves almost a microsecond of RT latency on my NFS client that uses
> a real Intel IOMMU. On my other NFS client, the DMA map operations
> are always a no-op. This savings applies only to NFS WRITE, of course.
> 
> I don't have a good benchmark for cycles per byte. Do you have any
> suggestions? Not sure how I would account for cycles spent handling
> Send completions, for example.

Cycles per byte is fairly simple but like all performance measurement
the trick is in the setup. Because of platform variations, it's best
to compare results on the same hardware. The absolute value isn't as
meaningful. Here's a rough sketch of one approach.

- Configure BIOS and OS to hold CPU frequency constant:
   - ACPI C-states off
   - Turbo mode off
   - Power management off (OS needs this too)
   - Anything else relevant to clock variation
- Hyperthreading off
   - (hyperthreads don't add work linearly)
- Calculate core count X clock frequency
   - (e.g. 8 X 3GHz = 24G cycles/sec)

Now, use a benchmark which runs the desired workload and reports %CPU.
For a given interval, record the total bytes transferred, time spent,
and CPU load. (e.g. 100GB, 100 sec, 20%).

Finally, compute CpB (the 1/sec terms cancel out):
  20% x 24Gcps = 4.8G cps
  100GB / 100s = 1G bps
  4.8Gcps / 1 GBps = 4.8cpb

Like I said, it's rough, but surprisingly telling. A similar metric
is cycles per IOP, and since you're focusing on small i/o with this
change, it might also be an interesting calculation. Simply replace
total bytes/sec with IOPS.

Tom.


>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>   net/sunrpc/xprtrdma/backchannel.c |    2 -
>>>   net/sunrpc/xprtrdma/rpc_rdma.c    |   82 +++++++++++++++++++++++++++++++++++--
>>>   net/sunrpc/xprtrdma/verbs.c       |    2 -
>>>   net/sunrpc/xprtrdma/xprt_rdma.h   |    2 +
>>>   4 files changed, 81 insertions(+), 7 deletions(-)
>>> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
>>> index 16572ae7..336a65d 100644
>>> --- a/include/trace/events/rpcrdma.h
>>> +++ b/include/trace/events/rpcrdma.h
>>> @@ -532,6 +532,8 @@
>>>   DEFINE_WRCH_EVENT(reply);
>>>     TRACE_DEFINE_ENUM(rpcrdma_noch);
>>> +TRACE_DEFINE_ENUM(rpcrdma_noch_pullup);
>>> +TRACE_DEFINE_ENUM(rpcrdma_noch_mapped);
>>>   TRACE_DEFINE_ENUM(rpcrdma_readch);
>>>   TRACE_DEFINE_ENUM(rpcrdma_areadch);
>>>   TRACE_DEFINE_ENUM(rpcrdma_writech);
>>> @@ -540,6 +542,8 @@
>>>   #define xprtrdma_show_chunktype(x)					\
>>>   		__print_symbolic(x,					\
>>>   				{ rpcrdma_noch, "inline" },		\
>>> +				{ rpcrdma_noch_pullup, "pullup" },	\
>>> +				{ rpcrdma_noch_mapped, "mapped" },	\
>>>   				{ rpcrdma_readch, "read list" },	\
>>>   				{ rpcrdma_areadch, "*read list" },	\
>>>   				{ rpcrdma_writech, "write list" },	\
>>> diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
>>> index 50e075f..1168524 100644
>>> --- a/net/sunrpc/xprtrdma/backchannel.c
>>> +++ b/net/sunrpc/xprtrdma/backchannel.c
>>> @@ -79,7 +79,7 @@ static int rpcrdma_bc_marshal_reply(struct rpc_rqst *rqst)
>>>   	*p = xdr_zero;
>>>     	if (rpcrdma_prepare_send_sges(r_xprt, req, RPCRDMA_HDRLEN_MIN,
>>> -				      &rqst->rq_snd_buf, rpcrdma_noch))
>>> +				      &rqst->rq_snd_buf, rpcrdma_noch_pullup))
>>>   		return -EIO;
>>>     	trace_xprtrdma_cb_reply(rqst);
>>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
>>> index a441dbf..4ad8889 100644
>>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>>> @@ -392,7 +392,7 @@ static int rpcrdma_encode_read_list(struct rpcrdma_xprt *r_xprt,
>>>   	unsigned int pos;
>>>   	int nsegs;
>>>   -	if (rtype == rpcrdma_noch)
>>> +	if (rtype == rpcrdma_noch_pullup || rtype == rpcrdma_noch_mapped)
>>>   		goto done;
>>>     	pos = rqst->rq_snd_buf.head[0].iov_len;
>>> @@ -691,6 +691,72 @@ static bool rpcrdma_prepare_tail_iov(struct rpcrdma_req *req,
>>>   	return false;
>>>   }
>>>   +/* Copy the tail to the end of the head buffer.
>>> + */
>>> +static void rpcrdma_pullup_tail_iov(struct rpcrdma_xprt *r_xprt,
>>> +				    struct rpcrdma_req *req,
>>> +				    struct xdr_buf *xdr)
>>> +{
>>> +	unsigned char *dst;
>>> +
>>> +	dst = (unsigned char *)xdr->head[0].iov_base;
>>> +	dst += xdr->head[0].iov_len + xdr->page_len;
>>> +	memmove(dst, xdr->tail[0].iov_base, xdr->tail[0].iov_len);
>>> +	r_xprt->rx_stats.pullup_copy_count += xdr->tail[0].iov_len;
>>> +}
>>> +
>>> +/* Copy pagelist content into the head buffer.
>>> + */
>>> +static void rpcrdma_pullup_pagelist(struct rpcrdma_xprt *r_xprt,
>>> +				    struct rpcrdma_req *req,
>>> +				    struct xdr_buf *xdr)
>>> +{
>>> +	unsigned int len, page_base, remaining;
>>> +	struct page **ppages;
>>> +	unsigned char *src, *dst;
>>> +
>>> +	dst = (unsigned char *)xdr->head[0].iov_base;
>>> +	dst += xdr->head[0].iov_len;
>>> +	ppages = xdr->pages + (xdr->page_base >> PAGE_SHIFT);
>>> +	page_base = offset_in_page(xdr->page_base);
>>> +	remaining = xdr->page_len;
>>> +	while (remaining) {
>>> +		src = page_address(*ppages);
>>> +		src += page_base;
>>> +		len = min_t(unsigned int, PAGE_SIZE - page_base, remaining);
>>> +		memcpy(dst, src, len);
>>> +		r_xprt->rx_stats.pullup_copy_count += len;
>>> +
>>> +		ppages++;
>>> +		dst += len;
>>> +		remaining -= len;
>>> +		page_base = 0;
>>> +	}
>>> +}
>>> +
>>> +/* Copy the contents of @xdr into @rl_sendbuf and DMA sync it.
>>> + * When the head, pagelist, and tail are small, a pull-up copy
>>> + * is considerably less costly than DMA mapping the components
>>> + * of @xdr.
>>> + *
>>> + * Assumptions:
>>> + *  - the caller has already verified that the total length
>>> + *    of the RPC Call body will fit into @rl_sendbuf.
>>> + */
>>> +static bool rpcrdma_prepare_noch_pullup(struct rpcrdma_xprt *r_xprt,
>>> +					struct rpcrdma_req *req,
>>> +					struct xdr_buf *xdr)
>>> +{
>>> +	if (unlikely(xdr->tail[0].iov_len))
>>> +		rpcrdma_pullup_tail_iov(r_xprt, req, xdr);
>>> +
>>> +	if (unlikely(xdr->page_len))
>>> +		rpcrdma_pullup_pagelist(r_xprt, req, xdr);
>>> +
>>> +	/* The whole RPC message resides in the head iovec now */
>>> +	return rpcrdma_prepare_head_iov(r_xprt, req, xdr->len);
>>> +}
>>> +
>>>   static bool rpcrdma_prepare_noch_mapped(struct rpcrdma_xprt *r_xprt,
>>>   					struct rpcrdma_req *req,
>>>   					struct xdr_buf *xdr)
>>> @@ -779,7 +845,11 @@ inline int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
>>>   		goto out_unmap;
>>>     	switch (rtype) {
>>> -	case rpcrdma_noch:
>>> +	case rpcrdma_noch_pullup:
>>> +		if (!rpcrdma_prepare_noch_pullup(r_xprt, req, xdr))
>>> +			goto out_unmap;
>>> +		break;
>>> +	case rpcrdma_noch_mapped:
>>>   		if (!rpcrdma_prepare_noch_mapped(r_xprt, req, xdr))
>>>   			goto out_unmap;
>>>   		break;
>>> @@ -827,6 +897,7 @@ inline int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
>>>   	struct rpcrdma_req *req = rpcr_to_rdmar(rqst);
>>>   	struct xdr_stream *xdr = &req->rl_stream;
>>>   	enum rpcrdma_chunktype rtype, wtype;
>>> +	struct xdr_buf *buf = &rqst->rq_snd_buf;
>>>   	bool ddp_allowed;
>>>   	__be32 *p;
>>>   	int ret;
>>> @@ -884,8 +955,9 @@ inline int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
>>>   	 */
>>>   	if (rpcrdma_args_inline(r_xprt, rqst)) {
>>>   		*p++ = rdma_msg;
>>> -		rtype = rpcrdma_noch;
>>> -	} else if (ddp_allowed && rqst->rq_snd_buf.flags & XDRBUF_WRITE) {
>>> +		rtype = buf->len < rdmab_length(req->rl_sendbuf) ?
>>> +			rpcrdma_noch_pullup : rpcrdma_noch_mapped;
>>> +	} else if (ddp_allowed && buf->flags & XDRBUF_WRITE) {
>>>   		*p++ = rdma_msg;
>>>   		rtype = rpcrdma_readch;
>>>   	} else {
>>> @@ -927,7 +999,7 @@ inline int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
>>>   		goto out_err;
>>>     	ret = rpcrdma_prepare_send_sges(r_xprt, req, req->rl_hdrbuf.len,
>>> -					&rqst->rq_snd_buf, rtype);
>>> +					buf, rtype);
>>>   	if (ret)
>>>   		goto out_err;
>>>   diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
>>> index 2f46582..a514e2c 100644
>>> --- a/net/sunrpc/xprtrdma/verbs.c
>>> +++ b/net/sunrpc/xprtrdma/verbs.c
>>> @@ -1165,7 +1165,7 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
>>>   	for (i = 0; i < buf->rb_max_requests; i++) {
>>>   		struct rpcrdma_req *req;
>>>   -		req = rpcrdma_req_create(r_xprt, RPCRDMA_V1_DEF_INLINE_SIZE,
>>> +		req = rpcrdma_req_create(r_xprt, RPCRDMA_V1_DEF_INLINE_SIZE * 2,
>>>   					 GFP_KERNEL);
>>>   		if (!req)
>>>   			goto out;
>>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
>>> index cdd6a3d..5d15140 100644
>>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>>> @@ -554,6 +554,8 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
>>>     enum rpcrdma_chunktype {
>>>   	rpcrdma_noch = 0,
>>> +	rpcrdma_noch_pullup,
>>> +	rpcrdma_noch_mapped,
>>>   	rpcrdma_readch,
>>>   	rpcrdma_areadch,
>>>   	rpcrdma_writech,
> 
> --
> Chuck Lever
> 
> 
> 
> 
> 
