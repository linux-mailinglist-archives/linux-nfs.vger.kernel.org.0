Return-Path: <linux-nfs+bounces-15740-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF811C1734C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 23:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34BCC35624E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7E13563C6;
	Tue, 28 Oct 2025 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YkM/TQM1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UTT98Jcj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF733CEB3
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690978; cv=none; b=ecvmUt0HX5IuR28mE5xbMs673YcOkyumFMfdEQt7xfCFvEUF5rM1LJgkzBOkmCRYGiU41a2tHdYOhJUifwSADWOHdy1VuFnq8orQ0EomPxeFd2Jgn18zpCT0ZT086vbzpFSbDf2gn68xotmpkDvCc6BPvPhMwlQ9rkda25FqonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690978; c=relaxed/simple;
	bh=DYLMj26ubjmXuAfk643cgrRQBYOo4gIF3F4ztH2Chkc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ufSc62R6wYaivd1Jo7uST2QBuUclStWgxwxqqJPIormxWp87rg1Ww/gjzMAbx6HgIgEXRp+noo6Q8neALpUo3N1xFx2wXeFHsnG2loP44vUnnnD0lL2OFndMe3c64BvVKXg7W/dhR0NA2KuHcGmJs5ubM/DCjXsl73WnQkHR8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YkM/TQM1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UTT98Jcj; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B82BD7A00F8;
	Tue, 28 Oct 2025 18:36:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 18:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761690975; x=1761777375; bh=8ejFiNA5yTH50Zr923v2g/2yrEw8sn5OcEC
	FGQxlhPU=; b=YkM/TQM1VAlbyXna6j2DGPquZHSTe7b8L9oNwWEbosekc99PvRj
	xlznG2x6dx9XAEoLyUcTWLhYQ+VItR5UmPXzsaK4LMkp8hq+obxtwIZmefDz+fGL
	KiOCFEZ1swvHawnoC4iaTz+lHyGWEb7Q6cb7Ghqug6OPIQaTeG/3/FSbbN2ACoZn
	SnoxNdCGBOOums0K9SnNavuqPvtoClKdgpHD3SHpnr+af/fnMUTz/SQOGCy94kBA
	Aqk7f+IP/r56wGjm4jCKtNRhmVQp2dz4lbjG//70zSanWy77v5RKZkpo1eT2EOOV
	sA1iiz9YH2G+oUHvr4y2Ji+uVVQDd//vLWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761690975; x=
	1761777375; bh=8ejFiNA5yTH50Zr923v2g/2yrEw8sn5OcECFGQxlhPU=; b=U
	TT98JcjGtuc5zZMMmonpIieCj0VD1QIDvWudMgEIUEO2MNsi9tIqqCkohqU+/yOe
	R60JPHCgB1TNwqeAw2zbyzd7TCkIdItXUHgknvca+kX1yQdhRa18HvhP7LTVJFoo
	enxsmbbxUhw1Qpiq7DYJkbhJJh5/cHaUufko5YGCcTz/zqcfrIuqOTBw2CNoytwR
	xTR2u8gDO4vSqdUIn9aiprydM+v2UA6RCkdi/h3FiR+eUc7dT3p+dsM1V4NcmEAB
	7P9xlH+qecmJ6XAOO8q2VzLLjuuZkGo/V0psBd7xGimcuS/qYIeu7T7f6hw1lqFN
	hagGnQXan1HrL7J1V97qA==
X-ME-Sender: <xms:XkUBaV0lFHQ9AOmoGX_uXmojYgoZc5BwDg-QNPRcFRIsrSV46__vOg>
    <xme:XkUBafy3UpVRrGT0vQuRqZHeQmK9qXIfWe28npzPspEdffkevml73ZhiChNY7pOAJ
    HbXDw1Er2Sv3ZZolRNy6xzQ2831DzJO-bQzwDvwcRXY9tjzFBA>
X-ME-Received: <xmr:XkUBafsYmFIQLQfmEulflMnu5-qm4a1S0SLfO6C9PiCPkj_Ic9TbxH4FysNcipgAmVmGIxZ3IYpDM7pXL356U7RMrP2fjuAOE5o_QnrksJcy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epgfeikeetueehudeigfefkeekleegheehueeifffhieefvdegueetgfekuddukeevnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtoh
    hmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    khholhhgrgesnhgvthgrphhprdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:XkUBaZyUhWYE43qMbVatlIVM15fYMooaDvYguv04-AkQJRaxOrGxhg>
    <xmx:XkUBaaA9qlhC98ayPaZU163BD65SXVT6cMjDW6XWI7Zca13Krd1zjg>
    <xmx:XkUBafcbitIAnxN5DIYa2ma9DQAJZYO7LWZ-Y1NPi9orrWtRhX606g>
    <xmx:XkUBaclIqsGtAFoPBZb2GBRT9ICqx_2iT0tIwQw-CZfHeItBjop9uA>
    <xmx:X0UBacYp7a-CfXRbVhOxM3bVvQAk5ShI6m2W6IF2rvIDZOA5JTZJhZ11>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 18:36:13 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 0/6] prepare for dynamic server thread management
In-reply-to: <e03fd3e300b01be35f5c10e33f819f3991776706.camel@kernel.org>
References: <20241023024222.691745-1-neilb@suse.de>,
 <e03fd3e300b01be35f5c10e33f819f3991776706.camel@kernel.org>
Date: Wed, 29 Oct 2025 09:36:11 +1100
Message-id: <176169097134.1793333.6570917569336480125@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 29 Oct 2025, Jeff Layton wrote:
> On Wed, 2024-10-23 at 13:37 +1100, NeilBrown wrote:
> > These patches prepare the way for demand-based adjustment of the number
> > of server threads.  They primarily remove some places there the
> > configured thread count is used to configure other things.
> > 
> > With these in place only two more patches are needed to have demand
> > based thread count.  The details of how to configure this need to be
> > discussed to ensure we have considered all perspectives, and I would
> > rather than happen in the context of two patches, not in the context of
> > 8.  So I'm sending these first in the hope that will land with minimal
> > fuss.  Once they do land I'll send the remainder (which you have already
> > seen) and will look forward to a fruitful discussion.
> > 
> > Thanks,
> > NeilBrown
> > 
> >  [PATCH 1/6] SUNRPC: move nrthreads counting to start/stop threads.
> >  [PATCH 2/6] nfsd: return hard failure for OP_SETCLIENTID when there
> >  [PATCH 3/6] nfs: dynamically adjust per-client DRC slot limits.
> >  [PATCH 4/6] nfsd: don't use sv_nrthreads in connection limiting
> >  [PATCH 5/6] sunrpc: remove all connection limit configuration
> >  [PATCH 6/6] sunrpc: introduce possibility that requested number of
> 
> Hi Neil,
> 
> You sent this just over a year ago. It looks like this set didn't get
> merged for some reason. Were you still pursuing this work? I have some
> interest in seeing a dynamic thread count work, so if not I'd be
> interested in picking up this work.

Hi Jeff,
 thanks for asking.  This is still on my list of things that I want to
 pursue, but it clearly isn't getting any attention at present and is
 unlikely to any time this year.
 So if you are keen to push it that would be most welcome.

 My branch which I think was my most recent version of this has just
 been pushed to github.com/neilbrown/linux branch nfsd-dynathread
 in case there is anything useful there.

Thanks,
NeilBrown

