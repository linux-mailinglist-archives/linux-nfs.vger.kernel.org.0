Return-Path: <linux-nfs+bounces-7473-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1349B0FC6
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 22:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEA8B21D72
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 20:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217520F3F5;
	Fri, 25 Oct 2024 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="PSxCMSwJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557601925AB
	for <linux-nfs@vger.kernel.org>; Fri, 25 Oct 2024 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888067; cv=none; b=kanYwBM+RXmBfMi5VwZjo1wzhS+G48rqVWXslmsokjMTbz2QYdQgczWjJPqfyweaqxre84NXlh/bd9Ndcd2fzgV1HYdV0Xxv1A9TKD0zNWzZmX5KNKdfl2LAJb2Rx3FoR2GRw7varLc2BqJen+tMW5fI1v3by+t6OUevy7kJbuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888067; c=relaxed/simple;
	bh=k7+v2vXEkvIKOtLTkAdWrHxuvUydoRb7kPkPoiaM9zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssA3yc8+bqO9I1LkO8op3ECq5OwmnZDjt5M65s7riJMtEBL90jyI5RbcMThvJAx/5ZuSEDZ4Zz5mREnW4dj2B2mTLMUSz6rfl/dCswBIA+JiqhJZKKzO4WxKoNfgtrV/W8ZPQ+XeJB8SIhk4mkXf6rRfcjCNYFsPoZU7+08wU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PSxCMSwJ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JAB+QZPu2fIAgvCh4QlbivFp0+xii5nMKcJuSPCrrHw=; b=PSxCMSwJTaFrB7WfmrKVMSBIYk
	4YOQWyMgPHEup5qzQ4U8YhyccZoMjheZuqom9jIolDSkljGQPvqq9cPIF82Zz9WGXZyinKWRzRYm/
	ObKHK2JGvYc/Z/QoXAOVxFKBu+kYdLqA/st1fyXIz1P+wpDt5l7BOZt8+ECf+oYbt9Unzinrr5Y9L
	IhGTBSwbQPzkFxabGhxeJ5wbrdJp0dvU1renxHXIX3whcXSTPKBjfwFv0iUjlGaLJCozgOi4nXFZp
	IS6i1AwXP4kH3hdtO8u+8r807PWbDL6HU5oDQhJ9DaTB+BaURNQLPp2GmG6m3DilK1HISXVzvpjgZ
	4xnPeyvQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1t4QhN-004NH3-1I; Fri, 25 Oct 2024 20:14:17 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0DFBEBE2DE0; Fri, 25 Oct 2024 22:14:16 +0200 (CEST)
Date: Fri, 25 Oct 2024 22:14:16 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: NFSv4 referrals broken when not enabling junction support
Message-ID: <Zxv8GLvNT2sjB2Pn@eldamar.lan>
References: <Zv7NRNXeUtzpfbJg@eldamar.lan>
 <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>
 <ZxUVlpd0Ec5NaWF1@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxUVlpd0Ec5NaWF1@eldamar.lan>
X-Debian-User: carnil

Hi Steve,

On Sun, Oct 20, 2024 at 04:37:10PM +0200, Salvatore Bonaccorso wrote:
> Hi Steve,
> 
> On Tue, Oct 08, 2024 at 06:12:58AM -0400, Steve Dickson wrote:
> > 
> > 
> > On 10/3/24 12:58 PM, Salvatore Bonaccorso wrote:
> > > Hi Steve, hi linux-nfs people,
> > > 
> > > it got reported twice in Debian that  NFSv4 referrals are broken when
> > > junction support is disabled. The two reports are at:
> > > 
> > > https://bugs.debian.org/1035908
> > > https://bugs.debian.org/1083098
> > > 
> > > While arguably having junction support seems to be the preferred
> > > option, the bug (or maybe unintended behaviour) arises when junction
> > > support is not enabled (this for instance is the case in the Debian
> > > stable/bookworm version, as we cannot simply do such changes in a
> > > stable release; note later relases will have it enabled).
> > > 
> > > The "breakage" seems to be introduced with 15dc0bead10d ("exportd:
> > > Moved cache upcalls routines  into libexport.a"), so
> > > nfs-utils-2-5-3-rc6 as this will mask behind the #ifdef
> > > HAVE_JUNCTION_SUPPORT's code which seems needed to support the refer=
> > > in /etc/exports.
> > > 
> > > I had a quick conversation with Cuck offliste about this, and I can
> > > hopefully state with his word, that yes, while nfsref is the direction
> > > we want to go, we do not want to actually disable refer= in
> > > /etc/exports.
> > +1
> > 
> > > 
> > > Steve, what do you think? I'm not sure on the best patch for this,
> > > maybe reverting the parts masking behind #ifdef HAVE_JUNCTION_SUPPORT
> > > which are touched in 15dc0bead10d would be enough?
> > Yeah there is a lot of change with 15dc0bead10d
> > 
> > Let me look into this... At the up coming Bake-a-ton [1]
> 
> Thanks a lot for that, looking forward then to a fix which we might
> backport in Debian to the older version as well.

Hope the Bake-a-ton was productive :)

Did you had a chance to look at this issue beeing there?

Regards,
Salvatore

