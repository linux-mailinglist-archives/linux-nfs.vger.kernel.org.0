Return-Path: <linux-nfs+bounces-21161-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKuRC2sj72lV7gAAu9opvQ
	(envelope-from <linux-nfs+bounces-21161-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 10:50:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 812AC46F66F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 10:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C15D8300C92C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 08:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A6039901A;
	Mon, 27 Apr 2026 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="pWZFz2u8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tOWDNHbS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50C386C36;
	Mon, 27 Apr 2026 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279642; cv=none; b=Z6vvuXw4/+Zcfe9rKHMOtWcp2dAye0U5y0HtuBrewj8upouim/ql1bjiblsr5pXj9JDYb2I77sjwpnDDH/takNZXliFCGM3WBajv9jH0ZSJu9z7xHqHFtZxRqgwF9FSBuwJoU7M7a72umUEyaDMWxd7kZNSc5x/3GaZHTsfLeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279642; c=relaxed/simple;
	bh=x8IrAdNm5gcWTQot940bqU3wZaKyRnKqN8OS30gF8nQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=c6+a4soZsHUfuowsVbnLoYO9YZbzkbS14Ew5K0Q6hbrz6nMlHIQauiPXKmBxLOhl+ENtukrYjCmR2BzjvA7BIhZfV50oSn5EE4yRBMaEoA0LFTUIOJRbcK5K0Q2dibOYK9zDjooNe12pYLlwSZPHRibTGlYJ36oJMWUk65pBBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=pWZFz2u8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tOWDNHbS; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15549140008D;
	Mon, 27 Apr 2026 04:47:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Apr 2026 04:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777279639; x=1777366039; bh=FBe5VpX1Rb6JIbH61KWWGONSQrlIgrVejqe
	2hcQO24M=; b=pWZFz2u8Fi8E1zPc03GUEFGqhlEBk9CTxZzSrCesHIOaTC2ZIsh
	AJVLwijLlFyk3tFVJESVR78VyNeBazeShdZ17nY4qJpPddZ0SCvTtTCOSVTDdFa6
	jIOG0I1AZFg3R+ZyoLLhtRzisafmzeGw28AGvxq1gJn9QyjUS/0WWXObwYkdDR6y
	JnPV3HLKT4fMQbcYFB+N7Q39k12oXY8kFdD2SWs9maiTYl3v4sfJwVpkKMnExW0l
	FiuOfCCVwc0iDa3GOoPdgIzmy4sYzG2NoOZrwFJsdXYLBW7wBY6yi4/K2cVTGEaV
	/lUwa0k/Qqu1AQK7FvXkeq1SLUznxyI5NtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777279639; x=
	1777366039; bh=FBe5VpX1Rb6JIbH61KWWGONSQrlIgrVejqe2hcQO24M=; b=t
	OWDNHbSm/93XXRairGV9SECSrLbmf5SXrERHMcyLH+pVTRu/ZHBGps9ued2U3px4
	8+rqLROtG/M8gAYDLABe6xBuzsTMGeqhAVsX5Ck5Ejf8yyDAU2rmScXwVn8GMUkz
	5cuuCvEMOrWpJgTjI26FPaGLMWIhYTHaYfJ++eYH4bL7XTpiNClGISuPKxGTP+qA
	t1GgUga/wGr/FdD/TOrL0WMQBBGyQhSGb48T8selrQCciZe2g7hqdoZaP5sahQny
	YzHa6tvRTjXXtWkaBHMoxX6DDQOPxv6AjtCcut89O/HYjbPTRNiRdOZqJa98oUMX
	9Kmri04W3Q2aK3rZElBNQ==
X-ME-Sender: <xms:liLvaZi-OJsKb664ygMOxLUOWEmbrnAL57tdZET8dWGPvbe6dF0SxQ>
    <xme:liLvaSJZe1BsfkPxdB6kEkYCaJav7CIkrWqi0fHREbp_XzeGeY2SdPEBY0IwnKtil
    BbfBwjPizzjP-tklRFHWrEoCzc6Zt5kxhjPcaDOPcTo2cDt>
X-ME-Received: <xmr:liLvaWE-NgffTLzEX2bSKrDJxswo-4GoKEP9E1eEJB_i5JEnJwRsFBdaB3uvYIlVNzhr-NfmmJSZx_vyIEB1LnVAT2oZwJ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthekredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    dvhffgheekkeeitdelfeehhfekvedvgeffhffgudffieevleffheelhfefheevteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:liLvaY1RcTDBvi3inM8xJOaa6xTyjklJIfc-lYI1Vid3Wwpw73SInQ>
    <xmx:liLvadw_JgbWHmW2jyTqOOjfMAO8HmoL92T2TFjXi0ZHH946fBjSbg>
    <xmx:liLvaXiLOK9vjxucnUsirBowIKcsugmzpF1sDAh8MSCMoAUH3O_m0Q>
    <xmx:liLvaczNKagXB9cd_K_HlbHErkc2IrErq1hQpTejBz86ftut6M2Raw>
    <xmx:lyLvaUV8XAw_tvaj0TowmBxdPGZxaOQbVqZrfSPjc3kg-10JaezqrEQh>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 04:47:13 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Jeremy Kerr" <jk@ozlabs.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/19] VFS: Add LOOKUP_SHARED flag.
In-reply-to:
 <CAOQ4uxi8rqkbhK4=8N1ncfU1m6bjdHLbinSf=j3k0oVEaSa-wA@mail.gmail.com>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-8-neilb@ownmail.net>
  <CAOQ4uxi8rqkbhK4=8N1ncfU1m6bjdHLbinSf=j3k0oVEaSa-wA@mail.gmail.com>
Date: Mon, 27 Apr 2026 18:47:09 +1000
Message-id: <177727962988.1474915.2841674553452335690@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 812AC46F66F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21161-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:replyto,brown.name:email,noble.neil.brown.name:mid,messagingengine.com:dkim]

On Mon, 27 Apr 2026, Amir Goldstein wrote:
> On Mon, Apr 27, 2026 at 6:06 AM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > Some ->lookup handlers will need to drop and retake the parent lock, so
> > they can safely use d_alloc_parallel().
> >
> > ->lookup can be called with the parent lock either exclusive or shared.
> >
> > A new flag, LOOKUP_SHARED, tells ->lookup how the parent is locked.
> >
> > This is rather ugly, but will be gone soon after we move
> > d_alloc_parallel() out of the directory lock as ->lookup() will *always*
> > called with a shared lock on the parent.
> 
> Neil,
> 
> Forgive me for being skeptical about the *always* part.

Scepticism should always be encouraged.

> 
> How long ago did we add ->iterate_shared()?
> 
> It's true that Linus eventually got rid of ->iterate(), but we did not
> get rid of the assumption that iterate_shared() might be upgraded
> to exclusive lock.
> 
> The obvious reason is that *someone* needs to do this work for
> old filesystems, which are also hard to test and nobody wants to
> touch them.
> 
> I have nothing against this patch, but I think it is more realistic
> to state that LOOKUP_SHARED is here to stay, so if you think it
> is too ugly, maybe there is something to be done about it.
> Personally, I do not see the ugliness though.
> 
> Am I misjudging the situation of shared lookup wrt old filesystems?

Yes.
All filesystems must support ->lookup with a shared lock because it is
already the case that with a simple lookup only a shared lock is provided.
A filesystem *could* examine the lookup_flags and deduce if the lock is
actually exclusive (e.g.  if LOOKUP_CREATE is set) and misbehave
accordingly, but a vanishing small number of filesystems  (NFS and ....
I can't think of any others) ever look at the lookup_flags and I'm
certain none do anything so ... creative.

So I'm certain that it is safe from the filesystem's perspective to always
call with only a shared lock.  All that is needed is to change the VFS
to only ever do that.  That means separating the lock for lookup from
the lock for create/remove/move in directory ops, and one way to view
the current patch set (the complete one, not just this initial set) is
that it does exactly that.

Thanks for the review,
NeilBrown

