Return-Path: <linux-nfs+bounces-124-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6E77FBAEC
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 14:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8922DB21799
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F356442;
	Tue, 28 Nov 2023 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NwnXKNMq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F332BD4B
	for <linux-nfs@vger.kernel.org>; Tue, 28 Nov 2023 05:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pshlG/ligFC3SogVXAgvzFoPKpHGsgj01FPvrJM8Hhs=; b=NwnXKNMqKbb8/6H93AE5QmyPwH
	g7NPryLcu+hKXy3t/13Pg5jnNGom3SxJqHClWJ/g5xx6ShQGezXr/7IOE3ypItBHSrb2DiFQJNLrA
	XChUQcCcYcuvk/Jo2CPsf+/xUZGhkff8jGJrIeZt37F0jzH4Exgm5bGpw4igrPvvqpcIqBFT2ER6S
	K14f4G2+vddICFFuovGIAilwb/MCw0XZebTd1Joe1X582pqztSxPny1ncTm0H5ZawdNTJzLVDw1k0
	WNjXk+UdhNPcHhrNne4n2ji2GdnVBvi9FJ1zrmgYxUZoLLR3E00QAS/yXq2KYsk3WwhgQkbrPAs5z
	tgG08Rcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7xpp-005MHD-0L;
	Tue, 28 Nov 2023 13:09:05 +0000
Date: Tue, 28 Nov 2023 05:09:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Rick Macklem <rick.macklem@gmail.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Question about O_APPEND | O_DIRECT
Message-ID: <ZWXmcYy8NElP0FC2@infradead.org>
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
 <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
 <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch>
 <ZWTFn0/FtJ5WuQGc@infradead.org>
 <7E2914D2-B9AB-4280-9A44-875DA8B58328@oracle.com>
 <CAM5tNy4qVXXS3sHqx7Y3Ndt2YNnd1hrj32iJdo9KMi+ByMfEuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM5tNy4qVXXS3sHqx7Y3Ndt2YNnd1hrj32iJdo9KMi+ByMfEuQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 27, 2023 at 05:50:49PM -0800, Rick Macklem wrote:
> > > Well, it does support O_RDWR|O_APPEND, just not with O_DIRECT?
> > >
> > > Btw, I think an APPEND operation in NFS would be a very good idea, and
> > > I'd love to work with interested parties in the IETF on it.
> It is not easy to deal with w.r.t. RPC retries.

Indeed.

> I suppose a NFSv4.2 extension that either requires (or strongly
> recommends) persistent sessions might work?
> (Persistent sessions should pretty well guarantee an RPC is not
> redone on the server.)

I guess so.  That of course actually means we rely on a viable
implementation of persistent sessions.  The Linux server doesn't
support them, and I'm not sure which servers actually do.

