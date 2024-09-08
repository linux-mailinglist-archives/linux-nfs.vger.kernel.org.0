Return-Path: <linux-nfs+bounces-6324-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0727A9707AA
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 15:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32FFF1C20CC5
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 13:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3679C158207;
	Sun,  8 Sep 2024 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="DcPcZlFn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJqV71YX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE413633B;
	Sun,  8 Sep 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800598; cv=none; b=ToejFU/SNzhmRjMLjt1BJP3S4P/0GXuTWkqigJY/mMn7XIe2IZkntqKcVTAV9d0hIrEZjjwAtxMa4tkOWo26Jt9pKIlsPNj+3P9j+6/7RciuyQSHnOCFKtqU4mnF20u0WewEp/SZL1rQU4RlaWtOtrXYB0MvHu8d9lMjjusk/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800598; c=relaxed/simple;
	bh=yDqka7/iZVNwvPVULdbCBaLgrGGi/qWNRbUdH6LLAkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HttplKtq+HEmxM8RYIA8td3se7ZesHjh57v1GLPTavBoG6iHiHJyNi4nZ01nBeQUkn4SlqDsM7yvFSnNIoy5p5PPUKYrZQv3RpHGPpHgNcHyRUWzNw4/gcRs3obkYVWNU1bTL8M9XudfZqnGTIaKNEKj8I7A/lAQkTxQyn54P7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=DcPcZlFn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HJqV71YX; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D732F1380189;
	Sun,  8 Sep 2024 09:03:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 08 Sep 2024 09:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725800594; x=1725886994; bh=EyEB1QfU+b
	g7QcR7J67YpB8QE9vr1Ho4gvhdtqn6dbI=; b=DcPcZlFn5ugL/VFA9uLxWsqDrS
	HcaURmyNOW+1/7OOu6nTFPkG2Y11Q5Vx8DG3kOtlsgYEjPiW1kFBkmZ6TlpB+yiF
	Vhrp2Ux3Ohc26X/AU742ToU+FkrMSeXEPEfqG9B2huBa0g7cPpS1QC+sVPegOSgl
	yztROYqLpkAqUac3jzaqjZOkwma+ood28q6nnmsGoL2DHje49t8yP2JaHT2w6u9r
	Zfyko35kGRbq0vhqXWJ1WfaMRDhiX7yFrzIdmlaJyu/4+J76R8J1e3sBWByJ8WZA
	rRqb5nFB+cTYpvxbbiOKIuo1I5Eyqi7TD766cdTlUuwbRiCsAznDuXfVoTwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725800594; x=1725886994; bh=EyEB1QfU+bg7QcR7J67YpB8QE9vr
	1Ho4gvhdtqn6dbI=; b=HJqV71YX7L4aQX/kfSyx2YopDwi02hmtmxbfyz2ftP1O
	qcP7hUqEEE7DtlTno+1Oot0CvUHxYYPyP7khTz8i5jlYZ3rGlnpTCLRWRI2eN0Z9
	wNOThv9XKVmAOUxz2BJcq4wtPtwMWAUaJ85K8eoEUSef0JFfn51UVOmagKdmE1MI
	TtV2GsRFong7aOvQieO40DvpSa6EkWKTWoPeQqyiLEiX5C+c4qvT02vu5kz7wvjh
	I6fcTsUuidGFFYE4FJE6p8S1lKd1g41UQDHc0X8zP74hkx8Az3xowKf98Y0Ejz9j
	a/hvGlUwF4WtANKh567M9ys7m3ymBvG5keLoJFgvDQ==
X-ME-Sender: <xms:kqDdZqhf7aZl8v8fOsnPpO2v7Hx2Dr_N5U9G7abjH7YT5zkX0FEsAw>
    <xme:kqDdZrDG2H24hiDy6RCDOYJA-QD4ZN0SadF0M_ceG8bALHBN7U_8yLL4YgWNeFa9P
    mf7QOgQGrUKSw>
X-ME-Received: <xmr:kqDdZiERbxns0Z4EIOx-wg5dnKY_Le9BjB6bYlNC-QsWdHVl4Z5b3psumf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeihedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefh
    gfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedukedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvhhorhgvlh
    esshhushgvrdgtiidprhgtphhtthhopehshhgvrhhrhidrhigrnhhgsehorhgrtghlvgdr
    tghomhdprhgtphhtthhopegtrghluhhmrdhmrggtkhgrhiesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtohepjhhl
    rgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrihdrnhhgohesohhrrg
    gtlhgvrdgtohhm
X-ME-Proxy: <xmx:kqDdZjRd_UpRjFBMeLX33tOSWanPV6y828cjx_E3WEjyQyCSKBEsLw>
    <xmx:kqDdZnwr0c-enagC1OTFb0uPE1s2lnhhLux8DngLYD2Ey9aUGtyoug>
    <xmx:kqDdZh6IV4gIc5zvKuicClNvymgnpxx7fzOFOLDnLyiU4zrCoaSx3Q>
    <xmx:kqDdZkx61aPcCiYcJcwuzuR6WSUc-4y3fY6Gc7xOtf9nESqtl_RCtw>
    <xmx:kqDdZoqVnNfZBFhy6omsbkz-D_ZwLzC2dc0EyHVNsF-RE5tN0H3oFWUI>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Sep 2024 09:03:14 -0400 (EDT)
Date: Sun, 8 Sep 2024 15:03:12 +0200
From: Greg KH <greg@kroah.com>
To: cel@kernel.org
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>, sherry.yang@oracle.com,
	calum.mackay@oracle.com, kernel-team@fb.com,
	Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH 5.10.y 01/19] nfsd: move reply cache initialization into
 nfsd startup
Message-ID: <2024090804-arrest-unjustly-75e9@gregkh>
References: <20240905153101.59927-1-cel@kernel.org>
 <20240905153101.59927-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905153101.59927-2-cel@kernel.org>

On Thu, Sep 05, 2024 at 11:30:43AM -0400, cel@kernel.org wrote:
> From: Jeff Layton <jlayton@kernel.org>
> 
> [ Upstream commit f5f9d4a314da88c0a5faa6d168bf69081b7a25ae ]
> 
> There's no need to start the reply cache before nfsd is up and running,
> and doing so means that we register a shrinker for every net namespace
> instead of just the ones where nfsd is running.
> 
> Move it to the per-net nfsd startup instead.
> 
> Reported-by: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Stable-dep-of: ed9ab7346e90 ("nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfsctl.c |  8 --------
>  fs/nfsd/nfssvc.c | 10 +++++++++-
>  2 files changed, 9 insertions(+), 9 deletions(-)

Whole series now queued up, thanks.

greg k-h

