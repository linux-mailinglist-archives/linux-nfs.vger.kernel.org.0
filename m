Return-Path: <linux-nfs+bounces-16202-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2165C41CCA
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 23:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CBB44E048F
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 22:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4283A3128B1;
	Fri,  7 Nov 2025 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ZP7NpMHG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KAaKafrF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47F3128AF
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762553632; cv=none; b=FGPDkgWMvriB75XTFy44rGhvPfRnUYHjl3sGRkBMUXEQqC21pxyyHOkOWdv0CcQ/+n+UVqKjMGZdq1NShIrnaPjd+2ZeG8DIuHz5kHcAzLvyxRNKsKRm4ee8VjePzIkXqm54cNysz5N529E9h7Ab2ZWrWoVVVDBMruKUlKfMU7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762553632; c=relaxed/simple;
	bh=bxXgoyPj4ou44T2tA1SpKwwV6TOctGMWb0ayndp4h+o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=X1anZ9+FNkkl+UHV9zaVvrgzY5NHlAneJFdfdfNYPJUccdb35orRpTOC4SWLxqsncia/EtkADdqiUP+ZtPSWj6yw56PYAhUbjHSKep9wO+p55+rVvs0gY3Pb2CdIjoQjr6fIkmkRqGEHrgY/Vq44swcQ2EBDIQTQduV7EivLWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZP7NpMHG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KAaKafrF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id EE8871D001A4;
	Fri,  7 Nov 2025 17:13:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 07 Nov 2025 17:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762553628; x=1762640028; bh=y35QfMpsTvYJMTAE9t5RwUOfGZrIO0PFdWj
	YGo1N7gc=; b=ZP7NpMHGeIQ80xajAEu3hdQJql96T5CsOy53yEd3KsvPwL6lG87
	cKhPIzqNQC8h6bss98SP0GxHlWW8dhxS/U6b9PqVmQXaaJZagy6GkhZvkJonIoCa
	ZZ1MRARUWRhqzZZsSB2WGqWcu2J6ceMxZ1C2vkD9ib2KTYTe/XEaAPwAv3ooKSTF
	ufsoh2PFkEvladRYquQ2XSyPCGCMV7gJWEZoAc0lsLW5pkp+JBaM9sTL5gKvJy8m
	0Athb1g3tM+5TGoKkzfSwHZb8pLB2+Zj2ICyUVeYYtjK34cZd3/O5iIGGIoO+AFI
	NiYIq7oX+dVjs/c/XMOpH/p9Eq2VqofRzAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762553628; x=
	1762640028; bh=y35QfMpsTvYJMTAE9t5RwUOfGZrIO0PFdWjYGo1N7gc=; b=K
	AaKafrFcZARNiAzbWGtuvnRjwHbhqe39j7OETRhQCzc+i1LYp82TN41CfUKvMhk1
	UYB6K9oNahCrq3f7SRw/E2e0qWPzEqWQBjAQ978Q496U4Gy6OH0Mg+/gdbS+W6Nv
	bg0AIC8LO8ej7+NH43ljGeC4jovgw+AoelY7Dz2Ngic2IJbZmdpG41xjRjwz+Ml2
	6/8S++mjyRfk+1sKNrLfmWGxFrMg6d7GqXcjLs0ZZJ0u+YUgJaDWxASN8jjMshn3
	Rj8LWXO5DqRyvFooNjSLeIz5SdZKLJajiuvUXivDlcfpv5aFmfXmKfvebt48FYZC
	wzXw++92b/w5/9h8qknxQ==
X-ME-Sender: <xms:HG8Oabj2l_O6eAHbqP5UnNjDiajTzWHRl3BTeSfiYgie1XjnV4HclQ>
    <xme:HG8OaXFXZs_KwLX1XtHc58mDfLrENV2FBy_gJkmYNYeZHogrHF7o46I5BJj7s32h_
    OXxbsN1xP-vXzm1r_L3nhVILwXJY6f8MpNeswiKROQDDYJR>
X-ME-Received: <xmr:HG8OaRR_224ano8h-NrQMcDfS89w6HQ-d7tJgyL3WUo3_EQP9nO7dxZefYbOa786UWjhxOdMB9BZFMM58dCL_5zHMxhdGJcgzFgX2fKzWBDK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepshhnihhtiigvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:HG8OaUwx-lrynufErOUvQuKe5ovpjVf01yMqBtow7LuQnnYgIVP93w>
    <xmx:HG8OadfTHwfY1_oDyJwr38KJM_JUtW6KICx9hadqzqJEIQq_w8TRHg>
    <xmx:HG8OaXNazD13MKGkagXTTyd_1HOoXhO0cNOVKINjBFsyKPXGV5mgfQ>
    <xmx:HG8OaYslDYg_itfhEpsRC6QZYfbhJkOd3VKqLWQXgU0m6lFzmfse1Q>
    <xmx:HG8OaRkOno_4RJRphgFmDQYHM_OJj-ehIRiLZzsnQ8cNJ1B5NV3B7UyL>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 17:13:46 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Mike Snitzer" <snitzer@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
In-reply-to: <20251107153422.4373-3-cel@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>,
 <20251107153422.4373-3-cel@kernel.org>
Date: Sat, 08 Nov 2025 09:13:44 +1100
Message-id: <176255362443.634289.17013787490062336314@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 08 Nov 2025, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
> 
> When NFSD_IO_DIRECT is selected via the
> /sys/kernel/debug/nfsd/io_cache_write experimental tunable, split
> incoming unaligned NFS WRITE requests into a prefix, middle and
> suffix segment, as needed. The middle segment is now DIO-aligned and
> the prefix and/or suffix are unaligned. Synchronous buffered IO is
> used for the unaligned segments, and IOCB_DIRECT is used for the
> middle DIO-aligned extent.
> 
> Although IOCB_DIRECT avoids the use of the page cache, by itself it
> doesn't guarantee data durability. For UNSTABLE WRITE requests,
> durability is obtained by a subsequent NFS COMMIT request.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Co-developed-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/debugfs.c |   1 +
>  fs/nfsd/trace.h   |   1 +
>  fs/nfsd/vfs.c     | 140 ++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 138 insertions(+), 4 deletions(-)

This all looks nice and clean and easy to follow now - thanks.

Excepting the caveats you mentioned in the introductory note:
 Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

