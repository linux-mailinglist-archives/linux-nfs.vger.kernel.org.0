Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B14430E254
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 19:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhBCSRx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 13:17:53 -0500
Received: from p3plsmtpa11-08.prod.phx3.secureserver.net ([68.178.252.109]:56269
        "EHLO p3plsmtpa11-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231591AbhBCSOs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 13:14:48 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id 7Mf9l2VeRK9xx7Mf9l6ahy; Wed, 03 Feb 2021 11:13:59 -0700
X-CMAE-Analysis: v=2.4 cv=K9/nowaI c=1 sm=1 tr=0 ts=601ae7e7
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=JDjsHSkAAAAA:8 a=yPCof4ZbAAAA:8
 a=O4n9R6YOxJqAsZlgij0A:9 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22
 a=dseMxAR1CDlncBZeV_se:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v2 5/6] xprtrdma: Pad optimization, revisited
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
 <161236945965.1030487.13894327853038566730.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <f2aad824-4449-be60-a39f-bb317764b090@talpey.com>
Date:   Wed, 3 Feb 2021 13:13:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <161236945965.1030487.13894327853038566730.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLjTiY8FLn2E+ubZUE3/OAQbH7UoR55Hy9rcXEErYfHtTYtSUncCP83keR+3oCzoZCAnQKf1SIgdHEktOigCQVRtK+ArIQ7gw3WaYLVPm3MwoPUyOYGP
 YCWSuDIoZEoWIt3Dd9er/Vc7msFC31ZucyWsxOSm+N1b9Q4d1/vJUqs3JFrB2jmKBDW7csDotrSMVM1J7nunzQOsw1yigjX49lRcZv6jCtxLFZdL2ofU1H6L
 ZK6rWyJh5+fDE604RHwZNCGAuUr9SEXO3LcGixd8TyA=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a safe and obviously warranted processing revision.

The changelog is quite an eyeful for a one-liner, and maybe only
makes sense to the truly dedicated reader. But...

Reviewed-By: Tom Talpey <tom@talpey.com>

On 2/3/2021 11:24 AM, Chuck Lever wrote:
> The NetApp Linux team discovered that with NFS/RDMA servers that do
> not support RFC 8797, the Linux client is forming NFSv4.x WRITE
> requests incorrectly.
> 
> In this case, the Linux NFS client disables implicit chunk round-up
> for odd-length Read and Write chunks. The goal was to support old
> servers that needed that padding to be sent explicitly by clients.
> 
> In that case the Linux NFS included the tail kvec in the Read chunk,
> since the tail contains any needed padding. That meant a separate
> memory registration is needed for the tail kvec, adding to the cost
> of forming such requests. To avoid that cost for a mere 3 bytes of
> zeroes that are always ignored by receivers, we try to use implicit
> roundup when possible.
> 
> For NFSv4.x, the tail kvec also sometimes contains a trailing
> GETATTR operation. The Linux NFS clients is unintentionally
> including that GETATTR operation in the Read chunk as well as
> inline. Fortunately, servers ignore this craziness and go about
> their normal business.
> 
> The fix is simply to /never/ include the tail kvec when forming a
> data payload Read chunk.
> 
> Note that since commit 9ed5af268e88 ("SUNRPC: Clean up the handling
> of page padding in rpc_prepare_reply_pages()") the NFS client passes
> payload data to the transport with the padding in xdr->pages instead
> of in the send buffer's tail kvec. So now the Linux NFS client
> appends XDR padding to all odd-sized Read chunks. This shouldn't be
> a problem because:
> 
>   - RFC 8166-compliant servers are supposed to work with or without
>     that XDR padding in Read chunks.
> 
>   - Since the padding is now in the same memory region as the data
>     payload, a separate memory registration is not needed. In
>     addition, the link layer extends data in RDMA Read responses to
>     4-byte boundaries anyway. Thus there is now no savings when the
>     padding is not included.
> 
> Because older kernels include the payload's XDR padding in the
> tail kvec, a fix there will be more complicated. Thus backporting
> this patch is not recommended.
> 
> Reported by: Olga Kornievskaia <Olga.Kornievskaia@netapp.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/rpc_rdma.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> index f0af89a43efd..f1b52f9ab242 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -257,10 +257,7 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
>   		page_base = 0;
>   	}
>   
> -	/* When encoding a Read chunk, the tail iovec contains an
> -	 * XDR pad and may be omitted.
> -	 */
> -	if (type == rpcrdma_readch && r_xprt->rx_ep->re_implicit_roundup)
> +	if (type == rpcrdma_readch)
>   		goto out;
>   
>   	/* When encoding a Write chunk, some servers need to see an
> 
> 
> 
