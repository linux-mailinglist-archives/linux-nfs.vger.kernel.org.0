Return-Path: <linux-nfs+bounces-15524-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5209BFD929
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5566C34450C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7B296BBA;
	Wed, 22 Oct 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gViJWMvD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA992376E0;
	Wed, 22 Oct 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154076; cv=none; b=ChXd6YiPecxeQ9Qdzmkwf9UCEPSgG3BKqb6r6yf/xoAxE7Z1YCish+BcW/+ijyC7P1NCawlttJpf3VVuz0azEasqAeNvCu/CXgEYcYrsHIEYcxdrqYYc8BaHHwOoH7XyJkhfq+ewpg2HegvnoS0IuD/eOqng6KlPw0uMxHCvAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154076; c=relaxed/simple;
	bh=SQj22qzynJhYarLtKbyP0xB2U24cV0fTGmS7dLTs6co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0FkCOVwuELAlyyBgSCGRB4F3olWuSpq+Fdd/AkeNUg74EO6B7zCMltP8DOKF4sdl+ZSOIcXfQ/2sw2EsvJHweuwcN9I3MFnx0lNBlVBjqcN/RvEX7RJDn0wFStoVXcIWy8jpR6yGQ+CN+Ob2J4jKhe/Dh2kYQmXx/Pxbf5gUf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gViJWMvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2704C4CEE7;
	Wed, 22 Oct 2025 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761154076;
	bh=SQj22qzynJhYarLtKbyP0xB2U24cV0fTGmS7dLTs6co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gViJWMvDlzzk5anCzK4GH61YVcs7I5AxHppiUl4wEHeaoGn7OKO4cV1MndKo4G5Yl
	 zcA8/lXHdI2SFN9zjsPjx8SX6cOaidsr+0hjIYC9EPlQ1GbxKA4mk2oGcut3gdrZMm
	 +Rc9shVJSK4HzJU+ScwC5BsJopiirtZUiBgyurrkmiOfvu7BMNLbA+i68C/iDuGC7v
	 W3q8rphsjh7QLuXuprGqqMNG5iPMTSYL2cGaODzC5kYweyHyXoVCtgSGZfv3fHXmms
	 ELWfV6U/YLmJXkV7bZiQ4LMhGD9hUAAwmahvkfREKgLOBhWuJOL79uRIciGVDNV2s6
	 yOUW+lfGB35Xg==
Date: Wed, 22 Oct 2025 13:27:54 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	honza@suse.de
Subject: Re: [RFC PATCH] NFSD: Make FILE_SYNC WRITEs comply with spec
Message-ID: <aPkUGpuBfz_E0gGu@kernel.org>
References: <20251022162237.26727-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022162237.26727-1-cel@kernel.org>

On Wed, Oct 22, 2025 at 12:22:37PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Mike noted that when NFSD responds to an NFS_FILE_SYNC WRITE, it
> does not also persist file time stamps. To wit, Section 18.32.3
> of RFC 8881 mandates:
> 
> > The client specifies with the stable parameter the method of how
> > the data is to be processed by the server. If stable is
> > FILE_SYNC4, the server MUST commit the data written plus all file
> > system metadata to stable storage before returning results. This
> > corresponds to the NFSv2 protocol semantics. Any other behavior
> > constitutes a protocol violation. If stable is DATA_SYNC4, then
> > the server MUST commit all of the data to stable storage and
> > enough of the metadata to retrieve the data before returning.
> 
> For many years, NFSD has used a "data sync only" optimization for
> FILE_SYNC WRITEs, so file time stamps haven't been persisted as the
> mandate above requires.
> 
> Reported-by: Mike Snitzer <snitzer@kernel.org>
> Closes: https://lore.kernel.org/linux-nfs/20251018005431.3403-1-cel@kernel.org/T/#t
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> This would need to be applied to nfsd-testing before the DIRECT
> WRITE patches. I'm guessing a Cc: stable would be needed as well.
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f537a7b4ee01..2c5d38f38454 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1315,7 +1315,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	init_sync_kiocb(&kiocb, file);
>  	kiocb.ki_pos = offset;
>  	if (stable && !fhp->fh_use_wgather)
> -		kiocb.ki_flags |= IOCB_DSYNC;
> +		kiocb.ki_flags |=
> +			(stable == NFS_FILE_SYNC ? IOCB_SYNC : IOCB_DSYNC);
>  
>  	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
>  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> -- 
> 2.51.0
> 

I agree with this change.  And as I just replied elsewhere, IOCB_SYNC
doesn't cause a performance drop (at least not on modern systems with
NVMe): https://lore.kernel.org/linux-nfs/aPkNvmXsgdNJtK_7@kernel.org/

Only question I have:
does IOCB_SYNC _always_ imply IOCB_DSYNC (for VFS and all
filesystems)?  Or should we be setting IOCB_DSYNC|IOCB_SYNC ?

(I took to setting both for NFSD Direct, and NFS LOCALIO sets
both.. that was done by original LOCALIO author)

Basis for my question, is that there was a recent XFS performance
improvement made by Dave Chinner, reported by Jan Kara, for
DIO+DSYNC, see commit c91d38b57f2c4 ("xfs: rework datasync tracking
and execution").  Will DIO + IOCB_SYNC get the benefit of DIO +
IOCB_DSYNC relative to this XFS improvement?  I tried to review that
but wasn't able to spend enough time on it to be convinced that to be
the case.

Mike

