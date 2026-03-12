Return-Path: <linux-nfs+bounces-20125-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGDJOttes2lbVgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20125-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:48:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E2027BE89
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CDF631510F8
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C962FDC53;
	Fri, 13 Mar 2026 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Uiezvf1W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aFZ9JpaM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3028690;
	Fri, 13 Mar 2026 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362681; cv=none; b=UdlvT3f6+nYMGcLpCrcpBLky0He2UJYC/XDVg1I3FtKnRNR6HauOBcEBtjnKeE8WSD7yOpV7lriPcFCZ+pzJMYvXDMCiKpILK5HRdaga05Q4RrmykhzY90TcnxzQPYGKlDt18kGSHwGjAr2Ja/5Nl+mDBFOwXUg2JbVSOhrXiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362681; c=relaxed/simple;
	bh=mClAU9+MY2++0S4AUnzUn/uSCtCfpygQCVUKEYN56Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFsG/l88Ibm8qGksFh0AUBxbwMKVpJeikO1XdYtc2tp5iGTxWkLbGf2trrRSPQtDSnVkIK/Lh7frQK1Z+A7gkpjgmsbW9fPCNr5PxBu6z8n8dXEo3ox4z/4Thlt4cO0bpz2rVlA1IRNnO4/mvOsECQWtPX/B08pbarXPO5+2b58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Uiezvf1W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aFZ9JpaM; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id E582F1301B38;
	Thu, 12 Mar 2026 20:44:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362677;
	 x=1773369877; bh=W+v0RL/pMIx9j3nL0G9XTRWShzNEiYc7Idmh4VPeJRE=; b=
	Uiezvf1WupOqSkTJUVDzQj/e45sCFlF/EsxnaQRySLaMDeWubPQp5OddX1k1Tvyc
	fM8hXdjfAyk7mBWyOtJyl1XY3cLisZtYpoTj/wWI94u1+6Q1OTxA1xkorKNlWngZ
	19E1fuDeIU0QMydCYSd84SxYxTpG7sb9SkBfgNPvcxBV0NZIOsCaBRE1a4KLzZE1
	GjAYqOrBgI9TC6KxLc2SGiccYXPQXEx7/Wi8CMKCPXcZgKxji1zDJ/7l359QMTZa
	ywFy44n0vrD30GmvqShSeh7b/fwsohR/niM5kxoAlO95aTu0XwAx0CU7d688/FST
	arzVZR6P9jQqOOl/aBeZTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362677; x=1773369877; bh=W
	+v0RL/pMIx9j3nL0G9XTRWShzNEiYc7Idmh4VPeJRE=; b=aFZ9JpaMDgkx+1Rfj
	50EtuvgPbTu5u0p7h44/q79D178w3fkvuVwv2nTvXR1ZNLOWKPhEDjcXjRir7VU7
	zylNpYhPxXxgBAKwhYD5kG02FWQKM1yzB/OjVyPTUbXfqbNW7xMtuQ11zWCu5qhy
	8Qc/j0zpzCEtWZ5Pm5ap8yjnRvZxGUiVrHBgy5LW4llPZ1rSVe7AWeu11RiniJgk
	At57JqIa/txEQMSlOGgTWOftoLO6WArZ/AByvN2cKJ5FpiPU8PweDjNbLU/7Vf0Y
	BOGmEgiG57SWk7kyCNZ8fVwmdnUIkfzFF4d8/iw2mdvQvfAm9DHbT2S7Su5nZHrl
	zS9Vg==
X-ME-Sender: <xms:9V2zaQSw-WmTgNYr0os8VUGhQsueljKBGrE2oRSZGDy0Iuk7HwIJTA>
    <xme:9V2zaRdEwsU2zqEFcZKm0YLSqmFebJVxRT3LQI5x03edzqoO3rZaYgm01LJcI-WhT
    U9avNwHdvf99EaegUy6t6YanZkzJ4I8cwHeja0DE4EDWE_2Bw>
X-ME-Received: <xmr:9V2zaY61aWrMvr4oWcQ4QrQqpeDMkYMzw_-2zOUtrUaxf727cWq4eVI8D37sO-WVpowEgy45YnLzJotwmdflit8yW-zofMJzVxhLF0oJ_VZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:9V2zaRfBgIZEKNLftG1LyzVgU7NQ9DTMJ9kqBffjs9Na9LJNHlONYg>
    <xmx:9V2zafD9uInAbKGVcHuPpvvmpqxfgHGBYWWNujV3Yx4pCCqkZGx5aQ>
    <xmx:9V2zadFGXJ7cnAoIVm7EfZjxx8HeO2Wlz5enlMzCxbDZrdR-p2bMIw>
    <xmx:9V2zaXhFnkJBxDQSUZFlUwtvHMV6z-EQ2eB8IojUDHrrl0G8fshbww>
    <xmx:9V2zaSd2ICZlyrNVeZ_29UAt4vlNyQXkBhVEkUNQDaml3-NsmN3jVodG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:44:24 -0400 (EDT)
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
Subject: [PATCH 32/53] ext4: move dcache modifying code out of __ext4_link()
Date: Fri, 13 Mar 2026 08:12:19 +1100
Message-ID: <20260312214330.3885211-33-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20125-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,brown.name:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 91E2027BE89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

__ext4_link() is separate from ext4_link() so that it can be used for
replaying a "fast_commit" which records a link operation.
Replaying the fast_commit does not require any interaction with the
dcache - it is purely ext4-local - but it uses a dentry to simplify code
reuse.

An interface it uses - d_alloc() - is not generally useful and will soon
be removed.  This patch prepares ext4 for that removal.  Specifically it
removes all dcache-modification code from __ext4_link().  This will mean
that __ext4_link() treats the dentry as read-only so fast_commit reply
can simply provide an on-stack dentry.

Various "const" markers are sprinkled around to confirm that the dentry
is treated read-only.

This patch only rearranges code and slightly re-orders it, so those
changes can be reviewed separately.  The next patch will remove the use
of d_alloc().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c                 |  2 +-
 fs/ext4/ext4.h              |  4 ++--
 fs/ext4/fast_commit.c       | 14 +++++++++++---
 fs/ext4/namei.c             | 23 +++++++++++++----------
 include/linux/dcache.h      |  2 +-
 include/trace/events/ext4.h |  4 ++--
 6 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a1219b446b74..c48337d95f9a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -358,7 +358,7 @@ static inline int dname_external(const struct dentry *dentry)
 	return dentry->d_name.name != dentry->d_shortname.string;
 }
 
-void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
+void take_dentry_name_snapshot(struct name_snapshot *name, const struct dentry *dentry)
 {
 	unsigned seq;
 	const unsigned char *s;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 293f698b7042..1794407652ff 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2972,7 +2972,7 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
 void __ext4_fc_track_unlink(handle_t *handle, struct inode *inode,
 	struct dentry *dentry);
 void __ext4_fc_track_link(handle_t *handle, struct inode *inode,
-	struct dentry *dentry);
+	const struct dentry *dentry);
 void ext4_fc_track_unlink(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_link(handle_t *handle, struct dentry *dentry);
 void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
@@ -3719,7 +3719,7 @@ extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
 extern int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 			 struct inode *inode, struct dentry *dentry);
 extern int __ext4_link(struct inode *dir, struct inode *inode,
-		       struct dentry *dentry);
+		       const struct dentry *dentry);
 
 #define S_SHIFT 12
 static const unsigned char ext4_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f575751f1cae..2a5daf1d9667 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -388,7 +388,7 @@ static int ext4_fc_track_template(
 }
 
 struct __track_dentry_update_args {
-	struct dentry *dentry;
+	const struct dentry *dentry;
 	int op;
 };
 
@@ -400,7 +400,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct __track_dentry_update_args *dentry_update =
 		(struct __track_dentry_update_args *)arg;
-	struct dentry *dentry = dentry_update->dentry;
+	const struct dentry *dentry = dentry_update->dentry;
 	struct inode *dir = dentry->d_parent->d_inode;
 	struct super_block *sb = inode->i_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -483,7 +483,7 @@ void ext4_fc_track_unlink(handle_t *handle, struct dentry *dentry)
 }
 
 void __ext4_fc_track_link(handle_t *handle,
-	struct inode *inode, struct dentry *dentry)
+	struct inode *inode, const struct dentry *dentry)
 {
 	struct __track_dentry_update_args args;
 	int ret;
@@ -1471,7 +1471,15 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 		goto out;
 	}
 
+	ihold(inode);
+	inc_nlink(inode);
 	ret = __ext4_link(dir, inode, dentry_inode);
+	if (ret) {
+		drop_nlink(inode);
+		iput(inode);
+	} else {
+		d_instantiate(dentry_inode, inode);
+	}
 	/*
 	 * It's possible that link already existed since data blocks
 	 * for the dir in question got persisted before we crashed OR
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index c4b5e252af0e..80e1051cab44 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2353,7 +2353,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
  * may not sleep between calling this and putting something into
  * the entry, as someone else might have used it while you slept.
  */
-static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
+static int ext4_add_entry(handle_t *handle, const struct dentry *dentry,
 			  struct inode *inode)
 {
 	struct inode *dir = d_inode(dentry->d_parent);
@@ -3445,7 +3445,7 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
+int __ext4_link(struct inode *dir, struct inode *inode, const struct dentry *dentry)
 {
 	handle_t *handle;
 	int err, retries = 0;
@@ -3460,8 +3460,6 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 		ext4_handle_sync(handle);
 
 	inode_set_ctime_current(inode);
-	ext4_inc_count(inode);
-	ihold(inode);
 
 	err = ext4_add_entry(handle, dentry, inode);
 	if (!err) {
@@ -3471,11 +3469,7 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 		 */
 		if (inode->i_nlink == 1)
 			ext4_orphan_del(handle, inode);
-		d_instantiate(dentry, inode);
-		ext4_fc_track_link(handle, dentry);
-	} else {
-		drop_nlink(inode);
-		iput(inode);
+		__ext4_fc_track_link(handle, inode, dentry);
 	}
 	ext4_journal_stop(handle);
 	if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
@@ -3504,7 +3498,16 @@ static int ext4_link(struct dentry *old_dentry,
 	err = dquot_initialize(dir);
 	if (err)
 		return err;
-	return __ext4_link(dir, inode, dentry);
+	ihold(inode);
+	ext4_inc_count(inode);
+	err = __ext4_link(dir, inode, dentry);
+	if (err) {
+		drop_nlink(inode);
+		iput(inode);
+	} else {
+		d_instantiate(dentry, inode);
+	}
+	return err;
 }
 
 /*
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index a97eb151d9db..3b12577ddfbb 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -600,7 +600,7 @@ struct name_snapshot {
 	struct qstr name;
 	union shortname_store inline_name;
 };
-void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
+void take_dentry_name_snapshot(struct name_snapshot *, const struct dentry *);
 void release_dentry_name_snapshot(struct name_snapshot *);
 
 static inline struct dentry *d_first_child(const struct dentry *dentry)
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index a3e8fe414df8..efcf1018c208 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2870,7 +2870,7 @@ TRACE_EVENT(ext4_fc_stats,
 DECLARE_EVENT_CLASS(ext4_fc_track_dentry,
 
 	TP_PROTO(handle_t *handle, struct inode *inode,
-		 struct dentry *dentry, int ret),
+		 const struct dentry *dentry, int ret),
 
 	TP_ARGS(handle, inode, dentry, ret),
 
@@ -2902,7 +2902,7 @@ DECLARE_EVENT_CLASS(ext4_fc_track_dentry,
 #define DEFINE_EVENT_CLASS_DENTRY(__type)				\
 DEFINE_EVENT(ext4_fc_track_dentry, ext4_fc_track_##__type,		\
 	TP_PROTO(handle_t *handle, struct inode *inode,			\
-		 struct dentry *dentry, int ret),			\
+		 const struct dentry *dentry, int ret),			\
 	TP_ARGS(handle, inode, dentry, ret)				\
 )
 
-- 
2.50.0.107.gf914562f5916.dirty


