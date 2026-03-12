Return-Path: <linux-nfs+bounces-20131-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OODlKfpfs2lcVgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20131-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:53:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3427C074
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B6CC325E7E4
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E888311942;
	Fri, 13 Mar 2026 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WHV8jLjR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZIH5/VZH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7F30E0F5;
	Fri, 13 Mar 2026 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362785; cv=none; b=fDtKIH7WKHYoawMyRMIADuSWc+yBdyrVj5mULZ8CL6vt0R+0PwzrBgGqKi/fzaz6yQtDD3yK/RnqsqZADIiWrZf8GptoQvregszQZaxzhW0PCukso1f3i9T+Hi/Pw0fV2fGyVqyNF5y4JwyE8XgpJiZGR/BdNIgETgJ9NcKRTMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362785; c=relaxed/simple;
	bh=tv8rKn4N2IeoFeMnFx+2x9JGOMGaY+wE9fF08LJwdQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coavq4eHehs7M7b7ep4G5L7sEGWLykXSOI3H3GYZbc2bW0jReJAIeLcl2Ziu6F6DdQ1WnCMWiqmTqAaTT+uf9ope/lkvIZf0kt0qXU+fCurp2tfeRC7EZzV829LAw/FZ4qaTR73xLsFtuXN7txQiFvFfiiw2rgBG7Z+mBvzSL+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WHV8jLjR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZIH5/VZH; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 2F4F01301B58;
	Thu, 12 Mar 2026 20:46:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 12 Mar 2026 20:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362781;
	 x=1773369981; bh=beibKrJw8gVlJSS1MC+gPsWPAAjnc1lfM9GVMreQ7l0=; b=
	WHV8jLjRFjvExaZUz/IeuFgzAji4iuC1qCdaaeCT+yhJO1A8Jy46xlJATz84RftX
	8ziuDP+FIoVk37AiwmkWNq59mHh58p+afnfWD/PswUpqQxv2VeqaDwUpCCy1ua2S
	UTsPcAo+khmfNmWIe4/dEMaxZPSeXxrGb/QhRIAyhV4Q0EucmpogkjrKFycwgKSu
	8XvmsnDj5S9ck3EDBgdc36XgPp5YT7phSDnE54m2kT6FBaPSFqUxsEP5LfQT8Ibd
	kwPFZIqhYefJcMp6GHUuks2lW91o2lXD9/uMMRk5odSMf2vU+pN6LAFgjwuofxko
	Pxd4qYjc0WMvZ9umgpIH+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362781; x=1773369981; bh=b
	eibKrJw8gVlJSS1MC+gPsWPAAjnc1lfM9GVMreQ7l0=; b=ZIH5/VZHZrMfU1cW/
	wG0qw06iFIqEqoHXhM5fZAFsUmmSTK8s5iHKFawt41sSzRFI2voGV/g2vxNPRvvZ
	QT4aLkhEZTZsQGWPLjlqLtmevQqurNCd2EhPslV4EIvWQatGKGq6tQ6DUKA7hkfJ
	wjgHPYeUDwzEedB/fhcD6NPn128Xk4owWwoTOWNwhF+JKbEEbpihYJy0ES1ozFab
	f79UKDfTMpYIQuiK2/rFGv9Osd/YLjjgERMzFcZkc7zkq+y6Jg08tF8TybJSGwX8
	LmtR+qvbnSUv3BTDBUn27O3PhnWN1IVPZyiwC0uUVCe52zEbcPFy0n0GgdtLfz4g
	ljLng==
X-ME-Sender: <xms:XF6zaQUpRmafuJ_VHKe6XJaV4qBgLd_E5gKvsgYdkMxz2ET5WHAB7g>
    <xme:XF6zaYSv9FEh8EaTsVC5XLx0QELITHk5QqmtSV0zq-GJgWdsdFYgKGzfObe4ouSSs
    fYtZg0eaRckvm22EVOlAoe8UXRY5M4VziXPrC0xNjUE_1gxwQ>
X-ME-Received: <xmr:XF6zafdg4fZr2hEtwPzJRJgGbidcS4KiT_rsPzUcPRYmpmOD949T70dcc4FAu3lLy--iMqyCzh2s6_u31OdO5a0JYEsiwjCXKfUmRgzEyLkK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:XF6zacwSQeyzcLbD0R0qj4fwLPpCY48skK0gFd_OeC5jNrulEZpEVA>
    <xmx:XF6zaQFm4O5uI-OqJvlKJeYunIiAleVawCA6AQPaqmJ7eImB7SKTSw>
    <xmx:XF6zaQ7cTsUM98sAG-Ckq4Eg8qscb97mTd9koXQg4HUb5ty_tBHmLg>
    <xmx:XF6zaXGeOET1UNLDlICu6EvGX_PPuMutBSqqlmsQef4rv2ewdNid1w>
    <xmx:XV6zaTitV2u39poMCZ6KTd-RZDEhLge4mC8KQjRjbR3O4bUu34t1yTdf>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:46:07 -0400 (EDT)
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
Subject: [PATCH 26/53] smb/client: don't unhashed and rehash to prevent new opens.
Date: Fri, 13 Mar 2026 08:12:13 +1100
Message-ID: <20260312214330.3885211-27-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20131-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,brown.name:email,brown.name:replyto,ownmail.net:dkim,ownmail.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45D3427C074
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

smb/client needs to block new opens of the target of unlink and rename
while the operation is progressing.  This stablises d_count() and allows
a determination of whether a "silly-rename" is required.

It currently unhashes the dentry which will cause lookup to block on
the parent directory i_rwsem.  Proposed changes to locking will cause
this approach to stop working and the exclusivity will be provided for
the dentry only, and only while it is hashed.

So we introduce a new machanism similar to that used by nfs and afs.
->d_fsdata (currently unused by smb/client) is set to a non-NULL
value when lookups need to be blocked.  ->d_revalidate checks for this
and blocks.  This might still allow d_count() to increment, but once it
has been tested as 1, there can be no new opens completed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/smb/client/dir.c   |  3 +++
 fs/smb/client/inode.c | 48 +++++++++++++++++--------------------------
 2 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index cb10088197d2..cecbc0cce5c5 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -790,6 +790,9 @@ cifs_d_revalidate(struct inode *dir, const struct qstr *name,
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
+	/* Wait for pending rename/unlink */
+	wait_var_event(&direntry->d_fsdata, direntry->d_fsdata == NULL);
+
 	if (d_really_is_positive(direntry)) {
 		int rc;
 		struct inode *inode = d_inode(direntry);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d4d3cfeb6c90..3549605fa9c2 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -28,6 +28,13 @@
 #include "cached_dir.h"
 #include "reparse.h"
 
+/* This is stored in ->d_fsdata to block d_revalidate on a
+ * file dentry that is being removed - unlink or rename target.
+ * This causes any open attempt to block.  There may be existing opens
+ * but they can be detected by checking d_count() under ->d_lock.
+ */
+#define CIFS_FSDATA_BLOCKED ((void *)1)
+
 /*
  * Set parameters for the netfs library
  */
@@ -1946,27 +1953,21 @@ static int __cifs_unlink(struct inode *dir, struct dentry *dentry, bool sillyren
 	__u32 dosattr = 0, origattr = 0;
 	struct TCP_Server_Info *server;
 	struct iattr *attrs = NULL;
-	bool rehash = false;
 
 	cifs_dbg(FYI, "cifs_unlink, dir=0x%p, dentry=0x%p\n", dir, dentry);
 
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
 		return smb_EIO(smb_eio_trace_forced_shutdown);
 
-	/* Unhash dentry in advance to prevent any concurrent opens */
-	spin_lock(&dentry->d_lock);
-	if (!d_unhashed(dentry)) {
-		__d_drop(dentry);
-		rehash = true;
-	}
-	spin_unlock(&dentry->d_lock);
-
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
 	tcon = tlink_tcon(tlink);
 	server = tcon->ses->server;
 
+	/* Set d_fsdata to prevent any concurrent opens */
+	dentry->d_fsdata = CIFS_FSDATA_BLOCKED;
+
 	xid = get_xid();
 	page = alloc_dentry_path();
 
@@ -2083,8 +2084,9 @@ static int __cifs_unlink(struct inode *dir, struct dentry *dentry, bool sillyren
 	kfree(attrs);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
-	if (rehash)
-		d_rehash(dentry);
+
+	/* Allow lookups */
+	store_release_wake_up(&dentry->d_fsdata, NULL);
 	return rc;
 }
 
@@ -2501,7 +2503,6 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	struct cifs_sb_info *cifs_sb;
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
-	bool rehash = false;
 	unsigned int xid;
 	int rc, tmprc;
 	int retry_count = 0;
@@ -2517,23 +2518,15 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
 		return smb_EIO(smb_eio_trace_forced_shutdown);
 
-	/*
-	 * Prevent any concurrent opens on the target by unhashing the dentry.
-	 * VFS already unhashes the target when renaming directories.
-	 */
-	if (d_is_positive(target_dentry) && !d_is_dir(target_dentry)) {
-		if (!d_unhashed(target_dentry)) {
-			d_drop(target_dentry);
-			rehash = true;
-		}
-	}
-
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
 	tcon = tlink_tcon(tlink);
 	server = tcon->ses->server;
 
+	/* Set d_fsdata to prevent any concurrent opens */
+	target_dentry->d_fsdata = CIFS_FSDATA_BLOCKED;
+
 	page1 = alloc_dentry_path();
 	page2 = alloc_dentry_path();
 	xid = get_xid();
@@ -2570,8 +2563,6 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 		}
 	}
 
-	if (!rc)
-		rehash = false;
 	/*
 	 * No-replace is the natural behavior for CIFS, so skip unlink hacks.
 	 */
@@ -2662,8 +2653,6 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 			}
 			rc = cifs_do_rename(xid, source_dentry, from_name,
 					    target_dentry, to_name);
-			if (!rc)
-				rehash = false;
 		}
 	}
 
@@ -2671,8 +2660,9 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	CIFS_I(source_dir)->time = CIFS_I(target_dir)->time = 0;
 
 cifs_rename_exit:
-	if (rehash)
-		d_rehash(target_dentry);
+	/* Allow lookups */
+	store_release_wake_up(&target_dentry->d_fsdata, NULL);
+
 	kfree(info_buf_source);
 	free_dentry_path(page2);
 	free_dentry_path(page1);
-- 
2.50.0.107.gf914562f5916.dirty


