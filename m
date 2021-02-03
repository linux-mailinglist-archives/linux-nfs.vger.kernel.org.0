Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B7430E1EF
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 19:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhBCSH4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 13:07:56 -0500
Received: from p3plsmtpa11-02.prod.phx3.secureserver.net ([68.178.252.103]:46133
        "EHLO p3plsmtpa11-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232304AbhBCSHs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 13:07:48 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id 7MYDlin8jvJuI7MYDlHlNp; Wed, 03 Feb 2021 11:06:50 -0700
X-CMAE-Analysis: v=2.4 cv=ZIgSJV3b c=1 sm=1 tr=0 ts=601ae63a
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=bytjtrGhdB8b_lnsUz4A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v2 1/6] xprtrdma: Remove FMR support in
 rpcrdma_convert_iovs()
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
 <161236943446.1030487.4542967452464402073.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <a2a7d8a1-9372-04ac-7ad6-f29c34ef3804@talpey.com>
Date:   Wed, 3 Feb 2021 13:06:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <161236943446.1030487.4542967452464402073.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMtqoLaYAX7L71QRtO342xhy8n1F48M04xC95JhTmwlh9rso5hNYmlgbex39DzAZjj+21ppHGIyn//BVbBG8icEM3i8hBufPpOlwxc7z5n30e0rgh+js
 YajfnKZ6lbF6HopI+Tz2S260B7FBJ0hA1zyA/IkoxCiMuiYYNmThSD/O1GuzC/nshPE2vJmxYrRCMv22/UGCsasSIE4SXs7QTiZDdbupnR9zMoDYYywSonUL
 ll4/P9rSy5leM0cP5y9u9S3Dihc3Nh5ZL4pX9bovOVU=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/3/2021 11:23 AM, Chuck Lever wrote:
> Support for FMR was removed by commit ba69cd122ece ("xprtrdma:
> Remove support for FMR memory registration") [Dec 2018]. That means
> the buffer-splitting behavior of rpcrdma_convert_kvec(), added by
> commit 821c791a0bde ("xprtrdma: Segment head and tail XDR buffers
> on page boundaries") [Mar 2016], is no longer necessary. FRWR
> memory registration handles this case with aplomb.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/rpc_rdma.c |   19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> index 8f5d0cb68360..832765f3ebba 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -204,9 +204,7 @@ rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
>   	return 0;
>   }
>   
> -/* Split @vec on page boundaries into SGEs. FMR registers pages, not
> - * a byte range. Other modes coalesce these SGEs into a single MR
> - * when they can.
> +/* Convert @vec to a single SGL element.
>    *
>    * Returns pointer to next available SGE, and bumps the total number
>    * of SGEs consumed.
> @@ -215,21 +213,12 @@ static struct rpcrdma_mr_seg *
>   rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
>   		     unsigned int *n)
>   {
> -	u32 remaining, page_offset;
> -	char *base;
> -
> -	base = vec->iov_base;
> -	page_offset = offset_in_page(base);
> -	remaining = vec->iov_len;
> -	while (remaining) {
> +	if (vec->iov_len) {

This is weird. Is it ever possible for a zero-length segment to be
passed? If so, it's obviously wrong to return an uninitialized "seg"
to the caller. I'd suggest simply asserting that iov_len is != 0.

I guess this was an issue in the existing code, but there, it would
only trigger if *all* the segs were zero.

>   		seg->mr_page = NULL;
> -		seg->mr_offset = base;
> -		seg->mr_len = min_t(u32, PAGE_SIZE - page_offset, remaining);
> -		remaining -= seg->mr_len;
> -		base += seg->mr_len;
> +		seg->mr_offset = vec->iov_base;

I thought the previous discussion was that this should be offset_in_page
not the (virtual) iov_base.

Tom.

> +		seg->mr_len = vec->iov_len;
>   		++seg;
>   		++(*n);
> -		page_offset = 0;
>   	}
>   	return seg;
>   }
> 
> 
> 
