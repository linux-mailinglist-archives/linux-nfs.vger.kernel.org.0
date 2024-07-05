Return-Path: <linux-nfs+bounces-4630-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0B5928162
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 07:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59D91F211D0
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 05:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7679C27452;
	Fri,  5 Jul 2024 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RYPhi+IR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18B4C70
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720156703; cv=none; b=fLY9J2qXkAQWxoHQTCO+r5oqkiVB8NrZn1q8CwodZ4TLBs6qag7a2LbXEMTzC3gWym/iW9VAQiLH9y0s3rG5xRtjLIXfmmzr79KluTqzvWc2JLyefUeeu3eJChQpmRbEseDlgt5xInqgpKC/IKDSDCtKihY3WcMWygyjmJ7//QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720156703; c=relaxed/simple;
	bh=MZybyo/5eUQeEKpdpdA4WwjA0x8ItqgvuRf9Tgb8Eh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/JpOvawKse8BewZGN8qCT4pLVrKdC4Y5Gyb/gfbf9xr/5kx2UjHzkN1K/fnI1Tls1Z77Jb1Hsp9Ic06negOncvUt78tUoxiy8Tkan6J3ZSAzjBzHFiLkVz7tvT/szAlWpNvplQHOIgLye2WRlMBBgfPyacadr1ywxrGagbGxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RYPhi+IR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f94O0eiqWAsOk+riNCK06aeTfoDPZGh8nx8gC7Nd+ow=; b=RYPhi+IR4PDvuuii8A3+q8fhtY
	lI0YuXelPmZ4B/OaVU5qRUPwGzQX1cMB8Hd18zy+W5jglxH9MUuFknL4WD0f/6oXvVFmqHjxy8dj1
	3RQ7V3eX1oGY8/7r6lzltKW0v//ox9Is5jsbi9SPg9tj9NSvPnfAUxUs5+QDdhXj30ph4Cx74F2/P
	Jbjg9U8xSBTIg7Ssr9DbmVHP4mDbe8OLGAQTm5gwdGCL/LvnPJyf8M4Ed8V5GOfWeHBAhzxJztEkU
	p8rbSbYTb34fIsAwJv7cF1XsrlQHjatXLUYbVy/4X9hvtwNpJWXYuYYdfsmOaSssnsJXCQSYH6WKh
	3lUJ6bIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPbKp-0000000EvxL-0aJe;
	Fri, 05 Jul 2024 05:18:15 +0000
Date: Thu, 4 Jul 2024 22:18:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoeCFwzmGiQT4V0a@infradead.org>
References: <ZoTb-OiUB5z4N8Jy@infradead.org>
 <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org>
 <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
 <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
 <ZoY6e-BmRJFLkziG@infradead.org>
 <ZobqkgBeQaPwq7ly@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZobqkgBeQaPwq7ly@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 04, 2024 at 02:31:46PM -0400, Mike Snitzer wrote:
> Some new layout misses the entire point of having localio work for
> NFSv3 and NFSv4.  NFSv3 is very ubiquitous.

I'm getting tird of bringing up this "oh NFSv3" again and again without
any explanation of why that matters for communication insides the
same Linux kernel instance with a kernel that obviously requires
patching.  Why is running an obsolete protocol inside the same OS
instance required.  Maybe it is, but if so it needs a very good
explanation.

> And in this localio series, flexfiles is trained to use localio.
> (Which you apparently don't recognize or care about because nfsd
> doesn't have flexfiles server support).

And you fail to explain why it matters.  You are trying to sell this
code, you better have an explanation why it's complicated and convoluted
as hell.  So far we are running in circles but there has been no clear
explanation of use cases.

> > > Can the client use its localio access to bypass that since it's not
> > > going across the network anymore? Maybe by using open_by_handle_at on
> > > the NFS share on a guessed filehandle? I think we need to ensure that
> > > that isn't possible.
> > 
> > If a file system is shared by containers and users in containers have
> > the capability to use open_by_handle_at the security model is already
> > broken without NFS or localio involved.
> 
> Containers deployed by things like podman.io and kubernetes are
> perfectly happy to allow containers permission to drive knfsd threads
> in the host kernel.  That this is foreign to you is odd.
> 
> An NFS client that happens to be on the host should work perfectly
> fine too (if it has adequate permissions).

Can you please stop the personal attacks?  I am just stating the fact
that IF the containers using the NFS mount has access to the exported
file systems and the privileges to use open by handle there is nothing
nfsd can do about security as the container has full access to the file
system anyway.  That's a fact and how you deploy the various containers
is completely irrelevant.  It is also in case that you didn't notice
it last time about the _client_ containers as stated by me and the
original poster I replied to.

> > > I wonder if it's also worthwhile to gate localio access on an export
> > > option, just out of an abundance of caution.
> > 
> > export and mount option.  We're speaking a non-standard side band
> > protocol here, there is no way that should be done without explicit
> > opt-in from both sides.
> 
> That is already provided my existing controls.  With both Kconfig
> options that default to N, and the ability to disable the use of
> localio entirely even if enabled in the Kconfig:
> echo N > /sys/module/nfs/parameters/localio_enabled

And all of that is global and not per-mount or nfsd instance, which
doesn't exactly scale to a multi-tenant container hosting setup.


