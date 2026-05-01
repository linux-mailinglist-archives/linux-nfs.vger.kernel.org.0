Return-Path: <linux-nfs+bounces-21331-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL86G46E9Gk7CAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21331-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 12:46:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 043174ABBB2
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 12:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1F6D300D33F
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 10:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1144F38F924;
	Fri,  1 May 2026 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Mg3A221i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fiXPo2Xi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A4192590;
	Fri,  1 May 2026 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777632393; cv=none; b=QKYghovPwmgBobjQtNhOvHjs+PT2di+m3pJFBQJy7xVsuIZ2JD9nSRj5KY142PmET7Ps5Sjj+DT5n9DtQjJ/JKNammiXanJ+McsfWhK/95seu+fA0RfZRM7P44cpbzta/HHpptJWth5Qx7D6FS8q2+4dbpXzaaViJuFlq7AG0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777632393; c=relaxed/simple;
	bh=prCaRoSYmj64MXpiId8tjYxP/D+Dyae/L+g+QGh/VWY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RyTYMry1tOI4X5IUMr36ckSCAxTcX4DGV9y7hyT5WFS3Ko0DLPhtzzOkPHBfWApJItVbN4yKvtHBCx3VPi6T0ynyzHF0sPLcwY491SW8hbkANk/Nwm4/Zl5sJdE6ugYwHdTi25LkDu2J7iubj4fgs+hrlv05FArBuhj1ymMJ1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Mg3A221i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fiXPo2Xi; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CC551D00129;
	Fri,  1 May 2026 06:46:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 01 May 2026 06:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1777632389; x=1777718789; bh=ik5a7MC4PBdLeM/Fa2W8c64dptvpYcrqCSM
	lKFZOCU8=; b=Mg3A221izmR6XpCipCPeEw92O+KB92I18eGJnfauHSC9QNiODu2
	MnXYfhW8uYi8cdAlSCjawrEiW2DwApqG9cgWQuduZDrYfXc18MRhXE94zJ4gzKVG
	Xdi/092djiTVH2sfNQ5QiOR9hU+KWyhZ7S6AjflsVO0IZm1qeOXVVOX7F6aF9b6K
	tsM+zGJHyGq8I2Q3T2b68vJd6NYkR2hzAjjIwIz6tX4hoUYiM9OKCHEdI7hD6bEe
	3RRgb95nF7/PhVBFW7XLHWFa/G0NyqTzfFes9VbqpKM9hQJXNl/gaLPDK79+hIzp
	JmppLM/tYEsqX/v4cyISzAGASIy+m3Coctg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777632389; x=
	1777718789; bh=ik5a7MC4PBdLeM/Fa2W8c64dptvpYcrqCSMlKFZOCU8=; b=f
	iXPo2XiZZUG98T73ELuqH7RyJUHVpBovynnjsAY7fSQKSE+xNM5oiMWhtyq9LHNO
	uGANhrZheYanmy78SrB+9pbsuIx03zKHI3DYmIcuRKs2NaQ3K/s3THEdSFVeTJfV
	Q1TZkrgrTtt3dnQZ/awLmNBuwzlAnuLNBTia9l651hnfKoUiB2ncKBc//SBCF9ng
	W7ABFPdNS1hQtsEZu8sGjvObpJyPsVGMzIpldvYnPfVkn4IFdeq2yTtHdX4GW8eo
	gyI4HW3+7nHJ4y5/sL5VWJMeIgS7jutO39wJwW39/utTcf2XP0lnsjHC2G7tfvaz
	X7F9NXIJ9oXzRRGvb1zVg==
X-ME-Sender: <xms:hIT0aZ7phXdO1JK38gb9wAgGto3QBwFVcFs1GNYocP2epzN7vsygoQ>
    <xme:hIT0aTM2EkONopqck_hESu7BAyHAx8lo6IScQr5cGKCL-Pzup9aYZXJ8EnfxWOQJc
    CLUvdTwpmkPiLspXDtB_p6A6JzE6fdKb2AL8VC59qB9KntsvsQ>
X-ME-Received: <xmr:hIT0aSGIbNbSvADXnt6EDLL-VieUdHnC4JICehp0zl32fVFb_ctzRYgWdxMnMGh8amP1BA4Az6So71MX5fFRSl-z59YrcL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeltddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ffveejleejheeujeegheelleeuveduheejkeegveeuffetvefhfeevtdeuuefgjeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgr
    ihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthho
    pehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtghksehsuhhs
    vgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:hIT0afRaNDT70brM-V7_HHfAGsqViYZMQpCwm_6ik3ZHpjj6ZY0-xQ>
    <xmx:hIT0aSSO03eU9OjjPmXDUiRS0D8FVkfJrAej62GBTzJiHcWxi0iUng>
    <xmx:hIT0aSe2nXpIyFptkoNQjWH3NYjqgpe63vHxb7tCeYuMoWJBy9-ytA>
    <xmx:hIT0aWdLgbEJLs1L-NzYWpLxwXstwGzqnKqGenc0KreoSEPEmJ8TPA>
    <xmx:hYT0aYIkXlxHehQK3w3ouyX9BTgop2r3PZBy6DkyKL0AOoYIzqErcVHf>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 06:46:24 -0400 (EDT)
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
In-reply-to: <20260501033715.GB3518998@ZenIV>
References: <20260427040517.828226-5-neilb@ownmail.net>
  <20260428033738.GV3518998@ZenIV>
  <177737511992.1474915.1952404144121931523@noble.neil.brown.name>
  <20260428142225.GX3518998@ZenIV>
  <177741881482.1474915.12527082398060370192@noble.neil.brown.name>
  <20260429052626.GY3518998@ZenIV>  <20260429170731.GZ3518998@ZenIV>
  <177759308866.1474915.9708613530229799376@noble.neil.brown.name>
  <20260501011132.GA3518998@ZenIV>
  <177759959922.1474915.14496442965390503813@noble.neil.brown.name>
  <20260501033715.GB3518998@ZenIV>
Date: Fri, 01 May 2026 20:46:21 +1000
Message-id: <177763238102.1474915.1506201584306941315@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 043174ABBB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21331-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:email,messagingengine.com:dkim]

On Fri, 01 May 2026, Al Viro wrote:
> On Fri, May 01, 2026 at 11:39:59AM +1000, NeilBrown wrote:
>=20
> > I dislike them too.  I doubt I can find solutions that either of us
> > like, but they should be relatively short-lived.  Once we push the
> > locking down in the the inode_operations the filesystem will be in a
> > position to hold the lock only when it actually needs it (if at all).
>=20
> ... or we'll end up with hard-to-formulate constraints on what a filesystem
> may do with its internal locking to use the APIs provided by fs/{dcache,nam=
ei}.c
> safely.
>=20
> Note that e.g. "->iterate_shared() wants to know the synthetic inumbers
> a concurrent stat(2) would inject into dcache" (which is the original
> reason for dcache preseeding in that thing) is not uncommon.  In procfs
> you are lucky to have no mkdir() and friends; the same is not true in
> general and we'd better have a sane answer to "what could a filesystem
> like that do with its internal locking".  Or that thing will get blindly
> copied, with predictable results.

You say "not uncommon" but I can only find it in procfs and overlayfs.

You only need this if there is a backing store that doesn't provide
anything usable as inode numbers.
If there is no backing store, then you'll populate with
d_make_persistent() and provide inode numbers at that time.
If the backing store provides inode numbers - you use them.

For procfs the backing store is various kernel data structures (e.g. the
process table).  For overlayfs the backing store is a blend of 2 or more
other filesystems.

In either case, the backing store has its own locking protocol to manage
create/remove/iterate, so the filesystem likely doesn't need to provide
one.=20

For procfs I imagine that once we push parent parent-locking down in to
the filesystem, we'll simply remove it all from procfs.  Then there will
be no problem calling d_alloc_parallel() in iterate_shared as the thread
which owns the in-lookup dentry will never try to lock the parent.

For overlayfs I *think* there is no need for parent locking in ->lookup
so it is possible the same approach will work, though more careful
analysis will be needed.

The current code to drop and retake the lock is only transitional code
to get from here to there is manageable steps.

>=20
> > I'm confident that dropping the lock is safe.  If there was some way to
> > tell the VFS that the lock has already been dropped, then we wouldn't
> > need to reclaim it, but I cannot see a clean way to do that.
>=20
> FWIW, I'm more concerned about ->iterate_shared() - d_add_ci() is garbage
> that isn't used on a sanely configured kernel; ls -lR is not going away,
> no matter what, and exclusion requirements are going to be a lot more
> interesting for that one anyway.  It might be worth teaching iterate_dir()
> that in such-and-such conditions it ought to save position, drop the lock,
> do a lookup on name stashed in dir_context, retake the lock and call back i=
nto
> ->iterate_shared() from saved position.  With helper callable by ->iterate_=
shared()
> instances if they run into failing d_alloc_trylock() in a situation where t=
hey
> can't just shrug and move on...  Not sure.
>=20
> What kind of exclusion do you have in mind for foo_iterate_shared() in the
> long run?  Assuming that filesystem has directory-modifying operations, as
> well as lookups, and its inumbers are synthetic.

I think the VFS will still be taking a shared lock on the parent when
calling ->iterate_shared.  This is the easiest way to block rmdir while
a readdir is happening.

>=20
> BTW, do you have AFS and CIFS counterparts of your stuff from back in 2022
> that killed d_rehash() uses in fs/nfs?  I would love to kill d_rehash();
> exfat use is an easily removable junk, but fs/afs and fs/smb/client ones
> are trickier and the reasons why it needed to be killed in fs/nfs apply
> to those as well.
>=20

For fs/afs:

  https://github.com/neilbrown/linux/commit/7d074238b7674245308bb482d29f8b2eb=
10a6598
  https://github.com/neilbrown/linux/commit/a1ab4d991e1cbf02b7ae493798067db75=
d88ef48

or on lore.kernel.org
  20260312214330.3885211-20-neilb@ownmail.net
  20260312214330.3885211-21-neilb@ownmail.net


for fs/smb/client

  https://github.com/neilbrown/linux/commit/1df67fbccd424aaaf03a4dfeda07cd8f9=
e3bc682
  https://github.com/neilbrown/linux/commit/3c4f603881db16984b0b44e38a634d951=
7b9be84

or
  20260312214330.3885211-26-neilb@ownmail.net
  20260312214330.3885211-27-neilb@ownmail.net

I don't suppose you have any memory of
   Commit: a00be0e ("cifs: don't use ->d_time")
from 10 years ago.  Maybe you didn't even see it.

NeilBrown

