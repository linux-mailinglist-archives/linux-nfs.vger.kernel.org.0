Return-Path: <linux-nfs+bounces-21251-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ5ZFpCg8GnrWQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21251-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 13:57:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A464C48460A
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 13:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAA5830953DD
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F8C3ACA6A;
	Tue, 28 Apr 2026 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Gkxz4AFh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="En+4r/fo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE7C38AC78;
	Tue, 28 Apr 2026 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375479; cv=none; b=iZ1tCx8oQU5JO9JrVnWGLVHCvp30hhL2aqIFxMMGHNkjwqXyRl2fq3nG6l/YUkVj+hFgAkelZ8UxVYIjM2rBQhLNzrBDW7Wu78W7OKGHcT0tquPvBjP1z5bPAtud7Uyb4uTrciM5NgL0g5CYUG0dxIUknYtYkquQ1svyRMRUSZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375479; c=relaxed/simple;
	bh=73hrZX/9hodtc98NX9hgbpDvk/0kQ2WtBhJADuHRYCw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZymO0S2qJEf+kGH4GxCTxvEuJ0bLMlvIFV9verXZqwW9y6aqJfN/7KLainfp1/TbeMODGFCdOcfFVGQ/QUywKGHhDqJpMfnZL8uMljvGypS+lmUWjo6xDui6D7qS5qZE1ebIe9U7yqsSJ8+eTEvAmYYzYYkeYdv6XY8L4yxPzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Gkxz4AFh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=En+4r/fo; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E42C1D00192;
	Tue, 28 Apr 2026 07:24:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 28 Apr 2026 07:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777375476; x=1777461876; bh=xKPsdFEudyIsEhAYZUMMk0TOo3wAhY9ALk+
	HQFXsAAA=; b=Gkxz4AFhoDhgf91jdgwQogXIJ7N5X7aYQM/a8GmCesDBQvXbv7m
	vv/uFLdNO1DIgTZIgHMgfJnwvIKFoIFNltYxCCKc0FWsnDxMTpcGftmpVmHrQDbA
	rNIqPC/TC3LV/PzjznB1imvWahPpLTNiGYWOZ45LCQdW5LcdOP6rXiiPfIpR/ZZM
	/lhagRyzq2xZFEJCfJTxXsr2GpeTqh/JJ27OrlxtRbHJWlBJR52sEm+ZMfIq75AK
	4zjchcOAtDMaSe7m1X4VeauQWoVK0+fSsZoymMkU3002V22luPPQ4X7u/WwCZmLg
	O4xOn40sjQY8yo5NyJz1S7KmU1qMpNFl1KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777375476; x=
	1777461876; bh=xKPsdFEudyIsEhAYZUMMk0TOo3wAhY9ALk+HQFXsAAA=; b=E
	n+4r/foHCh4RdjuPy0xRyGTZxSgRAiy7Fn6M9w4A6A1/TNzP/can/03q4zZmcL0u
	r5ILnQHVYR5sur1eXsMsImAWYNU1Wyua0FUMsV8FYKoBnq0UEPh65BTXx2PaO+wn
	30h8/5YRgmppdtLjaK5v8yR9jGenM2uxHe3nM4daEgogmQoME1/lODKDAEYhCR+O
	hOXI+3P2lbTqWxOhqD0WbXVyGSZqx7HUVY/AQS2Bebj8h8kNA4ylTP1NlHLCHaVx
	er5F72BDGycJw8ssmZ8paTzEBOyEvHHzGP0AIb7xvEfBZr+IPhv7RagKy4kMorkM
	wqHSW/GoYkgqK/5ojILRg==
X-ME-Sender: <xms:85jwaeteZ2ENDJQ8wVzuvniGlcpubCDYYW-memszTDZiGRWV4dZ7kw>
    <xme:85jwafxVcFB_t7dD4mz_VLeQP0BMXons6KI_zbQa7hFpg7caPNVRD-S2di8xj6FPf
    wcRY3QDXJLfDqxe1zuvdvfRmOQ1ohPZxQiDngnq09ZlY4U_cQ>
X-ME-Received: <xmr:85jwabamWrM0XAfVXAn0iztEmGMqqQdX-0siY3Qt8aQkn7NI0yad0_hYKHhDSAYGVIM0OJTYkUE5TmfclUQbbpyk6FW9MWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:85jwaWU-bZzTfPwZcRL6OzRLw1LS3gdBTi0lEpSWoStzyp4V1HOscw>
    <xmx:85jwaUHrj555tPJ_w7n3xAKHmc4Mf0kBJ2NxHlDZUOU_G6hwb5Bgmg>
    <xmx:85jwaYBpNTEJF8l8-_95vkV3_d5N9VrybSHQU_8cUPl6fkfiSQJs_Q>
    <xmx:85jwaUyeRj9ofWsuEo7Xc6oZ_uREYIY5RWnfdNebdHzghqsLHy0jMA>
    <xmx:9JjwaWc-5FrzL7laTTb_MLT8AFALs928Y863uI-MMM7qD6GiSqXLDO6V>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 07:24:31 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jeremy Kerr" <jk@ozlabs.org>,
 "Ard Biesheuvel" <ardb@kernel.org>, linux-efi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/19] VFS: introduce d_alloc_noblock()
In-reply-to: <20260428022245.GU3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-6-neilb@ownmail.net>
  <20260428022245.GU3518998@ZenIV>
Date: Tue, 28 Apr 2026 21:24:29 +1000
Message-id: <177737546960.1474915.10696166841821338403@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: A464C48460A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21251-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,messagingengine.com:dkim,brown.name:replyto,brown.name:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qname.name:url,noble.neil.brown.name:mid]

On Tue, 28 Apr 2026, Al Viro wrote:
> On Mon, Apr 27, 2026 at 02:01:23PM +1000, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > Several filesystems use the results of readdir to prime the dcache.
> > These filesystems use d_alloc_parallel() which can block if there is a
> > concurrent lookup.  Blocking in that case is pointless as the lookup
> > will add info to the dcache and there is no value in the readdir waiting
> > to see if it should add the info too.
>=20
> ... except that there is - large part of the reasons for that in the origin=
al
> user (procfs) is that we want getdents() + open() + fstat() + compare ->st_=
ino
> from fstat() with ->d_ino from getdents() to work, even if you race with lo=
okup
> from another process coming in the middle of your getdents().
>=20
> What are your plans in that area?
>=20

I can't see that procfs needs the directory to be locked at all.
So we could drop the parent lock at the start of readdir and
reclaim at the end.  But I decided to just drop it in the rare case
where it could cause a problem.

Below is that patch I have to procfs.

Thanks,
NeilBrown


Author: NeilBrown <neil@brown.name>
Date:   Mon Mar 16 16:37:52 2026 +1100

    procfs: drop parent lock for d_alloc_parallel() in iterate_shared()
   =20
    When procfs finds a name in iterate_shared() that isn't in the dcache it
    *must* add it so that it can have a stable inode number to report
    (inodes are only accessible from the dcache in procfs).
   =20
    It uses d_alloc_parallel().  A planned change to locking will make it
    unsafe to call d_alloc_parallel() while holding the directory lock.
   =20
    Other filesystems which prime the dcache in iterate_shared() use
    d_alloc_noblock() which is safe but can fail if it races with ->lookup.
    As procfs cannot handle failure we need something better.
   =20
    procfs doesn't *need* the parent to be locked.  There are no shared data
    structures accessed that don't have their own locking.  So it is safe to
    drop and re-take the parent lock.  We could do this around the whole
    iteration, but as failure of d_alloc_noblock() is rare it is more
    efficient to drop and retake it just around a call of d_alloc_parallel()
    when d_alloc_noblock does fail.
   =20
    Other code that drops and retakes the lock in iterate_shared needs to
    be careful to check S_DEAD which could be set while the lock is
    dropped.  This is not needed in procfs as the flag is never set.
   =20
    As d_alloc_noblock() calls try_lookup_noperm(), we can skip that call
    and simplify the code.
   =20
    Signed-off-by: NeilBrown <neil@brown.name>

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d55a4b603188..feed586fa736 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2127,24 +2127,32 @@ bool proc_fill_cache(struct file *file, struct dir_co=
ntext *ctx,
 	unsigned type =3D DT_UNKNOWN;
 	ino_t ino =3D 1;
=20
-	child =3D try_lookup_noperm(&qname, dir);
+	child =3D d_alloc_noblock(dir, &qname);
 	if (IS_ERR(child))
 		goto end_instantiate;
=20
-	if (!child) {
+	if (child =3D=3D ERR_PTR(-EWOULDBLOCK)) {
+		/*
+		 * Need to drop directory lock, which isn't really
+		 * needed here anyway.  As rmdir never happens in procfs
+		 * we don't need to be concerned about S_DEAD being set
+		 * while unlocked.
+		 */
+		inode_unlock_shared(dir->d_inode);
 		child =3D d_alloc_parallel(dir, &qname);
-		if (IS_ERR(child))
-			goto end_instantiate;
-		if (d_in_lookup(child)) {
-			struct dentry *res;
-			res =3D instantiate(child, task, ptr);
-			d_lookup_done(child);
-			if (unlikely(res)) {
-				dput(child);
-				child =3D res;
-				if (IS_ERR(child))
-					goto end_instantiate;
-			}
+		inode_lock_shared(dir->d_inode);
+	}
+	if (IS_ERR(child))
+		goto end_instantiate;
+	if (d_in_lookup(child)) {
+		struct dentry *res;
+		res =3D instantiate(child, task, ptr);
+		d_lookup_done(child);
+		if (unlikely(res)) {
+			dput(child);
+			child =3D res;
+			if (IS_ERR(child))
+				goto end_instantiate;
 		}
 	}
 	inode =3D d_inode(child);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 04a382178c65..c19e1ccd6bb9 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -686,29 +686,34 @@ static bool proc_sys_fill_cache(struct file *file,
 	ino_t ino =3D 0;
 	unsigned type =3D DT_UNKNOWN;
=20
-	qname.name =3D table->procname;
-	qname.len  =3D strlen(table->procname);
-	qname.hash =3D full_name_hash(dir, qname.name, qname.len);
-
-	child =3D d_lookup(dir, &qname);
-	if (!child) {
+	qname =3D QSTR(table->procname);
+	child =3D d_alloc_noblock(dir, &qname);
+	if (child =3D=3D ERR_PTR(-EWOULDBLOCK)) {
+		/*
+		 * Need to drop directory lock, which isn't really
+		 * needed here anyway.  As rmdir never happens in procfs
+		 * we don't need to be concerned about S_DEAD being set
+		 * while unlocked.
+		 */
+		inode_unlock_shared(dir->d_inode);
 		child =3D d_alloc_parallel(dir, &qname);
-		if (IS_ERR(child))
-			return false;
-		if (d_in_lookup(child)) {
-			struct dentry *res;
-			inode =3D proc_sys_make_inode(dir->d_sb, head, table);
-			res =3D d_splice_alias_ops(inode, child,
-						 &proc_sys_dentry_operations);
-			d_lookup_done(child);
-			if (unlikely(res)) {
-				dput(child);
-
-				if (IS_ERR(res))
-					return false;
-
-				child =3D res;
-			}
+		inode_lock_shared(dir->d_inode);
+	}
+	if (IS_ERR(child))
+		return false;
+	if (d_in_lookup(child)) {
+		struct dentry *res;
+		inode =3D proc_sys_make_inode(dir->d_sb, head, table);
+		res =3D d_splice_alias_ops(inode, child,
+					 &proc_sys_dentry_operations);
+		d_lookup_done(child);
+		if (unlikely(res)) {
+			dput(child);
+
+			if (IS_ERR(res))
+				return false;
+
+			child =3D res;
 		}
 	}
 	inode =3D d_inode(child);

