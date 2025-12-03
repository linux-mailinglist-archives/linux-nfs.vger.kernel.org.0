Return-Path: <linux-nfs+bounces-16894-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34740CA1DAB
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 23:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 070DA30034AE
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 22:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718D42E8B81;
	Wed,  3 Dec 2025 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="6FbCEQGe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iuwk4px8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA332E282B
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801910; cv=none; b=VtflkZJtg+gP7bfbpfHI10/Cvto2Zy6xoSjyOfkrEnx2AVOzJyL4/2c5WHY27fgkK7eIE7l9ARDeymvH6xOGzl3PWRUi+XHrvUU1Dpi41/sAnLCoWNkYqIlFs74xa4WHa8ERhDM3JtwOFbdgyNqNmo6rmRC7yIRGrvzLDx0xQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801910; c=relaxed/simple;
	bh=lNz105qXlPk0UtdR3G5JZSwS/6R546kCSRj1oQydeIQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LBVZqf6RLM3w4CfiJG29Ki3g9H7ldE5ysElbbWs3ZiWepfG9Fk6Im0WeaPkF86f9UNXThDAcl1/npx3ZAThgqDr4IPRWcIvws2XYXdBX4Csxd/OhWj6sUJtUyoAyBcO+qh4BAWV+DQtUphMWWTtwPXt5TNxtK3mrfD0jE5FyzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=6FbCEQGe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iuwk4px8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B6EA1D00161;
	Wed,  3 Dec 2025 17:45:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 03 Dec 2025 17:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1764801907; x=1764888307; bh=Okzg/JJaBMPxeqD3LEdFwZ5F00BKoNlteXa
	b4YUDrsk=; b=6FbCEQGe+OlAvSsz9/qBrLRIEITPgrRbnlnL0FvY1nk21KVX8ex
	X7MZMltVttpxYwuYlHw7QaMMuyFgEfW2sU2UiJCZ2uC4NSn7aPIE5lOB3Az5CXVs
	xk1R//QnjArMQmbXUqjMvzOAGIFNsNzzqNt8k0PNehggdBg7NcbajsXsFw3gSPfC
	GwCfj+iE2M0Q1OHiUmtO0QEGs73KT48bDq058uBRdJvAQ0VXjmUV8sawZ8YzD9HS
	nH7CYlxBAvAHFZNI5JbmPIUL2nnRCSlaa+xFqC+0XR0qsYMdzVI83aSGbSOBWcds
	WbaBgku/LDIQhwymhB6VYbEbjy9wMabnMbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764801907; x=
	1764888307; bh=Okzg/JJaBMPxeqD3LEdFwZ5F00BKoNlteXab4YUDrsk=; b=I
	uwk4px88OQpHw0AG3M9kdCKStvdAJYIYK4+tWime48A08cNL+RTknY3pB1dSuOfq
	j3NZ1NksmFo9VMAl8X/pCYiLRk0SrWpY0aQzf4wOhAf3VUWQptaOSBTxJcLY/imN
	+c3BK3YWoBdOinDZyF9uw3PfcVDVcMD2kIpJn1jj7qLp2KvDAH+dh6dEfUjPNDYp
	R0RrYBoNjAL3hitkZ9MFK1XP92+xSGyWH4SYZJJiXC0nqKiuWT8JBth5vUHWnZDj
	vKG3gy0LLPROF1h1bv8I5phL0nvTMh20Pd+dwMbY3Y2zyOGeNtMOlpgCbK94RGxD
	XYH2Wsw0L5CbQ7Rw0WKMw==
X-ME-Sender: <xms:c70wadlivGNGKZJm9elzKGeaLDiPO7A-9bGefQ3B4YUt-b0X1H_AEw>
    <xme:c70wabEQ3wSSgWsvVbBJR_cIagPnmKqqoTjX0NgTlxQAPBIy_hszaQ2bnOuNwlJ5X
    Pk0Imyzv8hEcmbP06ry9JdHUOcvDsYv4B8jepiedImfPNRldg>
X-ME-Received: <xmr:c70waV79aEj43Yvb6PwxKgVIA8vV0DVlSoKW4BLHMBFd5rMb1yLSHvDxTXym3nmHPAuT902VFNrL9nNx-KfjEG3UF2aJAwOKEPiVfv9sc-uf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegtddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    eptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepud
    etfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgv
    vhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrd
    gtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:c70waTnDrc0dsiDXkyZcftNZYPwohtnNzK1dq5WH_Cjuw5s1JpO6zQ>
    <xmx:c70waaopol4oCVb_cSfNteg1L7OKD6b3bBKxINrl9pGAkOvXU5AN4w>
    <xmx:c70waSvZfyO00YOUpQ4jbWTfWRF3TFcRQWRTzDS6bZm-SMEmblQIyw>
    <xmx:c70wafF0CuwfnPvrHAwF4eJceHvBckSnvid9MegI4LwZrGtyCkq86g>
    <xmx:c70waazdVDM8hhNaztxxfOhEdjbyOb-4N9jYjgi61AH7rpEa7mO47wsi>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 17:45:05 -0500 (EST)
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
Subject: Re: [PATCH v2 1/2] nfsd: prevent write delegations when client has
 existing opens
In-reply-to: <079ef086-fa1c-4a9f-b011-e47547b4e3bc@app.fastmail.com>
References: <20251202224208.4449-1-cel@kernel.org>,
 <176471811359.16766.18131279195615642514@noble.neil.brown.name>,
 <dc25626e-fae0-401b-93ed-1c4fdf34186c@app.fastmail.com>,
 <176472909957.16766.8691035364646019081@noble.neil.brown.name>,
 <eaaa46486ec7b1273adfc1a3bdbf11cb1f557e40.camel@kernel.org>,
 <079ef086-fa1c-4a9f-b011-e47547b4e3bc@app.fastmail.com>
Date: Thu, 04 Dec 2025 09:45:03 +1100
Message-id: <176480190344.16766.4086911917002460445@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 04 Dec 2025, Chuck Lever wrote:
> 
> On Wed, Dec 3, 2025, at 7:26 AM, Jeff Layton wrote:

> 
> > I agree with Neil here (despite my questioning this on our call
> > yesterday).

Ahh.. I wondered what had triggered the about-face between one patch set
and the next.  I now see it was your off-line conversation ...
Maybe it would help to surface this:

  Jeff suggested in a private conversation that ....  so this version
  takes a different approach and .....

??

> 
> Then you prefer the v1 patch that reuses the nfsd_file already
> in fi_fds[O_RDONLY], and we can drop the addition of the
> WARN_ON_ONCE ?

That is the direction that I would prefer too.

Thanks,
NeilBrown

