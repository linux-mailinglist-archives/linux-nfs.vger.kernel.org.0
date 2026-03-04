Return-Path: <linux-nfs+bounces-19784-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC67G1S6qGkdwwAAu9opvQ
	(envelope-from <linux-nfs+bounces-19784-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 00:03:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B1B208D7E
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 00:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BFA5304CE99
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 23:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B607738424C;
	Wed,  4 Mar 2026 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LdPFlQGP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FTS77x5H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03803793A0;
	Wed,  4 Mar 2026 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665410; cv=none; b=ESKR7N2J+foxieOudyCnBaTekwsebWNnFfabzbXqQd9AuEWvfK5q+1RUgJPg3JAkoHvqUBoJ3A+3hJ6BeYBoEc983gBFvOA4y6pXryQMqqiLts7cIiG0R0y4yn9Goa70NL3yooDPmo8RLRsMgMX/ocYRjw+S5QftJSmTHhGZAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665410; c=relaxed/simple;
	bh=O8kBrtBtOPAI6uj0gytOhu3Is4E8hr94H8g3GkofaCc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oQfbgmbZEd5j0VIOU8cpnT8iLU8xPdpBx+DFaL9h2Ax10HHvZXgl0ZpGFObGyJnZvhoaxXZx6az0y4pFvTkRc8Benp7Ywvi2fg2tEjNo2blymRqmJKs6ZyFdzHfrRjW7cOKD/Jtjh9CnUtHC7ZIidqIAlI41mBpnnG0JTA44nno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LdPFlQGP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FTS77x5H; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB6B37A01D1;
	Wed,  4 Mar 2026 18:03:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Mar 2026 18:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1772665407; x=1772751807; bh=zCexf+MdQmjBh727ay4vZda/kQnXXO5zStK
	27sGWvs4=; b=LdPFlQGP1pbMpi9Wo0a6+PNvDBqkpJyc3cwL5vRn2Zb8UwczOUR
	ntpRuW0ooUr09iJkVnEd73DWPLAapvMg7Osn1UpcMTgxzxfPd3lH9RM6+Yc4Bk58
	mhWNinTuxYHf6BURRkSzudmXJzivQgSR9j1sMYybOnLCyfWax1AXAbdvz1Kb/4gU
	bn5SFZLQYscLj1+qUoljCc8HhDxaQHCOMWefHLDZTvoxAsxUND3yh9/vQ/sM/BGU
	DvOnaEw+gLw+Oyb1SW7LLQpIijPLtJ6Q4HJOA78xoyvIYbyWTgWZljXDVGfN6CmH
	0W/5REwJskNE9SrvniQCXeQN7MWUHEeTzUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772665407; x=
	1772751807; bh=zCexf+MdQmjBh727ay4vZda/kQnXXO5zStK27sGWvs4=; b=F
	TS77x5HGr2/9nHDRt7F8L7zMudcZ4UXA26whikbwmUAI6AwX3RJPMJSlzzfWbC++
	viQzt4G/RYDOe3FPzk9QJm2Flj3GH76uvNekknIO+VQun5c1p2nZpqKojvbB46UM
	PpOI6FHNOaL4Cgznq4HJmRailkK5n/OH+ZgIa1TA1+rdckZ9lcS0NJkEt6+Bt07e
	qZyk2NMNOFlPb/OM1HVcC8Axg+83UBrfvCOX+OTs7/KtA9kDk7NdAw5GVXyl/Y/c
	0vVafrZNal2u3Xnw6W/nWs5DKyJrpAGUWM8/+qYTYTqzmKrytEJ+cMeHfOS/Cd9i
	PxDAIQ7XJiKE3oVlXmWGg==
X-ME-Sender: <xms:P7qoaTCNZWEsPIigDi0seH4vCXXzB1JNpijrU_8oL-xYeqkBC47BKw>
    <xme:P7qoaUdchgwBudHJ4xmbjH4NDoNaGNvkB0jpcblpZhjhlWOf0q27Ca0l4qQb_Fetr
    mLZozhG6Zr9TJ54m7bxcREk0e-qR8sUnpQLjPNCSQKRbM5Zmg>
X-ME-Received: <xmr:P7qoadmKmb1q1oV4G0o2HOhyUFfo6FPLkDY4vPAJ6nh9_Q3Q78dv19L5JUCpC7p_20hZYNIR-GBZrproYTzQfzMyxnotTXcjDIiPohVKB2DW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtkeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdfhgfehkeekiedtleefhefhkeevvdegfffhgfduffeiveelffehlefhfeehveetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhjrdhirg
    hmrdhtjhesphhrohhtohhnrdhmvgdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopeduuddvkeekiedusegsuhhgshdruggvsghirghnrdhorh
    hg
X-ME-Proxy: <xmx:P7qoabEY-dn-LsJC6Jg4XzVY3KMYhEQfblUp7DGSnkbte3yaIFGMeA>
    <xmx:P7qoaV5lrse3bjM8R_DeRsp3W4IF8E7JwIGrnpvfMsjx-Y6kYPHJOA>
    <xmx:P7qoaTkLqzkhd8dU7iy29JAi67JCH6TTfSS74yL9Ttj71Xg5wiFKKQ>
    <xmx:P7qoaarRKUjl58EXIPf6GVnlXvd-Bx_Tenf4qxC3PtUxVkf7WmGePw>
    <xmx:P7qoaebEU5iOOOP-v0jBlaxRq5OKlWpubefUAJQ2n9mRGoJijMCeIj6Q>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 18:03:25 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Tj" <tj.iam.tj@proton.me>, Jeff Layton <jlayton@kernel.org>
Cc: 1128861@bugs.debian.org, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, stable@vger.kernel.org
Subject: Re: Regression: Missing check in nfsd_permission() causes -ENOLCK No
 locks available
In-reply-to: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
Date: Thu, 05 Mar 2026 10:03:21 +1100
Message-id: <177266540127.7472.3460090956713656639@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: A9B1B208D7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19784-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,ownmail.net:dkim,brown.name:replyto,noble.neil.brown.name:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Action: no action

On Tue, 24 Feb 2026, Tj wrote:
> Upstream commit 4cc9b9f2bf4dfe13fe573 "nfsd: refine and rename 
> NFSD_MAY_LOCK" and
>   stable v6.12.54 commit 18744bc56b0ec  (re)moves checks from 
> fs/nfsd/vfs.c::nfsd_permission().
> 
>   This causes NFS clients to see
> 
> $ flock -e -w 4 /srv/NAS/test/debian-13.3.0-amd64-netinst.iso sleep 1
> flock: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso: No locks available
> 
> Keeping the check in nfsd_permission() whilst also copying it to 
> fs/nfsd/nfsfh.c::__fh_verify() resolves the issue.
> 
> This was discovered on the Debian openQA infrastructure server when 
> upgrading kernel from v6.12.48 to later v6.12.y where worker hosts (with 
> any earlier or later kernel version) pass NFSv3 mounted ISO images to 
> qemu-system-x86_64 and it reports:
> 
> !!! : qemu-system-x86_64: -device 
> scsi-cd,id=cd0-device,drive=cd0-overlay0,serial=cd0: Failed to get 
> "consistent read" lock: No locks available
> QEMU: Is another process using the image 
> [/var/lib/openqa/pool/2/20260223-1-debian-testing-amd64-netinst.iso]?
> 
> A simple reproducer with the server using:
> 
> # cat /etc/exports.d/test.exports
> /srv/NAS/test 
> fdff::/64(fsid=0,rw,no_root_squash,sync,no_subtree_check,auth_nlm)
> 
> and clients using:
> 
> # mount -t nfs [fdff::2]:/srv/NAS/test /srv/NAS/test -o 
> proto=tcp6,ro,fsc,soft

Linux has two quite different sorts of locks - flock and fcntl.
flocks lock the whole file, shared or exclusive.
fcntl can lock any byte-range (including the whole file), shared or
exclusive.  flock and fcntl locks don't conflict.

exclusive flock locks only require read access to the file
exclusive fcntl locks require write access to the file.

The NLM protocol only supports one type of byte-range lock.  It is
natural to map fcntl locks onto NLM locks.  The early Linux NFS
implementation handled flock locks entirely locally so different clients
didn't conflict.  This could be confusing but was widely documented and
understood.
Some years ago Linux NFS was enhanced to handle flock locks like
whole-file fcntl locks.  This means that clients with flock locks would
conflict (maybe good) but that flock locks and fcntl locks would now
conflict (maybe bad).
You can still get the old behaviour with "-o local_lock=flock".

So if you open a file on NFS read-only and attempt an exclusive flock,
that will be sent to the server as a full-range fcntl lock which should
require write access.  If the server finds you don't have write access -
you lose.

It would seems to make sense to tell qemu that the device is read-only. 
Then it will hopefully only request a shared lock.  Can you try that?

Note that even before my patch, if the filesystem was exported read-only
or mounted read-only on the server, then exclusive flock locks would
fail.

I think that the current behaviour is correct, however I do understand
that it is a regression and maybe that justifies incorrect behaviour.
Maybe Jeff, as locking maintainer, would be willing to do something like

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index dd0214dcb695..6c674fc51bab 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -73,6 +73,14 @@ static inline unsigned int file_hash(struct nfs_fh *f)
 
 int lock_to_openmode(struct file_lock *lock)
 {
+	/*
+	 * flock only requires READ access and to support
+	 * clients which send flock locks via NLM we
+	 * report O_RDONLY for full-file locks.
+	 */
+	if (lock->fl_start == 0 &&
+	    lock->fl_end == NLM4_OFFSET_MAX)
+		return O_RDONLY;
 	return lock_is_write(lock) ? O_WRONLY : O_RDONLY;
 }
 

But I wouldn't encourage him to.

NeilBrown


> 
> will trigger the error as shown above:
> 
> $ flock -e -w 4 /srv/NAS/test/debian-13.3.0-amd64-netinst.iso sleep 1
> flock: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso: No locks available
> 
> A simple test program calling fcntl() with the same arguments QEMU uses 
> also fails in the same way.
> 
> $ ./nfs3_range_lock_test 
> /srv/NAS/test/debian-13.3.0-amd64-netinst.{iso,overlay}
> Opened base file: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso
> Opened overlay file: /srv/NAS/test/debian-13.3.0-amd64-netinst.overlay
> Attempting lock at 4 on /srv/NAS/test/debian-13.3.0-amd64-netinst.iso
> fcntl(fd, F_GETLK, &fl) failed on base: No locks available
> Attempting lock at 8 on /srv/NAS/test/debian-13.3.0-amd64-netinst.overlay
> fcntl(fd, F_GETLK, &fl) failed on overlay: No locks available
> 
> 
> 
> 


