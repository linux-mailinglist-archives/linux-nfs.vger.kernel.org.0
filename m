Return-Path: <linux-nfs+bounces-21123-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHnSNWDa7mkPygAAu9opvQ
	(envelope-from <linux-nfs+bounces-21123-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:39:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 832CB46C7A5
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 991F63010B9A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 03:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FFC2E9ED6;
	Mon, 27 Apr 2026 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="X00VZCJz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HjQ1+wym"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7435CB95;
	Mon, 27 Apr 2026 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261042; cv=none; b=S1tV4FGxK2uiix0uaPF4z4fJHML775EtAweYWwhn6uNoV/qJhNWUismC2cmkm+Ahp7SneJqF5avXJLN/rU/hB43sa4deLMleSeQxWW0+fWWrgxLDEthWvmk+RWqe5KUVImHofTnQHwZXepRUPzHehw1b5fAMLXBxk7NN8PqShn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261042; c=relaxed/simple;
	bh=n0RBYhb1fP4ASV0zBA39c1ZPWM/TE8hrkDBaS0wQeV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggyi6mVivIHB15oTwIKzQOZVGSwvPtxStMJWA2XycdJdDdNoGmcuDoig+CWPuF+wgScGCGl2JXca8C65aKPUXEevaHa9xzEE+7I01wS1Ho7/Xk1G5WA6lAogJ4yvkqihTJcUgRnjbHToA6KyE9wbRKw8fF1Gn57DKOsWuprA1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=X00VZCJz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HjQ1+wym; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id C0701EC03EF;
	Sun, 26 Apr 2026 23:37:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 26 Apr 2026 23:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777261040;
	 x=1777347440; bh=GR1euGmhNh9kvDlUiHAfiXoej5uoUlhCzq+/NqNURu4=; b=
	X00VZCJzsdrfZ+r2LwxJmUH2a/qS7h+dB+kAtNcUg1EGrS/h3B52o11E1M+iSN9g
	L7Cz6Eh9b3+cjzL6hYdT8nzNkhm6fxeCbI6k/6WjSToiqJP3q6UKFeIQyelAvu5A
	NPAprD4eXgvE1k3Q+GXsD5lVrkkspj9thVysSWzy6uEpT5ChfYEaR1L3HTKMrnVP
	oBKAw6h7tvuQ76368b5KpN9CrzN1GOi2gcjogYda3SbIgos/JF1d2jRrDMn4+YR0
	ipbAJnGpf2tezoqvHRFsc8Fi34fwGT6dsQsbvXSdw1HXwPZl//8Qa/lr/HJBt4EK
	cwFw5uBEsogIBOWA7rIH+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777261040; x=1777347440; bh=G
	R1euGmhNh9kvDlUiHAfiXoej5uoUlhCzq+/NqNURu4=; b=HjQ1+wymwFNTHDWCR
	vjy+OtQoWcF0znJfWZ4hir/xs+qy7gLT8ZqtuPo89DKEZPHXneEJF6B92i3PqLWl
	YGIL1YSfPGugYNT/PIsxOhQniclAEgx4QVqjHASgLdyi2ZIix55aB37vaHxhvovy
	6ghIChafPgJ6vrr9LaclwGm5lmUyvxh+6U34xGA+vxTgDs7oQaGQy6XrZ3FQ92cw
	zCzQ1gVLhtYfyNlPIEvrq+8R0xRryJ7kzHgqqPd70QRGHGg4yJMN0JaIqUNHZr1c
	qWoCRsIj/acG8g53xPNfPMg3lBm6eZRsY5F044dVNVWX1o7qLOHBcNNFXOQyfuzF
	BqpHQ==
X-ME-Sender: <xms:8NnuaRTX_iBhW-Yg-_4CqCbwuDRGGM6a0idlBm3YbLshXM7rHv35xw>
    <xme:8NnuaVdk08JXs9KALAyoMv_BIWSVpIZCOCGnlCmYB3qV9A5-dbJRRjkyfSrchjuTE
    hKw7qF6Dg_i_f9EluqHumhgtAix-iV2pHPGy0NlhWBQsmv8qQ>
X-ME-Received: <xmr:8NnuadeVG9_IJt4M3MOVL7-VJEN-tGmnu957dhDdQq5W-fqnVf_NAomfr1Ggc_oYP8b5Vg5t4fJGknkn3AWr7ITA98_yErM>
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
X-ME-Proxy: <xmx:8NnuaT-SuvgLYoGi9VUg4qtyvG6cfas59FCTazAYOwjxCjA3L29QgQ>
    <xmx:8NnuaVP-h0WekhXG-K6GIsWPFImzRpC_Eqy5DOQYFqu10OfLpnu_NA>
    <xmx:8NnuaZVyBJpO9ZohzGIyB5KkQ3yGZjT4SBs8eQg2K-f-nUuFUbwDQQ>
    <xmx:8Nnuadhm6QW5YGQbblZF1rMiKQUHt38tDte4uaiOsA-kN_i8SAz-fA>
    <xmx:8NnuafHcmFOBsty0_VG3vONL3T-0wBh5NTEmjLksWIQZEsxoEIx4Elvw>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 23:37:15 -0400 (EDT)
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
Subject: [PATCH v2 09/19] ovl: stop using lookup_one() in iterate_shared() handling.
Date: Mon, 27 Apr 2026 13:29:42 +1000
Message-ID: <20260427033527.773006-10-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: 832CB46C7A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21123-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]

From: NeilBrown <neil@brown.name>

lookup_one() is expected to be removed as it does not fit well with
proposed changes to directory locking.
Specifically d_alloc_parallel() will be ordered outside of i_rwsem
and as iterate_shared() is called with i_rwsem held it is not safe
to call d_alloc_parallel().

We can instead call d_alloc_noblock() and then call the ->lookup, but
that can fail if there is a lookup attempt concurrent with the
readdir().

ovl cannot afford for the lookup to fail as that could produce incorrect
results, and it cannot safely drop i_rwsem temporarily and that could
introduce races with handling of the directory cache.

Instead we rely on the fact that ovl_iterate() has an exclusive lock on
the directory, so any concurrent lookup will wait for the ovl_iterate()
call to complete.  We allocate a separate dentry and if the lookup is
successful, it is hashed with the result.

When the concurrent lookup gets i_rwsem it mustn't do its own lookup -
it must use the existing dentry.  This is found, if it exists, using
try_lookup_noperm().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/namei.c   | 12 ++++++++++++
 fs/overlayfs/readdir.c | 24 ++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index ca899fdfaafd..69032eb2b1e2 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1385,6 +1385,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	bool check_redirect = (ovl_redirect_follow(ofs) || ofs->numdatalayer);
+	struct dentry *alias;
 	int err;
 	struct ovl_lookup_ctx ctx = {
 		.dentry = dentry,
@@ -1399,6 +1400,17 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > ofs->namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
+	/*
+	 * The existance of this in-lookup dentry might have forced
+	 * readdir to do the lookup with a new dentry.  If so we must
+	 * return that one.
+	 */
+	alias = try_lookup_noperm(&QSTR_LEN(dentry->d_name.name,
+					    dentry->d_name.len),
+				  dentry->d_parent);
+	if (alias && !IS_ERR(alias))
+		return alias;
+
 	with_ovl_creds(dentry->d_sb)
 		err = ovl_lookup_layers(&ctx, &d);
 
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 1dcc75b3a90f..e03b32491941 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -574,8 +574,28 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
 		}
 	}
 	/* This checks also for xwhiteouts */
-	this = lookup_one(mnt_idmap(path->mnt), &QSTR_LEN(p->name, p->len), dir);
-	if (IS_ERR_OR_NULL(this) || !this->d_inode) {
+	this = d_alloc_noblock(dir, &QSTR_LEN(p->name, p->len));
+	if (this == ERR_PTR(-EWOULDBLOCK)) {
+		/*
+		 * Some other thead is looking up this name and will
+		 * block on i_rwsem before it can complete the lookup.
+		 * We will do the lookup in a new dentry and when that
+		 * lookup gets a turn it will find and return this
+		 * dentry.
+		 */
+		this = d_alloc_name(dir, p->name);
+	}
+	if (!IS_ERR(this) && !d_unhashed(this)) {
+		/* Either we got an in-lookup or we made our own unhashed */
+		struct dentry *alias = ovl_lookup(dir->d_inode, this, 0);
+
+		if (alias) {
+			d_lookup_done(this);
+			dput(this);
+			this = alias;
+		}
+	}
+	if (IS_ERR(this) || !this->d_inode) {
 		/* Mark a stale entry */
 		p->is_whiteout = true;
 		if (IS_ERR(this)) {
-- 
2.50.0.107.gf914562f5916.dirty


