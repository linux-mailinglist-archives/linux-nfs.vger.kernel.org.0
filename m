Return-Path: <linux-nfs+bounces-21144-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IsROPrg7mkdzQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21144-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:07:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E0246CD97
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEA0930021FD
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D704427A916;
	Mon, 27 Apr 2026 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="H27rvNOb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DWDgnrtG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDF023EAB3;
	Mon, 27 Apr 2026 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262836; cv=none; b=cu2likyR0tg0jiyGpWdHEwXa+EY0+WPGul+gnR2OHg+K6meAccqetOvl8M0GLzC3AT6OrZOZ8We4FG4XYioS1CgW3vvUDxpe5K4MhNuyshrreenfCKz5dBjvx5FA49DUenE4ISffgqp+5snnqxiTW5LQ/SVF6IuGBHyWHGEmGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262836; c=relaxed/simple;
	bh=n0RBYhb1fP4ASV0zBA39c1ZPWM/TE8hrkDBaS0wQeV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPWAWTh4catKJSqf061PW1QGhOL4eY80CgQFrkkIzvh+fc3YHrm0tgMy2KYGt6KjmUtGdFT3ooyEdRsn0dB3V0waIGisOnV/rR2tcO/k63A+b8IwV8wzeAmRL3bQST5woOjcP0jHjm0exclYzrFQFn6srzAJr8jsS1JevoR+vZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=H27rvNOb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DWDgnrtG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7BEE2EC03EF;
	Mon, 27 Apr 2026 00:07:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Apr 2026 00:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262834;
	 x=1777349234; bh=GR1euGmhNh9kvDlUiHAfiXoej5uoUlhCzq+/NqNURu4=; b=
	H27rvNObQ8Zyp8Ja3r/knWAtvfb0Q0LVCUftkmRqXxl/cGdfwuU9SKy6KXEchJHy
	L6eUrhCaOywiFf9vIvvZL4CxP6efvDIbzGCLsG5OPaaeLHmzOIC5tG+uuJakfcDo
	Kf4VoDzVfF3OSR1SW9rvM0XARsgX2ifdIu2mSFH4BmGvvlgisW5IQxtJzYyHxacE
	QB5A+RDBU+1qrBpf50O6EesZhGn/QJ825lIUtp9YIK3+N64L6f6qSO/XMXZbndyl
	01AGFxFCXoQMyUuhurhioTOPPdfHRtbp8k7EFfBgaYpDQcxbJrOh1lVx+OKEerxI
	/Rk3q8W7Iw/+0dgb5gTwRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262834; x=1777349234; bh=G
	R1euGmhNh9kvDlUiHAfiXoej5uoUlhCzq+/NqNURu4=; b=DWDgnrtGnH50h2Blx
	zAJyKUyiWcwokHQ4hrxKEUCVCvgY5iJjySZUmrpVnH3vPP+O4SZxgK6xFWUbGJPK
	GZ9ejRJg1/iKzVcjp1xMaNWjamTSAd6VAb6loXeaJGFjhiNCj8ckn5qo765MEMbE
	mOte97paDYoTzZnxTP77xOVSsaS9pHm7Cy0rj1pEJxxUWrBU0pmdPhdyto7JWs7W
	rT0wAqX9IIMBka4dP1w8xFbIRh7Ho4A/C/eXWUukmSwOy+dN7vGpDDPRg7+157fs
	un+T2D7Mbh2otpMaqaoP47zlw5nC4U62TsNbq8uMh99IzSZ7ke1ffZXrZ3KppHX5
	f74rQ==
X-ME-Sender: <xms:8uDuaUeDcU8zBpXVTYjMs4Ktq_ZoMAd-i-1SLCrO-v6bru-nWKO3FQ>
    <xme:8uDuaaVRsCBZO1KThd18ibPmfZ1rHtdVGU4gpOv5P1e69CwGBbEjD0mSweIzYBADx
    wX6owVnr85q6TaQK9dwe6gLrS8WC8ILUGWvoosQ5Masp5U6>
X-ME-Received: <xmr:8uDuaSjAzfd6bDI_EWSoFIAYfz4T8eLk_Vbbq5nrNlojPZ7HfAisknHtFRfquE0lH9KFkTFI1IPb7qKayx_V1SVN6rCn4KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:8uDuaUhdAPXj-OYhz0xo-SJjJYEve9x06C01qqvrnLaSYiX1nY2C4g>
    <xmx:8uDuaXtA_DVsgm-0dBQkxo9GC20t8az6ZgE_jymLEZshnWBUyUsKwg>
    <xmx:8uDuaSupecb0plY5bKr-szEsnTzfQuCHZXxDASM3bwSZLKzbuSyDdA>
    <xmx:8uDuaQNFlqqgjattC1q0E3lphqLwmwTJ_xffIp0LWs8RJ4xx8L2KjQ>
    <xmx:8uDuaXygpAp7FeDc9dfBDK0N4nEIkL_KyjKYn8LFg5J0f38Jch8wK5ww>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:07:09 -0400 (EDT)
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
Subject: [PATCH v3 09/19] ovl: stop using lookup_one() in iterate_shared() handling.
Date: Mon, 27 Apr 2026 14:01:27 +1000
Message-ID: <20260427040517.828226-10-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260427040517.828226-1-neilb@ownmail.net>
References: <20260427040517.828226-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62E0246CD97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21144-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,ownmail.net:dkim,ownmail.net:mid]

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


