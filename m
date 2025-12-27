Return-Path: <linux-nfs+bounces-17331-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCFCCE02F3
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 00:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 471E53002049
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 23:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7013B2AA;
	Sat, 27 Dec 2025 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Rm2lDgR4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="boEW9VGx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B803A1E66
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766876562; cv=none; b=ikXi2xZflR2T7itPy0ZcmMwPVCBIoVEKrk9uZMlWr0J7/ywSecIf7LhWMcMoHoJZNsQUkgH5RrT3RAAmACNo0CVDiuD4QmdevLC67PXm5sPSSywtRBCPx78xmKS7sVDG78MehQ00bORBrEqb2b9KWwcocOQ1skih5hCm9TlnEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766876562; c=relaxed/simple;
	bh=wOx1JO24VkMW7z5SROWTR6Ms6Dp4IFLZkETEvmYSyEo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cwpbkW8KjGlenOgfv+ysb4/cWF7KDtrVnuUnMBdOqSm48cZAf48VET1tIBmP5uGeH08D+QG5zAQte9YIpIKQfCMtsw98hmzPQiehLgMN/NhB2UhjeLzy8zxvgVtHIsM23iwGkSHzFDe1oU6J2UPc76Spo4jUPubSgKqbPRLeHTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Rm2lDgR4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=boEW9VGx; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id ED8D81D00089;
	Sat, 27 Dec 2025 18:02:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 27 Dec 2025 18:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1766876558; x=1766962958; bh=WBxNIgqaCgByRTdnjuKS7erjLxlNFX149CF
	aFO/Hvsk=; b=Rm2lDgR4Y8NKdeVDOw/VMyQhsx5MeMe0/TJ/bq/NEIdac17cbDg
	mJnWSOC7F9iwzg4dFg1+d05HhL8KV4ew52samqHxyJwGbXQCwIGOMtOav0ZGZCUx
	KLDXrHHp/fjfEh8zD2WBdLyYMU8bvntw75GYQgoFYYaf1yqs+lmkQ2c1sYS4ZEi8
	AX1+olbg3auDlSA4hi+Xbo73j9rtv5Edo1o0vVrdNGKHfIMnHkRHwIac6MoAqhqo
	vOa5CO4eBl5UDT4Lq6w+8m8O+fwhEbMxttkY2BwCeWFClm/Lg7uD8pGZHkPV+FRK
	ivJkpj8OQap2uEVCiBGW2vUG1XNn049mLvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766876558; x=
	1766962958; bh=WBxNIgqaCgByRTdnjuKS7erjLxlNFX149CFaFO/Hvsk=; b=b
	oEW9VGxJv/UrivHPBdELamoJm+HosC0rqbT4Ify3TXHMSs6EmNFmlo/y1SUW5hBj
	pfPoaEGCgY+Z786XLgceqReM0qGV/8Nx4RG71K3VfffUB999Rfe8V+4W3ugcj1HF
	08x8LGLAKAflXluV6rVkpzuQ0xe9FFw0VSnchvJgqwDVcdkGLEzQlRL7dK7dfHx3
	k2pu6jWkSCPi4WjsObH291CfOk10Y5LfHGM0n3dHzztfnrtZYXJ6DDHFuKkGpKlR
	gOe/GoFUpWYwthM91oQT4CD1UzmwLqhJplUgTuXhtpR0gfFu6l4UIq3xT5gg4uDW
	Im8IdmWoBOD2eekfEyTnQ==
X-ME-Sender: <xms:jmVQaQ7c2Uw6BX6M8rw1zKNBurJFwGhRpxXpaPMRkeMA6Bnjx0OTog>
    <xme:jmVQaUJKLXQ6br0fQyZ60IowjWOGjbudMjwTUMvCVVIG23K8cIlUdVTYCRlx5QOFb
    jIbhsIhlNaAdCLaFq-0v3hqZDk9kQ_pjzCtxFxaAo2xbsRSEg>
X-ME-Received: <xmr:jmVQaRvGG8S6LykuBn0RsZYa3kwAMk0bs1987LC2bCxkZwbd2oewLogVQ4cLPI9PsjNuBvAFT1xLlIx_daxSD643QewsaoHxZ7XmZ5NBNKz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvdeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jmVQabIJYw243FnSZtFdpYWDIqBcUkZLNEGN3sXI0sFieI7whJz-8g>
    <xmx:jmVQaS_hrUE3rNhmGRNYLl3u5Ni4OGkHDhuXl966mxmBH0d1MlKlJg>
    <xmx:jmVQacx6-tpyeG9aYDUj65ScKpUx5G3RS39fgAvkVk77aQ4uei66wQ>
    <xmx:jmVQaX7s49b6Kq6ASGRqS1Tw_Zxzj8wltM3qoQp8m7F1OqO2p522vA>
    <xmx:jmVQaX1W48YmOHS0sJs9iTDIfDwJmv82vQz8aRZJGrdyJf5OhsKFc4VU>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 18:02:36 -0500 (EST)
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
 "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH 3/3] xdrgen: Add enum value validation to generated decoders
In-reply-to: <45fe648f-6399-439f-afbe-83541133386b@app.fastmail.com>
References: <20251226151935.441045-1-cel@kernel.org>,
 <20251226151935.441045-4-cel@kernel.org>,
 <176679268968.16766.17613591475642801974@noble.neil.brown.name>,
 <45fe648f-6399-439f-afbe-83541133386b@app.fastmail.com>
Date: Sun, 28 Dec 2025 10:02:32 +1100
Message-id: <176687655268.16766.18035767292619384422@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 28 Dec 2025, Chuck Lever wrote:
> 
> On Fri, Dec 26, 2025, at 6:44 PM, NeilBrown wrote:
> > On Sat, 27 Dec 2025, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> 
> >> XDR enum decoders generated by xdrgen do not verify that incoming
> >> values are valid members of the enum. Incoming out-of-range values
> >> from malicious or buggy peers propagate through the system
> >> unchecked.
> >> 
> >> Add validation logic to generated enum decoders using a switch
> >> statement that explicitly lists valid enumerator values. The
> >> compiler optimizes this to a simple range check when enum values
> >> are dense (contiguous), while correctly rejecting invalid values
> >> for sparse enums with gaps in their value ranges.
> >> 
> >> The --no-enum-validation option on the source subcommand disables
> >> this validation when not needed.
> >> 
> >> The minimum and maximum fields in _XdrEnum, which were previously
> >> unused placeholders for a range-based validation approach, have
> >> been removed since the switch-based validation handles both dense
> >> and sparse enums correctly.
> >
> > This patch doesn't only update the code generation in xdrgen, it also
> > runs xdrgen and updates the nfs4xdr_gen.[ch] files.  This results in
> > changes to those files which I wasn't expecting to see based on the
> > above - specifically the removal of semicolons, presumably due to a
> > recent fix to xdrgen.
> >
> > I wonder if updates to generated files should also be separate patches?
> 
> It's an interesting review policy question.
> 
> The precedent I'm following here is that typically folks prefer that
> when a new function is introduced, at least one call site is added,
> in the same patch, that makes use of it.
> 
> So, when an xdrgen change is made, if it results in substantive
> changes to the generated code, all code is regenerated and those
> changes are committed in the same patch.

Largely makes sense - thanks.  But I wonder about "substantive".
I was distracted by all the ";" changes which seemed irrelevant, and by
the date stamp changes which just seemed annoying.

If you got rid of the datestamp, then you could *always* run xdrgen in
pre-commit.  Mostly it would do nothing, but the generated files would
never be out of date.

(of course with a bit of scripting you could get the pre-commit xdrgen
 to only replace the files if something other than the date stamp
 changed, so you could get the same effect while keeping the datestamp).

> 
> 
> > Or at least the commit message could mention that xdrgen was not only
> > changed, but it was run as well?
> 
> I will add some beef to the commit message before applying the
> patch to nfsd-testing.

Thanks!

NeilBrown



> 
> 
> > In any case the changes look good and valuable.
> >
> > Reviewed-by: NeilBrown <neil@brown.name>
> >
> > Thanks,
> > NeilBrown
> 
> -- 
> Chuck Lever
> 
> 


