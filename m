Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B80B2A9E97
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 21:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgKFUdS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 15:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgKFUdR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 15:33:17 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07EDC0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Nov 2020 12:33:17 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id CED29BD2; Fri,  6 Nov 2020 15:33:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CED29BD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1604694796;
        bh=jl/TfawUOLh46iaNG5SsHe8oJVEJ3Gkb+6VXRnAvN74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JgA7Y04BUs8FTi+1LbfDEl5K6z8eyAqBVetcX1JXhEEbl7s3bLiBhCqf5P8B2IAEt
         w07WFfnzbKqIjL0tDISYl1XBjcDAYcjlbkwxzMCfCiPlvslRncVsAop+SesR3a98IW
         jNIzGVlObjB2wNswtPhpmRWdnkpDsOQfBVB92h7A=
Date:   Fri, 6 Nov 2020 15:33:16 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Artur Molchanov <arturmolchanov@gmail.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] net/sunrpc: clean up error checking in proc_do_xprt()
Message-ID: <20201106203316.GA26028@fieldses.org>
References: <031F93AC-744F-4E02-9948-1C1F5939714B@gmail.com>
 <20201027141758.GA3488087@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027141758.GA3488087@mwanda>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 27, 2020 at 05:17:58PM +0300, Dan Carpenter wrote:
> There are three changes but none of them should affect run time:
> 
> 1)  You can't write to this file because the permissions are 0444.  But
>     it sort of looked like you could do a write and it would result in
>     a read.  Then it looked like proc_sys_call_handler() just ignored
>     it.  Which is confusing.  It's more clear if the "write" just
>     returns zero.
> 2)  The "lenp" pointer is never NULL so that check can be removed.
> 3)  In the original code, the "if (*lenp < 0)" check didn't work because
>     "*lenp" is unsigned.  Fortunately, the memory_read_from_buffer()
>     call will never fail in this context so it doesn't affect runtime.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  net/sunrpc/sysctl.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
> index a18b36b5422d..04526bab4a06 100644
> --- a/net/sunrpc/sysctl.c
> +++ b/net/sunrpc/sysctl.c
> @@ -63,19 +63,19 @@ static int proc_do_xprt(struct ctl_table *table, int write,
>  			void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	char tmpbuf[256];
> -	size_t len;
> +	ssize_t len;
>  
> -	if ((*ppos && !write) || !*lenp) {
> -		*lenp = 0;
> +	*lenp = 0;
> +
> +	if (write || *ppos)
>  		return 0;
> -	}
> +
>  	len = svc_print_xprts(tmpbuf, sizeof(tmpbuf));
> -	*lenp = memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, len);
> +	len = memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, len);

Except now we're passing *lenp = 0, that can't be right.

Though I actually kind of prefer this to Colin King's patch which just
casts (*lenp) in the comparison below.

--b.

> +	if (len < 0)
> +		return len;
>  
> -	if (*lenp < 0) {
> -		*lenp = 0;
> -		return -EINVAL;
> -	}
> +	*lenp = len;
>  	return 0;
>  }
>  
> -- 
> 2.28.0
