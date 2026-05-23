Return-Path: <linux-nfs+bounces-21878-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6APKCHbqEWqbrwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21878-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:57:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A75C02ED
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47C78301F5C0
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ED22C15B0;
	Sat, 23 May 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7p9Lyua"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C93191CA;
	Sat, 23 May 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558904; cv=none; b=D5+dy40wzbS5mEuV02joTFAE1vklX/5/2pLznowoEhOBRRyZTPVnh+NJl46D1DUco0Lxj76edniqXMNHJ0zRl5WCvG/8BFl8g4hT5ZYJUm2KF2rWrzQwGk8wxsedKAgRzD9/l8yglPw/5PdvX8Zy4XATR4ffGzyYvNF/iXNP5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558904; c=relaxed/simple;
	bh=Vsd/wl1Tn0vzabGFFmOePP1xPlA5IcmcVVYveD8+Ib0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/uCFUsuN2xnSFvHNAicgp/uKdGS+H7vBBOeTlM1ERS6mW8XP93MzhvwvIrqAQIoL5L243lzscKQH222SF0hVftt6QsS+kEbCcIcRXWD1EYeadJ9WWiTGVVOqp5HuZqeVNzt0XvI61qZEBFAzxcXwTIUoFjNi1P2MNNv1CeGpxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7p9Lyua; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0E71F00A3A;
	Sat, 23 May 2026 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779558902;
	bh=ITTiAQYd8mEQisPL9MCYMPbpKSqI/TuCeLpOsMIzCQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I7p9LyuaY2ah6+I6CPot4PjChnihlTibi2SZ7+Ut7FOot90SlZtu+2clc390PgyyZ
	 9agzHx48psjaHZps3KSB/WOFgnxbJlsqb6/JLVfZdNfGceJ2Y9XcD86fjETSGQdG3g
	 tKxIwd0x8Muwi4LWLDAtmpaPdQEJwZOXx6WyPNSbmE+u5QAgYaH89YA3aDsPYLEc0F
	 PjqkH50UzUw1A3SKAhs1BhctyTes5QQ7FF41TMFoGMlhxOlWaVHTLMocXy3NuVP8dg
	 4SHkhHKEWrGrwrUVSXBb1eQNbTsp+le/+0d8UdKFZomhr8PP97eaoRyEAUgjIKv34e
	 F2p7cOefs7OLQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 23 May 2026 20:54:15 +0300
Subject: [PATCH 03/17] ocfs2/dlm: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-b4-fs-v1-3-275e36a83f0e@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21878-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 670A75C02ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A few places in ocsfs2 allocate temporary buffers with __get_free_page() or
get_zeroed_page().

kmalloc() is a better API for such use and it also provides better
scalability and more debugging possibilities.

Replace use of __get_free_page() and get_zeroed_page() with kmalloc() and
kzalloc() respectively.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 fs/ocfs2/dlm/dlmdebug.c    | 24 +++++++++---------------
 fs/ocfs2/dlm/dlmdomain.c   |  8 +++++---
 fs/ocfs2/dlm/dlmmaster.c   |  5 ++---
 fs/ocfs2/dlm/dlmrecovery.c |  4 ++--
 4 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index fe4fdd09bae3..6ca8b3b68eef 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -260,10 +260,10 @@ void dlm_print_one_mle(struct dlm_master_list_entry *mle)
 {
 	char *buf;
 
-	buf = (char *) get_zeroed_page(GFP_ATOMIC);
+	buf = kzalloc(PAGE_SIZE, GFP_ATOMIC);
 	if (buf) {
 		dump_mle(mle, buf, PAGE_SIZE - 1);
-		free_page((unsigned long)buf);
+		kfree(buf);
 	}
 }
 
@@ -280,7 +280,7 @@ static struct dentry *dlm_debugfs_root;
 /* begin - utils funcs */
 static int debug_release(struct inode *inode, struct file *file)
 {
-	free_page((unsigned long)file->private_data);
+	kfree(file->private_data);
 	return 0;
 }
 
@@ -327,17 +327,15 @@ static int debug_purgelist_open(struct inode *inode, struct file *file)
 	struct dlm_ctxt *dlm = inode->i_private;
 	char *buf = NULL;
 
-	buf = (char *) get_zeroed_page(GFP_NOFS);
+	buf = kzalloc(PAGE_SIZE, GFP_NOFS);
 	if (!buf)
-		goto bail;
+		return -ENOMEM;
 
 	i_size_write(inode, debug_purgelist_print(dlm, buf, PAGE_SIZE - 1));
 
 	file->private_data = buf;
 
 	return 0;
-bail:
-	return -ENOMEM;
 }
 
 static const struct file_operations debug_purgelist_fops = {
@@ -384,17 +382,15 @@ static int debug_mle_open(struct inode *inode, struct file *file)
 	struct dlm_ctxt *dlm = inode->i_private;
 	char *buf = NULL;
 
-	buf = (char *) get_zeroed_page(GFP_NOFS);
+	buf = kzalloc(PAGE_SIZE, GFP_NOFS);
 	if (!buf)
-		goto bail;
+		return -ENOMEM;
 
 	i_size_write(inode, debug_mle_print(dlm, buf, PAGE_SIZE - 1));
 
 	file->private_data = buf;
 
 	return 0;
-bail:
-	return -ENOMEM;
 }
 
 static const struct file_operations debug_mle_fops = {
@@ -775,17 +771,15 @@ static int debug_state_open(struct inode *inode, struct file *file)
 	struct dlm_ctxt *dlm = inode->i_private;
 	char *buf = NULL;
 
-	buf = (char *) get_zeroed_page(GFP_NOFS);
+	buf = kzalloc(PAGE_SIZE, GFP_NOFS);
 	if (!buf)
-		goto bail;
+		return -ENOMEM;
 
 	i_size_write(inode, debug_state_print(dlm, buf, PAGE_SIZE - 1));
 
 	file->private_data = buf;
 
 	return 0;
-bail:
-	return -ENOMEM;
 }
 
 static const struct file_operations debug_state_fops = {
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index dc9da9133c8e..97bb9400e24b 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -63,7 +63,7 @@ static inline void byte_copymap(u8 dmap[], unsigned long smap[],
 static void dlm_free_pagevec(void **vec, int pages)
 {
 	while (pages--)
-		free_page((unsigned long)vec[pages]);
+		kfree(vec[pages]);
 	kfree(vec);
 }
 
@@ -75,9 +75,11 @@ static void **dlm_alloc_pagevec(int pages)
 	if (!vec)
 		return NULL;
 
-	for (i = 0; i < pages; i++)
-		if (!(vec[i] = (void *)__get_free_page(GFP_KERNEL)))
+	for (i = 0; i < pages; i++) {
+		vec[i] = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!vec[i])
 			goto out_free;
+	}
 
 	mlog(0, "Allocated DLM hash pagevec; %d pages (%lu expected), %lu buckets per page\n",
 	     pages, (unsigned long)DLM_HASH_PAGES,
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 93eff38fdadd..aee3b4c56dcc 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -2548,7 +2548,7 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
 
 	/* preallocate up front. if this fails, abort */
 	ret = -ENOMEM;
-	mres = (struct dlm_migratable_lockres *) __get_free_page(GFP_NOFS);
+	mres = kmalloc(PAGE_SIZE, GFP_NOFS);
 	if (!mres) {
 		mlog_errno(ret);
 		goto leave;
@@ -2725,8 +2725,7 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
 	if (wake)
 		wake_up(&res->wq);
 
-	if (mres)
-		free_page((unsigned long)mres);
+	kfree(mres);
 
 	dlm_put(dlm);
 
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 128872bd945d..9b97bf73df22 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -837,7 +837,7 @@ int dlm_request_all_locks_handler(struct o2net_msg *msg, u32 len, void *data,
 	}
 
 	/* this will get freed by dlm_request_all_locks_worker */
-	buf = (char *) __get_free_page(GFP_NOFS);
+	buf = kmalloc(PAGE_SIZE, GFP_NOFS);
 	if (!buf) {
 		kfree(item);
 		dlm_put(dlm);
@@ -933,7 +933,7 @@ static void dlm_request_all_locks_worker(struct dlm_work_item *item, void *data)
 		}
 	}
 leave:
-	free_page((unsigned long)data);
+	kfree(data);
 }
 
 

-- 
2.53.0


