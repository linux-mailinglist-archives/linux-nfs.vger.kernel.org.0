Return-Path: <linux-nfs+bounces-4621-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BC1926F48
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 08:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E1C1F21D0A
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 06:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785161A3BAC;
	Thu,  4 Jul 2024 06:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qY7LH6KH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267CF1A3BAB
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jul 2024 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072902; cv=none; b=hyGZUDzRvyYlulMh8Td+wTujQzD1RTOaz1VrLDRPjcc6bRNvHU1dCO1ivYZQ8Fa5wY5dB0zbHIUwzE7VpmfxzaZgOdssZEZ/UiAsn0GVSOxB0VqC0KfsLaA3g7uE9ChBO8rGjAfSCLxSwkdnOEIOjGKYo01DfalGaxn/xCOGMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072902; c=relaxed/simple;
	bh=kgOLwKc2dEahq9DpvuYoV0n3MswmuQzligYcf+yqGak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrXS+1Kn4a3ONPh8xjUh8FWxyGWvfMVXXoARh2gceG+scdV3qC4nH8SlxJsPqw1yP5D0msCT+PEmry0wh0cbQj//m0vEHtQrcGCz/RpdL4TMo+Kp0gF37PYtWMLcYmF0Ok1OSVWYdeLIVlnUSyQbXQJUHVFgxjwiyMF2+TbrgQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qY7LH6KH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EZE6wCYE5zUSPljmrWqcAc5ompbDXwI304HiUvlwTvk=; b=qY7LH6KHzw9+kkjDTMlEt5YXjC
	O4mBdfesFrfZaSpAljUijUww/O9wbVbaAs7M4uK2UoMqlkCmOCnnLuEQ8u2HFxvDx0IcJO0cnycTZ
	jTjV5jO6cYyM6hUi3qtPY15eoV7Eau+yW+J3FU9xsAZ6FYJuNDNLELT5SGACXYGuLURkabf5t7cC6
	XgREYz0ZIF+Tg3D1xPCud2YASK/GX8crEgUi3oVWpJanrmPdj53ncT6dVXj5y45iX8urvqx1DkZwM
	RScfBslIArqUQohyBTvaQnkZOGvsXL9ovVEIoPwiv1XiHC81JjU09qAZDTu2Icpv5MV6wYxFGEMjh
	p2aLVxLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPFXH-0000000CHMY-3rF2;
	Thu, 04 Jul 2024 06:01:39 +0000
Date: Wed, 3 Jul 2024 23:01:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoY6w_suKUR4i-WY@infradead.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org>
 <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org>
 <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVv4IVNC2dP1EaM@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 03, 2024 at 11:36:00AM -0400, Mike Snitzer wrote:
> > When Mike presented LOCALIO to me at LSF, my initial suggestion
> > was to use pNFS. I think Jeff had the same reaction.
> 
> No, Jeff suggested using a O_TMPFILE based thing for localio
> handshake.  But he had the benefit of knowing NFSv3 important for the
> intended localio usecase, so I'm not aware of him having pNFS design
> ideas.

How does O_TMPFILE fit in here?  NFS doesn't even support O_TMPFILE.


