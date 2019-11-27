Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E200610C024
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2019 23:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfK0WWT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Nov 2019 17:22:19 -0500
Received: from fieldses.org ([173.255.197.46]:42856 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfK0WWT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 27 Nov 2019 17:22:19 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id DB302150A; Wed, 27 Nov 2019 17:22:18 -0500 (EST)
Date:   Wed, 27 Nov 2019 17:22:18 -0500
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Ensure CLONE persists data and metadata changes to
 the target file
Message-ID: <20191127222218.GA31805@fieldses.org>
References: <20191127220551.36159-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127220551.36159-1-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 27, 2019 at 05:05:51PM -0500, Trond Myklebust wrote:
> The NFSv4.2 CLONE operation has implicit persistence requirements on the
> target file, since there is no protocol requirement that the client issue
> a separate operation to persist data.
> For that reason, we should call vfs_fsync_range() on the destination file
> after a successful call to vfs_clone_file_range().

Looking at RFC 7862....  So, COPY has a stable_how4 field in the reply,
but CLONE doesn't.  That's interesting!  OK, I guess this makes sense,
then.

--b.

> 
> Fixes: ffa0160a1039 ("nfsd: implement the NFSv4.2 CLONE operation")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: stable@vger.kernel.org # v4.5+
> ---
>  fs/nfsd/nfs4proc.c | 3 ++-
>  fs/nfsd/vfs.c      | 9 ++++++++-
>  fs/nfsd/vfs.h      | 2 +-
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 4e3e77b76411..38c0aeda500e 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1077,7 +1077,8 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		goto out;
>  
>  	status = nfsd4_clone_file_range(src->nf_file, clone->cl_src_pos,
> -			dst->nf_file, clone->cl_dst_pos, clone->cl_count);
> +			dst->nf_file, clone->cl_dst_pos, clone->cl_count,
> +			EX_ISSYNC(cstate->current_fh.fh_export));
>  
>  	nfsd_file_put(dst);
>  	nfsd_file_put(src);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index bd0a385df3fc..9d66c4719067 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -525,7 +525,7 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  #endif
>  
>  __be32 nfsd4_clone_file_range(struct file *src, u64 src_pos, struct file *dst,
> -		u64 dst_pos, u64 count)
> +		u64 dst_pos, u64 count, bool sync)
>  {
>  	loff_t cloned;
>  
> @@ -534,6 +534,13 @@ __be32 nfsd4_clone_file_range(struct file *src, u64 src_pos, struct file *dst,
>  		return nfserrno(cloned);
>  	if (count && cloned != count)
>  		return nfserrno(-EINVAL);
> +	if (sync) {
> +		loff_t dst_end = count ? dst_pos + count - 1 : LLONG_MAX;
> +		int status = vfs_fsync_range(dst, dst_pos, dst_end,
> +				commit_is_datasync);
> +		if (status < 0)
> +			return nfserrno(status);
> +	}
>  	return 0;
>  }
>  
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index a13fd9d7e1f5..cc110a10bfe8 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -56,7 +56,7 @@ __be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
>  __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
>  				    struct file *, loff_t, loff_t, int);
>  __be32		nfsd4_clone_file_range(struct file *, u64, struct file *,
> -			u64, u64);
> +				       u64, u64, bool);
>  #endif /* CONFIG_NFSD_V4 */
>  __be32		nfsd_create_locked(struct svc_rqst *, struct svc_fh *,
>  				char *name, int len, struct iattr *attrs,
> -- 
> 2.23.0
