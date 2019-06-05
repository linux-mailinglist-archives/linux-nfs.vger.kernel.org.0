Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA4361A4
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2019 18:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfFEQvK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 5 Jun 2019 12:51:10 -0400
Received: from p3plsmtpa09-07.prod.phx3.secureserver.net ([173.201.193.236]:60648
        "EHLO p3plsmtpa09-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728263AbfFEQvK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jun 2019 12:51:10 -0400
Received: from [10.1.242.150] ([166.172.59.195])
        by :SMTPAUTH: with ESMTPSA
        id YZ0vh8nQQ6wnfYZ0xhwcdr; Wed, 05 Jun 2019 09:43:52 -0700
Date:   Wed, 05 Jun 2019 16:43:48 +0000
In-Reply-To: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
References: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH RFC] svcrdma: Ignore source port when computing DRC hash
To:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org
From:   Tom Talpey <tom@talpey.com>
Message-ID: <9E0019E1-1C1B-465C-B2BF-76372029ABD8@talpey.com>
X-CMAE-Envelope: MS4wfArYkHDChxDhPwzjABZh7zTBpvvnY0ytWMLTdSVFLqOHVWOmJTThPU8yOKy2hmiKG/d7ZsfHv8Yyb2aNv3ba1Eva3K4E7n/yOXrQIsUurZKjeITLNtlH
 Xdm+zlYdUqLLHHIqF1zSJin+PyKmUOeonO4uawpxOGvF3pTTl1cwiDFBVl/jiGK5ECChswub+zgjIwns4z3fSU0I/BYCjUmcVvkJ9t4MYWTn9CJQA3GaHKaD
 gLfVZUPnt6c5oou5EYiTQQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/5/2019 8:15 AM, Chuck Lever wrote:
> The DRC is not working at all after an RPC/RDMA transport reconnect.
> The problem is that the new connection uses a different source port,
> which defeats DRC hash.
> 
> An NFS/RDMA client's source port is meaningless for RDMA transports.
> The transport layer typically sets the source port value on the
> connection to a random ephemeral port. The server already ignores it
> for the "secure port" check. See commit 16e4d93f6de7 ("NFSD: Ignore
> client's source port on RDMA transports").

Where does the entropy come from, then, for the server to not
match other requests from other mount points on this same client?
Any time an XID happens to match on a second mount, it will trigger
incorrect server processing, won't it? And since RDMA is capable of
such high IOPS, the likelihood seems rather high. Missing the cache
might actually be safer than hitting, in this case.

Tom.

> I'm not sure why I never noticed this before.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: stable@vger.kernel.org
> ---
>   net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 027a3b0..1b3700b 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
>   	/* Save client advertised inbound read limit for use later in accept. */
>   	newxprt->sc_ord = param->initiator_depth;
>   
> -	/* Set the local and remote addresses in the transport */
>   	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
>   	svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
> +	/* The remote port is arbitrary and not under the control of the
> +	 * ULP. Set it to a fixed value so that the DRC continues to work
> +	 * after a reconnect.
> +	 */
> +	rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
> +
>   	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
>   	svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
>   
> 
> 
> 
