Return-Path: <linux-nfs+bounces-21252-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL//FH+h8GkQWgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21252-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 14:01:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D436484705
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 14:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6B7E30E7DA0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 11:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731D83B27F3;
	Tue, 28 Apr 2026 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="dzHWJGYN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L7Ua+u9s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393FE3B2FD6;
	Tue, 28 Apr 2026 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376653; cv=none; b=im4VPJuMd7Zayv6LUTj8qotxSgUQ7MrmlyZ8i0HExtbOwlclXVXygItgCEcbwytLAs1yxHWdo0h8i+MUwO+skFnNh3oKyJW2KPubFCqPGYOlWyCApPBJq0pkH2c4XHrNr9GeuPr6/M6PoU9SJpXNEgtrTuVTM9PczRjZ1P0gl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376653; c=relaxed/simple;
	bh=PL8UHmWrQoXJLGqqAY6Lc/MVZPItciZEYbR4i6YeEDc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=b/a5opyKGZ0htwC/AP5Qg3/Z4If3tzjhZIQ0recfng+qoSJmTb3Gx3jV3Q3sLs57RfPROy2xppn7EiN9rFJx0GlOBHVIFgQsHL9SUoAbONax3ff5HnoUHZ9cQZOAsxg4F2k0aZI8d0dmBOulPCjkD8L076T8h8Q6AdLNQJoQffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dzHWJGYN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L7Ua+u9s; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8437F7A01A6;
	Tue, 28 Apr 2026 07:44:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 28 Apr 2026 07:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777376648; x=1777463048; bh=hNvCDZbxO3ENbBCMR1/00f1PQ5HW0ZeSNyw
	OZeKHXEs=; b=dzHWJGYNLjXo+VhYfMC3Hshlt89PskdbIzlnO57mFwI+nU0fiGT
	AJVZcH5TerOJOEYHm2K2lBd9FA4eHYOT3nBLqpUeDIyhfR8bfieITfOC+KTc9c5K
	pqrlk7BWmlVEVtKKWzGVdAnM8vrW+zWGh+VDgREZj28bqDs9g9YWBEh4iYq2IFHV
	cs0KCBWP4Mnn5ASFiim3WGsTDpvwRXqIRaMGuMk99unTDdYkdWm7dMLRA/HQa7Od
	JldcDkxPxbQZhXxb0zfJliivhyFirSczSL/GXp467CRwef71SfDmOwG3t1k9TJcy
	9VObzDdkLAnTbJ8uOu3v0fhyZtXMNDuvEfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777376648; x=
	1777463048; bh=hNvCDZbxO3ENbBCMR1/00f1PQ5HW0ZeSNywOZeKHXEs=; b=L
	7Ua+u9sU3TUD7Im/Y87/e1Z3bINkQHulNDLlHJgdSN9jfnAi6PBPkgwsk5XNJjwI
	+40RHke2SBUljCNJTXv3sJQOUQx6nCnmG0ISuVDfTSVbTB2dItYFb/xjO+5f4Qbf
	EXqtt9wSBSKIR4ZZurverHL3gVOrIRCUxzVMIVoytDmFRpiTT2lzOPoWBXW+dWiF
	Bjr38evKxEH92unUChrxro28jqYihp8COrBhfiXAVYA4l1e+Z83FpghC7zby1EMI
	lOQJaA8VfVnALgiKnoqy+lqutGZ3i5blan+Ag1NNrn0PHbQq/Vbx68FKW7q+OxLw
	FVTrosr4AMLnMc2C6pnzw==
X-ME-Sender: <xms:h53wacUnQmJWDuqzPo89pKGPBH9mqgcUEVdzK2iY8HNxNyUt_7W_aA>
    <xme:h53wac62A3M8vpxS_JlsevvAVE_EXVZgk4ZGay_zBC3OzLkxo_7Ytqugw66TJYryX
    LCgjHF5HzniwoKsTGFPkWeOmxZwQeBVezVzFkhgRJYYXA1xfA>
X-ME-Received: <xmr:h53waSCMrzJ7UBSXDspxHYdocoMj75rx6livtAC7XWZ4wseuaESGkhzaI60IQPql8u6LISLJHym6hmUHP-mFKX8nI0Ao0uQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudegjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:h53waYcoaIP7cbrdzBGwmC6q3tTWo1DFf9m6ibsaFIIKh_JkRqlPaw>
    <xmx:h53wabsnGLnldwuylEfVZWJTkIF3LS_W4Gj1DJo9bmBMOtbmazoRsQ>
    <xmx:h53waXLFBHC1zKRWwuE1GQR5RHFDpDxc5MhUL1w-A9OFtDU0mviLtw>
    <xmx:h53waVYwROlDIaxs6VgmAfOHbhCXY5Hwvxmjr-v7XJXZBe53YTfv1g>
    <xmx:iJ3waXEeVraZ0UHqrOiAo7gf9N96YlzcgsspYUCSGUNW8Lh2PyES3QKB>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 07:44:03 -0400 (EDT)
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
Cc: "Amir Goldstein" <amir73il@gmail.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Jeremy Kerr" <jk@ozlabs.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/19] VFS/ovl: add d_alloc_noblock_return()
In-reply-to: <20260428043511.GW3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-11-neilb@ownmail.net>
  <CAOQ4uxiZF0_dGtHY0x7T0oh=3jhDC7-THH_ANt-Ha5kfdRe4QQ@mail.gmail.com>
  <177733649056.1474915.2313612194633470905@noble.neil.brown.name>
  <20260428043511.GW3518998@ZenIV>
Date: Tue, 28 Apr 2026 21:44:01 +1000
Message-id: <177737664116.1474915.2913290838767301303@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 0D436484705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21252-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,suse.cz,szeredi.hu,ozlabs.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,noble.neil.brown.name:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:replyto]

On Tue, 28 Apr 2026, Al Viro wrote:
> On Tue, Apr 28, 2026 at 10:34:50AM +1000, NeilBrown wrote:
>=20
> > > This contract is a bit subtle.
> > > We have plenty of contracts where the caller must dput() in case of suc=
cess
> > > or in case of error, but must dput in case of a specific error that
> > > sounds fragile.
> > >=20
> > > How about:
> > > * If the existing dentry is d_in_lookup(), d_alloc_noblock()
> > >  * returns with error %-EWOULDBLOCK and the blocking dentry is passed
> > >  * in @dentryp. Regardless of the returned error, if @dentryp is set by=
 this
> > >  * function, the returned dentry must be dput() by the caller.
> >=20
> > That is sensible, though I've used slightly different words.
>=20
> I would add "dentry reference stored in *dentryp may be in any state -
> the only thing promised is that the reference is counting one;
> do *NOT* expect it to be in-lookup or in the same directory or
> hashed at any point or anything whatsoever, really.  Users beware."
>=20
> In case it's not obvious from the above, I don't think it's a safe API to h=
ave -
> there's very little you can do to that dentry other than dput() it and it d=
oes
> change things in a fairly subtle way: right now in-lookup dentry is *not*
> visible to any thread other than caller of d_alloc_parallel() that has crea=
ted
> it.  In particular, d_in_lookup(dentry) can only change due to actions of t=
he
> same thread.  With this primitive added this is no longer obviously true.
>=20

Maybe we could require the caller to hold an exclusive lock on the parent
inode (which the only proposed use case does).  Then we can promise that
the dentry will remain in-lookup as the owner will not proceed with the
lookup until it can get a shared lock.

 * The caller MUST hold an exclusive lock on the parent inode and can
 * be certain that if a dentry is provided in @dentryp, then it is
 * in-lookup and will remain in-lookup while the lock is held.

I don't have the patches to prove it yet but I expect this to be a
short-lived interface.  Once ovl has full control of the locking context
it should be able to allow lookup to always proceed while readdir is
active, so readdir will be able to use a regular d_alloc_parallel()
call.

Thanks,
NeilBrown

