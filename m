Return-Path: <linux-nfs+bounces-10368-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFF8A46630
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 17:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B437819C57D6
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB5121C191;
	Wed, 26 Feb 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJyw6qcw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572519CC3E
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585309; cv=none; b=I+Nzwdkabe5DKfek6I/ilpHbu0YeGCElvIYWNggaro03AIwhuxF471xQ/1XElwpM1rfFoVSO9jjTU5VQMFI3/CehSEofJR76vA2ZIU3MeGqSXaHYyf2GBP2FskwZkj/0BnLAPslWe5iWiCJYO6AwhNd0gLNeh7EK949aXRv2Nqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585309; c=relaxed/simple;
	bh=PRveJwF6nYxWuskf47EdIGKLYaRhkKXstkEM2GvVTqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmTVxiY+HetNHsdC/lyC/7ZUuZ3EO3FfGDO5CV8ODo7d6PDBgVfCYmN3qgj8TN5ZzLXs8V5rQm83YjluzZkF1oD3pMavvqco9Btd8sb5jrUerxzqHTJZgAfVeFRVbXw2uZdwtPefP/jBnbOFAsricFEBsmxvqHmkNScm8kFU19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJyw6qcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56952C4CED6;
	Wed, 26 Feb 2025 15:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740585308;
	bh=PRveJwF6nYxWuskf47EdIGKLYaRhkKXstkEM2GvVTqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJyw6qcwZQbITcKq+7Fa1+BvfEsObUzTuNcxk7Tn5Voc9l7qJaMt9EUfgnioCwe10
	 AprLwwgCpKJKQrC/aOHM26SDc7HUGjuW9Cns9SQMh4mmj9o0OCTHEyjDp/2vXU+FWE
	 g0iKFBInNCOUM7mqKzxx1VX1YbfXx/YpIo4Dh7p2MXCoScO9ZAi7L7LsPR7UxiJfWl
	 YIFxmKl6LPKf9b6sKGsDrc+hxii5xpHwmlRYsOFkHZqqP7WFWshT6BUf5VdPdZSTy7
	 Kgr7EgaQiyiuIzmCG3i/yIj6BVDYLobha89nFxsh1/IbKP1UhzF7mxdkonXSVItcwM
	 XQhi184IKiXiQ==
Date: Wed, 26 Feb 2025 10:55:07 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH for-akpm for-6.14-rcX] NFS: fix nfs_release_folio() to
 not call nfs_wb_folio() from kcompactd
Message-ID: <Z785W_G-9PZitxUz@kernel.org>
References: <20250225003301.25693-1-snitzer@kernel.org>
 <Z78sA-7_u5SyuFSw@infradead.org>
 <Z782z2suQAtBcS9j@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z782z2suQAtBcS9j@kernel.org>

On Wed, Feb 26, 2025 at 10:44:15AM -0500, Mike Snitzer wrote:
> On Wed, Feb 26, 2025 at 06:58:11AM -0800, Christoph Hellwig wrote:
> > On Mon, Feb 24, 2025 at 07:33:01PM -0500, Mike Snitzer wrote:
> > > Add PF_KCOMPACTD flag and current_is_kcompactd() helper to check for
> > > it so nfs_release_folio() can skip calling nfs_wb_folio() from
> > > kcompactd.
> > > 
> > > Otherwise NFS can deadlock waiting for kcompactd enduced writeback
> > > which recurses back to NFS (which triggers writeback to NFSD via
> > > NFS loopback mount on the same host, NFSD blocks waiting for XFS's
> > > call to __filemap_get_folio):
> > 
> > Having a flag for a specific kernel thread feels wrong.  I'm not an
> > expert in this area, but as fast as I can tell the problem is that
> > kcompactd should be calling into ->release_folio without __GFP_IO
> > set.
> 
> We can easily remove PF_KCOMPACTD and current_is_kcompactd() if/when
> more analysis and a cleaner fix emerges (from you, mm experts, etc).
> I'm not saying you're wrong about GFP flags needing to be clamped by
> kcompactd's call to ->release_folio, but it seems more finishing work
> needed.
> 
> As you can tell from my patch, we already have kswapd specialization
> with PF_KSWAPD and current_is_kswapd().  A consumer of large folios
> knowing that it being called as kcompactd is useful, hence my fix for
> deadlock seen with NFS loopback mounts on memory constrained systems.

Also, as followup to my fix: Trond and I have started exploring giving
NFS the ability to do more meaningful work on behalf of kswapd and
kcompactd from ->release_folio (rather than simply punt, by returning
false, like your proposed GFP flag clamping would do), see:

https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=kernel-6.12/nfs-next&id=b8fd0d3864e4bd43eaca1045002e89bede8fd91f

(I'm still working on testing/refining this patch...)

