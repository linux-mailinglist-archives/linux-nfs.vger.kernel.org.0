Return-Path: <linux-nfs+bounces-12235-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D2EAD2D5D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 07:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB2316EE18
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 05:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DA225EF81;
	Tue, 10 Jun 2025 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eH27CSTh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81121931C
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749533951; cv=none; b=L5H/xbVv9Mql1WLX6lC779ZiIXv37tHwqPUTODeisQDUwJQccfQwzpx+CaPqfmBxPNXOFVjwO0fHATVV7TP/ccIlnUQivH4tdQPp4Apw7JWJ7jWs9qZ5rl/F0qZTHM6jNXDaKOI2DaVcJauOFc6oqScs6IU02kh0SuxuqsykjEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749533951; c=relaxed/simple;
	bh=rigiyzExHXT8occ07SKFdGyZy2Xtl1TnOgfu0eMzHSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OraKeJlj+WipxoRUMuR6RRiminZ+qarKwRhvJckAmKHUTc3cZB+f8QWPKoWHbusDnai6t9WlbS6H55bXmb3D7FkYaNSunC+chJqNtgpTMgqNQzb9I1ivkFpajj8yEJalD9vTZeLGiRi2yHhju4NPMnficQaw7z/0VP9WFbInPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eH27CSTh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D7o0B2A4ZMqsSbF4dSWI7FRAu02HwuKBDrBrsoH3DGQ=; b=eH27CSTh0Zia58gzZE5KE82Yg5
	xZRixqB1c4vjbEbJBJ6FMzbjwShg5eZopZC3YOJLgBcFk1LlZhoG1YwDPgA7KV6PwBlBmnfnaIC6m
	YTFW7B7SBizDSWCNssVCDMQP+MizeE053u8c/dAtb+NDzVm2bTPefB9gldaTLcGdpT0q6IxbaxPMs
	H5JQsWCSGLGIpTi54SWnUy0fhivN2t07f9o50+fJHqmkVLfByXaLY8AN0cQ51JJco8Gx8WjJWNpBy
	Y7CFrTBNlj+aPJqKe8fp/SxAgQuJTWRdZyHfNeQF5Sp+GzVBtiAik+k7E+4dXjZnlYn5Brdm/ab03
	l2zJ/APw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrhS-00000005r7b-3jPf;
	Tue, 10 Jun 2025 05:39:06 +0000
Date: Mon, 9 Jun 2025 22:39:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	"J . Bruce Fields" <bfields@fieldses.org>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Implement large extent array support in pNFS
Message-ID: <aEfE-r2dkuDRUKsq@infradead.org>
References: <20250604130809.52931-1-sergeybashirov@gmail.com>
 <aEBeJ2FoSmLvZlSc@infradead.org>
 <uegslxlqscbgc2hkktaavrc5fjoj5chlmfdxhltgv5idzazm3h@irvki3iijaw4>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uegslxlqscbgc2hkktaavrc5fjoj5chlmfdxhltgv5idzazm3h@irvki3iijaw4>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 03:36:49AM +0300, Sergey Bashirov wrote:
> On Wed, Jun 04, 2025 at 07:54:31AM -0700, Christoph Hellwig wrote:
> > On Wed, Jun 04, 2025 at 04:07:08PM +0300, Sergey Bashirov wrote:
> > > When pNFS client in block layout mode sends layoutcommit RPC to MDS,
> > > a variable length array of modified extents is supplied within request.
> > > This patch allows NFS server to accept such extent arrays if they do not
> > > fit within single memory page.
> > 
> > How did you manage to trigger such a workload?
> 
> Together with Konstantin we spent a lot of time enabling the pNFS block
> volume setup. We have SDS that can attach virtual block devices via
> vhost-user-blk to virtual machines. And we researched the way to create
> parallel or distributed file system on top of this SDS. From this point
> of view, pNFS block volume layout architecture looks quite suitable. So,
> we created several VMs, configured pNFS and started testing. In fact,
> during our extensive testing, we encountered a variety of issues including
> deadlocks, livelocks, and corrupted files, which we eventually fixed.
> Now we have a working setup and we would like to clean up the code and
> contribute it.

Can you share your reproducer scripts for client and server?

Btw, also as a little warning:  the current pNFS code mean any client
can corrupt the XFS metadata.  If you want to actually use the code
in production you'll probably want to figure out a way to either use
the RT device for exposed data (should be easy, but the RT allocator
sucks..), or find a way to otherwise restrict clients from overwriting
metadata.

> > Also you patch doesn't apply to current mainline.
> 
> We will use the git repository link for NFSD from the MAINTAINERS file and
> "nfsd-next" branch to work on top of it. Please let me know if this is the
> wrong repository or branch in our case.

I guess that's generally fine, but around a -rc1 release it's a bit
cumbersome.

> As for the sub-buffer, the xdr_buf structure is initialized in the core
> nfsd code to point only to the "opaque" field of the "layoutupdate4"
> structure. Since this field is specific to each layout driver, its
> xdr_stream is created on demand inside the field handler. For example,
> the "opaque" field is not used in the file layouts. Do we really need to
> expose the xdr_stream outside the field handler? Probably not. I also
> checked how this is implemented in the nfs client code and found that
> xdr_stream is created in a similar way inside the layout driver. Below
> I have outlined some thoughts on why implemented it this way. Please
> correct me if I missed anything.

Well, the fields are opaque, but everyone has to either decode (or
ignore it).  So having common setup sounds useful.

> 1. Allocate a large enough memory buffer and copy the "opaque" field into
>    it. But I think an extra copy of a large field is not what we prefer.

Agreed.

> 2. When RPC is received, nfsd_dispatch() first decodes the entire compound
>    request and only then processes each operation. Yes, we can create a new
>    callback in the layout driver interface to decode the "opaque" field
>    during the decoding phase and use the actual xdr stream of the request.
>    What I don't like here is that the layout driver is forced to parse a
>    large data buffer before general checks are done (sequence ID, file
>    handler, state ID, range, grace period, etc.). This opens up
>    opportunities to abuse the server by sending invalid layout commits with
>    the maximum possible number of extents (RPC can be up to 1MB).

OTOH the same happens for parsing any other NFS compound that isn't
split into layouts, isn't it?  And we have total size limits on the
transfer.


