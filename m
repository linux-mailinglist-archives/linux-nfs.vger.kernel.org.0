Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E690849B950
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 17:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1586314AbiAYQvh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 11:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586455AbiAYQti (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 11:49:38 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22F5C061788
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 08:46:22 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 69A1170BB; Tue, 25 Jan 2022 11:46:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 69A1170BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643129180;
        bh=R/MIMdDWiSxg50vGM/gBVkyttkGPQYn8F8jYNOc5o/0=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=iuRFK59DLrQlBkOClvXXQp/aSr7MGqpGHcQTL+JR4D2HcF+kCIBEKssZPov6jg6jM
         I07PYFwk34sM7BKjtcnJa7pJEOcg2G09gbXoFxYW+V8+5K7GVCleLa+3OZbwQuP6b/
         2+XkhM3IDtZScKOptOLQ5s+l7oUEhm7uGU2zSV2s=
Date:   Tue, 25 Jan 2022 11:46:20 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC] NFSD: COMMIT operations must not return NFS?ERR_INVAL
Message-ID: <20220125164620.GB15537@fieldses.org>
References: <164312364841.2592.937810018356237855.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164312364841.2592.937810018356237855.stgit@bazille.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 25, 2022 at 10:15:18AM -0500, Chuck Lever wrote:
> Since, well, forever, the Linux NFS server's nfsd_commit() function
> has returned nfserr_inval when the passed-in byte range arguments
> were non-sensical.
> 
> However, according to RFC 1813 section 3.3.21, NFSv3 COMMIT requests
> are permitted to return only the following non-zero status codes:
> 
>       NFS3ERR_IO
>       NFS3ERR_STALE
>       NFS3ERR_BADHANDLE
>       NFS3ERR_SERVERFAULT
> 
> NFS3ERR_INVAL is not included in that list. Likewise, NFS4ERR_INVAL
> is not listed in the COMMIT row of Table 6 in RFC 8881.
> 
> Instead of dropping or failing a COMMIT request in a byte range that
> is not supported, turn it into a valid request by treating one or
> both arguments as zero.

Offset 0 means start-of-file, count 0 means until-end-of-file, so at
worst you're extending the range, and committing data you don't need to.
Since committing is something the server's free to do at any time,
that's harmless.  OK!

(Are the checks really necessary?  I can't tell what vfs_fsync_range()
does with weird values.)

--b.

> 
> As a clean-up, I replaced the signed v. unsigned integer comparisons
> because I found that logic difficult to reason about.
> 
> Reported-by: Dan Aloni <dan.aloni@vastdata.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c |    6 ------
>  fs/nfsd/vfs.c      |   43 ++++++++++++++++++++++++++++---------------
>  fs/nfsd/vfs.h      |    4 ++--
>  3 files changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 8ef53f6726ec..8cd2953f53c7 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -651,15 +651,9 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
>  				argp->count,
>  				(unsigned long long) argp->offset);
>  
> -	if (argp->offset > NFS_OFFSET_MAX) {
> -		resp->status = nfserr_inval;
> -		goto out;
> -	}
> -
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->status = nfsd_commit(rqstp, &resp->fh, argp->offset,
>  				   argp->count, resp->verf);
> -out:
>  	return rpc_success;
>  }
>  
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 99c2b9dfbb10..384c62591f45 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1110,42 +1110,55 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
>  }
>  
>  #ifdef CONFIG_NFSD_V3
> -/*
> - * Commit all pending writes to stable storage.
> +/**
> + * nfsd_commit - Commit pending writes to stable storage
> + * @rqstp: RPC request being processed
> + * @fhp: NFS filehandle
> + * @offset: offset from beginning of file
> + * @count: count of bytes to sync
> + * @verf: filled in with the server's current write verifier
>   *
>   * Note: we only guarantee that data that lies within the range specified
>   * by the 'offset' and 'count' parameters will be synced.
>   *
>   * Unfortunately we cannot lock the file to make sure we return full WCC
>   * data to the client, as locking happens lower down in the filesystem.
> + *
> + * Return values:
> + *   An nfsstat value in network byte order.
>   */
>  __be32
> -nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -               loff_t offset, unsigned long count, __be32 *verf)
> +nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
> +	    u32 count, __be32 *verf)
>  {
> +	u64			maxbytes;
> +	loff_t			start, end;
>  	struct nfsd_net		*nn;
>  	struct nfsd_file	*nf;
> -	loff_t			end = LLONG_MAX;
> -	__be32			err = nfserr_inval;
> -
> -	if (offset < 0)
> -		goto out;
> -	if (count != 0) {
> -		end = offset + (loff_t)count - 1;
> -		if (end < offset)
> -			goto out;
> -	}
> +	__be32			err;
>  
>  	err = nfsd_file_acquire(rqstp, fhp,
>  			NFSD_MAY_WRITE|NFSD_MAY_NOT_BREAK_LEASE, &nf);
>  	if (err)
>  		goto out;
> +
> +	start = 0;
> +	end = LLONG_MAX;
> +	/* NB: s_maxbytes is a (signed) loff_t, thus @maxbytes always
> +	 * contains a value that is less than LLONG_MAX. */
> +	maxbytes = fhp->fh_dentry->d_sb->s_maxbytes;
> +	if (offset < maxbytes) {
> +		start = offset;
> +		if (count && (offset + count - 1 < maxbytes))
> +			end = offset + count - 1;
> +	}
> +
>  	nn = net_generic(nf->nf_net, nfsd_net_id);
>  	if (EX_ISSYNC(fhp->fh_export)) {
>  		errseq_t since = READ_ONCE(nf->nf_file->f_wb_err);
>  		int err2;
>  
> -		err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
> +		err2 = vfs_fsync_range(nf->nf_file, start, end, 0);
>  		switch (err2) {
>  		case 0:
>  			nfsd_copy_write_verifier(verf, nn);
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 9f56dcb22ff7..2c43d10e3cab 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -74,8 +74,8 @@ __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
>  				char *name, int len, struct iattr *attrs,
>  				struct svc_fh *res, int createmode,
>  				u32 *verifier, bool *truncp, bool *created);
> -__be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
> -				loff_t, unsigned long, __be32 *verf);
> +__be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
> +				u64 offset, u32 count, __be32 *verf);
>  #endif /* CONFIG_NFSD_V3 */
>  #ifdef CONFIG_NFSD_V4
>  __be32		nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
