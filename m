Return-Path: <linux-nfs+bounces-15272-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 848FDBDFC65
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 18:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 399974F68BE
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A7B338F25;
	Wed, 15 Oct 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5kIg0OU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488F33768B
	for <linux-nfs@vger.kernel.org>; Wed, 15 Oct 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547228; cv=none; b=du3JRFKBitslT9Z5b7vp/rsHD9b4tGXuzPRo5GyMMY/QJ/3QsV5aVH6WaUJReV9dyH6bMoClFFu3sACUgGEmpebkcTJqYKE+AcPHLscgX9iIsKCc8wpzteLdeEX6ukI5tSgAQXpfkEPDrbQhQjgeK8nc/iCYh7s6JCMIxmB9Dxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547228; c=relaxed/simple;
	bh=ViuD0SaVns0m2WzZkgsKjC8pxsk1HXvSwrUQ8Pa/OSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIYvGEKCklzSCqkH4XreIAyiDl4Y0qGpLlhKn+G2qXfXmVABKcn0MkaWkg1IyoedDKPst6QdB7IXbGnwqpdi7nkKP2JiR31Xi706zRYLxIDMLcz93sCp4YdHKgrD6GtUiBb4E+W6dLn+1HHOCoJ5rPL6+acGrZVlubf9MlbbUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5kIg0OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D699EC4CEF9;
	Wed, 15 Oct 2025 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760547226;
	bh=ViuD0SaVns0m2WzZkgsKjC8pxsk1HXvSwrUQ8Pa/OSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5kIg0OU2Gn/MwO9MQcZ2UYVoPqRJ18C1EFkc8t9L3K9z1pmOgqNZso1ZwnhoJdTA
	 lH1z7437XtW8abg39yYnPZLdBsAwYHD8VTriUrJ80myS4RpOoPuVOpOc2wKpNCDOjH
	 xNzOz/ijLG01Xh3cNF3GW/sm5yivvj1mViZhbYE/yNZ/CtKYZ268/S9hTN0cdjJcNE
	 ZdPJpMXk79IHrKithFkTmLQfEiyDclbWsyrr19amv5E+nWTOeV5xnD/egltVhNldqp
	 PXBVY2VyhUHOJU8GUe4BCkEU//tPtM3A/IRs9kj4JKfZum1u9f7gLRWJxOdmpsiOx1
	 6RVuD2rD/5jsw==
Date: Wed, 15 Oct 2025 12:53:44 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS
 clients
Message-ID: <aO_RmCNR8rg9EtlP@kernel.org>
References: <20251013190113.252097-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013190113.252097-1-cel@kernel.org>

On Mon, Oct 13, 2025 at 03:01:13PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
> WRITE to be a FILE_SYNC WRITE. This indicates that the client does
> not need a subsequent COMMIT operation, saving a round trip and
> allowing the client to dispense with cached dirty data as soon as
> it receives the server's WRITE response.
> 
> This patch refactors nfsd_vfs_write() to return a possibly modified
> stable_how value to its callers. No behavior change is expected.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c |  2 +-
>  fs/nfsd/nfs4proc.c |  2 +-
>  fs/nfsd/nfsproc.c  |  3 ++-
>  fs/nfsd/vfs.c      | 11 ++++++-----
>  fs/nfsd/vfs.h      |  6 ++++--
>  fs/nfsd/xdr3.h     |  2 +-
>  6 files changed, 15 insertions(+), 11 deletions(-)
> 
> Here's what I had in mind, based on a patch I did a year ago but
> never posted.
> 
> If nfsd_vfs_write() promotes an NFS_UNSTABLE write to NFS_FILE_SYNC,
> it can now set *stable_how and the WRITE encoders will return the
> updated value to the client.
> 
> 
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index b6d03e1ef5f7..ad14b34583bb 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -236,7 +236,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
>  	resp->committed = argp->stable;
>  	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
>  				  &argp->payload, &cnt,
> -				  resp->committed, resp->verf);
> +				  &resp->committed, resp->verf);
>  	resp->count = cnt;
>  	resp->status = nfsd3_map_status(resp->status);
>  	return rpc_success;
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 7f7e6bb23a90..2222bb283baf 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1285,7 +1285,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	write->wr_how_written = write->wr_stable_how;
>  	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
>  				write->wr_offset, &write->wr_payload,
> -				&cnt, write->wr_how_written,
> +				&cnt, &write->wr_how_written,
>  				(__be32 *)write->wr_verifier.data);
>  	nfsd_file_put(nf);
>  
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 8f71f5748c75..706401ed6f8d 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -251,6 +251,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>  	struct nfsd_writeargs *argp = rqstp->rq_argp;
>  	struct nfsd_attrstat *resp = rqstp->rq_resp;
>  	unsigned long cnt = argp->len;
> +	u32 committed = NFS_DATA_SYNC;
>  
>  	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
>  		SVCFH_fmt(&argp->fh),
> @@ -258,7 +259,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>  
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
> -				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL);
> +				  &argp->payload, &cnt, &committed, NULL);
>  	if (resp->status == nfs_ok)
>  		resp->status = fh_getattr(&resp->fh, &resp->stat);
>  	else if (resp->status == nfserr_jukebox)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f537a7b4ee01..8b2dc7a88aab 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1262,7 +1262,7 @@ static int wait_for_concurrent_writes(struct file *file)
>   * @offset: Byte offset of start
>   * @payload: xdr_buf containing the write payload
>   * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
> - * @stable: An NFS stable_how value
> + * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_how
>   * @verf: NFS WRITE verifier
>   *
>   * Upon return, caller must invoke fh_put on @fhp.
> @@ -1274,11 +1274,12 @@ __be32
>  nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	       struct nfsd_file *nf, loff_t offset,
>  	       const struct xdr_buf *payload, unsigned long *cnt,
> -	       int stable, __be32 *verf)
> +	       u32 *stable_how, __be32 *verf)
>  {
>  	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>  	struct file		*file = nf->nf_file;
>  	struct super_block	*sb = file_inode(file)->i_sb;
> +	u32			stable = *stable_how;
>  	struct kiocb		kiocb;
>  	struct svc_export	*exp;
>  	struct iov_iter		iter;

Seems we need this instead here?

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5e5e5187d2e5..d0c89f8fdb57 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1479,7 +1479,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file		*file = nf->nf_file;
 	struct super_block	*sb = file_inode(file)->i_sb;
-	u32			stable = *stable_how;
+	u32			stable;
 	struct kiocb		kiocb;
 	struct svc_export	*exp;
 	errseq_t		since;
@@ -1511,7 +1511,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	exp = fhp->fh_export;
 
 	if (!EX_ISSYNC(exp))
-		stable = NFS_UNSTABLE;
+		*stable_how = NFS_UNSTABLE;
+	stable = *stable_how;
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = offset;
 	if (stable && !fhp->fh_use_wgather)

Otherwise, isn't there potential for nfsd_vfs_write's NFS_UNSTABLE
override to cause a client set stable_how, that was set to something
other than NFS_UNSTABLE, to silently _not_ be respected by NFSD? But
client could assume COMMIT not needed? And does this then elevate this
patch to be a stable@ fix? (no pun intended).

If not, please help me understand why.

Thanks!

> @@ -1434,7 +1435,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>   * @offset: Byte offset of start
>   * @payload: xdr_buf containing the write payload
>   * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
> - * @stable: An NFS stable_how value
> + * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_how
>   * @verf: NFS WRITE verifier
>   *
>   * Upon return, caller must invoke fh_put on @fhp.
> @@ -1444,7 +1445,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>   */
>  __be32
>  nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
> -	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
> +	   const struct xdr_buf *payload, unsigned long *cnt, u32 *stable_how,
>  	   __be32 *verf)
>  {
>  	struct nfsd_file *nf;
> @@ -1457,7 +1458,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
>  		goto out;
>  
>  	err = nfsd_vfs_write(rqstp, fhp, nf, offset, payload, cnt,
> -			     stable, verf);
> +			     stable_how, verf);
>  	nfsd_file_put(nf);
>  out:
>  	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index fa46f8b5f132..c713ed0b04e0 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -130,11 +130,13 @@ __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				u32 *eof);
>  __be32		nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				loff_t offset, const struct xdr_buf *payload,
> -				unsigned long *cnt, int stable, __be32 *verf);
> +				unsigned long *cnt, u32 *stable_how,
> +				__be32 *verf);
>  __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				struct nfsd_file *nf, loff_t offset,
>  				const struct xdr_buf *payload,
> -				unsigned long *cnt, int stable, __be32 *verf);
> +				unsigned long *cnt, u32 *stable_how,
> +				__be32 *verf);
>  __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
>  				char *, int *);
>  __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
> diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
> index 522067b7fd75..c0e443ef3a6b 100644
> --- a/fs/nfsd/xdr3.h
> +++ b/fs/nfsd/xdr3.h
> @@ -152,7 +152,7 @@ struct nfsd3_writeres {
>  	__be32			status;
>  	struct svc_fh		fh;
>  	unsigned long		count;
> -	int			committed;
> +	u32			committed;
>  	__be32			verf[2];
>  };
>  
> -- 
> 2.51.0
> 

