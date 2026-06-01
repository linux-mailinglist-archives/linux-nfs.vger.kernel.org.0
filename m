Return-Path: <linux-nfs+bounces-22141-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG2BBHkuHWo4WAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22141-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:02:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2713B61A931
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6983300BC7E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE233803FD;
	Mon,  1 Jun 2026 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mpV3vsr9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jgMapY9E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B94382398;
	Mon,  1 Jun 2026 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297265; cv=none; b=M+PFAgLRysByvebR5kuYkZzLj6LDXP6OLNzVy2VLhy5lqP71wjIPLRpnnyiBVbj+JUtnzs1S7sABviGgEGLIa+uX3ho39S9weLu5tRkADRXfKsvYU2TnMCqcBTi06M3hQdBUyiS/lt6cv+92xQxvk7UchpUpvyyv5rTonOn4eWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297265; c=relaxed/simple;
	bh=LbsB2lvc1nD44qvfGVHcePkqVb8kouuRhI3vAUFOSNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTD7eCwo+Mj3iGgKO3q7m4BLkdhRPD1Q/06KJtr2p9BwHBZ6idLqdbeTG1aQ3HUes/mKHGkBx9MjemJhhqB1nZOBYcoVlMv+GJ5BL5y9k9w5RdCAXnVJEtXAzFucG2bjjYbLxGyUp+kesubxEc4TzuJ8YlVHVyi/eqw4eggnrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mpV3vsr9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jgMapY9E; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 4CF9AEC020D;
	Mon,  1 Jun 2026 03:01:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 01 Jun 2026 03:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297263;
	 x=1780383663; bh=d/FDq/9JNI/+52vVLZxN2P5bcEEjohRAH25zlmccJQI=; b=
	mpV3vsr95c9ZUqL/7SAa2VSl35ldWxYQQF8eUhVdMmBxbQpi7j0+KKs6fdX152Sa
	nJOXRStBqYaU2qTgIW9/JI4lC4nPbfi/9Jy2VhWpSj6+1h7d0tCS0lCE51pYFk88
	eoNxJEeraghpwQU+1eRAh7Eg/sB5fq2e5Y4gGXgbYL92rl8/QYOOqRqy5vu+0y6S
	qI3IrrcyF5kBWzEkEGr5PcKWYlr7AKAT00/tw/uQ60cREHnIG6rXUuAB9iJlp0pK
	AcV7uB2YY2KyxAwnUqR5tJsBdCpKaSdWQR1JCwHy1zne28Y49bAYzjKuBmS+6Bni
	vvZwFtisl3t+UhKscnjzFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297263; x=1780383663; bh=d
	/FDq/9JNI/+52vVLZxN2P5bcEEjohRAH25zlmccJQI=; b=jgMapY9EKkrPpp9mZ
	jVux9IenM854cZALn2rRN4DffTkJ8plBumniSvQnq6Q/+v+UO/XMXSZ08xkKtXtC
	07Uidq5fbCMC1A1q7+8Rnl63gVSHauTyti0/DRHZsAOqK9maaSD0dPQs/Qpx7iaP
	WnnxUIomZ2hKEU+qH4Vh/Xed3mSZvXr8zUUP6xfv5jV8+cS3hummG3g3SUTTVDoe
	w7j+08ocFiuuEbfo+xec5A05O9WGR0xMCQLuJgzf6LtK67nSUym1R2fNKAFzKT+J
	9K5eZ0+6Bb7O8FJ0j3FUPme95JKc4CnP/T/Q8MKCHRLzXTF2BZCZt9mw/DCkKql1
	OmwBw==
X-ME-Sender: <xms:Li4dagECFVSWmv2_i3NInceBUzn8jrquO7iaCaghWY_wwi_ylAz2Uw>
    <xme:Li4dahjRHCblhx8mQESQkm5l5ls_2yPgm6p7V7cjW2Aq-ZSTFpZfVxZ5eVTkamIE1
    6omHixQVR1PvLbZoYuYJ5OlmCu4X-xcjKNgZFxruKHEnBqs1g>
X-ME-Received: <xmr:Li4daltZuzm0ibuUzgr8lkQC0LC_C0I2w045WIrWsiq3CoZQt5KeX4BeeR3n1-DA7m7GTAmcQ9umv_gSFNYhYz_sU-Zvv-g>
X-ME-Proxy-Cause: dmFkZTFNn2voCuMJwaZn4mQi+8OwFwP8MbOGesQswPxVACwdUxRDwWa/f62FrT4OS5+etX
    lpbG0CyNEC5ZEzEebDdmEkKKuwA8JYmTcJZDLGOjQuIsuC+VlGFN4cDtTpsp4TJxEBMQJN
    5UaE10g4X93jUBy1AA+vqprc2pKvYMKhkYGmTUuEeZluqnZwRRSGljv9KpJxnsuimm38u7
    Jp9HDBymSY6zDSdT1QCsnlup35Rls5SW6aC9Hwu2QHQS3M6fNepFkcCA+NA6zsxp9+rhtV
    lYy3c44qrxynOl4BJrfimD+Q/JXYY7JxRkwisEy5dkxg8tlTtB+eaV0PCk5+Kq5N3tTrqx
    upHbvQpPdJzHzpQXhOjRn+bZw9YeyQ0yQAdEs5NLBNDE1m5QurmVMGsqeDMEHke9wOzZqi
    SJYByftMsHSzr1hP8HaWdutXUOwPTtfiO0cjLtoUj0ht8QRBdfNMxaBCIH761xDyrMay06
    OErpzSWPSsa3pkLyYioTJFNUCwbSrVIvnObxN6eNFqsM5Ch4Y0gXfbynPbqSxIyIg+b2sB
    cLN3adSeLD4xXe5s78zPHkHNTXWLuO91BT7IVIM2vrX4kQQgyyxn14kDudWvHFrMF07fBz
    Q21MVXT4OSEPl53qBUHLGUg3sKw91tA9DtwEBHESzlPinjo4LbNYlyl9PGgg
X-ME-Proxy: <xmx:Li4dastTaZM1cws0PGrKhd1vTH16q_fnAMFEg6hWCOy2qEzTEj3ShQ>
    <xmx:Li4daiFTk6VKlvGtJ63OcrvgtojG3AgDQ-bpsBFXrkmHCZJRG4iqiA>
    <xmx:Li4davPduhMLy4fuKk5IpzRnK5jTUUpfGDQ-TxN-wDYtp74qRv0x2w>
    <xmx:Li4dapLtx2-bSWhIE5FQeuW1ArRpg2rhks2lRgQj0U5XAtMQ5uP46w>
    <xmx:Ly4dauo0YrhgIAf1q0UA_S1DWiMJ3ZnN4DmWOGeOgqGqNCcIF3N7yfmX>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:00:59 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	"Jori Koolstra" <jkoolstra@xs4all.nl>,
	Benjamin Coddington <ben.coddington@hammerspace.com>,
	"Mateusz Guzik" <mjguzik@gmail.com>
Subject: [PATCH 01/18] VFS: move mnt_want_write() and locking into lookup_open()
Date: Mon,  1 Jun 2026 16:37:49 +1000
Message-ID: <20260601070042.249432-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260601070042.249432-1-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,xs4all.nl,hammerspace.com,gmail.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22141-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2713B61A931
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

The mnt_want_write() call and the parent inode locking in
open_last_lookups() are only needed for lookup_open().  So we can move
them and all the got_write handling into lookup_open().

Note that we need to also check create_error when determining whether to
unlock shared or not, as O_CREAT can be cleared.

The fsnotify calls come too as they must be in the locked region.

Also use the existing dir_inode uniformly for dir->d_inode.

This is a step towards exporting an better "open/create" interface to nfsd.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 77 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c57a3609dfa1..998fde251fcf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4404,7 +4404,7 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  const struct open_flags *op,
-				  bool got_write, struct delegated_inode *delegated_inode)
+				  struct delegated_inode *delegated_inode)
 {
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
@@ -4413,9 +4413,25 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
+	bool got_write = false;
 
-	if (unlikely(IS_DEADDIR(dir_inode)))
-		return ERR_PTR(-ENOENT);
+	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
+		got_write = !mnt_want_write(nd->path.mnt);
+		/*
+		 * do _not_ fail yet - we might not need that or fail with
+		 * a different error; let lookup_open() decide; we'll be
+		 * dropping this one anyway.
+		 */
+	}
+	if (open_flag & O_CREAT)
+		inode_lock(dir_inode);
+	else
+		inode_lock_shared(dir_inode);
+
+	if (unlikely(IS_DEADDIR(dir_inode))) {
+		dentry = ERR_PTR(-ENOENT);
+		goto out;
+	}
 
 	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
@@ -4423,7 +4439,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (!dentry) {
 			dentry = d_alloc_parallel(dir, &nd->last);
 			if (IS_ERR(dentry))
-				return dentry;
+				goto out;
 		}
 		if (d_in_lookup(dentry))
 			break;
@@ -4439,7 +4455,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	}
 	if (dentry->d_inode) {
 		/* Cached positive dentry: will open in f_op->open */
-		return dentry;
+		goto out;
 	}
 
 	if (open_flag & O_CREAT)
@@ -4460,7 +4476,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		mode = vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
+		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
 		if (likely(got_write))
 			create_error = may_o_create(idmap, &nd->path,
 						    dentry, mode);
@@ -4475,7 +4491,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
 		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
 			dentry = ERR_PTR(create_error);
-		return dentry;
+		goto out;
 	}
 
 	if (d_in_lookup(dentry)) {
@@ -4515,11 +4531,27 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		error = create_error;
 		goto out_dput;
 	}
+out:
+	if (!IS_ERR(dentry)) {
+		if (file->f_mode & FMODE_CREATED)
+			fsnotify_create(dir_inode, dentry);
+		if (file->f_mode & FMODE_OPENED)
+			fsnotify_open(file);
+	}
+	if ((open_flag & O_CREAT) || create_error)
+		inode_unlock(dir_inode);
+	else
+		inode_unlock_shared(dir_inode);
+
+	if (got_write)
+		mnt_drop_write(nd->path.mnt);
+
 	return dentry;
 
 out_dput:
 	dput(dentry);
-	return ERR_PTR(error);
+	dentry = ERR_PTR(error);
+	goto out;
 }
 
 static inline bool trailing_slashes(struct nameidata *nd)
@@ -4562,9 +4594,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct delegated_inode delegated_inode = { };
-	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
-	bool got_write = false;
 	struct dentry *dentry;
 	const char *res;
 
@@ -4594,32 +4624,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		}
 	}
 retry:
-	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
-		got_write = !mnt_want_write(nd->path.mnt);
-		/*
-		 * do _not_ fail yet - we might not need that or fail with
-		 * a different error; let lookup_open() decide; we'll be
-		 * dropping this one anyway.
-		 */
-	}
-	if (open_flag & O_CREAT)
-		inode_lock(dir->d_inode);
-	else
-		inode_lock_shared(dir->d_inode);
-	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
-	if (!IS_ERR(dentry)) {
-		if (file->f_mode & FMODE_CREATED)
-			fsnotify_create(dir->d_inode, dentry);
-		if (file->f_mode & FMODE_OPENED)
-			fsnotify_open(file);
-	}
-	if (open_flag & O_CREAT)
-		inode_unlock(dir->d_inode);
-	else
-		inode_unlock_shared(dir->d_inode);
-
-	if (got_write)
-		mnt_drop_write(nd->path.mnt);
+	dentry = lookup_open(nd, file, op, &delegated_inode);
 
 	if (IS_ERR(dentry)) {
 		if (is_delegated(&delegated_inode)) {
-- 
2.50.0.107.gf914562f5916.dirty


