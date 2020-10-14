Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BC928EB02
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Oct 2020 04:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgJOCOi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Oct 2020 22:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgJOCOh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Oct 2020 22:14:37 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E46C0613B1
        for <linux-nfs@vger.kernel.org>; Wed, 14 Oct 2020 14:26:17 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 195E569C3; Wed, 14 Oct 2020 17:26:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 195E569C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602710776;
        bh=fOYQQVYkLChPD6OiLg4J/sj4FskeLbgptD5n8KmZRxY=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=rtm3iJB7yviet329Ti1h1bGcGz9KxS7ad4jygurs7eNyufF6mNT05o3Y9jNti/hpq
         FNhuGLOHDucMbEuug1dNXosq6klVFX5SD29Mh9nBcMht8H2WFtUuRI55p1ew54aXPz
         3IC311IDr34JgIuYI16ZZXiu5SYY9iP5FW7xCAvo=
Date:   Wed, 14 Oct 2020 17:26:16 -0400
To:     Dan Aloni <dan@kernelim.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] svcrdma: fix bounce buffers for unaligned offsets and
 multiple pages
Message-ID: <20201014212616.GB23262@fieldses.org>
References: <58FBC94E-3F7D-4C23-A720-6588B0B22E86@oracle.com>
 <20201002193343.1040351-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002193343.1040351-1-dan@kernelim.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applying for 5.10.--b.

On Fri, Oct 02, 2020 at 10:33:43PM +0300, Dan Aloni wrote:
> This was discovered using O_DIRECT at the client side, with small
> unaligned file offsets or IOs that span multiple file pages.
> 
> Fixes: e248aa7be86 ("svcrdma: Remove max_sge check at connect time")
> Signed-off-by: Dan Aloni <dan@kernelim.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Extended testing found another issue with the loop.
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> index 7b94d971feb3..c3d588b149aa 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> @@ -638,10 +638,11 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
>  		while (remaining) {
>  			len = min_t(u32, PAGE_SIZE - pageoff, remaining);
>  
> -			memcpy(dst, page_address(*ppages), len);
> +			memcpy(dst, page_address(*ppages) + pageoff, len);
>  			remaining -= len;
>  			dst += len;
>  			pageoff = 0;
> +			ppages++;
>  		}
>  	}
>  
> -- 
> 2.26.2
