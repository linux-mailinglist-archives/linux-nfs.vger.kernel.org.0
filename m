Return-Path: <linux-nfs+bounces-4617-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FDC926F01
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 07:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E34B218D7
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 05:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3451A01C5;
	Thu,  4 Jul 2024 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sCkkswBh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20E1107A0
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jul 2024 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720071952; cv=none; b=a/d9B73DvrtpYOF5DVbOffKYbySgFEJjj+Cri1OkfDbEWwHdgGuSK6X6JzaAIs9bB2G4PPBuZve2Sw2xu0tvBQ4UyuZr5BP8ZfrVhe3NCwA7YdSY4D3WdVVdWen4W3ngYYz3ap82H4M/qq5b8EfoT2XT6BEPoaDFXgYCUIIljE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720071952; c=relaxed/simple;
	bh=yfUvyo/w2go7AHrjyY2Dlt76Iv0AD7UjWB+BBuyiQdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vkq5PMunzzVU/BxkG1TvGv3WN2tqMOIIH0SYS4MNtcAtcyVF751mLZsJVl0FkAF+vbBQHEIuuuK3a6LzMMuWeAbCp4tzZftDbPh8yf6qz1U36j4+lVSOvYJ2449SMTW7xl4z9k+6N2u2lhA17yQda/oUdy4SScZ1BHQLK2Sjb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sCkkswBh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=prG+tWwTRM4D8IPB2JXiRKTtXtmnL36ESu1loFT8eeI=; b=sCkkswBhqP1MnmWw8EzqxvO/Fn
	4QQa48er/+GoV/HgAESzjXaj06JqVc4NdBBnXwb5pUU6H6q4pYkiaA/QU490Vrmn0IaiqmxJEBbgX
	seYPXsgaJFQ7ETEnrbJGvAhRlHV0nCcGBcVGweDB9xB4bmGNk5fDVSI3Mh7RtlXrRLalyF4U+xyf5
	Lk0sIywCPIj2fCvgh/4Kwj62d3OCnsRPTmUWG1KZCgj/Co9ucNdmOH35oircNpZB6vOVww7EbkBHB
	OyZSoZUdtcNUENt3drcTwyiCivbNY4CScrKHXHNatWHs6Kp/Hbx/biM9bsC/M33D5ODYifk/TGyXM
	fn3lMMZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPFHt-0000000CF77-2ZCx;
	Thu, 04 Jul 2024 05:45:45 +0000
Date: Wed, 3 Jul 2024 22:45:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org
Subject: Re: Security issue in NFS localio
Message-ID: <ZoY3CYlNebkh4K6S@infradead.org>
References: <172004548435.16071.5145237815071160040@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172004548435.16071.5145237815071160040@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 04, 2024 at 08:24:44AM +1000, NeilBrown wrote:
> 3/ The current code uses the 'struct cred' of the application to look up
>    the file in the server code.  When a request goes over the wire the
>    credential is translated to uid/gid (or krb identity) and this is
>    mapped back to a credential on the server which might be in a
>    different uid name space (might it?  Does that even work for nfsd?)
> 
>    I think that if rootsquash or allsquash is in effect the correct
>    server-side credential is used but otherwise the client-side
>    credential is used.  That is likely correct in many cases but I'd
>    like to be convinced that it is correct in all case.  Maybe it is
>    time to get a deeper understanding of uid name spaces.
> 
> Have I missed anything?  Any other thoughts?

Still getting up to speed with the code (and only the current one
posted by Mike, I haven't looked at your series yet), and the
fundamental underlying problem seems to be that while the code to
open the file resides in the nfsd code, it is called from client
context.  If opening the file was done in normal nfsd context with
all the usual limitations and then handed out it would work exactly
like FD passing and avoid almost all possibility of privilege
escalation.  I'm not sure how to best archive that, though.


