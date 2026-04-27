Return-Path: <linux-nfs+bounces-21121-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eItLOEHa7mkPygAAu9opvQ
	(envelope-from <linux-nfs+bounces-21121-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:38:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FB246C771
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50E40302A077
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 03:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D5035F19B;
	Mon, 27 Apr 2026 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IgVFNUI+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WVACiltR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852E35CB95;
	Mon, 27 Apr 2026 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261028; cv=none; b=hvbx0K2ecc1uZUlCyDUInXLVoPHKemBCNzq7sZewCOUqk0ljfom0k3rDlfu9Uxnz0VW6J9kjvviaJyrOyN614Xu3O8ehSw9umTln/S7FsJ0r+H+lcAoZaGkGKuoorek+5nt5/KxIDRQgd5svKE7Ohbh54TYKwT3zPoathjyH11w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261028; c=relaxed/simple;
	bh=Af17cpjWLrgjln+x15PYEXYO/pHIZybmrmOg/uu6FGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMA+UJz7u+YhdTonQf96Yk72uVLnBLnh0SZNNg3QBYmStLHnEv/O0GqrhOinYy7kQWYzRuJDT1l33P9BaApavx4sDlTWv/2he55JOM4reu3EnqXF7wfTz3tqwKR2r0p7EMIayfPub8RQgDp22xMHifUJupEqCxxoD6TMAZ9Owtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IgVFNUI+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WVACiltR; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC47714000BD;
	Sun, 26 Apr 2026 23:37:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 26 Apr 2026 23:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777261026;
	 x=1777347426; bh=2Sazp1M0TdInI6mi6hF1QSnGjDghjOgL8lkwZNivMpc=; b=
	IgVFNUI+/gOyDFNPlGJ2o+BShsyOgjot50UzS4rGGq9IW/0ZUlvJ0MLNzBTcvuVg
	WVb3iFHJw4nOOjuInIaSxSicohVL9DKhagmu0ol55wHzap/fnuLhbPIG856cptnf
	CpyhUkeUPKX5qW5DQKMvmwWoFxaNZt0coHX8I14qGnbRB2QO55MpDvnO+0dZx6Pz
	feq5kWPtMa81ACUu8nN81D+DRSwOStqPzBR8iTM0yjRHTAl2npqQ0klqyy9rpyO4
	/wwvOc7pAeR+ZbT8vzpED23SsYDSo93KhImvaywVSKYusRQsSgm4gZxGMQSxfJ1C
	byXVv86d4IOEIEwGE2lIUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777261026; x=1777347426; bh=2
	Sazp1M0TdInI6mi6hF1QSnGjDghjOgL8lkwZNivMpc=; b=WVACiltRQdApAwYHI
	ZqnR3UkX3wiXEfov35t9yGEUOOxOKCUnXcDhCB55/7/p8njZuTEeP5HGKzjognGh
	8sUNeNPL0w1gulJgmMOLd8b5jY8Rxx6LOrXiZJghkWQyaig2Kz5q74jtUvvW9cF4
	zYhLp0HiYAyGzkcouQiAvNF3R5wetmRaG7YBa3eXwu+tV7B6b5NB+Ncvs89vc/kr
	r23vQNE9SweRKSCSZLSLUoemxnbX4javb8c8Do+WSk+gAZ4+YgvMfuUKQ3humkDo
	o+NYCKr/FAzo/MHd9KCdZnxPIW96l7DfhwNPXWa8S2NurZMHaOlXOSf+GocEFrF7
	nzZqg==
X-ME-Sender: <xms:4tnuaewlExdkuDgHHFFHXkTC4maeSXAj_GkTNSa2YERWCAdgnoKfRQ>
    <xme:4tnuaUjgiLG4Z4xRHkcRlI_hOEAJ7EBt1q6fmra7VX0XNtYaP9d1DPmU5_0kIBRUp
    8ulvyum3w4Zd03z8lqRbFGqnXSf--B7m2sXn_SiSyBi4ze46g>
X-ME-Received: <xmr:4tnuaVzKUGAyFG0Sm86uqBt5FYgNQUCk4jlkD9CmBlDByV_YsqHMElLuVuWTGOW7U7qITjuWwV45qpjozuP2_9Wo8qGOJzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdprhgtphht
    thhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtghksehsuh
    hsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:4tnuaazwozeO_yb6lSo_Z11KNGab5Xzv_-Onx-qxOFctes5_kS-BoA>
    <xmx:4tnuaXqYsmN5wezpMt953u5v_8KE6j-3k1ioNqULixuooHK4L7Y2vg>
    <xmx:4tnuaVlHN-CKzpMU8c5NoDSfHwc6nAhwwndNmY-qYuy7CYeuCLKofg>
    <xmx:4tnuaYwNphmSnFFkgzd1TKJpvZaPBj_-ke1-pxIPOzujr-rdvIxB3Q>
    <xmx:4tnuafUab9FceF98Ad732QmakSD0uBzgopbf97ydFq6DDFtSwR95hZg7>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 23:37:02 -0400 (EDT)
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
	Ard Biesheuvel <ardb@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel
Subject: [PATCH v2 07/19] VFS: Add LOOKUP_SHARED flag.
Date: Mon, 27 Apr 2026 13:29:40 +1000
Message-ID: <20260427033527.773006-8-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260427033527.773006-1-neilb@ownmail.net>
References: <20260427033527.773006-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 86FB246C771
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
	TAGGED_FROM(0.00)[bounces-21121-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]

From: NeilBrown <neil@brown.name>

Some ->lookup handlers will need to drop and retake the parent lock, so
they can safely use d_alloc_parallel().

->lookup can be called with the parent lock either exclusive or shared.

A new flag, LOOKUP_SHARED, tells ->lookup how the parent is locked.

This is rather ugly, but will be gone soon after we move
d_alloc_parallel() out of the directory lock as ->lookup() will *always*
called with a shared lock on the parent.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 7 ++++---
 include/linux/namei.h | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a6349b31fdb6..e77ba9d31857 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1928,7 +1928,7 @@ static noinline struct dentry *lookup_slow(const struct qstr *name,
 	struct inode *inode = dir->d_inode;
 	struct dentry *res;
 	inode_lock_shared(inode);
-	res = __lookup_slow(name, dir, flags);
+	res = __lookup_slow(name, dir, flags | LOOKUP_SHARED);
 	inode_unlock_shared(inode);
 	return res;
 }
@@ -1942,7 +1942,7 @@ static struct dentry *lookup_slow_killable(const struct qstr *name,
 
 	if (inode_lock_shared_killable(inode))
 		return ERR_PTR(-EINTR);
-	res = __lookup_slow(name, dir, flags);
+	res = __lookup_slow(name, dir, flags | LOOKUP_SHARED);
 	inode_unlock_shared(inode);
 	return res;
 }
@@ -4413,6 +4413,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
+	unsigned int shared_flag = (op->open_flag & O_CREAT) ? 0 : LOOKUP_SHARED;
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -4480,7 +4481,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = dir_inode->i_op->lookup(dir_inode, dentry,
-							     nd->flags);
+							     nd->flags | shared_flag);
 		d_lookup_done(dentry);
 		if (unlikely(res)) {
 			if (IS_ERR(res)) {
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 2ad6dd9987b9..b3346a513d8f 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -37,8 +37,9 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_CREATE		BIT(17)	/* ... in object creation */
 #define LOOKUP_EXCL		BIT(18)	/* ... in target must not exist */
 #define LOOKUP_RENAME_TARGET	BIT(19)	/* ... in destination of rename() */
+#define LOOKUP_SHARED		BIT(20) /* Parent lock is held shared */
 
-/* 4 spare bits for intent */
+/* 3 spare bits for intent */
 
 /* Scoping flags for lookup. */
 #define LOOKUP_NO_SYMLINKS	BIT(24) /* No symlink crossing. */
-- 
2.50.0.107.gf914562f5916.dirty


