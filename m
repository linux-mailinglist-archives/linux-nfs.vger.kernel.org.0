Return-Path: <linux-nfs+bounces-21884-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0APbKMLqEWqzrwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21884-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:58:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2034B5C0394
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45CF53046DE3
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B40E34D394;
	Sat, 23 May 2026 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7D2ybPr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD9930CD81;
	Sat, 23 May 2026 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558949; cv=none; b=H9a73E5pY1Cp18kbW/cLDdPwuNx8q89WySzZGMA4YhDQpiDSDxWli27mX4JClbEqokisb9A8vm+ulRjhuzj5PNBWQvqjHf1eHPgFTxHu+qwikBNduTjlLpUGbUKvEG49ikSsEy80b+4imnRskn/wJCW85fjbmqv+weEHDh3+EOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558949; c=relaxed/simple;
	bh=1d6KQsAeKgySPVpGarXocvBZjBPMu1KCr+fEp1NqfpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCgLZKTNaKyNxjiw6hioYS4z0egrcidRKNReH+BbSsMUcFlnUUzPdMzE+aB0Ojp72RBa7z5oLguoNFhby9HLCVK8posZjn/Bj/OakddNiV3uAKZhM9EW2LI5uq6UXe0mD9LBpQ9O3I7q5mS/RSPL0ko12BBnjbJDQsHaSjfGbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7D2ybPr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484671F00A3A;
	Sat, 23 May 2026 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779558947;
	bh=yB2akKGsW8OhhHQjSAQNazF7z15KfNFtO0Wg450/3lA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d7D2ybPrqTXa2BX5BRBj5trjjELM1QO8HUQHB8PickiWyy8mZxEWuS5gG1w+Cl7Uy
	 HER8CMshtp3q8ixb+8UkyigX5UBOVBE98jLaoBkGBKPIXVaYANzk4YXHUfoe4OXN79
	 xW4fhVINDce6E3jAU4Xai5n3r4y5DApu+mnEG3zTAoIGygmccs2LZ+VI8QEuVDFj4e
	 nKsQlBUUtxGPAWg0DTy8gIDU8KAdfCFJKYgwGZYp3XtoDiua/XRmxDlb5rj39iDzW+
	 z1cf9/nRffFe1GKNVVbTa+W8bsuFDG4DWE1yHIDqMFcE2P+9dvdhMLon7+iYFqAkRL
	 npBGpF3iBQjyg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 23 May 2026 20:54:21 +0300
Subject: [PATCH 09/17] jfs: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-b4-fs-v1-9-275e36a83f0e@kernel.org>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
In-Reply-To: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
To: Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Dave Kleikamp <shaggy@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Kees Cook <kees@kernel.org>, 
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
 linux-ext4@vger.kernel.org, linux-mm@kvack.org, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21884-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,mit.edu,szeredi.hu,debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2034B5C0394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

jfs_readdir() allocates dirent_buf with __get_free_page().

kmalloc() is a better API for such use and it also provides better
scalability and more debugging possibilities.

Replace use of __get_free_page() with kmalloc().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 fs/jfs/jfs_dtree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index ac0f79fafaca..8ce6e4458cc2 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2729,7 +2729,7 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 	struct ldtentry *d;
 	struct dtslot *t;
 	int d_namleft, len, outlen;
-	unsigned long dirent_buf;
+	void *dirent_buf;
 	char *name_ptr;
 	u32 dir_index;
 	int do_index = 0;
@@ -2884,7 +2884,7 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 		}
 	}
 
-	dirent_buf = __get_free_page(GFP_KERNEL);
+	dirent_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (dirent_buf == 0) {
 		DT_PUTPAGE(mp);
 		jfs_warn("jfs_readdir: __get_free_page failed!");
@@ -2893,7 +2893,7 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 	while (1) {
-		jfs_dirent = (struct jfs_dirent *) dirent_buf;
+		jfs_dirent = dirent_buf;
 		jfs_dirents = 0;
 		overflow = fix_page = 0;
 
@@ -2903,7 +2903,7 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 			if (stbl[i] < 0) {
 				jfs_err("JFS: Invalid stbl[%d] = %d for inode %ld, block = %lld",
 					i, stbl[i], (long)ip->i_ino, (long long)bn);
-				free_page(dirent_buf);
+				kfree(dirent_buf);
 				DT_PUTPAGE(mp);
 				return -EIO;
 			}
@@ -2911,7 +2911,7 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 			d = (struct ldtentry *) & p->slot[stbl[i]];
 
 			if (((long) jfs_dirent + d->namlen + 1) >
-			    (dirent_buf + PAGE_SIZE)) {
+			    ((long)dirent_buf + PAGE_SIZE)) {
 				/* DBCS codepages could overrun dirent_buf */
 				index = i;
 				overflow = 1;
@@ -3014,7 +3014,7 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 		/* unpin previous leaf page */
 		DT_PUTPAGE(mp);
 
-		jfs_dirent = (struct jfs_dirent *) dirent_buf;
+		jfs_dirent = dirent_buf;
 		while (jfs_dirents--) {
 			ctx->pos = jfs_dirent->position;
 			if (!dir_emit(ctx, jfs_dirent->name,
@@ -3037,13 +3037,13 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 
 		DT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
 		if (rc) {
-			free_page(dirent_buf);
+			kfree(dirent_buf);
 			return rc;
 		}
 	}
 
       out:
-	free_page(dirent_buf);
+	kfree(dirent_buf);
 
 	return rc;
 }

-- 
2.53.0


