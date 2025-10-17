Return-Path: <linux-nfs+bounces-15346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5BCBEBFA5
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 01:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01BD8353609
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 23:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90C0199931;
	Fri, 17 Oct 2025 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="QMZIap1T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oruqB2Bd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60850354AFE
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760742929; cv=none; b=Rlz8J75sLrVWy9WZkj8ZXeefrVKZbCuNxlQLe2H4nyA39pB29AIt8+OwxLToqJUjS2B6PZgYOrJSeaubN9krx4gwJBVvl39+GAM4srans/qMZOve/4Wn1YaOpmwuHG8YmdbhdYvGfewk0+kzZc9Kfxw/ksIN9F+8rYB6JMaC/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760742929; c=relaxed/simple;
	bh=TqpHNaFG7mnzXuNLgVURK++edqitCQj3JV5D7bruuXU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=kA9t/xCC7Jqixy/9E2Xt4S+dzoYnGZWQ1nS+wq7yeDO4MPkWXuXgXqDr7MJ5WcLDsC/80jF6Biqc0q5fXvLbnATXFHoW9Rque7e+WViUEA51QvG7OkL+fIAZsK8X2qSK4jp3Kh+to3+mXWl+PCA6eU0t2KWmb07B9/ZbKvVx2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=QMZIap1T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oruqB2Bd; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 60744EC027B;
	Fri, 17 Oct 2025 19:15:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 17 Oct 2025 19:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760742926; x=1760829326; bh=mGmjrD5Yl3oXA454TJIltp7D1JbD1O/SI8s
	+oyXZdHU=; b=QMZIap1TGa2i18hu8Nlkp4in5kLKEXxc9XaJyqv4lHL6oRoXHzz
	8LstOAIRLw1M4129qXiTGrV5pikcL8BXY6PnyUbCJB7KynprE8AbMB0m/Xu0hKL7
	oiNvoZJ+0BDshdDHQBLqC5RiFrm/F8R67dMnM+85EOKqL2w4E8phoIdiovdYmV77
	L2BTRiIVafSdbM6cWZHjd0e1+Zuh7UMFuyOavlfjlM38aFW4lbNH18T8C/dWvf1i
	xRvEUQ4UumMTtd34sTkw1aUbwAodqAhmE9x0ywTgJizb99kmLSh6TcC5rTmOE913
	jsgpgKHqCQykp1BJvRvElnQJNwGZNSR47Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760742926; x=
	1760829326; bh=mGmjrD5Yl3oXA454TJIltp7D1JbD1O/SI8s+oyXZdHU=; b=o
	ruqB2BdqZWGjRjEga8YVkwSrVPypIlQRshYVWMMjoCKzFBo0oapdOSG7FhebQXvk
	7wzuN8HwHRAHCK/nwat92uKn4KBG4limJfUf9YTx8yhh4NnO9R7nFwb71RCnOu4E
	9z7IdFciyhXHHmuqyFbGky9YqlJYtAMuYxakrAQW8vwYQhBix+X/rwxxR6X4oX8L
	mCqqaJBgjl1FWu7bfogyYZKGDiMnqku0GckrWMegP4zzIRaK37/lK6i7cJzPPi8d
	9EqnLHjunsnrgI4Scbeo/xZmqWy1EUkWnRhz4HFZEnGPJHENbzyWJzIxjKFZuJ00
	VVF2ZhemDRvSUG4lkjLdQ==
X-ME-Sender: <xms:Ds7yaN-u_ACc02JGFJx2--NfdeLxeff7dzn6zlY08kzR210J_GrQOg>
    <xme:Ds7yaAzKr5Ysg-MeoBP7QxLPBk_MS38SjK8VMqis-FgUO2bql022s7akzx4r-37YH
    4G2gwTmvMCk8sCpGkezX8arnBfns3PO9qQ23f_39-3w8KHFTg>
X-ME-Received: <xmr:Ds7yaBON_FZ6Ko0u0ee2BJDjqMOsmSqdm0itq75pp8UkJ6EDPYwoMYI0icCjuEGE7K1rXxgb4aV96tjXvPZM6f8lwt8-Akkto5a6Nh6adm39>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtgeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Ds7yaN9AtOzZqrsxR_d2iZZ8drjypda9Lss4Fix6HtsUvPlmhRVGAQ>
    <xmx:Ds7yaG6H2hLEI4xS4R64aG6DbUe3bnL1irRnfsr8tN5JfJONTZPdBw>
    <xmx:Ds7yaL572HpSCX0Oa1mdh6z_3nat8fWrw6Oyt1vHoNmAUTmUPwdtOA>
    <xmx:Ds7yaHq0RCdCKKG0qHZIfFxFNX3NjRNQtuOpPiFYZoYCCA708GyU3g>
    <xmx:Ds7yaNjw_RoytXD9yfII8ErC90HNoHJjaPnO28m_VC7R797V-RwGgUUO>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 19:15:23 -0400 (EDT)
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
Cc: "Chuck Lever" <cel@kernel.org>, "Mike Snitzer" <snitzer@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS clients
In-reply-to: <9cb044ec5e03730c445f424d53afb3dbe51733d6.camel@kernel.org>
References: <>, <9cb044ec5e03730c445f424d53afb3dbe51733d6.camel@kernel.org>
Date: Sat, 18 Oct 2025 10:15:16 +1100
Message-id: <176074291626.1793333.10920318695776387234@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 17 Oct 2025, Jeff Layton wrote:
> On Fri, 2025-10-17 at 17:22 +1100, NeilBrown wrote:
> > On Thu, 16 Oct 2025, Jeff Layton wrote:
> > > 
> > > Somewhat related question:
> > > 
> > > Since we're on track to deprecate NFSv2 support soon, should we be
> > > looking at deprecating the "async" export option too? v2 was the main
> > > reason for it in the first place, after all.
> > 
> > Are we?  Is that justified?
> > 
> > We at SUSE had a customer who had some old but still perfectly
> > functional industrial equipment which wrote logs using NFSv2.
> > So we had to revert the nfs-utils changes which disabled NFSv2.
> > It would be nice if we/they didn't have to do that to the kernel was
> > well.
> > 
> > What is the down-side of continuing v2 support?  The test matrix isn't
> > that big.  Of course we need to revert the nfs-utils changes to continue
> > testing.  I'd be in favour of that anyway.
> > 
> > And async can still have a place for the hobbyist.  If a human is
> > overseeing a process and is prepared to deal with a server crash if it
> > happens, but doesn't want to be slowed down by the cost of being careful
> > just-in-case, then async is a perfectly rational choice.
> > 
> > I'm not in favour of deprecating things that work.
> > 
> > NeilBrown
> 
> I think we should. We deprecate obsolete drivers and (even CPU
> architectures!) all the time. Arnd has even started discussing
> deprecating 32-bit CPU support in the kernel altogether. Why would we
> not deprecate obsolete protocols too? The handful of people that still
> need v2 support can boot to an old kernel.

Protocols support interoperability.
I might want to run new software on new hardware while being able to
talk to old software running on old hardware.

So I think deprecating protocols requires more justification than
deprecating drivers or architectures.

> 
> Supporting NFSv2 is a maintenance burden (albeit a mostly minor one at
> this point). If we want to properly support it, it has to be tested,
> which I don't think anyone is doing currently. I only have so much time
> to spend on upstream maintenance, and I don't care to spend it
> supporting v2.
> 
> SuSE's customer using ancient equipment is an exception here, but I
> don't think that's enough to justify all of us spending time keeping v2
> limping along.

How much time do we spend?  128 patches in 10 years.

(and BTW it hasn't been SuSE for a long time - it is SUSE :-)

> 
> Do you have the same attachment to NFSv4.0? We had a discussion around
> starting to deprecate it as well. Having to support v4.0 _is_ a
> significant maintenance burden, IMO.

Good question.  My perception is that it is still used but it's use is
decreasing.  As it is so much more complex than v3, I'd be surprised if
there was any use in "industrial" space where long lifetimes are needed.

I agree that v4.0 is a greater support burden than v2, and that is a
significant consideration.  I think it is good that v2 has a config
option that defaults to 'n'.  I think a similar option for v4.0 would be
good.  That would also give a clearer picture of how intrusive v4.0
support is.

If supporting v2 really is, or becomes, a burden then removing it should
be considered.  But if it isn't a measurable burden, then I would be in
favour of keeping it.

NeilBrown

