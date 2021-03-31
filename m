Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08F13507C5
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 22:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhCaUGA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 16:06:00 -0400
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:38700
        "EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236273AbhCaUFj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 16:05:39 -0400
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id Rh5tlUAzVEYmdRh5ulMGRV; Wed, 31 Mar 2021 13:05:39 -0700
X-CMAE-Analysis: v=2.4 cv=adukITkt c=1 sm=1 tr=0 ts=6064d613
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=SEc3moZ4AAAA:8 a=98w_-zo1gpfBxod-KXEA:9
 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1 1/8] xprtrdma: Avoid Receive Queue wrapping
To:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
 <161721936504.515226.14877637433211331378.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <818b4215-d16a-532f-88cf-b65763f50341@talpey.com>
Date:   Wed, 31 Mar 2021 16:05:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <161721936504.515226.14877637433211331378.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDYb9MrwNIASWI1UMiFVC+/YlTvyvRKKOOkEcuQAFCicEuE72i+R4Wh0tSpLcmQ6xQhAZejfbyY7RdFewZ6gYO2egICzRf+T68GMm7ecPM/Blap6caJv
 q3LlftlpYK1jIWttAHEK3uprXk7h62XgAcfRZXFLhUyhAeHACEJOSqZHMRx1iWXhTPBV42mo9pOI543IMl45XEIUqtuy+8ygsYi/DIbg3ZFzJgQmNwOhnS5P
 3fgJUw00QRYC3bLc9YLp2lkDDLSeS3ublflYMNwbXXA=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/31/2021 3:36 PM, Chuck Lever wrote:
> Commit e340c2d6ef2a ("xprtrdma: Reduce the doorbell rate (Receive)")
> increased the number of Receive WRs that are posted by the client,
> but did not increase the size of the Receive Queue allocated during
> transport set-up.
> 
> This is usually not an issue because RPCRDMA_BACKWARD_WRS is defined
> as (32) when SUNRPC_BACKCHANNEL is defined. In cases where it isn't,
> there is a real risk of Receive Queue wrapping.
> 
> Fixes: e340c2d6ef2a ("xprtrdma: Reduce the doorbell rate (Receive)")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/frwr_ops.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
> index 766a1048a48a..132df9b59ab4 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -257,6 +257,7 @@ int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
>   	ep->re_attr.cap.max_send_wr += 1; /* for ib_drain_sq */
>   	ep->re_attr.cap.max_recv_wr = ep->re_max_requests;
>   	ep->re_attr.cap.max_recv_wr += RPCRDMA_BACKWARD_WRS;
> +	ep->re_attr.cap.max_recv_wr += RPCRDMA_MAX_RECV_BATCH;

Naively, it seems to me this should be max(BACKWARD, BATCH).
But, extra WR slots are cheap and safe.

Reviewed-By: Tom Talpey <tom@talpey.com>

>   	ep->re_attr.cap.max_recv_wr += 1; /* for ib_drain_rq */
>   
>   	ep->re_max_rdma_segs =
> 
> 
> 
