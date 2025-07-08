Return-Path: <linux-nfs+bounces-12949-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB6AAFD942
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 23:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591AE7ACB3B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243D244E8C;
	Tue,  8 Jul 2025 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV0WirF3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A637242D7C;
	Tue,  8 Jul 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008843; cv=none; b=BO9KDde8q2S/WC/3c9Mf1PdqsAAMJfQPvcsl3UgeOmV3TqUmxMcJh2y2tCKhrYOjtC3GzZ5ppimtq4c1e3fYSjrdb8ezVbJmWWvdRG1blOb4nxxnyAmu6HFnpkMcZqHWaZMsMFWOuUFHCre79aEtid+AHGgAy5jgLZuDW/5FQEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008843; c=relaxed/simple;
	bh=rQ6FdHEkZzA4N5LO7jbIVHziXBiZRXcsh1amPwT9KdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZznZAIk407SfK4GS+uRSRBuvYoKJkdo/SwKF5teFDEfYmpB9ElwFGuxxE3IpjSWAlwtJoEY15yOmbGWDkJ9CeBzBfFkzZ0xE3pS/Q+ORMkpGQ+p0BaEOprMA8P9wgLsJrOB66UbvSg13vTU9ZpB7xn5FCQcy+QTiW77K1PPiZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV0WirF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EA8C4CEED;
	Tue,  8 Jul 2025 21:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752008842;
	bh=rQ6FdHEkZzA4N5LO7jbIVHziXBiZRXcsh1amPwT9KdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MV0WirF3396cOiUBxHaRxIVm3yZrZrEbRNFyWS0DYvdpmhL+30dsGXRidZLNaiiEo
	 zhtwOvNhXPO7XE7lfiB3FyLPdXZ/hs9WI9uhXLpm2C/ZaZ9zXwkw5b7IYsg/+IW4hS
	 wna8filaKOO2vVOLBLVtdRwvHSaS5kCY5XwHwZyukzHZivdOkstuNriQ41rcnvzZaN
	 3fI98dmVTyKrpNuDGdw46LIXuD4s/JkXMQgqtQHblPBWa4qfPSwsytIQd/g2jwDHeG
	 1CboXzmaujqor9WIeNgGJ+ozIeKnoI0wawd7fWYhrpzDfXYHjI2vnq9PYTx+uaOUyZ
	 MygkjqLGWer3g==
Date: Tue, 8 Jul 2025 17:07:20 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] nfsd: call generic_fadvise after v3 READ, stable
 WRITE or COMMIT
Message-ID: <aG2IiOK2ufezUm-k@kernel.org>
References: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
 <20250703-nfsd-testing-v1-2-cece54f36556@kernel.org>
 <520bd301-4526-4364-bbfa-5f591ab8f60a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <520bd301-4526-4364-bbfa-5f591ab8f60a@oracle.com>

On Thu, Jul 03, 2025 at 04:07:51PM -0400, Chuck Lever wrote:
> On 7/3/25 3:53 PM, Jeff Layton wrote:
> > Recent testing has shown that keeping pagecache pages around for too
> > long can be detrimental to performance with nfsd. Clients only rarely
> > revisit the same data, so the pages tend to just hang around.
> > 
> > This patch changes the pc_release callbacks for NFSv3 READ, WRITE and
> > COMMIT to call generic_fadvise(..., POSIX_FADV_DONTNEED) on the accessed
> > range.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/debugfs.c  |  2 ++
> >  fs/nfsd/nfs3proc.c | 59 +++++++++++++++++++++++++++++++++++++++++++++---------
> >  fs/nfsd/nfsd.h     |  1 +
> >  fs/nfsd/nfsproc.c  |  4 ++--
> >  fs/nfsd/vfs.c      | 21 ++++++++++++++-----
> >  fs/nfsd/vfs.h      |  5 +++--
> >  fs/nfsd/xdr3.h     |  3 +++
> >  7 files changed, 77 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > index 84b0c8b559dc90bd5c2d9d5e15c8e0682c0d610c..b007718dd959bc081166ec84e06f577a8fc2b46b 100644
> > --- a/fs/nfsd/debugfs.c
> > +++ b/fs/nfsd/debugfs.c
> > @@ -44,4 +44,6 @@ void nfsd_debugfs_init(void)
> >  
> >  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
> >  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
> > +	debugfs_create_bool("enable-fadvise-dontneed", 0644,
> > +			    nfsd_top_dir, &nfsd_enable_fadvise_dontneed);
> 
> I prefer that this setting is folded into the new io_cache_read /
> io_cache_write tune-ables that Mike's patch adds, rather than adding
> a new boolean.
> 
> That might make a hybrid "DONTCACHE for READ and fadvise for WRITE"
> pretty easy.

That'd be really easy.  Jeff, maybe have a look to rebase your changes
on this patchset:
https://lore.kernel.org/linux-nfs/20250708160619.64800-1-snitzer@kernel.org/

Ontop of this patch in particular:
https://lore.kernel.org/linux-nfs/20250708160619.64800-8-snitzer@kernel.org/

My git branch with this patchset at the tip is available here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=kernel-6.12.24/nfsd-testing-snitm

Mike

