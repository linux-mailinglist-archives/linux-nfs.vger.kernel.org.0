Return-Path: <linux-nfs+bounces-20112-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IhOLxE5s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20112-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:07:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2162627AC87
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20A9C32DFE37
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B2E3B7749;
	Thu, 12 Mar 2026 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="blzcrDgL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixHPrpEO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883B3B0AC3;
	Thu, 12 Mar 2026 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352730; cv=none; b=sRITVV3t4lyVcazicXpR1awjN2tuFhEHfkb5c11UVzL/t1lHgbQZI116EOrPFT3lxzoN8iWrunGLzZCNlHiL/CReHNIY88QeMnZXqXverrS8iFNylfmxSSfF4T4QQSzywkLyFwep45hzDEbyuIY4d0FFAmiFGmIcapJ/Yti2ME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352730; c=relaxed/simple;
	bh=UmfJbnuU/Yo/a8QU+2YFRiWg5kbx4wC2VnpwUVdazVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDqY6QdrwaePmeIh0NSczvXxM0KAVlMcXAa4h9lgYz7SP8uH81BWR3+50508hO09CyXciFBcPEJxgjHcS8uleJwCtoh2yESNAyykPMY2930tPuLPHby7yDLCJ6Vl4HCqW8a5h4sjscobNfhW3y9giTUvvBmzP3s0Il7mWCSoGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=blzcrDgL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixHPrpEO; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 4DDDD1301B67;
	Thu, 12 Mar 2026 17:58:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 12 Mar 2026 17:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352726;
	 x=1773359926; bh=2wACx9EwCsU2MDL/6t9ARpFPHpQPm8JZgOjdNVtpbNE=; b=
	blzcrDgLn4ZT1/j/qNPwj10MGyDDKhidDzBQXDLYeoY4Yltme0biw2IT9ktAbaOb
	N7qFTQgNbIDpTUtHqfGoyMmpUnkIB5afxID4LfkxBWIe/3ZjfNoJeD8//kPAuxN+
	gG7mt8T+9KsDqj6oOqhnO7tq1PyR3O3qlNuDj4XyU8/suvadyNcwIMrRH79WoZyr
	oaxRL1ArA2O4uHcrh9ILrwXJWcm6ni4lXh4xLKgPm1bNw/98wN/aUlWXDActEM1M
	44KhqBaswgoORV7MrH5Sl9r6bWdoAtxSBWWS8K5XiUC97v+bt+lYIP/MePsALlc1
	0G9KqiqnN4hwv+H1715/Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352726; x=1773359926; bh=2
	wACx9EwCsU2MDL/6t9ARpFPHpQPm8JZgOjdNVtpbNE=; b=ixHPrpEOU9DFEicZZ
	zRVVExlYGJIKXL1t1vKaHDUivTDQpq17RVcDlcnpcX+oEEwR4o6fk1VFpaf7ELpu
	qPcrp1pU+E9aBsRq6LqGRwEyfCxFOAG/eZBuveJEVZ604l67sEjztB/T1VzgaPNq
	m1SQq5YT9ScU672gnZ9KQZAxk1dZBg6iIh/thQcnTYmFTZUE8fOl96euvWClr0Sk
	Jw4UArEOMp9nx8kYqCM/xH1Gu6MmI3GoPxnw+0BPKXleygi8xEj4rpevltF2XXQx
	AycZ8p2EmhSDx22kqIc0KRGYEOLQglNymJH4IFUMck56rrI6KAzuPWriwWjrqJO4
	3dPjg==
X-ME-Sender: <xms:FTezaVilNpfzTFwdXfDGmuvdmLmHH5wQOPmkXNJ2rwBPIIfOVLdr-w>
    <xme:FTezaTuEQy7o4nKc7Uw8jH6cqeXroA21BQ5do5RN0lUZCS7cVMdxOqY0Gqbu5Tp_B
    pnokX1bFr1SC1Y0W1BKG0kHSYQ0zHGoJ-i_qINfPDxpdL6D>
X-ME-Received: <xmr:FTezacAuaSfVqafttgspciqVDgEqkYKP35xc15xq4Bo7N7mSd4IApwHhjkxDfh-qhQISzjgboRJQNF9L38ZWpkUBmY7P3ZmYnejxCdb7p5bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:FjezaeWEAYX9YAtQPeDZruDF03hEM0vgWm_YUy0QmeB_LgHmBFwkWA>
    <xmx:FjezaSLbWaULXe565i-38R9rxAXNMxHpZtaCsRE2_7Lvyoo97n2wOw>
    <xmx:FjezafUxgwg3aoUBFXslTVRlf8kcFgM_dAW-I4hB8-MgQ9UtNSzYpg>
    <xmx:FjezaTQ6553DYdVPHGadz797tM8ymCQ09q3Sp6soEJBLNasY5B_i9g>
    <xmx:FjezaQyh3FuH2EnjtUC4nYKGVY1x8wZ_XxVdm4U8WHJbuM5_OEVYGjTj>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:58:32 -0400 (EDT)
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
Subject: [PATCH 53/53] VFS: remove LOOKUP_SHARED
Date: Fri, 13 Mar 2026 08:12:40 +1100
Message-ID: <20260312214330.3885211-54-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20112-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,ownmail.net:dkim,ownmail.net:mid,brown.name:email,brown.name:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ci_name.name:url]
X-Rspamd-Queue-Id: 2162627AC87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

->lookup is now always called with a shared lock and LOOKUP_SHARED set,
so we can discard that flag and remove the code for when it wasn't set.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c           | 10 ++--------
 fs/dcache.c            | 13 +++----------
 fs/namei.c             | 10 +++++-----
 fs/xfs/xfs_iops.c      |  3 +--
 include/linux/dcache.h |  3 +--
 include/linux/namei.h  |  3 +--
 6 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index f259ca2da383..29e39aeaf654 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -938,10 +938,7 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
 	/* Calling d_alloc_parallel() while holding parent locked is undesirable.
 	 * We don't really need the lock any more.
 	 */
-	if (flags & LOOKUP_SHARED)
-		inode_unlock_shared(dir);
-	else
-		inode_unlock(dir);
+	inode_unlock_shared(dir);
 	for (i = 0; i < subs->nr; i++) {
 		name = subs->subs[i];
 		len = dentry->d_name.len - 4 + strlen(name);
@@ -966,10 +963,7 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
 	 */
 	ret = NULL;
 out_s:
-	if (flags & LOOKUP_SHARED)
-		inode_lock_shared(dir);
-	else
-		inode_lock_nested(dir, I_MUTEX_PARENT);
+	inode_lock_shared(dir);
 	afs_put_sysnames(subs);
 	kfree(buf);
 out_p:
diff --git a/fs/dcache.c b/fs/dcache.c
index f573716d1a04..2d694e14bd22 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2224,7 +2224,6 @@ EXPORT_SYMBOL(d_obtain_root);
  * @dentry: the negative dentry that was passed to the parent's lookup func
  * @inode:  the inode case-insensitive lookup has found
  * @name:   the case-exact name to be associated with the returned dentry
- * @bool:   %true if lookup was performed with LOOKUP_SHARED
  *
  * This is to avoid filling the dcache with case-insensitive names to the
  * same inode, only the actual correct case is stored in the dcache for
@@ -2237,7 +2236,7 @@ EXPORT_SYMBOL(d_obtain_root);
  * the exact case, and return the spliced entry.
  */
 struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
-			struct qstr *name, bool shared)
+			struct qstr *name)
 {
 	struct dentry *found, *res;
 
@@ -2257,19 +2256,13 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 	 * d_in_lookup() (so ->d_parent is stable) and we are near the
 	 * end ->lookup() and will shortly drop the lock anyway.
 	 */
-	if (shared)
-		inode_unlock_shared(d_inode(dentry->d_parent));
-	else
-		inode_unlock(d_inode(dentry->d_parent));
+	inode_unlock_shared(d_inode(dentry->d_parent));
 	found = d_alloc_parallel(dentry->d_parent, name);
 	if (IS_ERR(found) || !d_in_lookup(found)) {
 		iput(inode);
 		return found;
 	}
-	if (shared)
-		inode_lock_shared(d_inode(dentry->d_parent));
-	else
-		inode_lock_nested(d_inode(dentry->d_parent), I_MUTEX_PARENT);
+	inode_lock_shared(d_inode(dentry->d_parent));
 	res = d_splice_alias(inode, found);
 	if (res) {
 		d_lookup_done(found);
diff --git a/fs/namei.c b/fs/namei.c
index 3d213070a515..9e2ac3077f72 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1826,7 +1826,7 @@ static struct dentry *lookup_one_qstr(const struct qstr *name,
 	if (unlikely(IS_DEADDIR(dir)))
 		old = ERR_PTR(-ENOENT);
 	else
-		old = dir->i_op->lookup(dir, dentry, flags | LOOKUP_SHARED);
+		old = dir->i_op->lookup(dir, dentry, flags);
 	inode_unlock_shared(dir);
 	if (unlikely(old)) {
 		d_lookup_done(dentry);
@@ -1951,7 +1951,7 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 			old = ERR_PTR(-ENOENT);
 		else
 			old = inode->i_op->lookup(inode, dentry,
-						  flags | LOOKUP_SHARED);
+						  flags);
 		inode_unlock_shared(inode);
 		d_lookup_done(dentry);
 		if (unlikely(old)) {
@@ -1966,14 +1966,14 @@ static noinline struct dentry *lookup_slow(const struct qstr *name,
 				  struct dentry *dir,
 				  unsigned int flags)
 {
-	return __lookup_slow(name, dir, flags | LOOKUP_SHARED, TASK_NORMAL);
+	return __lookup_slow(name, dir, flags, TASK_NORMAL);
 }
 
 static struct dentry *lookup_slow_killable(const struct qstr *name,
 					   struct dentry *dir,
 					   unsigned int flags)
 {
-	return __lookup_slow(name, dir, flags | LOOKUP_SHARED, TASK_KILLABLE);
+	return __lookup_slow(name, dir, flags, TASK_KILLABLE);
 }
 
 static inline int may_lookup(struct mnt_idmap *idmap,
@@ -4513,7 +4513,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			res = ERR_PTR(-ENOENT);
 		else
 			res = dir_inode->i_op->lookup(dir_inode, dentry,
-						      nd->flags | LOOKUP_SHARED);
+						      nd->flags);
 		inode_unlock_shared(dir_inode);
 		d_lookup_done(dentry);
 		if (unlikely(res)) {
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 2641061ba1db..cfd1cb42a29f 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -35,7 +35,6 @@
 #include <linux/security.h>
 #include <linux/iversion.h>
 #include <linux/fiemap.h>
-#include <linux/namei.h> // for LOOKUP_SHARED
 
 /*
  * Directories have different lock order w.r.t. mmap_lock compared to regular
@@ -370,7 +369,7 @@ xfs_vn_ci_lookup(
 	/* else case-insensitive match... */
 	dname.name = ci_name.name;
 	dname.len = ci_name.len;
-	dentry = d_add_ci(dentry, VFS_I(ip), &dname, !!(flags & LOOKUP_SHARED));
+	dentry = d_add_ci(dentry, VFS_I(ip), &dname);
 	kfree(ci_name.name);
 	return dentry;
 }
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index eb1a59b6fca7..74607dbcb7f0 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -250,8 +250,7 @@ struct dentry *d_duplicate(struct dentry *dentry);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
 					  const struct dentry_operations *);
-extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *,
-				bool);
+extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
 extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
 			const struct qstr *name);
 extern struct dentry *d_find_any_alias(struct inode *inode);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index cb79e84c718d..643d862a7fda 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -37,9 +37,8 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_CREATE		BIT(17)	/* ... in object creation */
 #define LOOKUP_EXCL		BIT(18)	/* ... in target must not exist */
 #define LOOKUP_RENAME_TARGET	BIT(19)	/* ... in destination of rename() */
-#define LOOKUP_SHARED		BIT(20) /* Parent lock is held shared */
 
-/* 3 spare bits for intent */
+/* 4 spare bits for intent */
 
 /* Scoping flags for lookup. */
 #define LOOKUP_NO_SYMLINKS	BIT(24) /* No symlink crossing. */
-- 
2.50.0.107.gf914562f5916.dirty


