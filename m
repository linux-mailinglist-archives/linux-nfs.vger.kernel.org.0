Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F03507BE
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 22:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhCaUDR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 16:03:17 -0400
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:46474
        "EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235933AbhCaUCo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 16:02:44 -0400
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id Rh34lkiXze8QFRh35lc49Y; Wed, 31 Mar 2021 13:02:44 -0700
X-CMAE-Analysis: v=2.4 cv=JLz+D+Gb c=1 sm=1 tr=0 ts=6064d564
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=yPCof4ZbAAAA:8 a=C6VLetKAY4Zs1ByzVGIA:9
 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1 3/8] xprtrdma: Put flushed Receives on free list
 instead of destroying them
To:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
 <161721937732.515226.2170674299158077377.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <8dc8bdd3-b006-46ed-cc9f-75fae4df3f40@talpey.com>
Date:   Wed, 31 Mar 2021 16:02:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <161721937732.515226.2170674299158077377.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJqm9Y4eYNXtpnh8IVA/QKf/SzRmy01lPLthQ2OhqIKgJDLTTdEpMy4ypk0ZcNjC++7mAs2ym3At+DfmkbHDphmhwDSCCyANiPiivUdpIWEg0Kl6qMoT
 NOXXlVM+Q6k3AQrv0r/nB4a2+KfTIGPhs9Pq2DF/1Eee0h0n8L2yHKmKH5z/waYoXxpe1DMFVwe32d3HYGb/8Mksx8ifnlMdf92Ez9GXFTaFLTLKs3AIDWB4
 GFR4zJ5yF0Ii8K7vFgOvkghDy6ZN7N7Ln3q9/UEdVaM=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/31/2021 3:36 PM, Chuck Lever wrote:
> Defer destruction of an rpcrdma_rep until transport tear-down to
> avoid races between Receive completion and rpcrdma_reps_unmap().

This seems sketchy, but it's a good approach to destroy in one
place, and off the hot path. You might restate the description
in a positive way, not strictly to avoid a race.

Reviewed-By: Tom Talpey <tom@talpey.com>

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/verbs.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 1d88685badbe..92af272f9cc9 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -80,6 +80,8 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
>   				       struct rpcrdma_sendctx *sc);
>   static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt);
>   static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt);
> +static void rpcrdma_rep_put(struct rpcrdma_buffer *buf,
> +			    struct rpcrdma_rep *rep);
>   static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep);
>   static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
>   static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
> @@ -205,7 +207,7 @@ static void rpcrdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
>   
>   out_flushed:
>   	rpcrdma_flush_disconnect(r_xprt, wc);
> -	rpcrdma_rep_destroy(rep);
> +	rpcrdma_rep_put(&r_xprt->rx_buf, rep);
>   }
>   
>   static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,
> 
> 
> 
