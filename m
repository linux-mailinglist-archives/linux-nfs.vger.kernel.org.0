Return-Path: <linux-nfs+bounces-13219-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B94B0FAB5
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 21:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4309B1C83DFC
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 19:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E2A1F0991;
	Wed, 23 Jul 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCkYYS+E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217FD131E2D
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297562; cv=none; b=Ly3yM+rnww5442qb0MqmUd226600br1V1XvdzKZN7zbHyeQVvjpDuWsk/tRnyqJTrjuU6HT1moEP++ex6wZdL3sbjgeHbnqkth6k3M8mkUv3oBjdt2WjPssxGopKWc7O+OrXYOfIr9hwmfnm7BN92ytSpYoS7uDOWv9TRkVnt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297562; c=relaxed/simple;
	bh=rtMmr9oYTOiEfygUa5LZF2wrhp84NFWX5euJPzutAuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzcKEwH8xs1p22gyeu7wtEiQMhQyze9X8OVgANsJ5z2ujN5AwssaZNvzFRoP4oglHCwrSaw9qgL6XsazqMHEqLRO2gmWuRYvLpO7Iwm3FbMUmF5Ihg0nEFid/5w4MVjJt2knnvVxKn39+rMEj7OH8dNnibNZ3MVTKc6swRu8qDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCkYYS+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5582C4CEF4;
	Wed, 23 Jul 2025 19:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753297562;
	bh=rtMmr9oYTOiEfygUa5LZF2wrhp84NFWX5euJPzutAuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCkYYS+EhH8AbsltykUoB1MqHxQUoQdtHUg1CB4c4YAbn9y1sCHvLw3L1SA67k0Yn
	 E7jgA2HxmuuVywrOf44X9D5JJbmWcSsUISY6JfJDUWJ+Jh76818dW0rQv00DQ8zY62
	 TAAaw09jeEr8GRrNxcpOdaS0Q3eJGfWk66kBSW/cx+lbnfNVj0C5z+9CQ8bGUQp4Tj
	 4vCIwRM7MEII8Lb9naltPOSSLDp6ee20I7CKOFLe6QuYqEf3jQ89uYKwbFJlne9rWc
	 Et2DXvfPovaJGO0bHgFw4zzXc29KH+2sHwo4QShK11yDKAb5f4aeQtDOvSHpr9tfW2
	 wODBvXEe/R2UA==
Date: Wed, 23 Jul 2025 15:06:00 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/5] NFSD: filecache: add STATX_DIOALIGN and
 STATX_DIO_READ_ALIGN support
Message-ID: <aIEymBV9tIynQIE9@kernel.org>
References: <20250723154351.59042-1-snitzer@kernel.org>
 <20250723154351.59042-2-snitzer@kernel.org>
 <41640810d384003d1e5ac5c9833d44fab7f101ab.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41640810d384003d1e5ac5c9833d44fab7f101ab.camel@kernel.org>

On Wed, Jul 23, 2025 at 02:58:19PM -0400, Jeff Layton wrote:
> On Wed, 2025-07-23 at 11:43 -0400, Mike Snitzer wrote:
> > Use STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get and store DIO
> > alignment attributes from underlying filesystem in associated
> > nfsd_file.  This is done when the nfsd_file is first opened for
> > a regular file.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/filecache.c | 32 ++++++++++++++++++++++++++++++++
> >  fs/nfsd/filecache.h |  4 ++++
> >  fs/nfsd/nfsfh.c     |  4 ++++
> >  3 files changed, 40 insertions(+)
> > 
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 8581c131338b..5447dba6c5da 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -231,6 +231,9 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
> >  	refcount_set(&nf->nf_ref, 1);
> >  	nf->nf_may = need;
> >  	nf->nf_mark = NULL;
> > +	nf->nf_dio_mem_align = 0;
> > +	nf->nf_dio_offset_align = 0;
> > +	nf->nf_dio_read_offset_align = 0;
> >  	return nf;
> >  }
> >  
> > @@ -1048,6 +1051,33 @@ nfsd_file_is_cached(struct inode *inode)
> >  	return ret;
> >  }
> >  
> > +static __be32
> > +nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
> > +{
> > +	struct inode *inode = file_inode(nf->nf_file);
> > +	struct kstat stat;
> > +	__be32 status;
> > +
> > +	/* Currently only need to get DIO alignment info for regular files */
> > +	if (!S_ISREG(inode->i_mode))
> > +		return nfs_ok;
> > +
> > +	status = fh_getattr(fhp, &stat);
> > +	if (status != nfs_ok)
> > +		return status;
> > +
> > +	if (stat.result_mask & STATX_DIOALIGN) {
> > +		nf->nf_dio_mem_align = stat.dio_mem_align;
> > +		nf->nf_dio_offset_align = stat.dio_offset_align;
> > +	}
> > +	if (stat.result_mask & STATX_DIO_READ_ALIGN)
> > +		nf->nf_dio_read_offset_align = stat.dio_read_offset_align;
> > +	else
> > +		nf->nf_dio_read_offset_align = nf->nf_dio_offset_align;
> > +
> > +	return status;
> > +}
> > +
> >  static __be32
> >  nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
> >  		     struct svc_cred *cred,
> > @@ -1166,6 +1196,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
> >  			}
> >  			status = nfserrno(ret);
> >  			trace_nfsd_file_open(nf, status);
> > +			if (status == nfs_ok)
> > +				status = nfsd_file_getattr(fhp, nf);
> 
> 
> Doing a getattr alongside every open could be expensive in some
> configurations (like reexported NFS). We may want to skip doing this
> getattr this if O_DIRECT isn't is use. Is that possible?

Good point, yes, should be easy enough.  Will depend on the debugfs
knobs, so will tack a patch on at the end.

Thanks,
Mike

