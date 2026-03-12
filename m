Return-Path: <linux-nfs+bounces-20138-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EEzJDxfs2lbVgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20138-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:50:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A28C27BF6A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD67C3053C23
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B823313535;
	Fri, 13 Mar 2026 00:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="dN+zoQ+X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="34dgo/VI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241DB30FC29;
	Fri, 13 Mar 2026 00:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362905; cv=none; b=FfXDscDS/sEngEB/HT77iY/toZxY5fI51vrTdTXPNIQ7tmDG9qWONUGZzNAaAVjfBe+WdR7OnCnPMvt+IA3aIeqIzlaMn+OBSgi75iBEZDcgt0C2jvi1x8T2aNVXfiEdXN2uiHF60UntIi/GYBO9RmPPY2KeSBZJnWZshsrMli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362905; c=relaxed/simple;
	bh=bPb+bIqpK5hvVK2d8DMn3IwNAwWZ+dX19WhkeuUgfD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NB8qeLjWgF7NV0K0DYYOpDvQZQFO/o5P827Rhld7kvJxLpLITSKLbvz50eNHGVNezye97Q/ESKaK/ya/MXFD78HyaMwTNsTK6ePJ6SS/7mnlYsuf6nDu/IRKDO4QlWjcQDSC+380ayL2ZdvMbsjOsw7z9SG202NM194ArGIBxkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dN+zoQ+X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=34dgo/VI; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 723B61301B7D;
	Thu, 12 Mar 2026 20:48:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 20:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362902;
	 x=1773370102; bh=3OVL4XXP8pGkqIJaCgrneigzeg9lURjpYtnSBAI2TgY=; b=
	dN+zoQ+X4IMCOwHYdmkT/bGnzCHvuxlXBbrpp9O8UwCmnQeDDi7ioO7y2/TUY8l5
	mQGtxsh3qVE4W70GI8wjUfwVDAFocwzcsunO2RHndj6ssUSoW5JU5xyWRUYJYDG9
	NMIjn03yZHXunWH8BNEHahsglP7uOUYKduvq4RcsnRx45o5+YD6/oyA0D9GyutPP
	mLXDY4UxeKqfkDk1pTNpvWvnW1/dJJmaIfcBQR9lGPgKHB0zDYqbbg/WeD543BZ1
	YZZiFH4HEkOT7GPsszH0tbfrqAMP2nkAl+SHWoXH2ZfgLfzJ7G8Da4TigmEpPMMB
	kWwgCUIZj7EH1b7QHZSsmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362902; x=1773370102; bh=3
	OVL4XXP8pGkqIJaCgrneigzeg9lURjpYtnSBAI2TgY=; b=34dgo/VIKgtmzJGsl
	miC6lP3iQWBH1TiVT3V5XLsNBZ4hEoP69rm02c/9mKZc3HpddJ+Jm5BVWcJn9DkB
	57t0tJJgDeHpeL+ua3mR8GhZPmEwPi0lQb3PwN14P92l/6Ep6Qp5LUxmLxKuHb0F
	wZYQlWii+7LBp+7LMX/8e2iuf/gsPxQRwWVKDTbZSMt9L0ZT01nsdAwc9YTMK1yk
	3Ch2rxde/oduz5imnG5I61fP0o7Q2RmqJ7K3UEHPNtcBLNHsLWMstLaJPoAb0igY
	8DF5fJdmXv6TlSvdhF6xHSluXNYiYlg4IeJQvDDCwPSoyDiP0Juj0NE2pRGV7aHr
	PQHYQ==
X-ME-Sender: <xms:1V6zaXtH06rAO7pV4rOdlFXVNkVijrUmCf0vVAv_Ujaykp9lWFkVUA>
    <xme:1V6zaSL_4xMe1h15v6v_9nrb4svolCWWxRRWlp58JThkCtUqNOpn_7K56KAMV4jBN
    cGtzCL1Thm9U_31I3DYNACQlL80mseSG3Y6nzMDWD0wdm-FNw>
X-ME-Received: <xmr:1V6zaRsNHbq1HAAvorz2a4ifJogef7TXKmNqTpQcCe9PxHeFXpkqvRiwJY2ifrOJhZJ5aR-dtvC4AwJT1dpKudgAOgsZ9isPlFg0GubFOswr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epteetteeuteffveduveetgfdtuedvfffhudetuefgffejgffhgffhgfetffetudeinecu
    ffhomhgrihhnpehsthgrthhushdruggrthgrnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgs
    pghrtghpthhtohephedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhroh
    esiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidqgihf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhunhhioh
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqthhr
    rggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1V6zaaTzQHsC2J_WA_QH8YOW_5awtZOh6jhAGe4ctTmQ0wdnVKsSLA>
    <xmx:1V6zaXWc7zV7rd1I7sVLWCAwTLiktPdZhBNJ4HbNuPxgBSFuw-c-Lg>
    <xmx:1V6zaUwUe1ZPNR8n0_mEqCQ_Sd_NPmOB64IRNXt4wuoK-BJWr1Ospw>
    <xmx:1V6zaT_DAKDOpJYW6voXCzE3Z5WD-QvwjIkw_5BxIl1FpW93PzBDgA>
    <xmx:1l6zaV-vNAGrjs6_6LMnFfMVOi8yPfJmYBYHQZTtZUELj1jaKl8Npb0B>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:48:08 -0400 (EDT)
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
Subject: [PATCH 19/53] afs: use d_time instead of d_fsdata
Date: Fri, 13 Mar 2026 08:12:06 +1100
Message-ID: <20260312214330.3885211-20-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20138-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,brown.name:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 7A28C27BF6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

afs uses ->d_fsdata to store version information for the parent
directory.  ->d_time is arguably a better field to store this
information as the version is like a time stamp, and ->d_time is an
unsigned long, while ->d_fsdata is a void *.

This will leave ->d_fsdata free for a different use ...  which
admittedly is also not a void*, but is certainly not at all a time.

Interesting the value stored in ->d_time or d_fsdata is u64 which is a
different size of 32 bit hosts.  Maybe that doesn't matter.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c      | 18 +++++++++---------
 fs/afs/internal.h |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 78caef3f1338..a0417292314c 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -808,7 +808,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 		afs_dir_iterate(dir, &cookie->ctx, NULL, &data_version);
 	}
 
-	dentry->d_fsdata = (void *)(unsigned long)data_version;
+	dentry->d_time = (unsigned long)data_version;
 
 	/* Check to see if we already have an inode for the primary fid. */
 	inode = ilookup5(dir->i_sb, cookie->fids[1].vnode,
@@ -895,9 +895,9 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 	}
 
 	if (op->file[0].scb.have_status)
-		dentry->d_fsdata = (void *)(unsigned long)op->file[0].scb.status.data_version;
+		dentry->d_time = (unsigned long)op->file[0].scb.status.data_version;
 	else
-		dentry->d_fsdata = (void *)(unsigned long)op->file[0].dv_before;
+		dentry->d_time = (unsigned long)op->file[0].dv_before;
 	ret = afs_put_operation(op);
 out:
 	kfree(cookie);
@@ -1010,7 +1010,7 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	_debug("splice %p", dentry->d_inode);
 	d = d_splice_alias(inode, dentry);
 	if (!IS_ERR_OR_NULL(d)) {
-		d->d_fsdata = dentry->d_fsdata;
+		d->d_time = dentry->d_time;
 		trace_afs_lookup(dvnode, &d->d_name, &fid);
 	} else {
 		trace_afs_lookup(dvnode, &dentry->d_name, &fid);
@@ -1040,7 +1040,7 @@ static int afs_d_revalidate_rcu(struct afs_vnode *dvnode, struct dentry *dentry)
 	 * version.
 	 */
 	dir_version = (long)READ_ONCE(dvnode->status.data_version);
-	de_version = (long)READ_ONCE(dentry->d_fsdata);
+	de_version = (long)READ_ONCE(dentry->d_time);
 	if (de_version != dir_version) {
 		dir_version = (long)READ_ONCE(dvnode->invalid_before);
 		if (de_version - dir_version < 0)
@@ -1100,7 +1100,7 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	 * version.
 	 */
 	dir_version = dir->status.data_version;
-	de_version = (long)dentry->d_fsdata;
+	de_version = (long)dentry->d_time;
 	if (de_version == (long)dir_version)
 		goto out_valid_noupdate;
 
@@ -1161,7 +1161,7 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	}
 
 out_valid:
-	dentry->d_fsdata = (void *)(unsigned long)dir_version;
+	dentry->d_time = (unsigned long)dir_version;
 out_valid_noupdate:
 	key_put(key);
 	_leave(" = 1 [valid]");
@@ -1931,7 +1931,7 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 		spin_unlock(&new_inode->i_lock);
 	}
 
-	/* Now we can update d_fsdata on the dentries to reflect their
+	/* Now we can update d_time on the dentries to reflect their
 	 * new parent's data_version.
 	 */
 	afs_update_dentry_version(op, new_dvp, op->dentry);
@@ -2167,7 +2167,7 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	/* This bit is potentially nasty as there's a potential race with
-	 * afs_d_revalidate{,_rcu}().  We have to change d_fsdata on the dentry
+	 * afs_d_revalidate{,_rcu}().  We have to change d_time_ on the dentry
 	 * to reflect it's new parent's new data_version after the op, but
 	 * d_revalidate may see old_dentry between the op having taken place
 	 * and the version being updated.
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 009064b8d661..106a7fe06b56 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1746,17 +1746,17 @@ static inline struct inode *AFS_VNODE_TO_I(struct afs_vnode *vnode)
 }
 
 /*
- * Note that a dentry got changed.  We need to set d_fsdata to the data version
+ * Note that a dentry got changed.  We need to set d_time to the data version
  * number derived from the result of the operation.  It doesn't matter if
- * d_fsdata goes backwards as we'll just revalidate.
+ * d_time goes backwards as we'll just revalidate.
  */
 static inline void afs_update_dentry_version(struct afs_operation *op,
 					     struct afs_vnode_param *dir_vp,
 					     struct dentry *dentry)
 {
 	if (!op->cumul_error.error)
-		dentry->d_fsdata =
-			(void *)(unsigned long)dir_vp->scb.status.data_version;
+		dentry->d_time =
+			(unsigned long)dir_vp->scb.status.data_version;
 }
 
 /*
-- 
2.50.0.107.gf914562f5916.dirty


