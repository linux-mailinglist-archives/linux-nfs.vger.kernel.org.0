Return-Path: <linux-nfs+bounces-5808-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE0E9612D3
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 17:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CE6281738
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797DF1C57AF;
	Tue, 27 Aug 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="hjAz/mTr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VuP9xHwv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAE1C5792;
	Tue, 27 Aug 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772829; cv=none; b=BhAHyFq7Gg8QD5/K8/FVb5i10098oZGmAgT/Za7U6aTJn83AGiagMY1VSDl9+g0HTdA6Mbqt6azwyDh3yVPIDoKsjTQ72XT0/PK6JglUiwgtTL94PU6rTX8q58T9WEi4ZcoJGLbyEsA9s6AWXFVcEeNzXm1tjuJlrZfL4gSe4BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772829; c=relaxed/simple;
	bh=PqW3LaLdaIXUKRv7ae1w6/zjG46YRxp+ySlwBpNlSDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvoeT+QCDbTOAMUiAuFwsqGS4bnBRs7z+dwcDRl7JU086+tWEF8SB/angXi5AkLgaEKjcal9mHsbKxn97KbIBerGHoM+AVXJS25KwoBqPAt+8xVrHhCLJYZigbNCnoFsInMpiJdfWlS+79+CKiFA6ImFG/4Ri7q644nUbH+X04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=hjAz/mTr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VuP9xHwv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 761F41151B29;
	Tue, 27 Aug 2024 11:33:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 27 Aug 2024 11:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724772826;
	 x=1724859226; bh=9uGAv2l5IKc9PnaG89xszMBC4k6+LpWKy1GRqAd95vM=; b=
	hjAz/mTrH+BLHWsTj+xoouDhwLjLgPYmztWxfWsb5c8eawFjoR2zYN9ap9kt33XQ
	GU4q+V6Yldpm4N5emTM/r/95AFzKE147uR6NSevaPxhubp6k6Mbe38/NpyKt36IK
	Yi90k5R/t+ANLicDm85Qq0K0fkYJxW2VeYy0wKQP5AFsb8WJyiF+lvJ3klqpnmQp
	ZgPq19SW/2eKN7weOChp3sLMdqCXltoEMkcWZfkAJSmCl0Ae5I0n02PpyuuLWhnN
	D7knO7bRh/QaojLeDdrzkeAUeixxOcsaR+5DwiaGl85ePgpmlwbmkOcw7/fl91xR
	zxjQJlhOXs2Raj09nui9Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724772826; x=
	1724859226; bh=9uGAv2l5IKc9PnaG89xszMBC4k6+LpWKy1GRqAd95vM=; b=V
	uP9xHwvimD1XOGUWIMnqMLs8z3QV5g3x4pG2hdqnvJ66w20G5pHAGvuXo1mUmtXb
	2qKp/Fe2RpNR8tUzMG5VXUK7ck4MqWfknl3tRH45YVGu34c/2nznCDdi3x3grGge
	nD20dliZvuk0UaOm9JhY+RA/MPC+QLNiFJyMSbVHBLJ3Y/fYB/Eyv0lWU7VHz/X6
	EwTRhVh6qmIEPBON9qq2lzag5ZeO720gsOdg1YjPOaaJNzm9XJa5UXdo2WXHf83T
	NdFebojTxwrp048grzdeue2weJGnNIxH5V1sAlgzZyluy+6h7KiLvlHFxDMQAOTj
	IiE00zjJOSXKBDtPHIvtw==
X-ME-Sender: <xms:2fHNZpM3m46PK3zB6LAp_x9KFftUh-rmoVjeT_Y6olZ_LZQ93G8daA>
    <xme:2fHNZr_XfinGtvRpiAAxDcfsutbi6gaYb4EnBqNmZIh11AsJCZBZdpKD1SRz-5ccx
    cZ24Q9KjVAx1Q>
X-ME-Received: <xmr:2fHNZoTOSx6o9cu6ITeWAa3Fb5D8bn9fxA13OIoP8_zinPA_w4ShsW4MrqKsTydWIj8h3wcrFtu-98PXMWUSiVjeUjhRPQN1pP0jPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeftddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpefgkeffieefieevkeelteejvdetvddtledugfdvhfetjeejieduledt
    fefffedvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtg
    homhdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgr
    sghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhilhhinhhgfhgvnhhg
    feeshhhurgifvghirdgtohhmpdhrtghpthhtohepnhgvihhlsgesshhushgvrdguvgdprh
    gtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2vHNZlvyZCCN5sAkb1cEvxFlTuX6OaXaV_PCYmI4wvxXnKn6fUIlTQ>
    <xmx:2vHNZhe34A6nRC1KvTZzYcrJeu84ijWUZXJxY9JipVRvLZO0Oy9P4Q>
    <xmx:2vHNZh07R3aq0Gi5aeHUPfr1_X83ca_ENszluGC_ydeQww5rRm3Jbw>
    <xmx:2vHNZt_KyXJLj0mUa9smfexmv7P4uI8IM5W-PT4ovqYSskkbkBpcBw>
    <xmx:2vHNZs1tgptKVrCeCmVPzuufnMcWE0LAwoMnRnU8hT2YtK30al1gIs78>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Aug 2024 11:33:45 -0400 (EDT)
Date: Tue, 27 Aug 2024 16:40:54 +0200
From: Greg KH <greg@kroah.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, linux-stable <stable@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>, Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.6.y] NFSD: simplify error paths in nfsd_svc()
Message-ID: <2024082749-goldfish-handwoven-09b3@gregkh>
References: <20240824162137.2157-1-cel@kernel.org>
 <2024082712-haiku-take-ef45@gregkh>
 <3C709C8F-8708-4434-8E64-41931DC5C753@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C709C8F-8708-4434-8E64-41931DC5C753@oracle.com>

On Tue, Aug 27, 2024 at 02:25:03PM +0000, Chuck Lever III wrote:
> 
> 
> > On Aug 27, 2024, at 8:46 AM, Greg KH <greg@kroah.com> wrote:
> > 
> > On Sat, Aug 24, 2024 at 12:21:37PM -0400, cel@kernel.org wrote:
> >> From: NeilBrown <neilb@suse.de>
> >> 
> >> [ Upstream commit bf32075256e9dd9c6b736859e2c5813981339908 ]
> >> 
> >> The error paths in nfsd_svc() are needlessly complex and can result in a
> >> final call to svc_put() without nfsd_last_thread() being called.  This
> >> results in the listening sockets not being closed properly.
> >> 
> >> The per-netns setup provided by nfsd_startup_new() and removed by
> >> nfsd_shutdown_net() is needed precisely when there are running threads.
> >> So we don't need nfsd_up_before.  We don't need to know if it *was* up.
> >> We only need to know if any threads are left.  If none are, then we must
> >> call nfsd_shutdown_net().  But we don't need to do that explicitly as
> >> nfsd_last_thread() does that for us.
> >> 
> >> So simply call nfsd_last_thread() before the last svc_put() if there are
> >> no running threads.  That will always do the right thing.
> >> 
> >> Also discard:
> >> pr_info("nfsd: last server has exited, flushing export cache\n");
> >> It may not be true if an attempt to start the first server failed, and
> >> it isn't particularly helpful and it simply reports normal behaviour.
> >> 
> >> Signed-off-by: NeilBrown <neilb@suse.de>
> >> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> fs/nfsd/nfssvc.c | 14 ++++----------
> >> 1 file changed, 4 insertions(+), 10 deletions(-)
> >> 
> >> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> >> Suggested-by: Li Lingfeng <lilingfeng3@huawei.com>
> >> Tested-by: Li Lingfeng <lilingfeng3@huawei.com>
> > 
> > Odd placement of these :)
> 
> Wasn't sure I was supposed to add them to the actual
> patch description because they weren't part of the
> original upstream commit.
> 
> But if that's OK to do for stable patches, I will
> add them in the usual spot next time.

Yes please, thanks!

