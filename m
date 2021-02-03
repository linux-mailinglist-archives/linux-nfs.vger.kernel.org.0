Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5F830E21C
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 19:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhBCSLn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 13:11:43 -0500
Received: from p3plsmtpa11-07.prod.phx3.secureserver.net ([68.178.252.108]:34989
        "EHLO p3plsmtpa11-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231890AbhBCSLh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 13:11:37 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id 7Mc6lv5i4m2QC7Mc6lbSA9; Wed, 03 Feb 2021 11:10:51 -0700
X-CMAE-Analysis: v=2.4 cv=YvnK+6UX c=1 sm=1 tr=0 ts=601ae72b
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=yPCof4ZbAAAA:8 a=xrybRMrWMomBRleDf54A:9
 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v2 4/6] rpcrdma: Fix comments about reverse-direction
 operation
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
 <161236945329.1030487.13444441650618425746.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <e7d683bd-9a2d-766f-a714-e7cec12612c5@talpey.com>
Date:   Wed, 3 Feb 2021 13:10:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <161236945329.1030487.13444441650618425746.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfI3k9yr/M84aEDxPrJ6RSRqcke9EA95OYDMC94LRfD9j1Ci6oYIH3H9UYPgfbmkhtqt/ogPptsH6IObMBxDVemCYlACBD6hUurvH8qcrLkmWjd1ty6YU
 1Ibz1ameThHAST+jrHclcEjMBTzw2rmO7OW0tZS1h2Rs31vDAUyiUNwJzhKm3EsstOlAHdmfAIJ335fzCQJBmaV0l3ftnyr++Cf36wqdKCpA87X+HpJYtoR7
 0KRa30B2iipWx6GVaDKBJY6fIZ7C1D9vozMjukVUI3I=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Reviewed-By: Tom Talpey <tom@talpey.com>

On 2/3/2021 11:24 AM, Chuck Lever wrote:
> During the final stages of publication of RFC 8167, reviewers
> requested that we use the term "reverse direction" rather than
> "backwards direction". Update comments to reflect this preference.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/backchannel.c          |    4 ++--
>   net/sunrpc/xprtrdma/rpc_rdma.c             |    6 +-----
>   net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    4 ++--
>   net/sunrpc/xprtrdma/xprt_rdma.h            |    6 +++---
>   4 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
> index 946edf2db646..a249837d6a55 100644
> --- a/net/sunrpc/xprtrdma/backchannel.c
> +++ b/net/sunrpc/xprtrdma/backchannel.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright (c) 2015-2020, Oracle and/or its affiliates.
>    *
> - * Support for backward direction RPCs on RPC/RDMA.
> + * Support for reverse-direction RPCs on RPC/RDMA.
>    */
>   
>   #include <linux/sunrpc/xprt.h>
> @@ -208,7 +208,7 @@ static struct rpc_rqst *rpcrdma_bc_rqst_get(struct rpcrdma_xprt *r_xprt)
>   }
>   
>   /**
> - * rpcrdma_bc_receive_call - Handle a backward direction call
> + * rpcrdma_bc_receive_call - Handle a reverse-direction Call
>    * @r_xprt: transport receiving the call
>    * @rep: receive buffer containing the call
>    *
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> index b3e66b8f65ab..f0af89a43efd 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -1153,14 +1153,10 @@ rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
>   	 */
>   	p = xdr_inline_decode(xdr, 3 * sizeof(*p));
>   	if (unlikely(!p))
> -		goto out_short;
> +		return true;
>   
>   	rpcrdma_bc_receive_call(r_xprt, rep);
>   	return true;
> -
> -out_short:
> -	pr_warn("RPC/RDMA short backward direction call\n");
> -	return true;
>   }
>   #else	/* CONFIG_SUNRPC_BACKCHANNEL */
>   {
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> index 63f8be974df2..4a1edbb4028e 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright (c) 2015-2018 Oracle.  All rights reserved.
>    *
> - * Support for backward direction RPCs on RPC/RDMA (server-side).
> + * Support for reverse-direction RPCs on RPC/RDMA (server-side).
>    */
>   
>   #include <linux/sunrpc/svc_rdma.h>
> @@ -59,7 +59,7 @@ void svc_rdma_handle_bc_reply(struct svc_rqst *rqstp,
>   	spin_unlock(&xprt->queue_lock);
>   }
>   
> -/* Send a backwards direction RPC call.
> +/* Send a reverse-direction RPC Call.
>    *
>    * Caller holds the connection's mutex and has already marshaled
>    * the RPC/RDMA request.
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> index ed1c5444fb9d..fe3be985e239 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -98,9 +98,9 @@ struct rpcrdma_ep {
>   	atomic_t		re_completion_ids;
>   };
>   
> -/* Pre-allocate extra Work Requests for handling backward receives
> - * and sends. This is a fixed value because the Work Queues are
> - * allocated when the forward channel is set up, long before the
> +/* Pre-allocate extra Work Requests for handling reverse-direction
> + * Receives and Sends. This is a fixed value because the Work Queues
> + * are allocated when the forward channel is set up, long before the
>    * backchannel is provisioned. This value is two times
>    * NFS4_DEF_CB_SLOT_TABLE_SIZE.
>    */
> 
> 
> 
