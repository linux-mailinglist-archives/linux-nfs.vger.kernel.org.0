Return-Path: <linux-nfs+bounces-21202-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOL1Mpn272mFMwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21202-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 01:51:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F353C47BF58
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 01:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 320BE301327F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 23:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0E63B6C18;
	Mon, 27 Apr 2026 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Lm1wnpTM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dKYGQ7x/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA7175A81;
	Mon, 27 Apr 2026 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333889; cv=none; b=Eds9YJjzG/5C7OnnTf1EdERLenqjYpfg4nMtXsXgwZp/N/APH+Qpp+i2XQKQ1u7GXMOBjR15HovEP1/lySY9HTxIVGyFyZ+B3D+z+o1n+QxrG6sTCAOCwBu3dpTBmB97uV3q5IAbcLb6dbPS08k0oIErN1QAu1v0csX8BoEoYs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333889; c=relaxed/simple;
	bh=mvMicDDfuQ91yWQ6x+2NhBD7HijHVbBp+TrBG6BEalI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=uaPRhlTm52DZ1ifiwGt9ot8YhKvzZqHN73B4ayF2WEoqkMFadZcjxJLp4zLcD5Ef5+RqITY/Ot+MBGjeWEJrIZFI8tWGSKRwQGYVNeBhdHSVnNqG1KlxLCQZajJsp4753Wh5WekVcuDVUoW9eRya0T2Zh+lCDqB+xu2TEcs61w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Lm1wnpTM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dKYGQ7x/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1041D14000E7;
	Mon, 27 Apr 2026 19:51:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 19:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777333886; x=1777420286; bh=RLnpXWB1C4BSlXHpUNFk6dMCri7Yu5n9eIK
	TWnvLMwI=; b=Lm1wnpTMcTE7q5vAdvhtp8zdQelEFhi1w2e8B4y/P7tvdwz5FM5
	+4IyK4sJBaTCLgTZO3BD8o0MpCOFfTr5muLR0IvVeTi5/nSwOilpMuILNadLSto8
	XxdGfFakL7HXlijpcSWT5Ah9FgDqjuLdMxtWKABgh39Dpx/9TB5yiyIPMtFZNUwo
	LsAkwHgW+mxLP5Hm/qyjhxyS5hHolETwdVsk0fM8MWmsgSgqWCeclIbddSA3Tgia
	hL2zDu1FzgTimkpfY+TGG+CMB/lce1IWlPHvNICvwaFtLG6A+Hjs5P4K1D3UpMJE
	RkuV0HG8SOFCrdKvZ9A+meVUXXtyHMGHliQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777333886; x=
	1777420286; bh=RLnpXWB1C4BSlXHpUNFk6dMCri7Yu5n9eIKTWnvLMwI=; b=d
	KYGQ7x/ahproGJ2u+JGp9LJ89xSesowTB8cc6W4j+Wlws37iLIQBlGDG0rk3h+TX
	XTFjMA+4KTUQpYiKw0fOJvUk6QbH3V6XeIiWaTn6tZhWV6kMq7PC/xv3ovUQm1tg
	hqsn19bc+Dygmic/Dk5XqS1cHTSQJz1l/w5diUt/y5XJwTStR1WwgMaS5cgUGgXv
	Y1JjEFNaBpH4y5N/Wc/DrzZbhnRY51br6polDpCFErdbvhYqW8hFF2rye0Oz8GWj
	7HA+DkXlESiRoaCVQDdWzhigUSXSPWv2eeZC8l7OZJRMOcDFEMYJxNb59/JM6Buy
	Vk/1SQVV/u/wJ/3w1yVEA==
X-ME-Sender: <xms:fPbvaTnCihP-mJr0aqlb_j-TAkfD6bmg2zcl2dbliB__Q5UY58wNEw>
    <xme:fPbvaTKyoSTHZrPkbeJKTdmuK_xHfY0E13OCQPbGl8MJxs6MS3-smmaFbQIwitXBw
    iLZVEotKgh5IuA4cQZhm5MloChdKHwEDy9ZPldjFLlOYUFaqg>
X-ME-Received: <xmr:fPbvabRt_zqGX1B907E9JA12E35RhtkliOdl5FcNkVMkdI1hZkeFvebhefXPKKdPDN8inssPdg-mAvo3C6fEgFG_N61Jf1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektddtiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:fPbvaYsshh5MXjM7S0dgY5w476poGR35AvRdBarqOKnXoFPZSyd2hg>
    <xmx:fPbvaW91K-jov4HMgvUgrszUFveKO46PTZLrf-JHMH3USQngYjaHQA>
    <xmx:fPbvaRaT_IzAZxynMKJK2l8cJvNVFcxtkt2njBgHzlL_u2Z2V08vQQ>
    <xmx:fPbvaSoXuKyLm_m0FSdIzzZrvnkDMnqskCP4CYtPd6zNbihCyHbSgA>
    <xmx:fvbvaUXhFFDDGrc0HkM9csP-z7fqgwaB3sZGW9OhgjRDZSLZMKN3KKfE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 19:51:20 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
 <CAOQ4uxiMUKHuGwpSkD=M4Z_QLxHn7Os9vaaWqAWd36HdfDRYuQ@mail.gmail.com>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-8-neilb@ownmail.net>
  <CAOQ4uxi8rqkbhK4=8N1ncfU1m6bjdHLbinSf=j3k0oVEaSa-wA@mail.gmail.com>
  <177727962988.1474915.2841674553452335690@noble.neil.brown.name>
  <CAOQ4uxiMUKHuGwpSkD=M4Z_QLxHn7Os9vaaWqAWd36HdfDRYuQ@mail.gmail.com>
Date: Tue, 28 Apr 2026 09:51:15 +1000
Message-id: <177733387513.1474915.8575818212511266099@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: F353C47BF58
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
	TAGGED_FROM(0.00)[bounces-21202-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,noble.neil.brown.name:mid]

On Mon, 27 Apr 2026, Amir Goldstein wrote:
> On Mon, Apr 27, 2026 at 10:47=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrot=
e:
> >
> > On Mon, 27 Apr 2026, Amir Goldstein wrote:
> > > On Mon, Apr 27, 2026 at 6:06=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > > >
> > > > From: NeilBrown <neil@brown.name>
> > > >
> > > > Some ->lookup handlers will need to drop and retake the parent lock, =
so
> > > > they can safely use d_alloc_parallel().
> > > >
> > > > ->lookup can be called with the parent lock either exclusive or share=
d.
> > > >
> > > > A new flag, LOOKUP_SHARED, tells ->lookup how the parent is locked.
> > > >
> > > > This is rather ugly, but will be gone soon after we move
> > > > d_alloc_parallel() out of the directory lock as ->lookup() will *alwa=
ys*
> > > > called with a shared lock on the parent.
> > >
> > > Neil,
> > >
> > > Forgive me for being skeptical about the *always* part.
> >
> > Scepticism should always be encouraged.
> >
> > >
> > > How long ago did we add ->iterate_shared()?
> > >
> > > It's true that Linus eventually got rid of ->iterate(), but we did not
> > > get rid of the assumption that iterate_shared() might be upgraded
> > > to exclusive lock.
> > >
> > > The obvious reason is that *someone* needs to do this work for
> > > old filesystems, which are also hard to test and nobody wants to
> > > touch them.
> > >
> > > I have nothing against this patch, but I think it is more realistic
> > > to state that LOOKUP_SHARED is here to stay, so if you think it
> > > is too ugly, maybe there is something to be done about it.
> > > Personally, I do not see the ugliness though.
> > >
> > > Am I misjudging the situation of shared lookup wrt old filesystems?
> >
> > Yes.
> > All filesystems must support ->lookup with a shared lock because it is
> > already the case that with a simple lookup only a shared lock is provided.
> > A filesystem *could* examine the lookup_flags and deduce if the lock is
> > actually exclusive (e.g.  if LOOKUP_CREATE is set) and misbehave
> > accordingly, but a vanishing small number of filesystems  (NFS and ....
> > I can't think of any others) ever look at the lookup_flags and I'm
> > certain none do anything so ... creative.
> >
> > So I'm certain that it is safe from the filesystem's perspective to always
> > call with only a shared lock.  All that is needed is to change the VFS
> > to only ever do that.  That means separating the lock for lookup from
> > the lock for create/remove/move in directory ops, and one way to view
> > the current patch set (the complete one, not just this initial set) is
> > that it does exactly that.
> >
>=20
> I see.
> I will remain skeptical, because there is always *something* with some
> special filesystems - think fuse servers (not under your control) which
> have grown to rely on the kernel to serialize atomic_open() on the director=
y -
> but the level of skepticism is lower now ;)

atomic_open is different from lookup!
atomic_open already gets an exclusive lock if LOOKUP_CREATE, otherwise a
shared lock.  That won't change.

So if an atomic_open handler wants to drop and retake the directory
lock, it can switch on LOOKUP_CREATE.  If it wants to call d_add_ci()
from atomic_open (which is credible in the non-CREATE case) it would
need to be careful.
But no current users of d_add_ci() (xfs and ntfs) support atomic_open.

This proposed practice of dropping and retaking the directory lock is a
transitional arrangement only.
Eventually we will get to:

 inode_lock_shared()
 ->lookup()
 inode_unlock_shared()

and that will change to simple

  ->lookup()

with

  foo_lookup()
  {
     inode_lock_shared(parent)

     do the lookup

     inode_unlock_shared(parent)
  }

and then if "do the lookup" calls d_add_ci() or otherwise needs to drop
the lock, the code that needs to be unlocked gets moved after the
inode_unlock_shared() and we won't need to take the lock again.

So ultimately the fs will be completely responsible for any
directory-wide locks that it might want to take.

fuse would be well advised to keep the directory exclusive locked across
upcalls unless the server has advised that the lock isn't needed.

Thanks,
NeilBrown


>=20
> I mean it would suck pretty badly if locking order would be fs_type dependa=
pt,
> but honestly, I do not think we will be able to avoid that, so we need to
> make sure that humans and lockdep are able to understand the different
> scopes of vfs locking at least per filesystem type.
>=20
> Thanks,
> Amir.
>=20


