Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90BC5125248
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 20:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfLRTtK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 14:49:10 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:42760 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbfLRTtJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 14:49:09 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id DA9AA7EAAA1;
        Thu, 19 Dec 2019 06:49:06 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ihfJh-0004eL-Bb; Thu, 19 Dec 2019 06:49:05 +1100
Date:   Thu, 19 Dec 2019 06:49:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Clone should commit src file metadata too
Message-ID: <20191218194905.GW19213@dread.disaster.area>
References: <20191218173752.81645-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218173752.81645-1-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=SEtKQCMJAAAA:8 a=YjQstw7mB-IPi5IG-P4A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22 a=kyTSok1ft720jgMXX5-3:22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 18, 2019 at 12:37:52PM -0500, Trond Myklebust wrote:
> vfs_clone_file_range() can modify the metadata on the source file too,
> so we need to commit that to stable storage as well.
> 
> Reported-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/vfs.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f0bca0e87d0c..bc7f330c2a79 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -280,19 +280,25 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
>   * Commit metadata changes to stable storage.
>   */
>  static int
> -commit_metadata(struct svc_fh *fhp)
> +commit_inode_metadata(struct inode *inode)
>  {
> -	struct inode *inode = d_inode(fhp->fh_dentry);
>  	const struct export_operations *export_ops = inode->i_sb->s_export_op;
>  
> -	if (!EX_ISSYNC(fhp->fh_export))
> -		return 0;
> -
>  	if (export_ops->commit_metadata)
>  		return export_ops->commit_metadata(inode);
>  	return sync_inode_metadata(inode, 1);
>  }
>  
> +static int
> +commit_metadata(struct svc_fh *fhp)
> +{
> +	struct inode *inode = d_inode(fhp->fh_dentry);
> +
> +	if (!EX_ISSYNC(fhp->fh_export))
> +		return 0;
> +	return commit_inode_metadata(inode);
> +}
> +
>  /*
>   * Go over the attributes and take care of the small differences between
>   * NFS semantics and what Linux expects.
> @@ -536,7 +542,10 @@ __be32 nfsd4_clone_file_range(struct file *src, u64 src_pos, struct file *dst,
>  		return nfserrno(-EINVAL);
>  	if (sync) {
>  		loff_t dst_end = count ? dst_pos + count - 1 : LLONG_MAX;
> -		int status = vfs_fsync_range(dst, dst_pos, dst_end, 0);
> +		int status = commit_inode_metadata(file_inode(src));
> +
> +		if (!status)
> +			status = vfs_fsync_range(dst, dst_pos, dst_end, 0);

Hmmm.  Seeing as the source and destination inode were modified in
the same transaction on XFS, we only need one journal write to flush
them both. However, commit+fsync ends up doing:

	journal write (src+dst metadata)
	writeback data (dst data)
	  -> can dirty dst metadata
	journal write (dst metadata) or device cache flush (dst data)

So either way, we end up having to do multiple device cache flushes
and possibly multiple journal writes.

IOWs, This would be much more efficient as:

	fsync(dst)
	commit_inode_metadata(src)

as it would end up as:

	writeback data (dst data)
	journal write(src+dst metadata)

and the call to commit_inode_metadata(src) ends up being a no-op
with almost no overhead...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
