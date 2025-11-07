Return-Path: <linux-nfs+bounces-16162-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE25C3F172
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 10:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E9C188D17B
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D45316918;
	Fri,  7 Nov 2025 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="esfXnlnU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S26y+VmD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79930316917
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506696; cv=none; b=W99UH5fucYa0Mt5Qs+poCPwBZs8LWIOBP4Xi4gcPtZyCUve+GBDgbaZkD0OO8jlfjTQQa4PK2yqNk8EL1LoE1kaafX2cPb7fTMDo9eueULfH6fjixVw+eq1+Qo8JoRGvNngSihKraQGMy+0UJKxvzclQKEVADuTzhPeEPeOadYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506696; c=relaxed/simple;
	bh=gRf7GzMLxHIp1cv3ooX9ZTX0S/O5AuCcFOO7fFPL5YI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gD6xcOr5XVV6Opn0VOY+YO2a7em1hzTpSTdkYJzoddc5zSNjCLOdLYxXq709olUWDpIfJSTyGmE0Ejgzc7hC7XWPruyPkJRQjhPCH9sUOD7CgK+ndR4tWifO1gbOXklc6Hrep070+9U+k7BSrdEN2K5Dfp6KdHcDgtEwDheTWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=esfXnlnU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S26y+VmD; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5543F1D000A1;
	Fri,  7 Nov 2025 04:11:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 07 Nov 2025 04:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762506692; x=1762593092; bh=YwJZVVnmS0p6hYrcG9MSJIHBYRnBNE043GJ
	UN3B7RoY=; b=esfXnlnU7O+kmZIYTNZvxKNK0Si/3VhyH6YDuIjZseGiD782iRi
	yBipsKiCFwOII7baKCRNhJqj92axV8Z5tEWnN18NEzIFQ1CECLJsqKOkR+o2ooxJ
	t8gR6HxG/5qEaY92VGEq1SmE68sVFEgv7B3XPapwkPcrs9W+D+n/falHPgrAPqxn
	blCjjEzk/hYDBwoHijImXyVck+9eYlD+qvS2tZlJ0bq/xvY0kOfMSV71eYUWvCIp
	2tGCpYs72KlMPIpP0BX7TNEIL2fuZVSdEHewnoWKgRlbboid7v9yQeHNFp/OJ8aZ
	IykjPT/vArBkD7lGdlbUMPfsJXYXuOzQ35A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762506692; x=
	1762593092; bh=YwJZVVnmS0p6hYrcG9MSJIHBYRnBNE043GJUN3B7RoY=; b=S
	26y+VmD4s/z5vIeP79IANNEh0ihZi7piyiu9UuDfUPzkaOaVDBWov60/pizEKQ8f
	VLL8fmtjUrwafckgtcmgH53zVZ+mmxwajzsCZ8+rfkq9yPRbak2bC6WZ5AEFqXOQ
	jGplOBLr2/JdgtbbjI7+vxMWzySuvi4fIvJtZuEPuwSJDFN8I3wqAu7LtHfE8TBb
	La24r2oaKed7MmtVdN+zxosZHGgjYCKjBSawbn5icndUjGrt9tPiiog/pXnZ5B7c
	A+JQjgIHxmQNQSlldh7Z+wlyb0DtaKGJg9OX/6cwk3Cmi/G4LiTTVpkLK/pR7LOq
	3OMbMf8Xp5vs8vCUQMt+g==
X-ME-Sender: <xms:xLcNaV44SM8H1lvgvtfQWHGinXePbSuSPPY9NM_U2kDy3HreOjVPVA>
    <xme:xLcNaZ40OwJqgt51nBgV6RE9geWzmKu_aHjmoChITsuXlSNOSw3nsMlV5ml6x9jUa
    fxsO10gKvmq5JCNfjtmBMVpXnqfbI3FOKREAzMqcc673_zB>
X-ME-Received: <xmr:xLcNaRdpDRje0WjSJUnituJP7Q2vuI-pZfFy0M5tkyFohNNzM3AyegCrgG6UaRdlFxbRJ5vdJwQR-5pujykRzf8Sew3a8FPVogtC4ihhnu0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveeuheeuteeigffftdetgeeiveffkeeigeettdekleevffffvefggfdtueeliedvnecu
    ffhomhgrihhnpehophgvnhhsuhhsvgdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuh
    igqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughm
    hieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhsphhmrghnghgrlhhorhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepsghhrghrrghthhhsmhdrhhhskhesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:xLcNadB2dPY9hvUeMSNWjTgp69V6QCHMIbI3zRUbJEi6-qccdpoJOQ>
    <xmx:xLcNaU-sVidpXJJQALt_OG8Gq180YVnw0ISb4Go-uzkPNBK2uvKHHA>
    <xmx:xLcNaYKlIEiZwb1xmNJ79Ap8kAhomlS8UJZwsUpxAioLOLnx2JbbvQ>
    <xmx:xLcNadhXXOI5Z1WAQDDFlrXhk7JanHx1z6gSPo5UBy08Ym4tuO5JfQ>
    <xmx:xLcNaVvl9J-SyedzALlgLDd4F8oCCb_XewXeLlB2XR2oKJIN_PR8wn7n>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 04:11:30 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Shyam Prasad N" <nspmangalore@gmail.com>
Cc: linux-nfs@vger.kernel.org, "Bharath SM" <bharathsm.hsk@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>
Subject: Re: Requesting a client side feature to enable/disable serialization
 of open/close in NFSv4 clients
In-reply-to:
 <CANT5p=od_-93SNQtvaid7yrW_XTqCN5_MJS=cYzgydrPkhtJ3g@mail.gmail.com>
References:
 <CANT5p=rmuH59F9dpvrop0f+8XfVnK6fZHyqLhb10UsYfa6XJgw@mail.gmail.com>,
 <CANT5p=od_-93SNQtvaid7yrW_XTqCN5_MJS=cYzgydrPkhtJ3g@mail.gmail.com>
Date: Fri, 07 Nov 2025 20:11:23 +1100
Message-id: <176250668306.634289.13564785727214953785@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 07 Nov 2025, Shyam Prasad N wrote:
> On Tue, Nov 4, 2025 at 11:18=E2=80=AFAM Shyam Prasad N <nspmangalore@gmail.=
com> wrote:
> >
> > Hi Trond,
> >
> > Several months ago, Neil from SUSE provided this workaround for their
> > customer to allow the NFS clients to work around a bug on the server:
> > https://code.opensuse.org/kernel/kernel-source/c/d543ea1660582777ca7f8a8f=
91afd048de09b7b6?branch=3D377837fd53dbd7a6c35cff41d5c42ab1224512b0
> > However, I see that this change is not present in the mainline kernel.
> >
> > I would like to request this feature on the NFSv4.1 clients in the
> > mainline kernel too, so that we can have this support in all distros
> > in the future.
> > This is a useful low-risk change that will provide a fallback in case
> > of servers that don't implement this scenario properly.
> > Let me know what you think.
> >
> > --
> > Regards,
> > Shyam
>=20
> Looks like Neil's email ID has changed since. Updating the email ID.
>=20
> Hi Neil,
> Is there a specific reason why you did not submit this patch upstream?
>=20

I didn't submit it because I didn't think it was appropriate for
upstream and I was confident that it wouldn't be accepted.

We don't work around bugs in servers - that would give the server
vendors an excuse not to fix them.

I implemented that patch for SUSE because earlier kernels *did*
serialise all opens for v4.1.  When we released a newer kernel to our
customers which removed the serialisation, that created a regression for
some and we take regressions seriously.  But it wasn't a regression in
the kernel (which upstream takes seriously), it was a regression in the
customer's experience (which SUSE takes seriously, but the kernel
community is less invested in).

If a buggy server exposed a weakness in the Linux client (e.g.  could
cause a crash or an infinite loop), then I think we should address that.
If a server raised the possibility of ambiguity in the specification,
then we should consider addressing that.  But this is a case of the
server clearly behaving incorrectly in way that doesn't harm the client
and isn't ambiguous.  So I don't think the upstream client should work
around this bug.

It would be much better to ask the server vendor to fix their server (or
use a different server).

NeilBrown

