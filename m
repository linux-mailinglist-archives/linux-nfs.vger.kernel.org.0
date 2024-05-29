Return-Path: <linux-nfs+bounces-3463-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C01C8D2D2F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 08:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AC5B2772E
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 06:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166852F56;
	Wed, 29 May 2024 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2oUD228m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D038DE8
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964024; cv=none; b=QkH4Uus1m/0Sh8+8tnWWaOe7sdHqv9gjh7KoHKfWIO9D5ofUKz4QUa8ggqiUG8zoMmJWkgSd9x4Xe9ZKLtFts7Hs+Pwc4/Qa3npT5+THbOi3CecEy8++4i+6lJjCTO3uQss4Ylr+fikwTWwA071yROeJUcMZMaw/14j38PfE30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964024; c=relaxed/simple;
	bh=53j3DODW1KM0Euedr+NFYv+aOrxPzLAhbHZIyUehbGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtXzmJ3cisfK2ggeDUJv2cAdbMsGtopX+04RePF4mJw0EhUplyJpeRD+ysc9P/HutPclh5vKvI3t7+WI2WFkinxDtMdq5KIvIV9yYXSLZxddG6xVWGvHGpuyhfHmqpWS15HpdaagVeOTGvPwYRR1qtE+/QafByR/bXTueUjKwWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2oUD228m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OA0pyDnh6NUQtir3uPzdSdyscgY2aj16Q/SiBWX42ys=; b=2oUD228mjN67/265L9jyOHWA9J
	rH15eBEK+e1UHwW/xctagSCfGQLTWT/XCT4QLKIfirSseIMn2kRfXc15uOXyLAlqd7haFH//d/6TV
	FqXuudSbsEk40WjnV0/G/VvUOvd5xhWxl9kViefsf08MnNk5UnFAQY/tEa0209d80m4Hs1XvWUISL
	krNEqDBSdwCD5HDZLYvIr89HaGIH0lKvwxgdT9cv53+2dP3s/UE4exFyD1Ys5H/j4+hLjAZtm4eMO
	j5A1fTwdfpzI7tAJ2Q8W+uEDF5EJjZPV7h31ecbMddg6a2/bzXdH5v125EY1jCeS3gNNXcx/AAsoK
	EzhEBUDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCCm6-000000030PY-1XW5;
	Wed, 29 May 2024 06:27:02 +0000
Date: Tue, 28 May 2024 23:27:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Shelton <dan.f.shelton@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RFC2224 support in Linux /sbin/mount.nfs4?
Message-ID: <ZlbKtv4asoSjKdbq@infradead.org>
References: <CAAvCNcCTWbU-ejURuUC0_xhcoU3GF+2jX28rV4+2cKgfO5Lqxg@mail.gmail.com>
 <619bbf23-dbfe-4c26-adb9-1cc89f3f22a2@redhat.com>
 <CAAvCNcCGhZ917yerEOMcEEj7+_Yz5by8en2F4Yr5zLk0iQEGjg@mail.gmail.com>
 <ee3805865e12f8ed2f82f7e99e33598f0bcc6667.camel@kernel.org>
 <CAAvCNcD0MTwBthZE3KPAoG=_gsVY=tNS5D4K+UV6+9jMJPs1Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAvCNcD0MTwBthZE3KPAoG=_gsVY=tNS5D4K+UV6+9jMJPs1Og@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 29, 2024 at 05:02:00AM +0200, Dan Shelton wrote:
> One syntax across all platforms?

And what exatly would be the use case for that?  It's not like
mounting file systems is portable in any kind of way.

> 
> The ms-nfs41-client (ref below) has a parser in nfs_mount.exe,

Good for them if they care, but of zero relevance for Linux.


