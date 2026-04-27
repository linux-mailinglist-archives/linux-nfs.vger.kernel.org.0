Return-Path: <linux-nfs+bounces-21148-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC+AHUbh7mkdzQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21148-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:08:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A546CE25
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE2FE300850D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAA023EAB3;
	Mon, 27 Apr 2026 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mLLAnJTp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UfOtO6YK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E94922423A;
	Mon, 27 Apr 2026 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262874; cv=none; b=rtWvImG7x+qc6NHwqN600jsC5OFoPTh38Afx3Vy7+sOoiFpjznft4sJl+9gIdfKy+JZJ3wUPg4zsUsj+e3tAS6KQ5m7GEBYF/yzA3Aea2elxI/w+vrek1RpBg/Zmna35MyhnJN1tG/lWweskMdul77WxYlIC2a4VSPm22RhJW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262874; c=relaxed/simple;
	bh=R8RTr73kDdtIdtZlHNHhZGf1H97V3ZZBbREhAgyCF6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfpjZFaska3EvLvO3wlHBmoWRiHxLlF2+7pu3La0UzqpiyQiKpF4uEtvIz8tJivGaJJzs6+jGhFFTBP9iQL1/pIPh9XXT/eqhR42j1uosFw1No/zT1zfl8tXipxcwrcrfD6E2vXYthOuzVK7zIAzHwn4bwbbBcUBxHPRMQ9Tu3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mLLAnJTp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UfOtO6YK; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B11191400046;
	Mon, 27 Apr 2026 00:07:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Apr 2026 00:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262872;
	 x=1777349272; bh=9AVqWdMXv3arOefL33JAEpcHRtNfzSlIFOE+OQc0Rdg=; b=
	mLLAnJTpo68d+44VmWJ2shXrZUoK7hoUmRLl+g7OhD8bETnS/CnQkwI93L6rYN+D
	yWlGgw6WPzXjfPmCs9XPgil811/laFKXNlgGnc+L+R5rHNOpz5CrGWqYw57sqZPU
	+47GycDY4yaKQQKYUtCjLHP4jesgkWX9bzt5ATL3+xc6JEiXFhFpVztuaK8gbUs/
	4LT7xSK/EgrEyQx41IAGyL8tDxeqYtFwjBXrTrU+g55NAE+Eszcagl3gklL6E+hp
	COW1k98qvgQwDyki1YtKyc972nxoC0TkGU28JxTHRv5ieq+GHtOSaw8zlIjiHpG1
	gHCrlxOzRp5PLD6Q8Wdr6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262872; x=1777349272; bh=9
	AVqWdMXv3arOefL33JAEpcHRtNfzSlIFOE+OQc0Rdg=; b=UfOtO6YKp6V+6jxvu
	kckMHRkZGe9qWll1ZckeFe+XHZwOq7lufZX+pSRGPw/xyU7Wt1h8DdKxEoMiR7tB
	I4te1Bqnc9JkqMrtK/XbXdqScRl7D6KEmKPDI6kBm1XGe3MkJXKdlJaoD39G0PYk
	qQnTGVtFAYnQdg+2MHAfOLPPxTUY0JbFVVdzFZnISQPTiEbfP/JwqjMR0b8jqsFs
	F1AJEwuVUAZZ0g02pLLAlbFsBoCAYZhYSBcSj+4JWaSOWdIwPPME32lWRN9mc6Of
	PL4evonKRgZNoaawJtFrW3CXlbohAytmgQKfYvn48RCN7fRbrWzjssGp5DnEz67F
	TYkJg==
X-ME-Sender: <xms:GOHuadgEfMH8VTvtsLkLwIOoR5ynFBMXn9m7Jesa5fBWxegkXIcARg>
    <xme:GOHuaeXpyULCPWQrxsJjPFehjoT61EA2UkOiB5mhx1Dk4spcXXCyU1BDmjkXDSpJ4
    D_QBERou_mnfiTyKYXZKcZcHkSMTBPrMYyzdoRM4VA1c-8>
X-ME-Received: <xmr:GOHuaev2LcctYy3crtEomDS2o7cpKWEey_LPRaFVVXGhY45do3wbZGXXVluJT8nEcgEzBr4lcWTt7LjY3ffsF-FE4TZRAJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:GOHuafYCUs54FDLj0dAny2FfZzGuFK9gZktp187Yuo9D5AbTVyrYZA>
    <xmx:GOHuaf7iPVni5MPoiFPHKP_uwfsWzdvN8dHaBnnzAWpbVfwFSmTrjw>
    <xmx:GOHuafmyF0Jeymtuhd9pjNjLW7JumgTz2ZTAKK849iu2J-Gr_-vClA>
    <xmx:GOHuadGcLmdXb3vBKMSUdcLAqApGr9krXHHZjDVUnQethNNUTTIk6A>
    <xmx:GOHuaezj2nfo89pZf5HR5CophVPr9A7SCZzfkjPXgbSDaCXv3r7QZ5hz>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:07:48 -0400 (EDT)
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
Subject: [PATCH v3 13/19] nfs: remove d_drop()/d_alloc_parallel() from nfs_atomic_open()
Date: Mon, 27 Apr 2026 14:01:31 +1000
Message-ID: <20260427040517.828226-14-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: 072A546CE25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21148-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:replyto,brown.name:email,messagingengine.com:dkim,ownmail.net:dkim,ownmail.net:mid]

From: NeilBrown <neil@brown.name>

It is important that two non-create NFS "open"s of a negative dentry
don't race.  They both have only a shared lock on i_rwsem and so could
run concurrently, but they might both try to call d_splice_alias() at
the same time which is confusing at best.

nfs_atomic_open() currently avoids this by discarding the negative
dentry and creating a new one using d_alloc_parallel().  Only one thread
can successfully get the d_in_lookup() dentry, the other will wait for
the first to finish, and can use the result of that first lookup.

A proposed locking change inverts the order between i_rwsem and
d_alloc_parallel() so it will not be safe to call d_alloc_parallel()
while holding i_rwsem - even shared.

We can achieve the same effect by causing ->d_revalidate to invalidate a
negative dentry when LOOKUP_OPEN is set.  Doing this is consistent with
the "close to open" caching semantics of NFS which requires the server
to be queried whenever opening a file - cached information must not be
trusted.

With this change to ->d_revaliate (implemented in nfs_neg_need_reval) we
can be sure that we have exclusive access to any dentry that reaches
nfs_atomic_open().  Either O_CREAT was requested and so the parent is
locked exclusively, or the dentry will have DCACHE_PAR_LOOKUP set.

This means that the d_drop() and d_alloc_parallel() calls in
nfs_atomic_lookup() are no longer needed to provide exclusion

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 9580af999d70..0791fc2d161b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1656,6 +1656,13 @@ int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry,
 {
 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
 		return 0;
+	if (flags & LOOKUP_OPEN)
+		/* close-to-open semantics require we go to server
+		 * on each open.  By invalidating the dentry we
+		 * also ensure nfs_atomic_open() always has exclusive
+		 * access to the dentry.
+		 */
+		return 0;
 	if (NFS_SERVER(dir)->flags & NFS_MOUNT_LOOKUP_CACHE_NONEG)
 		return 1;
 	/* Case insensitive server? Revalidate negative dentries */
@@ -2111,7 +2118,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	unsigned int lookup_flags = 0;
 	unsigned long dir_verifier;
-	bool switched = false;
 	int created = 0;
 	int err;
 
@@ -2156,17 +2162,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		attr.ia_size = 0;
 	}
 
-	if (!(open_flags & O_CREAT) && !d_in_lookup(dentry)) {
-		d_drop(dentry);
-		switched = true;
-		dentry = d_alloc_parallel(dentry->d_parent,
-					  &dentry->d_name);
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
-		if (unlikely(!d_in_lookup(dentry)))
-			return finish_no_open(file, dentry);
-	}
-
 	ctx = create_nfs_open_context(dentry, open_flags, file);
 	err = PTR_ERR(ctx);
 	if (IS_ERR(ctx))
@@ -2209,10 +2204,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
 	put_nfs_open_context(ctx);
 out:
-	if (unlikely(switched)) {
-		d_lookup_done(dentry);
-		dput(dentry);
-	}
 	return err;
 
 no_open:
@@ -2235,13 +2226,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			res = ERR_PTR(-EOPENSTALE);
 		}
 	}
-	if (switched) {
-		d_lookup_done(dentry);
-		if (!res)
-			res = dentry;
-		else
-			dput(dentry);
-	}
 	return finish_no_open(file, res);
 }
 EXPORT_SYMBOL_GPL(nfs_atomic_open);
-- 
2.50.0.107.gf914562f5916.dirty


