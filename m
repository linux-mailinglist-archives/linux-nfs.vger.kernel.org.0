Return-Path: <linux-nfs+bounces-15347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A411EBEBFC1
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 01:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62DA34E163A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 23:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425113AD26;
	Fri, 17 Oct 2025 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Uqq45KDu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WKWPhT2/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C4354AFE
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 23:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743184; cv=none; b=b3fmZQH5/n3zlEMJobHaly64U7YqNR2lzNblQFsK4E7Qr8gSUb+FxPtR8ILFpF5uaKVD22zbhiC3Oe2xgfge9eM7NtK5noWHMhY+/f9jguabP/xYxGYTWHFY51dveCNvHUEMQ4Aye+sKyxdt3IQO20HcgyxElfrrZoV9GGmyYGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743184; c=relaxed/simple;
	bh=KxRIYF5Iax01ZstmRKJlgXdlSWlEvZ+tu4Q8Xtm5WSg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ufnApX2M2G6ijguhZgDmgy1ifgdYu8W/K82HgYb1i2Sx6v5qBn9SJ/sF91XV3U0+3FmI3VE0jCLxM+tO1d1yYgcxVp588TxbJc3OoFgyT1QAlb21XNbyl+i3CWmoLzrEll2+vSjBoEejpaQu7rw2YMZCmEzrLMGj43SitI3/73E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Uqq45KDu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WKWPhT2/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F75B140021C;
	Fri, 17 Oct 2025 19:19:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 17 Oct 2025 19:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760743181; x=1760829581; bh=W+EUaiymkCxsCWyUfrRQheJ54GKkLEY8rsk
	oAkESSO4=; b=Uqq45KDuV1WJ/mWaT0ozpOcZXA1AVNvr6ejm1+ofl/15Bou98+c
	Zf/CJ58hOPDA/UpBO8ANpPEzTVEUZhe1CAM46hTACEDAnSaqsSO6vwiOEVAIcOiA
	+qkpJ6rVj8QdsaDOUv70jpLeBNcbpkQOV4u0OKoIycPvpdtuKUfLWvYuF7ujSGpS
	Nwhhd4KClPOfylhSJwUbPDW4QBdLuJ2ftVpx9Q0+IPMpARrOSlhucdoPSSvkRN6N
	2hUKftdw7Cee5a1Toonb7+kgGoYxrcuIhU30h/jQ5ycesjuXJGrje25ldYyYWlH8
	80N9xOyYmN8yIzahmKEr7ClQIfD4OE8PkuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760743181; x=
	1760829581; bh=W+EUaiymkCxsCWyUfrRQheJ54GKkLEY8rskoAkESSO4=; b=W
	KWPhT2/XnICaIYoYELNeas9cTY3Q03960uVPjsWk66AIItNamhYmHLOqsO77UkwM
	npr+DFcdLRZEXk6yhma/2ZxezGMrOLyjcxQ3+U5fkngxmqX7enOOaiTfejrYqjHT
	pS5KqCF1b77MJ+fd/BG6wOVwcwt/ZIGwO5HBIgJBo8tsjwicXvmiJxbhqRmU+nVl
	4YBnJfOixJshVS3I6aDMerULAUJtNqvHEICi+zXOjEgp+vJBL2gqc4iWk0lHs5fu
	eXoTWxYIbSp94Zocfof2ef9WAhOtZ2fPnFbK2NvoEFbMxAxKaXq2sqaTpfoOQ/ne
	Z44LMhtDCWYPxX2TbNFMQ==
X-ME-Sender: <xms:DM_yaJ_RM8Dqv9jHxEWVj5ZjmSN5NeN4gbuMUlEchFXX4LAmbBVpyA>
    <xme:DM_yaMwVYhMy4U7cXCeSiUrljGaZQh8w1UBAF_KsSCkWgrPKrj5COr7mSSZNE_u97
    qNfUN3OPVaNXcRp_X6-ADfTrrZW5mVvI801yOlkpDr_rkAMfQ>
X-ME-Received: <xmr:DM_yaNNN9fOr9pcrcjFIie7QxU15MEubjzI9AAyibXrR40l4WWr6j8c5YJL3YNHqLQ2utT3kZityGCig5wbbxrXNA_RMCVg_s4RvxaSKsRBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtgeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DM_yaJ_SynBb7T2Bdqtr7WeJVG0JUzDyhY0wmML6sqlQtElheDsJlA>
    <xmx:DM_yaC4WaXRNVzuFmo2Bl1wBlcOqury5i7JyTgkYi8IGDsSRGBsZJw>
    <xmx:DM_yaH7DyzEi8MsRDdkjoe5uF1nRHbMSqbf69ddH-nUY4a22zwDbSA>
    <xmx:DM_yaDrBUESwBaGi3r5Q_vH9mv-oeErHWHzdX4sfkKqaj-_m__j-_Q>
    <xmx:Dc_yaJghZ6U4CKJqT_cvvm-iSly55sJDM-T6YbWpLD8VLgvQrfqqbXhr>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 19:19:38 -0400 (EDT)
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
Cc: "Jeff Layton" <jlayton@kernel.org>, "Mike Snitzer" <snitzer@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS clients
In-reply-to: <cbc86905-47ac-4f8e-b008-9120ba62a413@kernel.org>
References: <20251013190113.252097-1-cel@kernel.org>,
 <aO_RmCNR8rg9EtlP@kernel.org>,
 <c95b46b6-5db4-4588-ac79-4f6d38df0ae2@kernel.org>,
 <138caf9b98325952919d37119c1d2938a8f4f950.camel@kernel.org>,
 <176068215301.1793333.15890172978403788855@noble.neil.brown.name>,
 <cbc86905-47ac-4f8e-b008-9120ba62a413@kernel.org>
Date: Sat, 18 Oct 2025 10:19:36 +1100
Message-id: <176074317665.1793333.7672400013601107801@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 18 Oct 2025, Chuck Lever wrote:
> On 10/17/25 2:22 AM, NeilBrown wrote:
> > On Thu, 16 Oct 2025, Jeff Layton wrote:
> >>
> >> Somewhat related question:
> >>
> >> Since we're on track to deprecate NFSv2 support soon, should we be
> >> looking at deprecating the "async" export option too? v2 was the main
> >> reason for it in the first place, after all.
> > 
> > Are we?  Is that justified?
> > 
> > We at SUSE had a customer who had some old but still perfectly
> > functional industrial equipment which wrote logs using NFSv2.
> > So we had to revert the nfs-utils changes which disabled NFSv2.
> > It would be nice if we/they didn't have to do that to the kernel was
> > well.
> 
> It's difficult to make deprecation decisions like this because such
> customers are rare and are unrepresented to upstream developers. But
> it's clear that there are at least two interesting alternatives
> for such customers:
> 
> - Stick with older releases of Linux
> - Switch to a user space client implementation

Certainly they are options, but not without problems.
Using older software is not best-practice.
Using user-space server (I assume you mean) works as long as that
server doesn't follow our lead to discard v2 support.

> 
> 
> > What is the down-side of continuing v2 support?  The test matrix isn't
> > that big.  Of course we need to revert the nfs-utils changes to continue
> > testing.  I'd be in favour of that anyway.
> 
> IMO changes to remove NFSv2 support from nfs-utils were premature. NFSv2
> can still be enabled in the kernel, so nfs-utils should continue to have
> full support for it.
> 

Maybe I should post a patch to restore v2 support under a config option.

Thanks,
NeilBrown


> 
> > And async can still have a place for the hobbyist.  If a human is
> > overseeing a process and is prepared to deal with a server crash if it
> > happens, but doesn't want to be slowed down by the cost of being careful
> > just-in-case, then async is a perfectly rational choice.
> 
> async is not a hobbyist-only setting. I am aware of production
> deployments that use the setting.
> 
> As much as I hate async, it's not something the user community will
> permit us to remove, so it's going to remain for a while. But as I
> mentioned before, it seems to have less and less purpose as persistent
> storage speeds continue to improve.
> 
> 
> -- 
> Chuck Lever
> 


