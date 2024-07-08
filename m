Return-Path: <linux-nfs+bounces-4706-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32188929F31
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6545289D21
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55CC6F2F4;
	Mon,  8 Jul 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y4M5THoA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99663F9F9
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431430; cv=none; b=jB3Duons7B+64LlwXiAOt1BpnENElpLqml/l2yuu8rreGjpXuEJwAHem3BFC/FpcpoNlm4q55sH0bbDeetmwVvK+b6FipbzmtGNGu2Rx/EbBsWhRAEqnhrapuBgggOVplPgxdWegk47LMI0K1XfYGSqV16FZEbWjfFOWW6QMxlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431430; c=relaxed/simple;
	bh=KOKHG+dVt+0bpHlMHykMympI1sslvjn1UnyoLyrXYuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoQdNVAmxTd11X63WpBgcgqu5+99+3a6DTO1459C4Vunc+lcsH5rs48Op2xQtULvVTnf8xnGi4svowGwMR2PijosHolZuGin8iTScKygz6q9mzREAX0kihfYP1NDNF1TSdmi3Rhy9E/CuKJCb+iBHT+bdri23zpTNpY/he+lu0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y4M5THoA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0JsDHYK/WmnSsM80jJvtp69pmB9ll7aNOma0+DC2Tlw=; b=y4M5THoAxSqrAYpCmVfTN6EUG9
	OEVg/WjwMb3ETZZAUK5UbezelsKq/8NSy+DI/leHt8RilUrAbl5O62VafhluWxtjsaWTdvJbHah9q
	zM75/5QpUe6nxLU6IQ+0gaJfjXNt93Tmc8hXjkx1HixyakQsempmlhATsBt0VRZ0x8g8vvxSaIytC
	3a0C+CbssWQSZjqEF2vtXT7xiX8AWAQYOJdftB7IgJbpKIvMsARzpOU1oyh1q6JGOlaJRWT/TQzIY
	t4JuH+AxwXJsGX9AcRHPKUsdWGWr1az0kf6qqv5EY1tYIxQ/iQ+FDWZd83JA6o7mxZQh/qBtlPBUU
	1kr+7F2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQknz-00000003IL3-2uBm;
	Mon, 08 Jul 2024 09:37:07 +0000
Date: Mon, 8 Jul 2024 02:37:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZouzQ8trA1YW0CdS@infradead.org>
References: <>
 <ZojnVdrEtmbvNXd-@infradead.org>
 <172041138255.15471.5728203307255005157@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172041138255.15471.5728203307255005157@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 08, 2024 at 02:03:02PM +1000, NeilBrown wrote:
> > I did not say that we have the exact same functionality available and
> > there is no work to do at all, just that it is the standard way to bypass
> > the server.
> 
> Sometimes what you don't say is important.  As you acknowledge there is
> work to do.  Understanding how much work is involved is critical to
> understanding that possible direction.

Of course there is.  I've never said we don't need to do any work,
I'm just asking why we are not using the existing infrastruture to do
it.

> But pNFS is about handing out grants using standardised protocols that
> support interoperability between distinct nodes, and possibly distinct
> implementations.  localio doesn't need any of that.  It all exists in a
> single implementation on a single node.  So in that sense there can be
> expected to be different priorities.
> 
> Why should we pay the costs of pNFS when implementing localio?

Why do you think we pay a cost for it?  From all I can tell it makes
the job simpler, especially if we want to do things like bypassing
the second page cache.

> That
> question can only be answered if we have a good understanding of the
> costs and benefits.  And that requires having a concrete proposal for
> the "pNFS" option - if only a detailed sketch.

I sketched the the very sketchy sketch earlier - add a new localio
layout that does local file I/O.  The I/O side of that is pretty
tivial, and maybe I can find some time to write draft code.  The file
open side is just as horrible as in the current localio proposal,
and I could just reuse that for now, although I think the concept
of opening the file in the client contect is fundamentally wrong
no matter how we skin the cat.

