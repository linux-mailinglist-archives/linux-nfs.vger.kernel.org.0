Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14E35F656
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 16:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhDNOk4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 10:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhDNOkz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 10:40:55 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F9C061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 07:40:34 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id D4DC96A45; Wed, 14 Apr 2021 10:40:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D4DC96A45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1618411233;
        bh=qOJgkaSA51CVYqAKbBXwO3MsopB+BDfJem651yfKiS4=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=bV6fxLx8sLGYSv2H/fDEhH9nXyKqPgkI4PwmBPVLOgxcxl7fRrwTm2DoZSF82tWTZ
         07RRHNqpVxN8SV2yXFikHgq69P7jslaXFS8XVK+nSxAveQGpUh6NPAW6yWwsW4qGkp
         mTzlxpebsBKj38QA/t8QieMtwOsR3ixmjQeHWHiU=
Date:   Wed, 14 Apr 2021 10:40:33 -0400
To:     trondmy@kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Olga Kornievskaia <kolga@netapp.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv42: Don't force attribute revalidation of the
 copy offload source
Message-ID: <20210414144033.GC16800@fieldses.org>
References: <20210414143138.15192-1-trondmy@kernel.org>
 <20210414143138.15192-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414143138.15192-2-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks!  Testing....

--b.

On Wed, Apr 14, 2021 at 10:31:38AM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> When a copy offload is performed, we do not expect the source file to
> change other than perhaps to see the atime be updated.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs42proc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 3875120ef3ef..a24349512ffe 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -390,12 +390,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
>  	}
>  
>  	nfs42_copy_dest_done(dst_inode, pos_dst, res->write_res.count);
> -
> -	spin_lock(&src_inode->i_lock);
> -	nfs_set_cache_invalid(src_inode, NFS_INO_REVAL_PAGECACHE |
> -						 NFS_INO_REVAL_FORCED |
> -						 NFS_INO_INVALID_ATIME);
> -	spin_unlock(&src_inode->i_lock);
> +	nfs_invalidate_atime(src_inode);
>  	status = res->write_res.count;
>  out:
>  	if (args->sync)
> -- 
> 2.30.2
