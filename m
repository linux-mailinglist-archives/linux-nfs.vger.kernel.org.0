Return-Path: <linux-nfs+bounces-20137-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEZ1D9Bfs2lcVgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20137-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:52:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C51327C028
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFBCF302E750
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40B130AAD0;
	Fri, 13 Mar 2026 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mdKzMrUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yDEdPqox"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958829BD82;
	Fri, 13 Mar 2026 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362888; cv=none; b=T0eWVYADOZkpqeBtEbdXrI3qRY/8SJFfsK2MfynLZlsv9ND+zk8pBq1wptol3aQBirVjO3QJ9LMFiYvqSdAiLndOs9Ju5iAYLiXtHNDAcdwts2PKVSIWJ+La8YcLhfeuOVq6SbN1Qle/dGLb3wx0QOO6duuwGz5B7wkPrDn9ldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362888; c=relaxed/simple;
	bh=J2J65yPHZ8aYn1x2FV6a4SeL2IbdAXmJXNoFbksmJ00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TG3XajR/KTV0aXC8Uc32po083cfiMlfXmyzyyqR/qIqoNRUf8vWjVEkxYmLw5RdBuBa6ZSLklxP2VcSnXGFFzEVGYu0pkuapfmp6OZYajad6OVgW3A90bZBstw9K2r5juM92CeCmvXCdH6DqL+plj6pY5IDocvunJvBGzOb7aag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mdKzMrUC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yDEdPqox; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id ABF701301B7A;
	Thu, 12 Mar 2026 20:48:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 20:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362884;
	 x=1773370084; bh=vcLY9NjcITx2BXCNwc1K2QRLwUNNN9sEl0XxFiatrQo=; b=
	mdKzMrUCmCgev5rjqMYLbCk9/NmPt8l5SN1cuh/XYEGVQSm40ukfPkz/tmPxK/Fw
	C8CU42AUDwoB+BWyvZtfv3qDJQwJMZqdkw0S72eJstmGGGMBhaX3ZHeVREPYyC2V
	fvUXlbJyg6aO5H4oucGa1RsaVgY2d21FE00GybtMYM8I1ew/f4keraC6xDUPB7c+
	5Pn0hGoCJlIddOhvP8sj6pXnoHeVeH2/moOy4KjHgIUwC35SmgVP2TRJhtJl4ARo
	qOU1z9u/0AZz+m+raqJO2irqtfbC4sPHEnz+cJH8kzFrV31gL9Yt6CTvQ0AfNIcZ
	ThO11BMQNTi0fw4x0ZoXng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362884; x=1773370084; bh=v
	cLY9NjcITx2BXCNwc1K2QRLwUNNN9sEl0XxFiatrQo=; b=yDEdPqoxm0mvV/5PV
	Tn/eyzEfPnGUZEUvP0huJ0EgtFB+R+oNg15Lem1KP+cIB5aYs2Z0gfeS39ngIbKd
	sOWHNPGK+ZBSJt6wqiz2s389Zx158JBtkDde4mi+o9LWu2L220htc5Z57Rzo3VCu
	Z90aAHSpgBiPjX8Yb5AmV6q6FQWHuRjLfpHlr9jZjWb14gW0ydd4OI2iRf2hiTOH
	MlOKV6hphPTxCpVXdLyVJMEyK2ZBPk/i/vECEPqsu4qQtVl5VtfC5ZMnfsQ25QJV
	yMMfqpO4OcTvkWzFGghdY4we94eIkCp4DUNmAIn0DHytKFG5IxjjFvYe1zdHOPjm
	yg30A==
X-ME-Sender: <xms:xF6zaULW-NwfZ6qu3iJ9TlEpAEC4uvO82gKtANaBAXYbdtWdN5XVkQ>
    <xme:xF6zaX1A6f3iSCrTwSwJZCB6Tw6LuoRySNxlr4ygzru7LHkCgercK7wD_YNFghaPH
    blQzzGMx3reVFOfFHrMVsy8tYCFIb3P9olIpEKtDle8iuAB>
X-ME-Received: <xmr:xF6zafzQznsFTdMpan5mFbq7xcgpUC_0AeCWzRdATCvsU8ZvZPDZNod_8tQfK5u15bLRkg3QSLtcNDY4l8SUvRBc_s98YD0PPSRUwc6_MXez>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtoheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:xF6zae1CmnJpT51rTdmfgm3qsIuMeUX2qKE-vHu6G96-t9rU5tfCfg>
    <xmx:xF6zaQ6Kg0DhF3JyA7Grw7T5XFPqYZr7dC9NGUkrW1os-H7djLtabg>
    <xmx:xF6zaZfjJJxvAh-lv1fnj6C-QCEXixW2zPJzDqHfmxNxsWpWg-scjA>
    <xmx:xF6zacbpasj86nZdirEODaqhQnsR5vPmsB0fhCgedqBfuHkUzp7tIQ>
    <xmx:xF6zaUUkZ-bPNnauXw_6I8hrTSreHohEU96-xm7UFeGDs5FbnFLK1l-1>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:47:50 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,	Carlos Maiolino <cem@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,	Tyler Hicks <code@tyhicks.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	coda@cs.cmu.edu,
	linux-mm@kvack.org,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 20/53] afs: don't unhash/rehash dentries during unlink/rename
Date: Fri, 13 Mar 2026 08:12:07 +1100
Message-ID: <20260312214330.3885211-21-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20137-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,brown.name:email,brown.name:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid]
X-Rspamd-Queue-Id: 3C51327C028
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

afs needs to block lookup of dentries during unlink and rename.
There are two reasons:
1/ If the target is to be removed, not silly-renamed, the subsequent
   opens cannot be allowed as the file won't exist on the server.
2/ If the rename source is being moved between directories a lookup,
   particularly d_revalidate, might change ->d_time asynchronously
   with rename changing ->d_time with possible incorrect results.

afs current unhashes the dentry to force a lookup which will wait on the
directory lock, and rehashes afterwards.  This is incompatible with
proposed changed to directory locking which will require a dentry to
remain hashed throughout rename/unlink/etc operations.

This patch copies a mechanism developed for NFS.  ->d_fsdata which is
currently unused is now set to a non-NULL value when lookups must be
blocked.  d_revalidate checks for this value, and waits for it to become
NULL.

->d_lock is used to ensure d_revalidate never updates ->d_time while
->d_fsdata is set.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/afs.h      |  7 ++++++
 fs/afs/dir.c      | 64 +++++++++++++++++++++++++++++------------------
 fs/afs/internal.h |  5 +---
 3 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index ec3db00bd081..019e77b08458 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -26,6 +26,13 @@ typedef u64			afs_volid_t;
 typedef u64			afs_vnodeid_t;
 typedef u64			afs_dataversion_t;
 
+/* This is stored in ->d_fsdata to stop d_revalidate looking at,
+ * and possibly changing, ->d_time on a dentry which is being moved
+ * between directories, and to block lookup for dentry that is
+ * being removed without silly-rename.
+ */
+#define AFS_FSDATA_BLOCKED ((void*)1)
+
 typedef enum {
 	AFSVL_RWVOL,			/* read/write volume */
 	AFSVL_ROVOL,			/* read-only volume */
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index a0417292314c..9c57614feccf 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1034,6 +1034,10 @@ static int afs_d_revalidate_rcu(struct afs_vnode *dvnode, struct dentry *dentry)
 	if (!afs_check_validity(dvnode))
 		return -ECHILD;
 
+	/* A rename/unlink is pending */
+	if (dentry->d_fsdata)
+		return -ECHILD;
+
 	/* We only need to invalidate a dentry if the server's copy changed
 	 * behind our back.  If we made the change, it's no problem.  Note that
 	 * on a 32-bit system, we only have 32 bits in the dentry to store the
@@ -1069,6 +1073,10 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	if (flags & LOOKUP_RCU)
 		return afs_d_revalidate_rcu(dir, dentry);
 
+	/* Wait for rename/unlink to complete */
+wait_for_rename:
+	wait_var_event(&dentry->d_fsdata, dentry->d_fsdata == NULL);
+
 	if (d_really_is_positive(dentry)) {
 		vnode = AFS_FS_I(d_inode(dentry));
 		_enter("{v={%llx:%llu} n=%pd fl=%lx},",
@@ -1161,7 +1169,13 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	}
 
 out_valid:
+	spin_lock(&dentry->d_lock);
+	if (dentry->d_fsdata) {
+		spin_unlock(&dentry->d_lock);
+		goto wait_for_rename;
+	}
 	dentry->d_time = (unsigned long)dir_version;
+	spin_unlock(&dentry->d_lock);
 out_valid_noupdate:
 	key_put(key);
 	_leave(" = 1 [valid]");
@@ -1536,8 +1550,7 @@ static void afs_unlink_edit_dir(struct afs_operation *op)
 static void afs_unlink_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
-	if (op->unlink.need_rehash && afs_op_error(op) < 0 && afs_op_error(op) != -ENOENT)
-		d_rehash(op->dentry);
+	store_release_wake_up(&op->dentry->d_fsdata, NULL);
 }
 
 static const struct afs_operation_ops afs_unlink_operation = {
@@ -1591,11 +1604,7 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 		afs_op_set_error(op, afs_sillyrename(dvnode, vnode, dentry, op->key));
 		goto error;
 	}
-	if (!d_unhashed(dentry)) {
-		/* Prevent a race with RCU lookup. */
-		__d_drop(dentry);
-		op->unlink.need_rehash = true;
-	}
+	dentry->d_fsdata = AFS_FSDATA_BLOCKED;
 	spin_unlock(&dentry->d_lock);
 
 	op->file[1].vnode = vnode;
@@ -1885,9 +1894,10 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 
 	_enter("op=%08x", op->debug_id);
 
-	if (op->rename.rehash) {
-		d_rehash(op->rename.rehash);
-		op->rename.rehash = NULL;
+	if (op->rename.unblock) {
+		/* Rename has finished, so unlocks lookups to target */
+		store_release_wake_up(&op->rename.unblock->d_fsdata, NULL);
+		op->rename.unblock = NULL;
 	}
 
 	fscache_begin_write_operation(&orig_cres, afs_vnode_cache(orig_dvnode));
@@ -1970,6 +1980,9 @@ static void afs_rename_exchange_edit_dir(struct afs_operation *op)
 
 		d_exchange(old_dentry, new_dentry);
 		up_write(&orig_dvnode->validate_lock);
+	/* dentry has been moved, so d_validate can safely proceed */
+	store_release_wake_up(&old_dentry->d_fsdata, NULL);
+
 	} else {
 		down_write(&orig_dvnode->validate_lock);
 		if (test_bit(AFS_VNODE_DIR_VALID, &orig_dvnode->flags) &&
@@ -2009,11 +2022,10 @@ static void afs_rename_exchange_edit_dir(struct afs_operation *op)
 static void afs_rename_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
-	if (op->rename.rehash)
-		d_rehash(op->rename.rehash);
+	if (op->rename.unblock)
+		store_release_wake_up(&op->rename.unblock->d_fsdata, NULL);
+	store_release_wake_up(&op->dentry->d_fsdata, NULL);
 	dput(op->rename.tmp);
-	if (afs_op_error(op))
-		d_rehash(op->dentry);
 }
 
 static const struct afs_operation_ops afs_rename_operation = {
@@ -2121,7 +2133,6 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		op->ops		= &afs_rename_noreplace_operation;
 	} else if (flags & RENAME_EXCHANGE) {
 		op->ops		= &afs_rename_exchange_operation;
-		d_drop(new_dentry);
 	} else {
 		/* If we might displace the target, we might need to do silly
 		 * rename.
@@ -2135,14 +2146,12 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		 */
 		if (d_is_positive(new_dentry) && !d_is_dir(new_dentry)) {
 			/* To prevent any new references to the target during
-			 * the rename, we unhash the dentry in advance.
+			 * the rename, we set d_fsdata which afs_d_revalidate will wait for.
+			 * d_lock ensures d_count() and ->d_fsdata are consistent.
 			 */
-			if (!d_unhashed(new_dentry)) {
-				d_drop(new_dentry);
-				op->rename.rehash = new_dentry;
-			}
-
+			spin_lock(&new_dentry->d_lock);
 			if (d_count(new_dentry) > 2) {
+				spin_unlock(&new_dentry->d_lock);
 				/* copy the target dentry's name */
 				op->rename.tmp = d_alloc(new_dentry->d_parent,
 							 &new_dentry->d_name);
@@ -2160,8 +2169,12 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 				}
 
 				op->dentry_2 = op->rename.tmp;
-				op->rename.rehash = NULL;
 				op->rename.new_negative = true;
+			} else {
+				/* Block any lookups to target until the rename completes */
+				new_dentry->d_fsdata = AFS_FSDATA_BLOCKED;
+				op->rename.unblock = new_dentry;
+				spin_unlock(&new_dentry->d_lock);
 			}
 		}
 	}
@@ -2172,10 +2185,11 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	 * d_revalidate may see old_dentry between the op having taken place
 	 * and the version being updated.
 	 *
-	 * So drop the old_dentry for now to make other threads go through
-	 * lookup instead - which we hold a lock against.
+	 * So block revalidate on the old_dentry until the rename completes.
 	 */
-	d_drop(old_dentry);
+	spin_lock(&old_dentry->d_lock);
+	old_dentry->d_fsdata = AFS_FSDATA_BLOCKED;
+	spin_unlock(&old_dentry->d_lock);
 
 	ret = afs_do_sync_operation(op);
 	if (ret == -ENOTSUPP)
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 106a7fe06b56..f2898ce9c0e6 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -891,10 +891,7 @@ struct afs_operation {
 			const char *symlink;
 		} create;
 		struct {
-			bool	need_rehash;
-		} unlink;
-		struct {
-			struct dentry	*rehash;
+			struct dentry	*unblock;
 			struct dentry	*tmp;
 			unsigned int	rename_flags;
 			bool		new_negative;
-- 
2.50.0.107.gf914562f5916.dirty


