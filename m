Return-Path: <linux-nfs+bounces-8371-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7FB9E63FF
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62218163F08
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD03B13C8FF;
	Fri,  6 Dec 2024 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rsiikS2J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xAnRmVxq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wi/sJ+7u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TglHwA/1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A685156236
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451586; cv=none; b=Syh0nyclBIXHTLf1reQ2K3g3nEn6Vwu2jtFDlkq+9f5+YW9R981fshr/cQF3LtYsD7Wb85ybtg2MQcw6QbycCNycrZPvGEV01WX22PUS6xEVD8WuxcMwcBjySVuBtx9w6R7xEU+D/sORSmMbHc3ZJwtXxQdFQi/7bdciK86aNcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451586; c=relaxed/simple;
	bh=dGxEauQ5AiclfhaDNdq2WobA3iP6WuROfPZD4be0tTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLtVqyqcet7mFthW90VY/WSxcmMC/QqcHxyT23tkmgtOsDLZoiufMpzq0P/WLckmVGOMDt4jhzlPiVovTj7QAKO5GcNcB+AGN3/agGBga3lzr1oJxWK5Ci5EUcutES00BQiSCuMUFQDaj2F3EMMpMUR7L2NeonnyD0eq7DA8PsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rsiikS2J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xAnRmVxq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wi/sJ+7u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TglHwA/1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E54F1F38E;
	Fri,  6 Dec 2024 02:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEzXuyO84He5M3buB+jg1R0KA4CrI62RrWSXlq5lffg=;
	b=rsiikS2Jt3aHhbv1xyC9zAc30AsrsAP5BPTsKwmqPcUzZVHxGwqL8BMM7ReFo94+/rhuV+
	wnxHNRCRX85OsV8tw85x8jFwk+VSoDUA0iZ7CAb82IAlTrRvoRLk1ZetdenpiPEjF75xoM
	nwAbH//DxqpN5wza7hEzG5bM6j9O5ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEzXuyO84He5M3buB+jg1R0KA4CrI62RrWSXlq5lffg=;
	b=xAnRmVxq4whUTPbC5Iblm29L7ie7V730Fnp0+6f8hdLrPzRFvQQJYNTupnA0JRWlpOyAje
	gX/1bFXE+I892bCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEzXuyO84He5M3buB+jg1R0KA4CrI62RrWSXlq5lffg=;
	b=Wi/sJ+7u+7aB1m0WGDxdQ/NfHvMRdyvreBzm1YLzAnIuorJ3QRdyhgJe7OnD1jcF9ZMxML
	H+DBssMFOQLM4IJFK3L3eKsTfT9Lvq5jPpPrPup5+mQZ5fsqRWZ+sFGO4Ew9diQkrrQmVN
	32Zp2uzd/bMMLgPB1T0JCGqIP1663V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEzXuyO84He5M3buB+jg1R0KA4CrI62RrWSXlq5lffg=;
	b=TglHwA/1XiwwCk2MB3rhslLgXwXAAyUxb1K9ZZaHObHlTDX/bVpWB9m/fwKscDGRQJkbB7
	XVzx2YfnRvZMzpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB3A913A15;
	Fri,  6 Dec 2024 02:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HaKBJzxfUmdbJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:19:40 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 08/11] nfs: discard nfs_wait_bit_killable()
Date: Fri,  6 Dec 2024 13:15:34 +1100
Message-ID: <20241206021830.3526922-9-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206021830.3526922-1-neilb@suse.de>
References: <20241206021830.3526922-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This patch changes NFS to use wait_on_bit() instead of
wait_on_bit_action()
nfs_wait_bit_killable() is identical to bit_wait() except that it
returns -ERESTARTSYS instead of -EINTR.  NFS doesn't care about this
distinction.  The status will often get back to user-space but it will
only be sent when the process is being killed in which case there is no
user-space to care.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/file.c      |  5 ++---
 fs/nfs/inode.c     | 14 ++------------
 fs/nfs/internal.h  |  1 -
 fs/nfs/nfs4state.c |  5 ++---
 fs/nfs/pnfs.c      |  9 +++------
 5 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1bb646752e46..0fafdfec5886 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -607,9 +607,8 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto out;
 	}
 
-	wait_on_bit_action(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
-			   nfs_wait_bit_killable,
-			   TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
+	wait_on_bit(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
+		    TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 
 	folio_lock(folio);
 	mapping = folio->mapping;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 4c4c3ab57fcd..2f1b4f11a056 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -72,15 +72,6 @@ nfs_fattr_to_ino_t(struct nfs_fattr *fattr)
 	return nfs_fileid_to_ino_t(fattr->fileid);
 }
 
-int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
-{
-	schedule();
-	if (signal_pending_state(mode, current))
-		return -ERESTARTSYS;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
-
 /**
  * nfs_compat_user_ino64 - returns the user-visible inode number
  * @fileid: 64-bit fileid
@@ -1419,9 +1410,8 @@ int nfs_clear_invalid_mapping(struct address_space *mapping)
 	 * the bit lock here if it looks like we're going to be doing that.
 	 */
 	for (;;) {
-		ret = wait_on_bit_action(bitlock, NFS_INO_INVALIDATING,
-					 nfs_wait_bit_killable,
-					 TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
+		ret = wait_on_bit(bitlock, NFS_INO_INVALIDATING,
+				  TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 		if (ret)
 			goto out;
 		smp_rmb(); /* pairs with smp_wmb() below */
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index e564bd11ba60..1ec10fa50830 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -451,7 +451,6 @@ extern void nfs_evict_inode(struct inode *);
 extern void nfs_zap_acl_cache(struct inode *inode);
 extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
 extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
-extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 /* localio.c */
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9a9f60a2291b..556b521f17eb 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1313,9 +1313,8 @@ int nfs4_wait_clnt_recover(struct nfs_client *clp)
 	might_sleep();
 
 	refcount_inc(&clp->cl_count);
-	res = wait_on_bit_action(&clp->cl_state, NFS4CLNT_MANAGER_RUNNING,
-				 nfs_wait_bit_killable,
-				 TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
+	res = wait_on_bit(&clp->cl_state, NFS4CLNT_MANAGER_RUNNING,
+			  TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 	if (res)
 		goto out;
 	if (clp->cl_cons_state < 0)
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 445ba09ba324..400f409f45fa 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2022,9 +2022,8 @@ static int pnfs_prepare_to_retry_layoutget(struct pnfs_layout_hdr *lo)
 	 * reference
 	 */
 	pnfs_layoutcommit_inode(lo->plh_inode, false);
-	return wait_on_bit_action(&lo->plh_flags, NFS_LAYOUT_RETURN,
-				   nfs_wait_bit_killable,
-				   TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
+	return wait_on_bit(&lo->plh_flags, NFS_LAYOUT_RETURN,
+			   TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 }
 
 static void nfs_layoutget_begin(struct pnfs_layout_hdr *lo)
@@ -3319,9 +3318,8 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	if (test_and_set_bit(NFS_INO_LAYOUTCOMMITTING, &nfsi->flags)) {
 		if (!sync)
 			goto out;
-		status = wait_on_bit_lock_action(&nfsi->flags,
+		status = wait_on_bit_lock(&nfsi->flags,
 				NFS_INO_LAYOUTCOMMITTING,
-				nfs_wait_bit_killable,
 				TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 		if (status)
 			goto out;
@@ -3369,7 +3367,6 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 		}
 	}
 
-
 	status = nfs4_proc_layoutcommit(data, sync);
 out:
 	if (status)
-- 
2.47.0


