Return-Path: <linux-nfs+bounces-21321-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CJLKUQA9Gn99QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21321-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 03:22:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 202344A999B
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 03:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75795301FFBC
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 01:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EF82C026C;
	Fri,  1 May 2026 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="dyd4FSvG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="keie/jMZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324EB1DF751;
	Fri,  1 May 2026 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598451; cv=none; b=hSwJkdpl6X9NVH0CAXlDIrcmal1axFpV/yi1uKMnl93VNrURbfO+K1mYwN8DgoLgqWziYg1GDlo2rKjSHepFL+FVXVKjIFigwY3PCOYFQkQMBmCMuCDrcQK20P+dhDJr19hFL83PXNjwJtu5QpzIiRBkgHxsW/26iaHrLG2+N2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598451; c=relaxed/simple;
	bh=A+YBGMyvBl7GOzZbBTljFVysDhnPc/yNFIdskIpWvKI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ejOA/cuGd2QDVecspr6bJoMIUxau3oMJtqZHydGYis8bt1Nl1bf97iofNydUuo0Ty9jT2ev5t7wawYss3pqOA0HY1WK3vPZ4T6Dijr7ghYw8KC1eA4oiA3sq2HCKyXXlGAvMoIAZNu+N8ulblnugCG44qAiVUoAK8OP3ockAS4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dyd4FSvG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=keie/jMZ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E6821D000ED;
	Thu, 30 Apr 2026 21:20:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 30 Apr 2026 21:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777598447; x=1777684847; bh=VoUWr0usAn90IKemM6n2soxuv4K0Xy430Mx
	TbeCzr00=; b=dyd4FSvG41docTwhTKBuK6kIGXGn1duKymbaggYG3nFk7BYby4V
	v9UfZx26PiYzN10y2DmUHHWVwQwzB8Jm3JbcTxYUsV3DziAptUVZpYjNvaGsC/0n
	axoy+StZwKItM74nXe2IKZOwPFGlREqEH4pigtP+Qd4NFmL255+CkccBC5qzrmwI
	v6kKFDV2Q5EAtdmKt53IeGYnX7PJwiUbl3DhEvay03th6cI9kRxL6g++H1yHlOy6
	cuH5MB+dFSdtRNeLg+P6ex6nqKm7RgE2O+WIl+GoOs9ii2vS2gnkdaEB3ccE3XEX
	rZhW/di+gdI2ldDC/T195j2HZJg39PUdeJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777598447; x=
	1777684847; bh=VoUWr0usAn90IKemM6n2soxuv4K0Xy430MxTbeCzr00=; b=k
	eie/jMZvBzyEjUcDdQZRyESum91qQC5eA8ECzp7yOoKVtwJLv8nAUmqYkGbgpirs
	4oBZsOwKVwlkQ/pULjNnCgLk/QWNbtHmhNffNdh0ClLov1zlUzcZ18dYHUiyWE/t
	8E2TJblsNPCkwuNqVuzHN23R07hPhRT8Jj90zI9DXZRwGSDrG/Gy73CD9XyXkoa1
	g9+wiP2GlesyyxRPD+dTIxaG06En6Tvfk0z4TLaIyL/qGFfPshCrxtZOtc59FXRr
	ZK+OqVyVoDXHxQ+QoNBdsNsWH+oqAQzjsINs0zKe4UmP74SXF46ZczO1lyO4HdjF
	CTFMdSJOTaLNWyXiMfpcw==
X-ME-Sender: <xms:7v_zaQtL7FcSc6ahqLA3ImXD4T9mMlw8fcFCIZqfLBmVpyPN3sacEw>
    <xme:7v_zaZyfrSAPfpKW2Z7xdL09dpeoWb7IaTMXGbiqBKrx6BMF38fkDVEpUfDstkidT
    yBdRU_7KGjMqSFBNBVeAqIqG1Wq2rFbfk0lVLOrL4TiPtHZ9Ho>
X-ME-Received: <xmr:7v_zada_GA2Pt8R8zZQQzI1WaR9cUfut6kPq61ao0FFozsg3dLwfYAmw02ogFHmmh8XxBk1lSMMDo3sOtecnUbr9-apoLLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeekjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:7v_zaQWxcIYKUkxf7rrihLuNa950VQ8eU9j3ziPBFQhbBpASlRN8MA>
    <xmx:7v_zaWF5g8b2hgF8xPiE-HvAn_o_xrSv-iPp8M8THpg1hnGpzlEeNA>
    <xmx:7v_zaSCtGcvo3_OFnYmizntweaNB-bkka1HLU1o0cx6vpGDgT4LdRg>
    <xmx:7v_zaWwpufHugoBiwdGXr77wD8K-sRTPZ_WZbeooRCLxnu1h77No2g>
    <xmx:7__zaYcpJ2OLUpaOkYl_RpQGfjQxy6wv7g2aXrpK_mZi0b3zDqqZc-gW>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 21:20:42 -0400 (EDT)
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
In-reply-to: <177759308866.1474915.9708613530229799376@noble.neil.brown.name>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-5-neilb@ownmail.net>
  <20260428033738.GV3518998@ZenIV>
  <177737511992.1474915.1952404144121931523@noble.neil.brown.name>
  <20260428142225.GX3518998@ZenIV>
  <177741881482.1474915.12527082398060370192@noble.neil.brown.name>
  <20260429052626.GY3518998@ZenIV>  <>, <20260429170731.GZ3518998@ZenIV>,
 <177759308866.1474915.9708613530229799376@noble.neil.brown.name>
Date: Fri, 01 May 2026 11:20:38 +1000
Message-id: <177759843868.1474915.6100875324018019224@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 202344A999B
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
	TAGGED_FROM(0.00)[bounces-21321-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,noble.neil.brown.name:mid,messagingengine.com:dkim]

On Fri, 01 May 2026, NeilBrown wrote:
> On Thu, 30 Apr 2026, Al Viro wrote:
> > On Wed, Apr 29, 2026 at 06:26:26AM +0100, Al Viro wrote:
> >=20
> > > with obvious adjustments in end_dir_add().  That's it.  Outside of fs/d=
cache.c,
> > > same as in the patch you've posted, modulo renaming you've suggested fo=
r new flag.
> >=20
> > Something like patch below (on top of -rc1, completely untested).  I've l=
ifted
> > the wakeup part out of end_dir_add() into its callers - less confusing th=
at way.
> > Note that in __d_move() the dentry you've ended up passing to end_dir_add=
() was
> > *NOT* the one added - it was the one replaced with existing one spliced i=
n its place.
>=20
> I saw this comment the first time I read this email, but I didn't
> process it properly.  That code is wrong.  It only makes sense to=20
> __d_wake_in_lookup_waiters() a dentry that we know was in-lookup, and in
> d_move, that is target.
> This can only happen (I think) in nfs where nfs_lookup() skips the lookup
> for LOOKUP_RENAME_TARGET and leaves the dentry in-lookup.  Other threads
> looking up that name will then block.
> After the rename completes that in-lookup dentry will now be unhashed
> but we need to wake it up so other threads can continue (and repeat the
> lookup).=20
>=20
> So we need
>=20
> 		__d_wake_in_lookup_waiters(target);
>=20
> in d_move.  target, not dentry.
>=20
> Thanks for flagging this,
>=20
> Also my testing has hit a problem with some sort of deadlock in the nfs
> server (so accessing and XFS filesystem).  They are tring to unlink a
> file and are waiting in d_alloc_parallel() under reconnect_path.
> This is running generic/467.
>=20
> So better hold off this patchset until I have that understood.

The two problems are actually one.

__d_move() is called in d_splice_alias() with the target dentry often
being in-lookup.  reconnect_path() does exactly this and is expected to
find an existing dentry for a directory and to splice that dentry to the
in-lookup dentry is has.
So the wakeup of the wrong dentry in __d_move() is causing the deadlock
in nfsd.

I'll resend that short series after some testing.

Thanks,
NeilBrown

