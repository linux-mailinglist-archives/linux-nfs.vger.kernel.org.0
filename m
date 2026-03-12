Return-Path: <linux-nfs+bounces-20110-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAoDNoY5s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20110-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:09:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 402F127AD32
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0B4532C8370
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133C33B2FF6;
	Thu, 12 Mar 2026 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Aiv/eft0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1OKI1aeP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD63AB290;
	Thu, 12 Mar 2026 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352696; cv=none; b=JD7A2qxXcbMqBtQTRlZIvUtQWRWfw8K/h/9bt/We5EhKaVFJ6NgTpLusix5JDw/hPEQ6f1a7fQI0EsMnTx2GSbg1U4ZxbcKNQTeOvhiVymH1KofNHmFuDrrbeHHjYCMBcreiYlthtqUfYlekc2L2DTMul8lvGvNZZBrTrogobvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352696; c=relaxed/simple;
	bh=PDfaEKR3ToWZipBTJ7awOf9nXE0QxmMtFDzDKxbjUmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqumXwgi9n7PbrqwTfTGXuce8ko6ljK3NvDPGin1XM1mdOj2O9E+LXJkl5wJIEyeWgHwx7WknvxpV+STnfw5JtO+KVI6g7vkTVKo5o+23P6SRV/VO3Ofq68kbtWe2zDIN3MOoPfW1KevKpGKQ440gLbv0fzFAlKHtBkUTQ2nqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Aiv/eft0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1OKI1aeP; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 531271301B68;
	Thu, 12 Mar 2026 17:58:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 12 Mar 2026 17:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352692;
	 x=1773359892; bh=MUCVEDpSf+0EP+yvqNrKKgbgS6k/EkMfChZKLZ22YF8=; b=
	Aiv/eft0lgPfT980cKxeTnbansdx69JMDdu3/JvECSezFjIw35T8po0J7Dr8uNz3
	sIBBHBdSe4MXUrEF8Fj06jbhW2EE7JC8gaPZzvxL4boq4YxDZ+CRXvvNlgYjU+ad
	zVo48RhaQGZQOjrYGJTHjDPxeGvcjtjerjOc4eh0NjzqVTlyohkpdmmv2NUqgUY0
	kGTPr9S74jE/j+NCuYF03/ks4uS34m9TEH/qtCulLr0zXqcwhZT0jqA18NZMxYk8
	7Q7QidM3FocAj62Z/Xs8FMUmSkMlrAh0Tu4ZwGqs+fXuxjjYBw4q/KLFBSxgulO/
	O8xZvAKjbOCAu8Ctbd/xlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352692; x=1773359892; bh=M
	UCVEDpSf+0EP+yvqNrKKgbgS6k/EkMfChZKLZ22YF8=; b=1OKI1aeP/URdJ6EVy
	Z+vyP9J8PKZrd0kY//3qj71VewKCNrnBkJOvFWrxGJymoeibivc952VMmJ0Wmphn
	GdXCcWC2chTiQ8YEYimV8Wfe46qK2KFxr0eSSwm2kf+ajXccqEga9+LHL5oUW84X
	yEB8WJoc/CtgIS9uwc4JfckT9M7HIIj9BkYyKEc7UKLYbnFaA3YX1pZd7rtnIM7X
	0CSikuFS9fiJ8+Et3mu0UkfKU4IGmFqiDYedmOmjR/0tGilyq8lfTDvk4GLhoa0C
	FKHKzDyWUSwTK3s6Ka962SMkXym18zo7X8d44IXEmqoskkODbePuGhcnghfwNyOh
	65kZw==
X-ME-Sender: <xms:8zazaZFnoL8nTaaYepHGpsupAfToMV1lBcOZjtfZuL-x6VPw3SWcTA>
    <xme:8zazaSAZo4J78ZKHviJoQ10vRcZP6ii2DtWlvfEKAp3RekpRuw90IejAvYRzXDFwn
    Yc4RlxEYTkb05EfEfYvmJjkVqqbfriM8oqn-yznpG8ry3DPhg>
X-ME-Received: <xmr:8zazaWOA1gfEptRTXhBFBUUqip5J9NWoLsZfbbynxyjbB4YaJqvofFlgOJi-xvcNcJEMzCUijUyS1Q2aXEJGU1Wh6GK96JOVcKRNeRYsjKcL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnefuuh
    gsshhtuchvrghrshculdehtddmnecujfgurhephffvvefufffkofgjfhhrggfgsedtkeer
    tdertddtnecuhfhrohhmpefpvghilheurhhofihnuceonhgvihhlsgesohifnhhmrghilh
    drnhgvtheqnecuggftrfgrthhtvghrnhepveevkeffudeuvefhieeghffgudektdelkeej
    iedtjedugfeukedvkeffvdefvddunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghrtghp
    thhtohephedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhrohesiigvnh
    hivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidqgihfshesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqthhrrggtvgdq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9Dazach7av5MJT8wwTcG8MKSecwRaPCM_rUgbieUz9-plDpwI6zy9g>
    <xmx:9DazaU2BJC8dq5eg3cq_PE4esCqPkCfcmRsZ9j1K6OYny_6Tiy29xg>
    <xmx:9DazaWrD5GSVDOaic2AawCbj7ijw4e0hSyT9fTNC10lRFnoKpI1HXQ>
    <xmx:9DazaZ3IuPVJmTmgR8W3UIMoIjUFqPw7tpd4R62FV11LjodKC9RNvg>
    <xmx:9DazaVRBxjCwEQEOkYevKr9zMpuJ2elXpo_n74CoZdvgrzBnIBgDvJIG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:57:59 -0400 (EDT)
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
Subject: [PATCH 51/53] VFS: use d_alloc_parallel() in lookup_one_qstr_excl().
Date: Fri, 13 Mar 2026 08:12:38 +1100
Message-ID: <20260312214330.3885211-52-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20110-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:email,brown.name:replyto]
X-Rspamd-Queue-Id: 402F127AD32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

lookup_one_qstr_excl() is used for lookups prior to directory
modifications (other than open(O_CREATE)), whether create, remove,
or rename.

A future patch will lift lookup out of the i_rwsem lock that protects
the directory during these operations (only taking a shared lock if the
target name is not yet in the dcache).

To prepare for this change and particularly to allow lookup to
always be done outside the parent i_rwsem, change lookup_one_qstr_excl()
to use d_alloc_parallel().

For the target of create and rename some filesystems skip the
preliminary lookup and combine it with the main operation.  This is only
safe if the operation has exclusive access to the dentry.  Currently
this is guaranteed by an exclusive lock on the directory.
d_alloc_parallel() provides alternate exclusive access (in the case
where the name isn't in the dcache and ->lookup will be called).

As a result of this change, ->lookup is now only ever called with a
d_in_lookup() dentry.  Consequently we can remove the d_in_lookup()
check from d_add_ci() which is only used in ->lookup.

If LOOKUP_EXCL or LOOKUP_RENAME_TARGET is passed, the caller must ensure
d_lookup_done() is called at an appropriate time, and must not assume
that it can test for positive or negative dentries without confirming
that the dentry is no longer d_in_lookup() - unless it is filesystem
code acting on itself and *knows* that ->lookup() always completes the
lookup (currently true for all filesystems other than NFS).
This is all handled in start_creating() and end_dirop() and friends.

Note that as lookup_one_qstr_excl() is called with an exclusive lock on
the directory, d_alloc_parallel() cannot race with another thread and
cannot return a non-in-lookup dentry.  However that is expected to
change so that case is handled with this patch.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 14 ++++++++++
 fs/dcache.c                           | 16 +++--------
 fs/namei.c                            | 38 ++++++++++++++++++++-------
 3 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 7e83bd3c5a12..5ddc5ecfcc64 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1403,3 +1403,17 @@ you really don't want it.
 lookup_one() and lookup_noperm() are no longer available.  Use
 start_creating() or similar instead.
 
+
+---
+
+**mandatory**
+
+All start_creating and start_renaming functions may return a
+d_in_lookup() dentry if passed "O_CREATE|O_EXCL" or "O_RENAME_TARGET".
+end_dirop() calls the necessary d_lookup_done().  If the caller
+*knows* which filesystem is being used, it may know that this is not
+possible.  Otherwise it must be careful testing if the dentry is
+positive or negative as the lookup may not have been performed yet.
+
+inode_operations.lookup() is now only ever called with a d_in_lookup()
+dentry.
diff --git a/fs/dcache.c b/fs/dcache.c
index abb96ad8e015..f573716d1a04 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2261,18 +2261,10 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		inode_unlock_shared(d_inode(dentry->d_parent));
 	else
 		inode_unlock(d_inode(dentry->d_parent));
-	if (d_in_lookup(dentry)) {
-		found = d_alloc_parallel(dentry->d_parent, name);
-		if (IS_ERR(found) || !d_in_lookup(found)) {
-			iput(inode);
-			return found;
-		}
-	} else {
-		found = d_alloc(dentry->d_parent, name);
-		if (!found) {
-			iput(inode);
-			return ERR_PTR(-ENOMEM);
-		}
+	found = d_alloc_parallel(dentry->d_parent, name);
+	if (IS_ERR(found) || !d_in_lookup(found)) {
+		iput(inode);
+		return found;
 	}
 	if (shared)
 		inode_lock_shared(d_inode(dentry->d_parent));
diff --git a/fs/namei.c b/fs/namei.c
index cb80490a869f..bba419f2fc53 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1774,13 +1774,14 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 }
 
 /*
- * Parent directory has inode locked exclusive.  This is one
- * and only case when ->lookup() gets called on non in-lookup
- * dentries - as the matter of fact, this only gets called
- * when directory is guaranteed to have no in-lookup children
- * at all.
- * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
- * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
+ * Parent directory has inode locked.
+ * If Lookup_EXCL or LOOKUP_RENAME_TARGET is set
+ * d_lookup_done() must be called before the dentry is dput()
+ * If the dentry is not d_in_lookup():
+ *   Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
+ *   Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
+ * If it is d_in_lookup() then these conditions can only be checked by the
+ * file system when carrying out the intent (create or rename).
  */
 static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 					   struct dentry *base, unsigned int flags)
@@ -1798,18 +1799,27 @@ static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 	if (unlikely(IS_DEADDIR(dir)))
 		return ERR_PTR(-ENOENT);
 
-	dentry = d_alloc(base, name);
-	if (unlikely(!dentry))
-		return ERR_PTR(-ENOMEM);
+	dentry = d_alloc_parallel(base, name);
+	if (unlikely(IS_ERR(dentry)))
+		return dentry;
+	if (unlikely(!d_in_lookup(dentry)))
+		/* Raced with another thread which did the lookup */
+		goto found;
 
 	old = dir->i_op->lookup(dir, dentry, flags);
 	if (unlikely(old)) {
+		d_lookup_done(dentry);
 		dput(dentry);
 		dentry = old;
 	}
 found:
 	if (IS_ERR(dentry))
 		return dentry;
+	if (d_in_lookup(dentry))
+		/* We cannot check for errors - the caller will have to
+		 * wait for any create-etc attempt to get relevant errors.
+		 */
+		return dentry;
 	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
 		dput(dentry);
 		return ERR_PTR(-ENOENT);
@@ -2921,6 +2931,8 @@ static struct dentry *__start_dirop(struct dentry *parent, struct qstr *name,
  * The lookup is performed and necessary locks are taken so that, on success,
  * the returned dentry can be operated on safely.
  * The qstr must already have the hash value calculated.
+ * The dentry may be d_in_lookup() if %LOOKUP_EXCL or %LOOKUP_RENAME_TARGET
+ * is given, depending on the filesystem.
  *
  * Returns: a locked dentry, or an error.
  *
@@ -2942,6 +2954,7 @@ void end_dirop(struct dentry *de)
 {
 	if (!IS_ERR(de)) {
 		inode_unlock(de->d_parent->d_inode);
+		d_lookup_done(de);
 		dput(de);
 	}
 }
@@ -3854,8 +3867,10 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
 	return 0;
 
 out_dput_d2:
+	d_lookup_done(d2);
 	dput(d2);
 out_dput_d1:
+	d_lookup_done(d1);
 	dput(d1);
 out_unlock:
 	unlock_rename(rd->old_parent, rd->new_parent);
@@ -3950,6 +3965,7 @@ __start_renaming_dentry(struct renamedata *rd, int lookup_flags,
 	return 0;
 
 out_dput_d2:
+	d_lookup_done(d2);
 	dput(d2);
 out_unlock:
 	unlock_rename(old_dentry->d_parent, rd->new_parent);
@@ -4059,6 +4075,8 @@ EXPORT_SYMBOL(start_renaming_two_dentries);
 
 void end_renaming(struct renamedata *rd)
 {
+	d_lookup_done(rd->old_dentry);
+	d_lookup_done(rd->new_dentry);
 	unlock_rename(rd->old_parent, rd->new_parent);
 	dput(rd->old_dentry);
 	dput(rd->new_dentry);
-- 
2.50.0.107.gf914562f5916.dirty


