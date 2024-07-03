Return-Path: <linux-nfs+bounces-4582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 111079252C1
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 07:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2443B22187
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 05:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F092745B;
	Wed,  3 Jul 2024 05:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1ghJg32L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44E61803E
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 05:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719983100; cv=none; b=UV12GkAK4xufH1FhoWH9FU41SZf0bwzKWcjailDb60eUaB7feD5YMy2P2mNxrdEUlD32OYcKyy996ZkBtrgMIjBeLll3FtCqHpTm+f0W95s6hA2XK34rQ/HpTtYLDvfhM285ssKZgPYbhpWjBbBTKdixMRfrgSBMO8Yl1DZaqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719983100; c=relaxed/simple;
	bh=4OR3+iZbkLiUr4r3XJqm9aXMyimbJeb6Lt4nIiN/khk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdpaJWqRfl986qquc01wmk7AhWBJlbbuQ3JgPYIwuUk2HdqleZFBM60CISO9+evWiR+4OYJumR1vm68iE+tCrnS4kenK4HUXbMXjutLvZTFXMLQYfBvz3G9/qaGB5utOEjWhQlc9WfjOirWdiP/Vwq9MQEw711wgb1Mj6Y6soW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1ghJg32L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4DCW6nAFq3SgHZli+iFm0IYFOaebKPN4NBL3UzDZVTI=; b=1ghJg32LJtVq104QNhv2BfL8nE
	uO/XY6/PC5oPDkDnOglmzRrvT35AgxA4/9hTFM4AHVTef2ZQ/U9RW+rY7feuh4+MzWiNUHTdnxppA
	LgdF61r70THmFB9TVZlNOjPKeQcPEZ7JfXSww3tbCbj19gpiajkld1ldJMsulHABn8GcxLWoCRQ1y
	3f4ld8etq82dyPzmXSoa2qpYZSoRU+PQjlThdVeXGsv7KkO0irP2oOeLjcANJKIZbNaUTJcgq+cc6
	mrXvW+oTdLblxU9dAEk4WaEPlod4dCGPxth26J9I4nr2svIr00FT4/vyyfdWqcNIMTDGecZZ6agti
	AraB9wQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOsAq-000000090vk-0sbA;
	Wed, 03 Jul 2024 05:04:56 +0000
Date: Tue, 2 Jul 2024 22:04:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>,
	"snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoTb-OiUB5z4N8Jy@infradead.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 02, 2024 at 06:06:09PM +0000, Chuck Lever III wrote:
> To make it official, for v11 of this series:
> 
>   Nacked-by: Chuck Lever <chuck.lever@oracle.com>

We've also not even looked into tackling the whole memory reclaim
recursion problem that have historically made local loopback
network file system an unsupported configuration.  We've have an
ongoing discussion on the XFS list that really needs to to fsdevel
and mm to make any progress first.  I see absolutely not chance to
solved that in this merge window.  I'm also a bit surprised and
shocked by the rush here.


