Return-Path: <linux-nfs+bounces-16166-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B67C4016F
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 14:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5540B4E1AD8
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F032D7DDA;
	Fri,  7 Nov 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xBi6Cexr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC427AC31
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521884; cv=none; b=B5wsXzf1rov69RQ+iqw31r6fVj+5vZ4pvs5vHYV4fl2A+TDervUeqdSl+ABoTzjN5DZ/+/Axaq/MgqBvCUPJd4gveKALzk+Wa83BLxZHSwTsTPHB83hii+sI0Zg6hnq+d77HUioo8/+q31N0abR/h0wFvsRWq0qAoVcHrEvQ9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521884; c=relaxed/simple;
	bh=Y5+eHgW8VxRV2lSFJ+RAXbuBKyFEgpQhfTZFtQUbwjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlUhNOmVPxQC1h/GHV5IOfyqpUQe9kbY8oamCpDgzIsXVDqlA+Cv1xu370NogmRbOXopVqz+RL7cvd9pFnJnrnIxqDa7ySQKX3oSVveAc9OJRygNV+SQEwhaSXugKXZB5Zhj2simornShdK8rnaTbmftGU5q/IfA0eGmTzm9zvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xBi6Cexr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U4EgPRosCc0YIlVSW1O6FFL5aZOYnAiIgb76tWThEj8=; b=xBi6CexrAp12UFSFFKFD1fnpLu
	vQUpr2qSLdZXYhccCWR8tK1bHuUCt0ZnH/Dh90Y95Xkq+5MDNBs/szczsS/15/37HM21vhZ3nOB32
	KkgkJtGWCy2vWTT37Fz6juVAT1EUWA7zRQVt8J0jk5U7nbQjZDcVTubi+oMQUEPr45p8dVmVNhMVb
	0BElv5jQzX6CHApBh2N6X7xT+ty2p1Rl9+2uV/kY2KzdXEDaeBm4Nv1rWZk1u6FxDAPbOEThQP+Xc
	/32Wi0j/Bt9e4RM4dHuzaw/qFBStYwiQLYzoT4pD3AXsPz9Gd3B812b1XVr4MHsA4b8oWS92z1Sea
	pTSiCOoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHMSD-0000000HOgl-1xpn;
	Fri, 07 Nov 2025 13:24:37 +0000
Date: Fri, 7 Nov 2025 05:24:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v10 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQ3zFRizxIa-Hk6F@infradead.org>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-5-cel@kernel.org>
 <176242391124.634289.8771352649615589358@noble.neil.brown.name>
 <aQyfgfWu8kPfe1uA@infradead.org>
 <aQyn-_GSL_z3a9to@infradead.org>
 <aQzRdTcyc2nhTWqj@kernel.org>
 <e0723227-6984-4c04-be7c-c3be852a8607@kernel.org>
 <aQzwvqlD0xiYjMCW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQzwvqlD0xiYjMCW@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 06, 2025 at 02:02:22PM -0500, Mike Snitzer wrote:
> > > Selectively pushing the flag twiddling out to nfsd_direct_write()
> > > ignores that we don't want to use DONTCACHE for the unaligned
> > > prefix/suffix. Chuck and I discussed this a fair bit 1-2 days ago.

Please document why.  Because honestly it makes zero sense to do that.
But if you insist, at least write a detailed comment why you don't want
that, so if people have to debug that odd decision in the future they
at least know why it was taken.

The rest looks ok to me.


