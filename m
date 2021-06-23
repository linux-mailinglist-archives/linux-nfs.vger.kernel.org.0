Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C459E3B2291
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jun 2021 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFWVkV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 17:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFWVkT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 17:40:19 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B59C061574
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 14:38:01 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 70E5D6208; Wed, 23 Jun 2021 17:38:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 70E5D6208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1624484280;
        bh=gXNfmG7Ugkl7yjAM+oDHcyeHYa+0APL6q/GDe+0ZT0M=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=Oqb7aD53yFO6zyb8NGSfhNozHf39ldQ91RVEQ8N+PCJAg+k3nqZQvTcYtEoynAwGh
         7UWnJ5FDtYy+swhp0T6OVrjh1oNFLR0RmVfONwe9sJSmQQ2X0yRG8vyeFgrnuB7+6M
         6olmhKz2C8i/mmmLQprT8F2HEBdw10PhukqzcWVA=
Date:   Wed, 23 Jun 2021 17:38:00 -0400
To:     trondmy@kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Message-ID: <20210623213800.GG20232@fieldses.org>
References: <20210617232652.264884-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617232652.264884-1-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Applying, with Chuck's Tested-by, thanks.--b.

On Thu, Jun 17, 2021 at 07:26:52PM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> When flushing out the unstable file writes as part of a COMMIT call, try
> to perform most of of the data writes and waits outside the semaphore.
> 
> This means that if the client is sending the COMMIT as part of a memory
> reclaim operation, then it can continue performing I/O, with contention
> for the lock occurring only once the data sync is finished.
> 
> Fixes: 5011af4c698a ("nfsd: Fix stable writes")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/vfs.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 15adf1f6ab21..46485c04740d 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1123,6 +1123,19 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
>  }
>  
>  #ifdef CONFIG_NFSD_V3
> +static int
> +nfsd_filemap_write_and_wait_range(struct nfsd_file *nf, loff_t offset,
> +				  loff_t end)
> +{
> +	struct address_space *mapping = nf->nf_file->f_mapping;
> +	int ret = filemap_fdatawrite_range(mapping, offset, end);
> +
> +	if (ret)
> +		return ret;
> +	filemap_fdatawait_range_keep_errors(mapping, offset, end);
> +	return 0;
> +}
> +
>  /*
>   * Commit all pending writes to stable storage.
>   *
> @@ -1153,10 +1166,11 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	if (err)
>  		goto out;
>  	if (EX_ISSYNC(fhp->fh_export)) {
> -		int err2;
> +		int err2 = nfsd_filemap_write_and_wait_range(nf, offset, end);
>  
>  		down_write(&nf->nf_rwsem);
> -		err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
> +		if (!err2)
> +			err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
>  		switch (err2) {
>  		case 0:
>  			nfsd_copy_boot_verifier(verf, net_generic(nf->nf_net,
> -- 
> 2.31.1
