Return-Path: <linux-nfs+bounces-15561-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D071BFF47B
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 07:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0323A681E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 05:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF03203706;
	Thu, 23 Oct 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQycFxp2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86002BB13
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198730; cv=none; b=L1sVSsCr5FYCpcT+3HYfoG+27aMThctC5anfZW8lRmTKGGZC/7UvAG8OJUR8v4ScYg9wqmVqicnEI8QfQgOUmJhN45jlR8xIlqhkdWWcdJwdI34Kv7z2AXP5RO4kVM4vPCdiKiWLWRuouIQjywRLdr1N5YOXnqEHaREQaCryO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198730; c=relaxed/simple;
	bh=HYnrTwI79JvN7+nSz6EbwrdcxEdjoScgsmVz3VEF+vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqWOlxMiZ8h71PjwAaySGTi2pfqdIddcPV5DHcFE/YZtIjuMi+vE9BJ9An6yjiRHBaKGFGQHI3H+5SpQo0U9t3ZYUnn6e1IPQh0jps1v4nW89uupXsbqjWzMlNhV4k5qb19PtyT2ctuzOI1lUusJ5El7CmjN0pMqAIREpuAr/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nQycFxp2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0CfI4Z94LEBYs9jW65HPS2k81EoEapGC7pa5BlXdGt0=; b=nQycFxp25ej1acx7T5KaeOtwp9
	P8oz8GLCedSbV0CYKCZ1EXBNPsmLLD++EnT5zk5ELXYom4s52WWo8xsu11evQE4YpmmJI70Wi2BB9
	795yFQl/K+Uc9V/OOZpQxUhrpA8sUtD20TqOBwUaiZWqnH06h+vBS7uoPB3iRoRxTUPCLmLPZEFij
	JsoJaAMW9V+WAj+19BfCdp6CDmKxMorS7Qq9tmYiSXgHrdTCzTW4871Pz8KRrfMuEf0w37GCmqQTz
	G9nho6GtIhnrRz0lcqDrGNs4hAX3MyaKzuJsTBtf7926WtPuZM/SyL0JfmbIpfJ3yEezmzB2nBG94
	+ICT4mOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBoF2-00000005ACP-0nFn;
	Thu, 23 Oct 2025 05:52:04 +0000
Date: Wed, 22 Oct 2025 22:52:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPnChLocfNsu_UN7@infradead.org>
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-3-cel@kernel.org>
 <aPXihwGTiA7bqTsN@infradead.org>
 <3728820c-d0a5-46d7-b886-3343606cb776@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3728820c-d0a5-46d7-b886-3343606cb776@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 22, 2025 at 01:59:04PM -0400, Chuck Lever wrote:
> On 10/20/25 3:19 AM, Christoph Hellwig wrote:
> >> +	/*
> >> +	 * Any buffered IO issued here will be misaligned, use
> >> +	 * sync IO to ensure it has completed before returning.
> >> +	 * Also update @stable_how to avoid need for COMMIT.
> >> +	 */
> >> +	kiocb->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
> > What do you mean with completed before returning?  I guess you
> > mean writeback actually happening, right?  Why do you need that,
> > why do you also force it for the direct I/O?
> 
> This is the only comment where I'm not clear on what corrective
> action to take.

I have multiple issues with the comment.  One is that it really should
talk about commiting data to stable storage instead of completing,
as that seems to be the main point (and also what IOCB_DSYNC /
IOCB_SYNC) does.  If we stick to using IOCB_SYNC it should also
mention metadata or more specifically timestamps.

But I also really don't get the "Any buffered IO issued here will
be misaligned, ..." part.  What does buffered I/O and/or misalignment
have to do with not wanting to do a COMMIT?

> I think IOCB_SYNC would be needed with O_DIRECT to force timestamp
> updates. Otherwise, IOCB_SYNC is relevant only when the function is
> forced to fall back to some form of write through the page cache.

Well, IOCB_SYNC is only needed to commit timestamps.  O_DSYNC is
always required if you want to commit to stable storage.  As said
above I don't really understand from the patch why we want to do
that, but IFF we want to do that, we need IOCB_DSYNC bother for
direct and buffered I/O.

