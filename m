Return-Path: <linux-nfs+bounces-21319-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAKcBDbr82kV8wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21319-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 01:52:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A89E44A8F84
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 01:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6694301A1F7
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD663D8112;
	Thu, 30 Apr 2026 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="M08qftXn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cHS/FKj/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306BD3D904E;
	Thu, 30 Apr 2026 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777593101; cv=none; b=jjBJUzJUdmNY1MitSVH+a60If6dTcabygig/6nvU8WBil/10iiqrolqgIFG5xHSi6Fv+rfVySHz7y2F3ooz0+tlxLriCH35CadtGAmRcbX90SDdLFDxN6gbJwxJXY1k51GY2ixZwKahjoF056AsCWbTGB9BTTmWpKtrrJTC594w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777593101; c=relaxed/simple;
	bh=aO6LLC8o1CRIM0rP3dZEQagY+ByLjZzuWf3NiqNRKN4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IScjOwmJ7uiMgPJIJAgKAA5TSPRmmI9bUDBmynukULPGfUrYxVd4B3GD42r/7y2AFMrwgqLbEsCmor2a9f5bwdXEY/X5ANAWrHK9bjjDRfQSyHhTqdCSCP2ohgRyrC25UcYeVhPeGUjSpKHKDXWt9t/bE6SSrGjxGqKUiiFlHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=M08qftXn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cHS/FKj/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF5961400159;
	Thu, 30 Apr 2026 19:51:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 30 Apr 2026 19:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777593096; x=1777679496; bh=SoFsYwQGnMtWMKIme69DRpXKTM5BZO5qLvs
	+ZUwxrZY=; b=M08qftXnutctKSp/G5u74axo0GjWhCsfpUK8OR0I5JoXIsK02md
	GiF94elNIV5izQfaImQyXcjJxMiQ5vH10wEuiUhx5QfvlDUEkY8uA5EeaGGu6y+2
	gAjCQGBuCojrG1LOeN4uZh5uYzxmFIbqQYUeiFg7Tf8RyNqSm6NL9G7jAQxKyPNW
	QNtGsB+dRpcNI7j63tpUoLKAGBhqC76/DSv3np4Qh8AE4fgYsoGILHCgczB91qWR
	wLQAwSutU9pAP3Eai2KCtbD8daSepCOWLivGXIgVpx+5hXxsBTFavos+o2klHjb6
	BYf73Bf2AJg9SdSkJ15uwrTYFD1ZhSzb6ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777593096; x=
	1777679496; bh=SoFsYwQGnMtWMKIme69DRpXKTM5BZO5qLvs+ZUwxrZY=; b=c
	HS/FKj/qUnZDVmrRSZbqMiCoXRSyjiFOeEI4XuYSkzhzd5WQfAoHStf/4yQbOddR
	OGiZN9PPpf2Fm6wguVKI0qK1Ky25cvSEzKXt4yXnkt7ZT4H50TXSh+HDKCnw0O+b
	nmAPB1NqfWxedDuXNN3uQYpOmJ5HUau3NvrNMuVLTD5Z8DmyInuF4KjTnGsGr8sv
	UzHwj+JjGomgMM4PMSlh6z31YlobHPTyEfozbctDIQqWdhe4D1BVDJiSy57PDlIm
	S+c5VTFJmit6DKsnMRRT3yyws4pwDHl85nXgFbVO2gpDnO4PM1sP+zofVE4Fi2YW
	Y3bCTA4J0f7C/bEK4ytdw==
X-ME-Sender: <xms:COvzacsHaUgvHpBxoA1OhSFr9Wf26BmVYRIe39YqVxdglpLEboWRHA>
    <xme:COvzadlV0iQN0V0jQClf8pQZEkSyB7NoMiMv0L1_i-7pfy1nyq358ORdA3zM1Psx4
    Vb0CnX53nGLWxdsLxuQTERe_fTxvwZItCWtt98lqNdLMd8nFuo>
X-ME-Received: <xmr:COvzaUxCAEL5Mf3NKO22kS1vBdTAOPgi6QASYkmmHRdfFUeau8oQal_PKpu5c_SgIyKmKfgTw1NRTk4Wdtvr_O5PWU2nM84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeeilecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:COvzaZwenh6wP_KcPPyALOYQqiRbbfuVFESj5E3gfsRmrtnQc9m6sA>
    <xmx:COvzaT8JSbuduUt2JjHnZ1w6jWVjQNYd82tMcte0ktZ7u89KAHEqwQ>
    <xmx:COvzaZ88O5H2atcHOVuYrCZtgYPAT3cAUQ_adXn18y9gOBiVIXddkg>
    <xmx:COvzaWdFbHBD4NPLaBYmJBw0-FR20uOY0RW0LZ_1ugTgsY9Et525hw>
    <xmx:COvzaeCsiVKPAdC-rXvJ_YY_N5ldgTPvgJQPXf2mA48_juqBMN-zwSdy>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 19:51:31 -0400 (EDT)
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
In-reply-to: <20260429170731.GZ3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-5-neilb@ownmail.net>
  <20260428033738.GV3518998@ZenIV>
  <177737511992.1474915.1952404144121931523@noble.neil.brown.name>
  <20260428142225.GX3518998@ZenIV>
  <177741881482.1474915.12527082398060370192@noble.neil.brown.name>
  <20260429052626.GY3518998@ZenIV>  <20260429170731.GZ3518998@ZenIV>
Date: Fri, 01 May 2026 09:51:28 +1000
Message-id: <177759308866.1474915.9708613530229799376@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: A89E44A8F84
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
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21319-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,noble.neil.brown.name:mid,messagingengine.com:dkim]

On Thu, 30 Apr 2026, Al Viro wrote:
> On Wed, Apr 29, 2026 at 06:26:26AM +0100, Al Viro wrote:
>=20
> > with obvious adjustments in end_dir_add().  That's it.  Outside of fs/dca=
che.c,
> > same as in the patch you've posted, modulo renaming you've suggested for =
new flag.
>=20
> Something like patch below (on top of -rc1, completely untested).  I've lif=
ted
> the wakeup part out of end_dir_add() into its callers - less confusing that=
 way.
> Note that in __d_move() the dentry you've ended up passing to end_dir_add()=
 was
> *NOT* the one added - it was the one replaced with existing one spliced in =
its place.

I saw this comment the first time I read this email, but I didn't
process it properly.  That code is wrong.  It only makes sense to=20
__d_wake_in_lookup_waiters() a dentry that we know was in-lookup, and in
d_move, that is target.
This can only happen (I think) in nfs where nfs_lookup() skips the lookup
for LOOKUP_RENAME_TARGET and leaves the dentry in-lookup.  Other threads
looking up that name will then block.
After the rename completes that in-lookup dentry will now be unhashed
but we need to wake it up so other threads can continue (and repeat the
lookup).=20

So we need

		__d_wake_in_lookup_waiters(target);

in d_move.  target, not dentry.

Thanks for flagging this,

Also my testing has hit a problem with some sort of deadlock in the nfs
server (so accessing and XFS filesystem).  They are tring to unlink a
file and are waiting in d_alloc_parallel() under reconnect_path.
This is running generic/467.

So better hold off this patchset until I have that understood.

Thanks,
NeilBrown

