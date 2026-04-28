Return-Path: <linux-nfs+bounces-21264-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJQ3EHhI8WmBfgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21264-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 01:53:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D954B48D931
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 01:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EEAC3197E90
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 23:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4039D6E9;
	Tue, 28 Apr 2026 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="SERDNOiD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r6HyJ9i3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8139BFE8;
	Tue, 28 Apr 2026 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418826; cv=none; b=pwIEnSngWaMKmjsWXxj425oqpFL9t4V12q7pOBFCb8CIPk7y4cQ7Lkg2UL9dk1HAvmEW7MmqqxyzMcFhN8wMWGCfwNAx4+eRauK9+EEJxXN7N4QbjnunDrPSVkNf2xC970lpQVijdVkCBB72bMyRFLciFeEN8ZxFJdZG1TZv190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418826; c=relaxed/simple;
	bh=H83mUExKMOJ9QVnA/PT+IyVVWp9gs26S0cQ2MWYxix0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ADtp/abKTJD6P19OvCKEAr0Y+I4GdtSMqaQrEEnC2OJ0ZFYZpl8cVVujBA7ViDoOcYvR7kdEdQT6NbiyevRMfUMjV8RkQFIoQBg6f4RDWVsUaVPadiTQJlnNhgO0HA/kCQMa5i2AiacXDwqd1P6+6Bv0xBNkdGKaqS22QvjmHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=SERDNOiD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r6HyJ9i3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 306A4EC0129;
	Tue, 28 Apr 2026 19:27:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 28 Apr 2026 19:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777418822; x=1777505222; bh=at/a6IqJDyCCIZdrIl3n76yHV6BWGZ2EUYj
	l3mPQ+fc=; b=SERDNOiDle0vCp609KWqlYsQQFrEXAL85Bk39reBC8w74xyf2WT
	MMDif7fmPWa3l4q9hsYTJs45IrPdzCYurQg5kA9RGEqNn6kW7lVDnHFzi6ehO953
	dkwcFeCNOsIsXoxc3Ia42rCy8+8BetAzRUdhyQY+5/G6ptowgOLHFmLbr8UQBXRV
	838SRHKQylJDtwI6Hq8Ge1qtrPZ8yZ7fQOsEo8L1o31H6hXaO10I5oqrk/rSCHVi
	+dGpNAQ2H2VhWbcW1lAuRubZvdvNG4ohp4OXP79eUHawOkw2wIP90YVWUhi2TC46
	TtH6cVN76SSXWMI/r3XvN8eEHpposQceN2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777418822; x=
	1777505222; bh=at/a6IqJDyCCIZdrIl3n76yHV6BWGZ2EUYjl3mPQ+fc=; b=r
	6HyJ9i3TZwRKv1XLp1D7bPNclNrhDHj+zdG2klB09MHuMw95eXc+ouZFdUFnIQ4e
	rROlBeSyfgsFGQU3Bkt+PGC5bW8Y38ziOTzy2rCdzbCIPCQG8oS2SoNXdNMyd7rF
	QlnICR1J1Ya03hCALU3PtrrSAKOkirpLQeLI7i9edxbYhE9J70vezuxf61JUIRRo
	h7icrpeFL0yUxHKnUf67x/RQ5IDZNSZOvqSuVWNQr3wwsuQteO9Q8DVUmuq3b45k
	yIX7B1W82UUWrFWv+lewOqaoj1kSCZF6ECF1O6SWG+iXht39enlo4ClhP+F7520e
	x7S6/0LvJOZlrJwzrMonw==
X-ME-Sender: <xms:RULxaQzRCQyZrVTAI9K4LF-ayzqIH5tdx0Czi3e-a4fiWDc34182sA>
    <xme:RULxaQmUkL4KsmjNACuNx-2nyXlB1eo8DSN_kb4AHd6LhJ7HOUhqAi4ZvKOkevj2o
    4Eggi55w2leZoMQ_cK9EBOasEbYJEbKQ1pEK77UjwUKmg-T>
X-ME-Received: <xmr:RULxaT_A0Aj8ivIzKyW6AnfX6XUWJpHiFwcr5wEIYemS_s_zWEP6FeCH8EO6YLGLmGZcb3IubPN-tHUH__2KeowqZa2G-78>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekvdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
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
X-ME-Proxy: <xmx:RULxaboz83LYCvdTLUtmgkqGguz2I8kX4N_4jfZRyYoe52aBC6GgiA>
    <xmx:RULxaXK-XzAU_sGbQYmFiAiHmI8OHsNtaBPuBKFmVMpURLmxRpzvqw>
    <xmx:RULxaV1bnC2HzAjr7fEl0M2lF5tuDCo9UwPOE5jfuTU9PjQyMKzFmg>
    <xmx:RULxaWUnJNJmgjOJRIk0qZskktslDTA1IsYTsCdeqjkYzRcW75wK5Q>
    <xmx:RkLxaS6Bf5OdNQlmr0DZKgYdh4VPbqbELTEXHU_aXr06uqJ97FRksb9p>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 19:26:57 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jeremy Kerr" <jk@ozlabs.org>,
 "Ard Biesheuvel" <ardb@kernel.org>, linux-efi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] VFS: use wait_var_event for waiting in
 d_alloc_parallel()
In-reply-to: <20260428142225.GX3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-5-neilb@ownmail.net>
  <20260428033738.GV3518998@ZenIV>
  <177737511992.1474915.1952404144121931523@noble.neil.brown.name>
  <20260428142225.GX3518998@ZenIV>
Date: Wed, 29 Apr 2026 09:26:54 +1000
Message-id: <177741881482.1474915.12527082398060370192@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: D954B48D931
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
	TAGGED_FROM(0.00)[bounces-21264-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:replyto,noble.neil.brown.name:mid,ownmail.net:dkim]

On Wed, 29 Apr 2026, Al Viro wrote:
> On Tue, Apr 28, 2026 at 09:18:39PM +1000, NeilBrown wrote:
> > > d_must_wait() conditional, though - ->d_flags and ->d_lock are in diffe=
rent
> > > cachelines and there's no need to dirty both every time we are called.
> > > IOW, have d_must_wait() do this:
> > > 	if (!d_in_lookup(dentry))
> > > 		return false;
> > > 	if (!(dentry->d_flags & DCACHE_LOCK_WAITER))
> > > 		dentry->d_flags |=3D DCACHE_LOCK_WAITER;
> > > 	return true;
> >=20
> > The only time that DCACHE_LOCK_WAITER will already be set is when there
> > are two (or more) waiters as well as the thread they are waiting on.
> > That means three (or more) threads all accessing the same name at the
> > same time.  How often does that happen?  Is the micro-optimisation worth
> > the small increase in code size?
>=20
> Depends upon the load, obviously - a bunch of threads hitting the same
> pathname at the same time... not impossible.
>=20
> More to the point, why not set DCACHE_LOCK_WAITER as soon as we grab ->d_lo=
ck
> there?  Then waiting becomes simply "wait until !d_in_lookup()".  Sure, we
> might end up setting DCACHE_LOCK_WAITER on a dentry that has just dropped
> DCACHE_PAR_LOOKUP - who cares?
>=20
> While we are at it, do we need to drop it when we clear PAR_LOOKUP?  Because
> if we do not, the whole "what do we return from __d_lookup_unhash()" thing
> disappears - we simply pass the dentry to end_dir_add() and have it check
> ->d_flags & DCACHE_LOCK_WAITER to decide whether to bother with wakeup.
>=20

Yes, your are right.

I've been thinking of this mostly in the context of locking the dentry for
directory ops, for which lookup is just one special case.
In that context the dentry can be locked and unlocked multiple time so
we really want to clear DCACHE_LOCK_WAITERS on each unlock.

However in the current code it is only used for lookup which only
happens once on a given dentry so we never need to clear
DCACHE_LOCK_WAITERS.

On the basis that we shouldn't add complexity until we actually need it,
I'll rename DCACHE_LOCK_WAITERS to DCACHE_LOOKUP_WAITERS and never clear
it, as you suggest.

Thanks,
NeilBrown

