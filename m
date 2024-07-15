Return-Path: <linux-nfs+bounces-4899-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56616930F18
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C54F281697
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849AF13AD11;
	Mon, 15 Jul 2024 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pcJkZVZU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CVQrUvqc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pcJkZVZU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CVQrUvqc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE696AB8
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029715; cv=none; b=kFapN9ti7HNn4aP+cQiQh/hvAAs7BQu2jEfM6RA9/MDymoXAovKHizkhLNJM5KBpXZCidy3XMYfOy32iRj/AssHbFW3Ltx8pvG4T6AV6veaG/62XsJ9919h0HXF4+/QZYD8gSN+MYX0rvmmY+Ups/tUp6ePPMxcqVU3QvU6WDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029715; c=relaxed/simple;
	bh=CLhX6vpT4BIEobXt15m61jAzWkehqqnZ6KTQUixkOP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYvIFTuYZ0MsG2bfhvmnY5tqJ7NepJ/Ox9Su1+heuNJzp37++EUpJV4avZxXiyRNCBrp9TV9InffUZjGseRzQv5B+nfHacVrzDF5pwihOQc7MDan65SdPYUZHpJLnBpjXs24yDikPAyAxqiqd61TGnnJbBYtSPLn89lfrEIWLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pcJkZVZU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CVQrUvqc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pcJkZVZU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CVQrUvqc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 089951F7B2;
	Mon, 15 Jul 2024 07:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaMXKNV+oIixwuRWZ4nip45zTBjKxx2jZDfhXmuv9Bo=;
	b=pcJkZVZUUtOEGMSK2E7+P6GHXqJLpKuAfKtssNm1mMkBQgfPDmPh/yzpVpXPpO6Adna8+K
	EACR2m3le/nPweaf4BEV0hRwxSjC5pr0YxbgT/FIjrZHUNgHzPv7GwXniS4m0Ojbtl0Ban
	7DSmfUAYZgH0TICtcRYX/opXuZc4sJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaMXKNV+oIixwuRWZ4nip45zTBjKxx2jZDfhXmuv9Bo=;
	b=CVQrUvqctBeLpnGfT5EFrN5wr6a2PeqiucRaZqEPq1LvnLTAmK761ol5r6dgNvT7LzEG31
	DEZ32IhCbqDUASBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaMXKNV+oIixwuRWZ4nip45zTBjKxx2jZDfhXmuv9Bo=;
	b=pcJkZVZUUtOEGMSK2E7+P6GHXqJLpKuAfKtssNm1mMkBQgfPDmPh/yzpVpXPpO6Adna8+K
	EACR2m3le/nPweaf4BEV0hRwxSjC5pr0YxbgT/FIjrZHUNgHzPv7GwXniS4m0Ojbtl0Ban
	7DSmfUAYZgH0TICtcRYX/opXuZc4sJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaMXKNV+oIixwuRWZ4nip45zTBjKxx2jZDfhXmuv9Bo=;
	b=CVQrUvqctBeLpnGfT5EFrN5wr6a2PeqiucRaZqEPq1LvnLTAmK761ol5r6dgNvT7LzEG31
	DEZ32IhCbqDUASBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A068E137EB;
	Mon, 15 Jul 2024 07:48:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LuWcFU3UlGYAbgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:48:29 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 07/14] Change unshare_fs_struct() to never fail.
Date: Mon, 15 Jul 2024 17:14:20 +1000
Message-ID: <20240715074657.18174-8-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240715074657.18174-1-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *

nfsd threads need to not share the init fs_struct as they need to
manipulate umask independently.  So they call unshare_fs_struct() and
are the only user of that function.

In the unlikely event that unshare_fs_struct() fails, the thread will
exit calling svc_exit_thread() BEFORE svc_thread_should_stop() reports
'true'.

This is a problem because svc_exit_thread() assumes that
svc_stop_threads() is running and consequently (in the nfsd case)
nfsd_mutex is held.  This ensures that the list_del_rcu() call in
svc_exit_thread() cannot race with any other manipulation of
->sp_all_threads.

While it would be possible to add some other exclusion, doing so would
introduce unnecessary complexity.  unshare_fs_struct() does not fail in
practice.  So the simplest solution is to make this explicit.  i.e.  use
__GFP_NOFAIL which is safe on such a small allocation - about 64 bytes.

Change unshare_fs_struct() to not return any error, and remove the error
handling from nfsd().

An alternate approach would be to create a variant of
kthread_create_on_node() which didn't set CLONE_FS.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/fs_struct.c            | 42 ++++++++++++++++++++-------------------
 fs/nfsd/nfssvc.c          |  9 +++------
 include/linux/fs_struct.h |  2 +-
 3 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 64c2d0814ed6..49fba862e408 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -109,35 +109,39 @@ void exit_fs(struct task_struct *tsk)
 	}
 }
 
+static void init_fs_struct(struct fs_struct *fs, struct fs_struct *old)
+{
+	fs->users = 1;
+	fs->in_exec = 0;
+	spin_lock_init(&fs->lock);
+	seqcount_spinlock_init(&fs->seq, &fs->lock);
+	fs->umask = old->umask;
+
+	spin_lock(&old->lock);
+	fs->root = old->root;
+	path_get(&fs->root);
+	fs->pwd = old->pwd;
+	path_get(&fs->pwd);
+	spin_unlock(&old->lock);
+}
+
 struct fs_struct *copy_fs_struct(struct fs_struct *old)
 {
 	struct fs_struct *fs = kmem_cache_alloc(fs_cachep, GFP_KERNEL);
 	/* We don't need to lock fs - think why ;-) */
-	if (fs) {
-		fs->users = 1;
-		fs->in_exec = 0;
-		spin_lock_init(&fs->lock);
-		seqcount_spinlock_init(&fs->seq, &fs->lock);
-		fs->umask = old->umask;
-
-		spin_lock(&old->lock);
-		fs->root = old->root;
-		path_get(&fs->root);
-		fs->pwd = old->pwd;
-		path_get(&fs->pwd);
-		spin_unlock(&old->lock);
-	}
+	if (fs)
+		init_fs_struct(fs, old);
 	return fs;
 }
 
-int unshare_fs_struct(void)
+void unshare_fs_struct(void)
 {
 	struct fs_struct *fs = current->fs;
-	struct fs_struct *new_fs = copy_fs_struct(fs);
+	struct fs_struct *new_fs = kmem_cache_alloc(fs_cachep,
+						    GFP_KERNEL| __GFP_NOFAIL);
 	int kill;
 
-	if (!new_fs)
-		return -ENOMEM;
+	init_fs_struct(new_fs, fs);
 
 	task_lock(current);
 	spin_lock(&fs->lock);
@@ -148,8 +152,6 @@ int unshare_fs_struct(void)
 
 	if (kill)
 		free_fs_struct(fs);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(unshare_fs_struct);
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 7377422a34df..f5de04a63c6f 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -873,11 +873,9 @@ nfsd(void *vrqstp)
 
 	/* At this point, the thread shares current->fs
 	 * with the init process. We need to create files with the
-	 * umask as defined by the client instead of init's umask. */
-	if (unshare_fs_struct() < 0) {
-		printk("Unable to start nfsd thread: out of memory\n");
-		goto out;
-	}
+	 * umask as defined by the client instead of init's umask.
+	 */
+	unshare_fs_struct();
 
 	current->fs->umask = 0;
 
@@ -899,7 +897,6 @@ nfsd(void *vrqstp)
 
 	atomic_dec(&nfsd_th_cnt);
 
-out:
 	/* Release the thread */
 	svc_exit_thread(rqstp);
 	return 0;
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 783b48dedb72..8282e6c7ff29 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -22,7 +22,7 @@ extern void set_fs_root(struct fs_struct *, const struct path *);
 extern void set_fs_pwd(struct fs_struct *, const struct path *);
 extern struct fs_struct *copy_fs_struct(struct fs_struct *);
 extern void free_fs_struct(struct fs_struct *);
-extern int unshare_fs_struct(void);
+extern void unshare_fs_struct(void);
 
 static inline void get_fs_root(struct fs_struct *fs, struct path *root)
 {
-- 
2.44.0


