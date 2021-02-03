Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE46030E24C
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 19:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhBCSQm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 13:16:42 -0500
Received: from p3plsmtpa11-05.prod.phx3.secureserver.net ([68.178.252.106]:52006
        "EHLO p3plsmtpa11-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231492AbhBCSPj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 13:15:39 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id 7Mfulo3x4Czab7Mfulx6GX; Wed, 03 Feb 2021 11:14:47 -0700
X-CMAE-Analysis: v=2.4 cv=T8xJ89GQ c=1 sm=1 tr=0 ts=601ae817
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=yPCof4ZbAAAA:8 a=HJdh2ZyBudsEIxQGtc4A:9
 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v2 6/6] rpcrdma: Capture bytes received in Receive
 completion tracepoints
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
 <161236946591.1030487.17569515553232560373.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <6c125f8d-11ef-db24-aa18-26a165c5413a@talpey.com>
Date:   Wed, 3 Feb 2021 13:14:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <161236946591.1030487.17569515553232560373.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGeoJUnkXZBV8JsYlFlwv9in+JoTOrDmP1+eQuE6qKuZvs/RV/tzhZzWkr7MWOcXzVSjx5ZZk/7EFIajCj9BsDMq0gieJ64An8emkWLifGRFUeV0S7M/
 Bgp9ZoGgmf6qjcVkpGgYGwqFDpJeWifWv0Hk6hfjwuhp4VM7pz1ckolUkb2QJtqE77+OaLc8eZ0S9ciSNIhW+T8RUJU3bOT0DzsFbhZ1N32PmfbFJ4qcmnCB
 5reMpKJs3wzjmcry6+H+9zLLEq768ag2pkcY0lMs+HU=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Acked-By: Tom Talpey <tom@talpey.com>

On 2/3/2021 11:24 AM, Chuck Lever wrote:
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   include/trace/events/rpcrdma.h |   50 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
> index 76e85e16854b..c838e7ac1c2d 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -60,6 +60,51 @@ DECLARE_EVENT_CLASS(rpcrdma_completion_class,
>   				),					\
>   				TP_ARGS(wc, cid))
>   
> +DECLARE_EVENT_CLASS(rpcrdma_receive_completion_class,
> +	TP_PROTO(
> +		const struct ib_wc *wc,
> +		const struct rpc_rdma_cid *cid
> +	),
> +
> +	TP_ARGS(wc, cid),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, cq_id)
> +		__field(int, completion_id)
> +		__field(u32, received)
> +		__field(unsigned long, status)
> +		__field(unsigned int, vendor_err)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cq_id = cid->ci_queue_id;
> +		__entry->completion_id = cid->ci_completion_id;
> +		__entry->status = wc->status;
> +		if (wc->status) {
> +			__entry->received = 0;
> +			__entry->vendor_err = wc->vendor_err;
> +		} else {
> +			__entry->received = wc->byte_len;
> +			__entry->vendor_err = 0;
> +		}
> +	),
> +
> +	TP_printk("cq.id=%u cid=%d status=%s (%lu/0x%x) received=%u",
> +		__entry->cq_id, __entry->completion_id,
> +		rdma_show_wc_status(__entry->status),
> +		__entry->status, __entry->vendor_err,
> +		__entry->received
> +	)
> +);
> +
> +#define DEFINE_RECEIVE_COMPLETION_EVENT(name)				\
> +		DEFINE_EVENT(rpcrdma_receive_completion_class, name,	\
> +				TP_PROTO(				\
> +					const struct ib_wc *wc,		\
> +					const struct rpc_rdma_cid *cid	\
> +				),					\
> +				TP_ARGS(wc, cid))
> +
>   DECLARE_EVENT_CLASS(xprtrdma_reply_class,
>   	TP_PROTO(
>   		const struct rpcrdma_rep *rep
> @@ -838,7 +883,8 @@ TRACE_EVENT(xprtrdma_post_linv_err,
>    ** Completion events
>    **/
>   
> -DEFINE_COMPLETION_EVENT(xprtrdma_wc_receive);
> +DEFINE_RECEIVE_COMPLETION_EVENT(xprtrdma_wc_receive);
> +
>   DEFINE_COMPLETION_EVENT(xprtrdma_wc_send);
>   DEFINE_COMPLETION_EVENT(xprtrdma_wc_fastreg);
>   DEFINE_COMPLETION_EVENT(xprtrdma_wc_li);
> @@ -1790,7 +1836,7 @@ TRACE_EVENT(svcrdma_post_recv,
>   	)
>   );
>   
> -DEFINE_COMPLETION_EVENT(svcrdma_wc_receive);
> +DEFINE_RECEIVE_COMPLETION_EVENT(svcrdma_wc_receive);
>   
>   TRACE_EVENT(svcrdma_rq_post_err,
>   	TP_PROTO(
> 
> 
> 
