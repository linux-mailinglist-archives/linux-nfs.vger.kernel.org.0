Return-Path: <linux-nfs+bounces-16178-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D73C40927
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D82B4F1AC1
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092AC32A3C6;
	Fri,  7 Nov 2025 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rVWlPOGL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453932B9BA
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529062; cv=none; b=kHP+rouIBr55GOBpcooP2lA7JNd46hQsKCEyG1s/OQCf9kzH7Ji3DpdF8NDGsNA7lekgFUJY9UuZ1fQhjS3tRapPdEhLx2rJ7B8toxpa+78CSrrm9Lo1IR18+TCI0Jsq2odVcQ5zATKmQJ+lyGN4O2MspdSSrulGkXukQg52zbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529062; c=relaxed/simple;
	bh=1q+X6XmIflUUmhqQ4N8erFpSXu5FvOUS6gzYy/i6CBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5Exd1DoZfhgpr+R7+yQr/8MHbrEuMvOJY+y7Cupqw51h6kDnZRRjoBDfBGOhGvQ+vL5nzR6PgBSH1z4Nk2U696l8KYJTV79rNoAAFjtBOLPJ9Ihc+q1BgPKch41dI61ANgiymwQRwsxKnARbJDtezfvtb6DKF8y2jhYdbg7oHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rVWlPOGL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SyA8NXinO2uBthAh3t1Hg1Jk1edJVikPCFwyE6m6LnY=; b=rVWlPOGL5IYRznMm14WRcnYanf
	L87rCOwfVBDGCOKPMo5d//6BbhBu8tE8wQtF8cumOxqCYYYs9O4Qc32SDD1WdXBK6qKyN964RlivP
	EH/JnjyS8DoAQn9EzcZxFuAccS5enmzIsflRpbbEzjfgJnDXDixhg9GkP+LFGvjToy9fcH/44og1W
	mIVlkD9EGDaXlIttEPxT5KEzfzvnYZwAAHMX7j37fCbcRDDi4jUcfz9crCG+0sg24B7V7OhfgUvch
	YkN93JMCO8eVrOtoRti2VfvCdjGDeGF7n0FU0ySKoeqAIwFGsMgo3g/MNm72TVJVa5b/x3Nc/uVD9
	asmvUAow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHOK1-0000000Ha0L-1Hpx;
	Fri, 07 Nov 2025 15:24:17 +0000
Date: Fri, 7 Nov 2025 07:24:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v10 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQ4PIT0ixuSkvk6X@infradead.org>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-5-cel@kernel.org>
 <176242391124.634289.8771352649615589358@noble.neil.brown.name>
 <aQyfgfWu8kPfe1uA@infradead.org>
 <aQyn-_GSL_z3a9to@infradead.org>
 <aQzRdTcyc2nhTWqj@kernel.org>
 <e0723227-6984-4c04-be7c-c3be852a8607@kernel.org>
 <aQzwvqlD0xiYjMCW@kernel.org>
 <aQ3zFRizxIa-Hk6F@infradead.org>
 <60402263-4336-42e0-acfc-7f1cab6c1742@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60402263-4336-42e0-acfc-7f1cab6c1742@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 07, 2025 at 09:38:43AM -0500, Chuck Lever wrote:
> On 11/7/25 8:24 AM, Christoph Hellwig wrote:
> > On Thu, Nov 06, 2025 at 02:02:22PM -0500, Mike Snitzer wrote:
> >>>> Selectively pushing the flag twiddling out to nfsd_direct_write()
> >>>> ignores that we don't want to use DONTCACHE for the unaligned
> >>>> prefix/suffix. Chuck and I discussed this a fair bit 1-2 days ago.
> > 
> > Please document why.  Because honestly it makes zero sense to do that.
> 
> There is a slow-down. But it's not like using DONTCACHE on the unaligned
> ends results in a regression, technically, since this is a brand new
> feature.
> 
> So for an UNSTABLE unaligned WRITE in NFSD_IO_DIRECT mode, the unaligned
> ends would go through the page cache, and would not be durable until
> the subsequent COMMIT. Using DONTCACHE for the end segments adds a
> penalty, and no durability; but what is the value we get for that?

Less cache pollution, and especially less conflicts with other direct
I/O writes.  Do you have a link to results with the slowdown?  How much
is it?


