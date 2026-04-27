Return-Path: <linux-nfs+bounces-21135-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN7IEqDg7mkdzQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21135-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:05:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB03646CCCE
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30822300B9E9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C72D0605;
	Mon, 27 Apr 2026 04:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="akoox+IL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C9LP6sUS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B669823EAB3;
	Mon, 27 Apr 2026 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262748; cv=none; b=EyDDn1pp5A4Yr0lL4bsVA0HlAz4MPI1OtyegHRv3r5AwKiJ8l7iUSIg1brri5pl8TXnjxde8Nf7y0GRgunFkx9NF2rVPm10UKkd97yyq3yR/5xlTYEo8ID9QLzOkLQkE25VMcE3NXPtWz0g5XLGERmR7yIqYema5hWgnIXmHcAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262748; c=relaxed/simple;
	bh=RsaU22M8EZYVaWNZXXKDbLp51RIKWR9O764aH+N+SYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVPSvg3uXCN82NANHOykL3AgEOfqmNhQwTbEscagFZ0BrCS/W+e9Gv31YDbnVKfISM27Cb1ji/xJrnm0SjPVPEM0J9F1vOA10csIGQyVyaHjgWf8v0uIGWrIu8jtxxkR9RewZ9EHezv6yYnSbS0RzzhgFE9NAxL4gHjAEGgntpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=akoox+IL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C9LP6sUS; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 107F0EC04C5;
	Mon, 27 Apr 2026 00:05:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Apr 2026 00:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1777262746; x=1777349146; bh=c+HguMl2M4
	hQlw8DQigy0qNIcVo8gcYJA4N8MVbwUiw=; b=akoox+ILpYXkJJJQLSE+ApQOEj
	gWwKENdihyYkZSulyYwLp7/gAzW7IVUq5TJXCtOlrcIL5KIMcsNK45rMhGhKcpYT
	xOdHGcBS4otxcotgEDoivxFmIHELduBqywpziVFO8d7uqOZBrsO4jMxyIMIkFrnG
	APbC+zFAl1CLlH3C2nm48mPno06oav6kIDG/8WuBNaJZW5Vs235muusotA7QAALp
	6s+sVvxbEqkqwo2ZRZXsBMvKdj3RUL8lsffdRBsCHJ2Y15F1k92utIhxku4YS8sr
	Xo6IrzhmpJtA03gyqLYwzR9J93zr9aOtGW0t+Z8e5KWtjlhhX6eUOPqnEXqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1777262746; x=1777349146; bh=c+HguMl2M4hQlw8DQigy0qNIcVo8
	gcYJA4N8MVbwUiw=; b=C9LP6sUSF18gMWByj2QQfgm/QUo82o/sHRko5ZKtJhr2
	Z415belwGbwHemyjSzC1Ir1imtNzaZV0Jf/HJgH+mg+H5zCLINs/6rEQRT4/14dZ
	qPVDpxCF4RPnRYEFJ6cwyljuvQ9qjEOvfxOv+TXv+PRmJzLFaNn9cfGnQCaxDbQ3
	GDK8M+7ENPBMhE11SR88KFs/Gq2aPoya/CUW3/VO+U8HWeW0aZ8Uv1rzqZWlYPH2
	g9eSgz9REXx0NvQV0ukLSE5ergxBVQD2PndDhQjxY9ic3QBixQjVZnvYSlgSFo/3
	4xSa0ZMoqmNlO1YXqTWiYxQ8iVrXhulyiEcnyrY0mw==
X-ME-Sender: <xms:meDuaYVB3Sq9-LA275_3_HMJTbjy2Yk1VxJfXt80Yf6QdxJMWIOvxg>
    <xme:meDuaY4tMHMPDV9Gv2AyP_ueb9EMsQa6Cbo-Qa884SowEe7h0Aau8A-3jx1sdA9P5
    bMPGkDlRMlgzEuxSftEr0TFofS0oKPr_kCn1I1xOTP1Bcw>
X-ME-Received: <xmr:meDuaeCbTjEf-7q_fhidh2ofvp83_0XjNQna7zAK1gMSYWvyc_8EDqo2AiD0U7m9RML3Kr26z5hEz-9RG40dTMnDiy-OHEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkfforhgggfestdekredtredttdenucfhrhhomheppfgvihhluehrohif
    nhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeegte
    efgedttddviefggeeuveefleellefgjeeufeeukedtleeiieekvedtleevleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofi
    hnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtph
    htthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:meDuaUddSNpLgPbDYVdRX2CHlfQlNE7iNB0icGY2yLUgIbsPnBGiWA>
    <xmx:meDuaXsd80aQNe4HglZ_uF0KPOrcuQ-iwZyaMHVeZNigAyB4g-bmww>
    <xmx:meDuaTLoCZzlPfbkH_Si-QVuSFF8fZqHSl3BC3mGTKm-tWvndILM3A>
    <xmx:meDuaRZ8rM2r748cxklXY3oB9dWC5TGfkZmiHrcG3STgcqb00XlIiA>
    <xmx:muDuaTGqs2CXoFPeXqgxaq4x23ovMwe1CW8EKYMPvp5YKBv6tgZzQJBl>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:05:40 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/19] Prepare to lift lookup out of exclusive lock for directory ops
Date: Mon, 27 Apr 2026 14:01:18 +1000
Message-ID: <20260427040517.828226-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB03646CCCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21135-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,brown.name:replyto,ownmail.net:dkim,ownmail.net:mid,vger:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

[[ sorry - this v3 is identical to v2 except that the linux-kernel@vger
   address is actually correct.  Please reply to this one so that you don't
   get bounces like I did - NB ]]

This patch set progresses my effort to improve concurrency of
directory operations and specifically to allow concurrent updates
in a given directory.

It is a selection of patches from the 53-patch set I posted in March
which got relatively little response.  Maybe a shorter set will be more
approachable.

This set:
 - prepares the VFS in various ways
 - make use of these preparations in ovl and NFS (the most challenging
   filesystems for lookup as they do the most interesting things)
 - make use in efivars and shmem which for different reasons need a small 
   change that seemed worth including here.

The goal that these patch work towards is moving lookup out of i_rwsem
on the directory - except for the actual ->lookup call.  This is itself
a step towards allowing broad concurrency of operations in a given
directory.

There are two particular requirements before lookup can move outside the lock:
1/ d_drop() mustn't be used before an operation completes: the dentry being present
   in the dcache becomes part of the locking protocol.  This in turn requires
   d_splice_alias() to work with hashed negative dentries.
2/ d_alloc_parallel() mustn't be called while i_rw_sem is held, as this would
   result in a lock inversion.  So d_alloc_noblock and others are introduced
   to handle the various cases.
   In a few cases we need to drop and re-take i_rw_sem inside ->lookup.
   As lookup might be called with a shared or exclusive lock this requires
   a new LOOKUP_SHARED flag which is ugly but can be removed after the
   lookup is moved out of the lock (then ->lookup will only ever be called
   with a shared lock).

The full set of patches including these 19 and the rest to complete the
lifting of lookup out of the exclusive lock can be found at
   github/neilbrown/linux in branch pdirops

Significant changes since last time are:
 - use wait_var_event for d_alloc_parallel() rather than effectively
   duplicating that infrastructure - as suggested by Christop
 - changes to ovl_readdir handling as discussed with Amir.

Thanks,
NeilBrown

 [PATCH v3 01/19] VFS: fix various typos in documentation for
 [PATCH v3 02/19] VFS: enhance d_splice_alias() to handle in-lookup
 [PATCH v3 03/19] VFS: allow d_alloc_name() to be used with ->d_hash
 [PATCH v3 04/19] VFS: use wait_var_event for waiting in
 [PATCH v3 05/19] VFS: introduce d_alloc_noblock()
 [PATCH v3 06/19] VFS: add d_duplicate()
 [PATCH v3 07/19] VFS: Add LOOKUP_SHARED flag.
 [PATCH v3 08/19] VFS/xfs/ntfs: drop parent lock across
 [PATCH v3 09/19] ovl: stop using lookup_one() in iterate_shared()
 [PATCH v3 10/19] VFS/ovl: add d_alloc_noblock_return()
 [PATCH v3 11/19] efivarfs: use d_alloc_name()
 [PATCH v3 12/19] shmem: use d_duplicate()
 [PATCH v3 13/19] nfs: remove d_drop()/d_alloc_parallel() from
 [PATCH v3 14/19] nfs: use d_splice_alias() in nfs_link()
 [PATCH v3 15/19] nfs: don't d_drop() before d_splice_alias()
 [PATCH v3 16/19] nfs: don't d_drop() before d_splice_alias() in
 [PATCH v3 17/19] nfs: Use d_alloc_noblock() in nfs_prime_dcache()
 [PATCH v3 18/19] nfs: use d_alloc_noblock() in silly-rename
 [PATCH v3 19/19] nfs: use d_duplicate()

