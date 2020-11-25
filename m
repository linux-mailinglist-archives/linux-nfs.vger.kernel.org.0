Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573A52C4203
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 15:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgKYOR7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 09:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbgKYOR7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 09:17:59 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C628BC0613D4;
        Wed, 25 Nov 2020 06:17:58 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1666C6EA1; Wed, 25 Nov 2020 09:17:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1666C6EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606313878;
        bh=iy/sIbVpWsRX3k7zz1qB2mwaZ2KsN5gOAK8vwzKr12s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+Jbd6rodlgRhcYu5Xb1UsLp4qUs/omS+Zg+f1HPJ/4RY9TQJ9NK9Vib1Ow79Hm4B
         EkYDvMq9ZQMU6i/MmQgARGwpMogmu5bkJDBEivEXqi17JgY2ydeAt+A6JMoM92RI/A
         7SH4Z6CitC5/rzfjzKgDrsJZ1OOTAoLBaV9oGvgU=
Date:   Wed, 25 Nov 2020 09:17:58 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Huang Guobin <huangguobin4@huawei.com>
Cc:     chuck.lever@oracle.com, trond.myklebust@primarydata.com,
        richard.sharpe@primarydata.com, dros@primarydata.com,
        jeff.layton@primarydata.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix error return code in nfsd_file_cache_init()
Message-ID: <20201125141758.GB2811@fieldses.org>
References: <20201125083933.2386059-1-huangguobin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125083933.2386059-1-huangguobin4@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 25, 2020 at 03:39:33AM -0500, Huang Guobin wrote:
> Fix to return PTR_ERR() error code from the error handling case instead of
> 0 in function nfsd_file_cache_init(), as done elsewhere in this function.
> 
> Fixes: 65294c1f2c5e7("nfsd: add a new struct file caching facility to nfsd")
> Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
> ---
>  fs/nfsd/filecache.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index c8b9d2667ee6..a8a5b555f08b 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -686,6 +686,7 @@ nfsd_file_cache_init(void)
>  		pr_err("nfsd: unable to create fsnotify group: %ld\n",
>  			PTR_ERR(nfsd_file_fsnotify_group));
>  		nfsd_file_fsnotify_group = NULL;
> +		ret = PTR_ERR(nfsd_file_fsnotify_group);

I think you meant to add that one line earlier.

Otherwise fine, but it looks like an unlikely case so can probably wait
for the merge window.

--b.

>  		goto out_notifier;
>  	}
>  
> -- 
> 2.22.0
