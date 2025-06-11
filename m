Return-Path: <linux-nfs+bounces-12294-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CF4AD4C1C
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 08:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4EE1787E0
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 06:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67367189B8B;
	Wed, 11 Jun 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nRvhPFLH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CB91494A8
	for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749624915; cv=none; b=bqVPRJF1zqtb0UKHYeHXdGnIojMlz6bRzBI9H7bdZDfFJTGqeNCvxYE+kS2cI1MiUQtmvdt6vEEaNinXWwf183moWd8LztDu9p2eCAy+Crs5cTUXStbnf+hHamSqT3RKT3Gwdr1oF4oOcCeSq27yIEcUtQnc1F0XTkgc7vRPkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749624915; c=relaxed/simple;
	bh=vPWLyJMTO+rlyNj8Ejz28nXKtwkRkwH2Rs6aHVchmro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knSEfdx9AanfG8L5cV7upj1n/ByLMC00xbNp7Y0gP89uQMaJrG8wH/rCyOjvfolgnIcSZAkvhUf6YsuV3CMQ3TSbvJTAbloMCqR/2gmcGdxtgsxEifUJYINSJ9luI1Eyi7WJBs9weppA+pKJPqxDJfsGIIvdFx3Q7Q/DJUuoBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nRvhPFLH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I1ziS8F7zaJPJwhquxHX9AhnagS0bBxQq0YpSnmY6BI=; b=nRvhPFLHQyAa9q4NtI2mgtaHW0
	t4YM6T1i3I3ubez/dUztiPSDbi/IEYTF+9XbfudD4vVY0CIX+YJPUgCUd9f20XACXBYmsdtSsciWa
	qIJWbYVLllJxQo410dMV6nwaN82IyElBC02h4gJDvNlXSBKWdtyuqZseIg95QBg0XW+DhL7O6QKdM
	q7YCTj88jMHjCTrywm8JCXBuaC9nqqciYw4gUu26cttzqR4pBwexgjaNG/1Kd8BQCVjsDEVDSiQYP
	SUclXiwrAv7ViIF1P/6kB21OcMVNwkgVqDSA+HQdRHY+wUJLgNj61RZMrPAGYlw6WaRebjbLUEnkU
	NmGvI3dA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPFMb-00000009307-0cVU;
	Wed, 11 Jun 2025 06:55:09 +0000
Date: Tue, 10 Jun 2025 23:55:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	"J . Bruce Fields" <bfields@fieldses.org>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Implement large extent array support in pNFS
Message-ID: <aEkoTdJttLesPv6M@infradead.org>
References: <20250604130809.52931-1-sergeybashirov@gmail.com>
 <aEBeJ2FoSmLvZlSc@infradead.org>
 <uegslxlqscbgc2hkktaavrc5fjoj5chlmfdxhltgv5idzazm3h@irvki3iijaw4>
 <aEfE-r2dkuDRUKsq@infradead.org>
 <75iqhi3to6gohuo2o4h3cewslcjzsfyrl7l7x2x3qyiaaecjci@uwoeqjubvqft>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75iqhi3to6gohuo2o4h3cewslcjzsfyrl7l7x2x3qyiaaecjci@uwoeqjubvqft>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 06:24:03PM +0300, Sergey Bashirov wrote:
> On Mon, Jun 09, 2025 at 10:39:06PM -0700, Christoph Hellwig wrote:
> > On Tue, Jun 10, 2025 at 03:36:49AM +0300, Sergey Bashirov wrote:
> > > Together with Konstantin we spent a lot of time enabling the pNFS block
> > > volume setup. We have SDS that can attach virtual block devices via
> > > vhost-user-blk to virtual machines. And we researched the way to create
> > > parallel or distributed file system on top of this SDS. From this point
> > > of view, pNFS block volume layout architecture looks quite suitable. So,
> > > we created several VMs, configured pNFS and started testing. In fact,
> > > during our extensive testing, we encountered a variety of issues including
> > > deadlocks, livelocks, and corrupted files, which we eventually fixed.
> > > Now we have a working setup and we would like to clean up the code and
> > > contribute it.
> > 
> > Can you share your reproducer scripts for client and server?
> 
> I will try. First of all, you need two VMs connected to the same network.
> The hardest part is somehow to connect a shared block device to both VMs
> with RW access.

I know the basic setup :)

> On the client side, you need to have the same /dev/vda device available,
> but not mounted. Additionally, you need the blkmapd service running.

blkmapd is only needed for the block layout, which should generally be
avoided as it can't be used reliably because working fencing is
almost impossible.

> This should create 2.5k extents:
> fio --name=test --filename=/mnt/pnfs/test.raw --size=10M \
>     --rw=randwrite --ioengine=libaio --direct=1 --bs=4k  \
>     --iodepth=128 --fallocate=none

Thanks!  We should find a way to wire up the test coverage
somewhere, e.g. xfstests.

> Troubleshooting. If any error occurs, then kernel falls back to NFSv3.

That should really be NFSv4.

> the client code also has problems with the block extent array. Currently
> the client tries to pack all the block extents it needs to commit into
> one RPC. And if there are too many of them, you will see
> "RPC: fragment too large" error on the server side. That's why
> we set rsize and wsize to 1M for now.

We'll really need to fix the client to split when going over the maximum
compoung size.

> Another problem is that when the
> extent array does not fit into a single memory page, the client code
> discards the first page of encoded extents while reallocating a larger
> buffer to continue layout commit encoding. So even with this patch you
> may still notice that some files are not written correctly. But at least
> the server shouldn't send the badxdr error on a well-formed layout commit.

Eww, we'll need to fix that as well.  Would be good to have a reproducer
for that case as well.

> > Btw, also as a little warning:  the current pNFS code mean any client
> > can corrupt the XFS metadata.  If you want to actually use the code
> > in production you'll probably want to figure out a way to either use
> > the RT device for exposed data (should be easy, but the RT allocator
> > sucks..), or find a way to otherwise restrict clients from overwriting
> > metadata.
> 
> Thanks for the advice! Yes, we have had issues with XFS corruption
> especially when multiple clients were writing to the same file in
> parallel. Spent some time debugging layout recalls and client fencing
> to figure out what happened.

Normal operation should not cause that, what did you see there?

I mean a malicious client targeting metadata outside it's layout.


