Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71ED8380C8C
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhENPKx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 11:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhENPKx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 11:10:53 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC0C061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 08:09:41 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B25FD449B; Fri, 14 May 2021 11:09:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B25FD449B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621004979;
        bh=TElZ39jNcO2LJTaKYUU6wB8bWKMJE1ItSdc7s14/Lfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3u7+v8EERP2ZZYeZjw3oshI5V+C0dAfEusao6qqjrt8qf0nrCwh+jPvtmz2DS/ml
         jijP5yKQjZ+sL+LY0NYo4ExqoQiPGjGJakl6UsoJtr48RRri9hc2bjGj4FcNh6d72N
         Vzf9mi4zgPOFnqg+cAy4uADzo8gpM51r33vT37FQ=
Date:   Fri, 14 May 2021 11:09:39 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Nick Huang <nickhuang@synology.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Bing Jing Chang <bingjingc@synology.com>,
        Robbie Ko <robbieko@synology.com>
Subject: Re: [PATCH] nfsd: Prevent truncation of an unlinked inode from
 blocking access to its directory
Message-ID: <20210514150939.GE9256@fieldses.org>
References: <20210514035829.5230-1-nickhuang@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514035829.5230-1-nickhuang@synology.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 14, 2021 at 11:58:29AM +0800, Nick Huang wrote:
> From: Yu Hsiang Huang <nickhuang@synology.com>
> 
> Truncation of an unlinked inode may take a long time for I/O waiting, and
> it doesn't have to prevent access to the directory. Thus, let truncation
> occur outside the directory's mutex, just like do_unlinkat() does.

Makes sense to me, thanks.  I'll queue it up for 5.14.

Just out of curiosity: was this found just by inspection, or were you
hitting this in a real workload?  I'd be interested in what it took to
reproduce if so.

--b.

> 
> Signed-off-by: Yu Hsiang Huang <nickhuang@synology.com>
> Signed-off-by: Bing Jing Chang <bingjingc@synology.com>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/nfsd/vfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 15adf1f6ab21..39948f130712 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1859,6 +1859,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>  {
>  	struct dentry	*dentry, *rdentry;
>  	struct inode	*dirp;
> +	struct inode	*rinode;
>  	__be32		err;
>  	int		host_err;
>  
> @@ -1887,6 +1888,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>  		host_err = -ENOENT;
>  		goto out_drop_write;
>  	}
> +	rinode = d_inode(rdentry);
> +	ihold(rinode);
>  
>  	if (!type)
>  		type = d_inode(rdentry)->i_mode & S_IFMT;
> @@ -1902,6 +1905,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>  	if (!host_err)
>  		host_err = commit_metadata(fhp);
>  	dput(rdentry);
> +	fh_unlock(fhp);
> +	iput(rinode);    /* truncate the inode here */
>  
>  out_drop_write:
>  	fh_drop_write(fhp);
> -- 
> 2.25.1
