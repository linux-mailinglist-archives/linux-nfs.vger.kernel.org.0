Return-Path: <linux-nfs+bounces-14572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D6B86362
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 19:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D387C21A2
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B37214B06C;
	Thu, 18 Sep 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6u8ZfTm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736334BA5D
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216710; cv=none; b=ZvoAa2Que9u02xKj55ckf5g0rBZ/QS5XBt5m9Io9eNfcz9ZH1H+325pDb//oGFSL+ZLp0Jo9pykam/a4Ko1lAutcIwBQzMR+nDJR73jDgiNFv/KFkZB4157GcwqT3nACZmLkj14mKtAK5cxNGsSBYkBPXi/QFTIKuKXxAVLcaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216710; c=relaxed/simple;
	bh=vJDIe5NEyeFFbCSOVrJe4SNvxDP4Gj3jFhrOz8JfJkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEZxnCw6HaaSg9uOKH+k5I9ZrsJosc3RHPdUkBoLwLTF+I2VpEcEKcVe32bNgRXqaQRtlFjluXj+XEu00ZU9qvdBcijTq8fpPx65MrqwYc3CA5hvu9CjzWj21MBSZlc0IGRrPkgBEJv/30AbkQ8sFKIpwINFA3mzn8wkUYrZjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6u8ZfTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D1CC4CEE7;
	Thu, 18 Sep 2025 17:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758216709;
	bh=vJDIe5NEyeFFbCSOVrJe4SNvxDP4Gj3jFhrOz8JfJkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6u8ZfTm8UyI/3/9oTBXp4br2whUCnIv1UTH7kQpOaPzus1RaX/MBezEfP6LHPJbf
	 tpwahz9TcKJYIk1aVOD/I59WQXTncItSshqXbqXXR94i1Mx7TaCfPBNH1ic1vaAG55
	 K7cknnHRCz3TCdv0X7CCJVWSZaCGmxF9F3rJ0cmyiY+jGZ28LSikDwn1enKEjOO2nx
	 97K517atcFvzio1T40usQ2TaLqoAidoK8CFihHwPO/uFl+JzBJswI7v5CoK+oicSIz
	 xkd27ku5QOQThl3oMyP24VILXk7ohah7aAgpLV0MpM+KLBZkeRHZ2HoNsjpIH2fCnj
	 ly/guWBHgo0sg==
Date: Thu, 18 Sep 2025 13:31:48 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v10 2/7] nfs/localio: avoid issuing misaligned IO using
 O_DIRECT
Message-ID: <aMxCBIEFuBC0RiS7@kernel.org>
References: <20250917181843.33865-1-snitzer@kernel.org>
 <20250917181843.33865-3-snitzer@kernel.org>
 <404a4c49-9e16-46d1-8901-f7a8a6a9701b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404a4c49-9e16-46d1-8901-f7a8a6a9701b@oracle.com>

On Thu, Sep 18, 2025 at 01:15:10PM -0400, Anna Schumaker wrote:
> Hi Mike,
> 
> On 9/17/25 2:18 PM, Mike Snitzer wrote:
> > Add nfsd_file_dio_alignment and use it to avoid issuing misaligned IO
> > using O_DIRECT. Any misaligned DIO falls back to using buffered IO.
> > 
> > Because misaligned DIO is now handled safely, remove the nfs modparam
> > 'localio_O_DIRECT_semantics' that was added to require users opt-in to
> > the requirement that all O_DIRECT be properly DIO-aligned.
> > 
> > Also, introduce nfs_iov_iter_aligned_bvec() which is a variant of
> > iov_iter_aligned_bvec() that also verifies the offset associated with
> > an iov_iter is DIO-aligned.  NOTE: in a parallel effort,
> > iov_iter_aligned_bvec() is being removed along with
> > iov_iter_is_aligned().
> > 
> > Lastly, add pr_info_ratelimited if underlying filesystem returns
> > -EINVAL because it was made to try O_DIRECT for IO that is not
> > DIO-aligned (shouldn't happen, so its best to be louder if it does).
> > 
> > Fixes: 3feec68563d ("nfs/localio: add direct IO enablement with sync and async IO support")
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/localio.c           | 69 ++++++++++++++++++++++++++++++++------
> >  fs/nfsd/localio.c          | 11 ++++++
> >  include/linux/nfslocalio.h |  2 ++
> >  3 files changed, 72 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> > index 42ea50d42c995..380407c41822c 100644
> > --- a/fs/nfs/localio.c
> > +++ b/fs/nfs/localio.c

<snip>

> > @@ -406,6 +441,13 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
> >  	struct nfs_pgio_header *hdr = iocb->hdr;
> >  	struct file *filp = iocb->kiocb.ki_filp;
> >  
> > +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> > +		if (status == -EINVAL) {
> > +			/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
> > +			pr_info_ratelimited("nfs: Unexpected direct I/O read alignment failure\n");
> > +		}
> > +	}
> > +
> >  	nfs_local_pgio_done(hdr, status);
> >  
> >  	/*
> > @@ -598,6 +640,13 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
> >  
> >  	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
> >  
> > +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> > +		if (status == -EINVAL) {
> > +			/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
> > +			pr_info_ratelimited("nfs: Unexpected direct I/O write alignment failure\n");
> > +		}
> > +	}
> > +
> >  	/* Handle short writes as if they are ENOSPC */
> >  	if (status > 0 && status < hdr->args.count) {
> >  		hdr->mds_offset += status;

I'm just noticing these 2 hunks above. I revised them to remove 1
level of nesting but it seems that wasn't folded in early (in this
patch 2) but instead was left until patch 5 to cleanup.

You can leave patch 2 and 5 like they are, just mentioning this
because fixing up patch 2 to reflect how patch 5 left things for these
two hunks would reduce patch 5's changes/churn.

I can also carry that change through and post a v11 -- will wait to do
so until you've been able to get through the rest of the series in
case there are other things that need fixing.

> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > index 269fa9391dc46..be710d809a3ba 100644
> > --- a/fs/nfsd/localio.c
> > +++ b/fs/nfsd/localio.c
> 
> I'll need an acked-by from Chuck or Jeff for the NFSD portions of this patch.
>
> Thanks,
> Anna

Absolutely, I should've cc'd them (I've done so now).

Thanks,
Mike

