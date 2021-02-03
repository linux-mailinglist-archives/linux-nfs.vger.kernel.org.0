Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F9E30E207
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 19:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhBCSIp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 13:08:45 -0500
Received: from p3plsmtpa11-03.prod.phx3.secureserver.net ([68.178.252.104]:37623
        "EHLO p3plsmtpa11-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232929AbhBCSIm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 13:08:42 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id 7MZGlecM0ENw87MZGlXm7y; Wed, 03 Feb 2021 11:07:54 -0700
X-CMAE-Analysis: v=2.4 cv=H/Mef8Ui c=1 sm=1 tr=0 ts=601ae67a
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=yPCof4ZbAAAA:8 a=iVpnDK8QsyUIs4uriyEA:9
 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v2 2/6] xprtrdma: Simplify rpcrdma_convert_kvec() and
 frwr_map()
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
 <161236944071.1030487.460353530274045763.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <a26eed70-3f0f-907e-3c88-1b5f949c950c@talpey.com>
Date:   Wed, 3 Feb 2021 13:07:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <161236944071.1030487.460353530274045763.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfG7G3K6FIIpmgUll1eqp3gZanbyHICOUb8ol2zQvOkSNe4/FT/4C7aI5kMveeUg38vF3cNgB+Mgg+v/yidhMrkkGIyh6FVuOMQAJrFaBgXosVbhzrCZN
 CqljGiaJXcb9muu5W2naZH819KLbBPRmbun7KVzUbNEIaBRRXnr4r8dXS3qcFd8r/ToW6ZFjTA3Y5yVSH3InkX2TJBrGNN5KyQb7Bt9LyL2YbQFUNmKy3c55
 LPl0zfLueYNYzSXxO9YfVT36LCeeUMn/D6fpXiMcfKE=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Reviewed-By: Tom Talpey <tom@talpey.com>

On 2/3/2021 11:24 AM, Chuck Lever wrote:
> Clean up.
> 
> Remove a conditional branch from the SGL set-up loop in frwr_map():
> Instead of using either sg_set_page() or sg_set_buf(), initialize
> the mr_page field properly when rpcrdma_convert_kvec() converts the
> kvec to an SGL entry. frwr_map() can then invoke sg_set_page()
> unconditionally.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/frwr_ops.c  |   12 ++++--------
>   net/sunrpc/xprtrdma/rpc_rdma.c  |    2 +-
>   net/sunrpc/xprtrdma/xprt_rdma.h |    9 +++++----
>   3 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
> index baca49fe83af..13a50f77dddb 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -306,14 +306,10 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
>   	if (nsegs > ep->re_max_fr_depth)
>   		nsegs = ep->re_max_fr_depth;
>   	for (i = 0; i < nsegs;) {
> -		if (seg->mr_page)
> -			sg_set_page(&mr->mr_sg[i],
> -				    seg->mr_page,
> -				    seg->mr_len,
> -				    offset_in_page(seg->mr_offset));
> -		else
> -			sg_set_buf(&mr->mr_sg[i], seg->mr_offset,
> -				   seg->mr_len);
> +		sg_set_page(&mr->mr_sg[i],
> +			    seg->mr_page,
> +			    seg->mr_len,
> +			    offset_in_page(seg->mr_offset));
>   
>   		++seg;
>   		++i;
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> index 832765f3ebba..529adb6ad4db 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -214,7 +214,7 @@ rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
>   		     unsigned int *n)
>   {
>   	if (vec->iov_len) {
> -		seg->mr_page = NULL;
> +		seg->mr_page = virt_to_page(vec->iov_base);
>   		seg->mr_offset = vec->iov_base;
>   		seg->mr_len = vec->iov_len;
>   		++seg;
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> index 94b28657aeeb..02971e183989 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -283,10 +283,11 @@ enum {
>   				  RPCRDMA_MAX_IOV_SEGS,
>   };
>   
> -struct rpcrdma_mr_seg {		/* chunk descriptors */
> -	u32		mr_len;		/* length of chunk or segment */
> -	struct page	*mr_page;	/* owning page, if any */
> -	char		*mr_offset;	/* kva if no page, else offset */
> +/* Arguments for DMA mapping and registration */
> +struct rpcrdma_mr_seg {
> +	u32		mr_len;		/* length of segment */
> +	struct page	*mr_page;	/* underlying struct page */
> +	char		*mr_offset;	/* IN: page offset, OUT: iova */
>   };
>   
>   /* The Send SGE array is provisioned to send a maximum size
> 
> 
> 
