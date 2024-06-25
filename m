Return-Path: <linux-nfs+bounces-4288-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABDD915DDF
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 06:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16155283BEE
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 04:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E84142658;
	Tue, 25 Jun 2024 04:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0/N+ZWT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DA71411DE
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 04:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719291571; cv=none; b=nhaslNG1vz+qv54hEQxfTkb/qx987DMKq0NTzJFJW3zze360MYLQCBGecAdO/p4+aZdU/b2XZ/11POxmuPLr36IenOQgxZ9PmVyuh74QXmZ+q9IvF4aACEPAL9csZvw3/Iy8ruEVroN1QoW3H1n7G0awKtm/PrSxR5Mw9B0mAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719291571; c=relaxed/simple;
	bh=cJS/5xyHvsDMjCfHrDXor6UMm2Y/ZfOHKvCIb8UgFhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdB0Pae5IC/WJV3edCQ2lYjWotpM295KPdcfEBh7lOHhgtkpfNKbLe/SgUAXe6hVh340rgEbkugJ+xf5kSv5U5D+ywUGWUa385tirqTH0Z2EvdXrUjno1J8OYmhDudIG8ZduW3PMU+pYOo8TIzcEHmwk6Let9crGnmYa0PKrkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0/N+ZWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F741C4AF0A;
	Tue, 25 Jun 2024 04:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719291571;
	bh=cJS/5xyHvsDMjCfHrDXor6UMm2Y/ZfOHKvCIb8UgFhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0/N+ZWTFbazxN9rZasZJBAJbMuh2YGdasni07oAi28NNdz+H+Z9AX6xA6VlKMuHD
	 jYT3poCeFEqqxNCEUTuDSlHhjEY33Qny7wZK9Qe2dg3BbD4uqnRA9PEnTlMftrUXW7
	 S0YnNTomfUn2fz9frYmQ1MM9EUHuvzLyLpar84NQQiGwP0jjSjiBAPPciA7kHMw05O
	 Cj4Dq47nHAJCZuRlT1GfzjkAvGWeytiLsS9dzEuJI7CLsPyK2KcdbbAh0TqDCRxIBG
	 JjdAB11TaYoRNLHZdnifFcLJm9GyhxNRd4aelgJFDXfChx1M8B5u4zh6tTaF/Otm9N
	 7K3nH6boQtbBA==
Date: Tue, 25 Jun 2024 00:59:30 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v6 06/18] nfs/nfsd: add "localio" support
Message-ID: <ZnpOsggaI3pC0ani@kernel.org>
References: <>
 <ZnYMh35G6WC1YgCA@kernel.org>
 <171918165963.14261.959545364150864599@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171918165963.14261.959545364150864599@noble.neil.brown.name>

On Mon, Jun 24, 2024 at 08:27:39AM +1000, NeilBrown wrote:
> On Sat, 22 Jun 2024, Mike Snitzer wrote:
> > On Fri, Jun 21, 2024 at 04:08:20PM +1000, NeilBrown wrote:
> > > 
> > > Both branches of this if() do exactly the same thing.  iov_iter_advance
> > > is a no-op if the size arg is zero.
> > 
> > iov_iter_advance doesn't look to be a no-op if the size arg is zero.
> 
> void iov_iter_advance(struct iov_iter *i, size_t size)
> {
> 	if (unlikely(i->count < size))
> 		size = i->count;
> 	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
> 		i->iov_offset += size;
> 		i->count -= size;
> 	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
> 		/* iovec and kvec have identical layouts */
> 		iov_iter_iovec_advance(i, size);
> 	} else if (iov_iter_is_bvec(i)) {
> 		iov_iter_bvec_advance(i, size);
> 	} else if (iov_iter_is_discard(i)) {
> 		i->count -= size;
> 	}
> }
> 
> This adds "size" to offset, and subtracts "size" from count.  For iovec
> and bvec it is a slightly complicated dance to achieve this, but that is
> the net result.
> So if "size" is zero there is no change to the iov_iter.  Just some
> wasted cycles.  Do those cycles justify the extra conditional branch?  I
> don't know.  I would generally prefer simpler code which is only
> optimised with evidence.  Admittedly I don't always follow that
> preference myself and I won't hold you to it.  But I thought the review
> would be incomplete without mentioning it.

OK, thanks.

> > > > +static void
> > > > +nfs_get_vfs_attr(struct file *filp, struct nfs_fattr *fattr)
> > > > +{
> > > > +	struct kstat stat;
> > > > +
> > > > +	if (fattr != NULL && vfs_getattr(&filp->f_path, &stat,
> > > > +					 STATX_INO |
> > > > +					 STATX_ATIME |
> > > > +					 STATX_MTIME |
> > > > +					 STATX_CTIME |
> > > > +					 STATX_SIZE |
> > > > +					 STATX_BLOCKS,
> > > > +					 AT_STATX_SYNC_AS_STAT) == 0) {
> > > > +		fattr->valid = NFS_ATTR_FATTR_FILEID |
> > > > +			NFS_ATTR_FATTR_CHANGE |
> > > > +			NFS_ATTR_FATTR_SIZE |
> > > > +			NFS_ATTR_FATTR_ATIME |
> > > > +			NFS_ATTR_FATTR_MTIME |
> > > > +			NFS_ATTR_FATTR_CTIME |
> > > > +			NFS_ATTR_FATTR_SPACE_USED;
> > > > +		fattr->fileid = stat.ino;
> > > > +		fattr->size = stat.size;
> > > > +		fattr->atime = stat.atime;
> > > > +		fattr->mtime = stat.mtime;
> > > > +		fattr->ctime = stat.ctime;
> > > > +		fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
> > > 
> > > This looks wrong for NFSv4.  I think we should use
> > > nfsd4_change_attribute().
> > > Maybe it isn't important, but if it isn't I'd like to see an explanation
> > > why.
> > > 
> > > > +		fattr->du.nfs3.used = stat.blocks << 9;
> > > > +	}
> > > > +}
> > 
> > Not following, this is client code so it doesn't have access to
> > nfsd4_change_attribute().
> 
> This is nfs-localio code which blurs the boundary between server and
> client...
> 
> The change_attr is used by NFS to detect if a file might have changed.
> This code is used to get the attributes after a write request.
> NFS uses a GETATTR request to the server at other times.  The
> change_attr should be consistent between the two else comparisons will
> be meaningless.
> 
> So I think that nfs_get_vfs_attr() should use the same change_attr as
> the one that would be used if the NFS GETATTR request were made.
> For NFSv3, that is nfs_timespec_to_change_attr() as you have.
> For NFSv4 it is something different.
> 
> I think that having inconsistent change_attrs could cause NFS to flush
> its page cache unnecessarily.  As it can read directly from the
> server-side where is likely is cached, that might not be a problem.  If
> that reasoning does apply it should be explained.
> 
> However there is talk of exporting the "i_version" number to userspace
> through xattr.  For NFS that is essentially the change_attr. If we did
> that we would really want to keep the number consistent.
> 
> We could easily move nfsd4_change_attribute() into nfs_common or even
> make it an inline in some common include file.  It doesn't use any nfsd
> internals.

OK, makes sense, thanks for clarifying.  I'll fix it for v8.

Mike

