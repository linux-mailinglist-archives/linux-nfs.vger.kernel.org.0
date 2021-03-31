Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2483507B5
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 22:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhCaT77 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:59:59 -0400
Received: from p3plsmtpa06-05.prod.phx3.secureserver.net ([173.201.192.106]:56637
        "EHLO p3plsmtpa06-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235928AbhCaT7g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 15:59:36 -0400
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id Rh03lkYVn3MqERh03lWTBA; Wed, 31 Mar 2021 12:59:36 -0700
X-CMAE-Analysis: v=2.4 cv=Ztool/3G c=1 sm=1 tr=0 ts=6064d4a8
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=-yyDqTV712QqOYf6p0kA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1 2/8] xprtrdma: Do not post Receives after disconnect
To:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
 <161721937122.515226.14731175629421422152.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <4004f56f-3603-f56c-aea9-651230b3181e@talpey.com>
Date:   Wed, 31 Mar 2021 15:59:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <161721937122.515226.14731175629421422152.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHL4QpGp8w02/M/TI+jzRUynLsI47otmVQAFtqp87BK+CacGBmd9OajTNo90p6cZLh/QbA1DGuYmngU0S/m4h2hl5yBB08qb4+kJHNeU5JdWRed6STrT
 ZxNafpbaGmfRyaZ2r8Sa8QLL4lksXNVQYIoLMioNIVmSyqyssP2p/ZZNNE6gXaDrYVT6CUTMpD3L3DAK9JDF3mgbFm3PXKQebt5mbXcMhL54p1f4xuFbomuA
 14WuRFBCDoLCqyXznCDfqkxT7EHnxH90SehJKYMvloo=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/31/2021 3:36 PM, Chuck Lever wrote:
> Currently the Receive completion handler refreshes the Receive Queue
> whenever a successful Receive completion occurs.
> 
> On disconnect, xprtrdma drains the Receive Queue. The first few
> Receive completions after a disconnect are typically successful,
> until the first flushed Receive.
> 
> This means the Receive completion handler continues to post more
> Receive WRs after the drain sentinel has been posted. The late-
> posted Receives flush after the drain sentinel has completed,
> leading to a crash later in rpcrdma_xprt_disconnect().
> 
> To prevent this crash, xprtrdma has to ensure that the Receive
> handler stops posting Receives before ib_drain_rq() posts its
> drain sentinel.
> 
> This patch is probably not sufficient to fully close that window,

"Probably" is not a word I'd like to use in a stable:cc...

> but does significantly reduce the opportunity for a crash to
> occur without incurring undue performance overhead.
> 
> Cc: stable@vger.kernel.org # v5.7
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/verbs.c |    7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index ec912cf9c618..1d88685badbe 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -1371,8 +1371,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
>   {
>   	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
>   	struct rpcrdma_ep *ep = r_xprt->rx_ep;
> +	struct ib_qp_init_attr init_attr;
>   	struct ib_recv_wr *wr, *bad_wr;
>   	struct rpcrdma_rep *rep;
> +	struct ib_qp_attr attr;
>   	int needed, count, rc;
>   
>   	rc = 0;
> @@ -1385,6 +1387,11 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
>   	if (!temp)
>   		needed += RPCRDMA_MAX_RECV_BATCH;
>   
> +	if (ib_query_qp(ep->re_id->qp, &attr, IB_QP_STATE, &init_attr))
> +		goto out;

This call isn't completely cheap.

> +	if (attr.qp_state == IB_QPS_ERR)
> +		goto out;

But the QP is free to disconnect or go to error right now. This approach
just reduces the timing hole. Is it not possible to mark the WRs as
being part of a batch, and allowing them to flush? You could borrow a
bit in the completion cookie, and check it when the CQE pops out. Maybe.

> +
>   	/* fast path: all needed reps can be found on the free list */
>   	wr = NULL;
>   	while (needed) {
> 
> 
> 
