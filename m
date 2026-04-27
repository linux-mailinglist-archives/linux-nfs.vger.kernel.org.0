Return-Path: <linux-nfs+bounces-21146-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK+zJkHi7mkdzQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21146-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:12:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EED1F46CF4C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83BAC3066A01
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E1623ABBF;
	Mon, 27 Apr 2026 04:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="e0tiocWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p4mRIl61"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF6F27A916;
	Mon, 27 Apr 2026 04:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262852; cv=none; b=smTnbsdwuLaFueqpWApfaAWkNSHhjzAfpGLTRrEeVgoyELRqrZopTbZc3ivPHS1k4d7lt+n61oiqC0R8b36jgruz81RcNWJ40iOwHpuc0PWo+adcbj1+e74ytdq3MghyI9FtNrRkDUiawJarRcbgKM++6xWRMX/PqXyUVpk1oUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262852; c=relaxed/simple;
	bh=Ry03XapnV8ZPqRwD/otU1U6sq93iLJCjUmdAQ3JSF0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+GKvBd3aNvimZWgy7F2HbrCA+4irrvCIHTNQzESmCNJfB+PbJvbT2Pw7zdQT+Kl5rdXIe/3UEyBqfOekBp53/rPyDqGhi58vpvTv5IW4nnNjELbdDeWRzEJL0epDD7YXDzOJ9Q9YNXwJQ4tnoowio36qt1gwU9QzMEKDoSjoUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=e0tiocWc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p4mRIl61; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 029E8EC03EF;
	Mon, 27 Apr 2026 00:07:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 27 Apr 2026 00:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262849;
	 x=1777349249; bh=V1Hs5eklgfQn0H62/n/RsRquBHKKGkv3SWjXFgqWxeg=; b=
	e0tiocWcJeBFeHuA5Zoj1O729A0fdUG37W01YmLRh6FhslRIR5noVjJ8r3ggkvye
	FGxcwqUSIav/8W6ncfZl4c5MVbekdl7kncuXIlIaZNoToWZWLXH684lXDqczzQ8G
	HmLut2f3iO5Cuc+uOg8Ypf9r5i/lJLmVlO1myX6ZHzRquESI2BWHanaoTEILk+v0
	NacqYs5HqTZSJP2nEggrx6PdGjE5h+NlCyE8zizTkbOoAyRS49LkMZ1BhJ86tyfQ
	fkriInG9qvxGhc2UzrP2Wz4VmkD0lme6gMHbQXTuolFegttaf9KrfBzI7Wgj4gfX
	VCEWZ0LX+8Aiki2CgGs53A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262849; x=1777349249; bh=V
	1Hs5eklgfQn0H62/n/RsRquBHKKGkv3SWjXFgqWxeg=; b=p4mRIl610gvuGSfiC
	N8oRLAKLafsXb7EaQRcqYPiR3ZlQL+/E5tYRIgkjndVTm5gdtHpZl1eIxJC5CyFR
	3YI4PcI9o43Bgj3pQFrokiEAbWntDAkX1eRcuDN0Gn1FCP0EZN+m/o1uRgIlxQuD
	tBwikkbUkKK7cVvlhKD4el+xv1Hqyi+qCPdPlcbmSsX8cfdP5D24nUNJiUEwlPGo
	7Ynr1X3yhYJdvrQWirHnRwCCg/6qaLFxMcW8mRAIggPZA0jlMj3g48xGw9AKqBCL
	kgLzC6gOYFZc+gHSg4WO9/sq6n8uW+BIQ2IoW6O/bNXdc65+CqkcPP9dMt7wbG2C
	dx1xw==
X-ME-Sender: <xms:AeHuaQi93P0O0iwU9uWvmQlC0fAz5J82w8ZixqrAFZf0ncs0Mw0ljg>
    <xme:AeHuaVV2s0kp1AAyhyNKZA9yMGGoXCTqv68kiMKYaIddcmjnlivsCMaWTIJnqimR4
    aUueyKxDO89EvT58qp1awoULzNd9taRsEGKqKTz0YyTW7l-AKs>
X-ME-Received: <xmr:AeHuaZtiCyQ5LZ9xwZ6zmkMFUrVQNVE2gifQQx-JyArJ58CxCslr8eBnWpDUryfBQmbF6MvR4i6Ago0auU2-XZi3D2VGTOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
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
X-ME-Proxy: <xmx:AeHuaeb8mC2Wv5RbW2LQl9aY4P2zrNks-HP5tKdENwwTO9ZBkBxceg>
    <xmx:AeHuaS7uQzh5xMRygLvH3mmrF21GzlItj5JG5M-sSRAjdSV5YCz4Ug>
    <xmx:AeHuaWmW95Wdw1p04DRR45QZT5B1gCskGvkKlD8VMyh6xxsepfyGkg>
    <xmx:AeHuaYETGQ9DCqR1hhoyX2cKPQwa-RkAkdULzvVC43aT3DtvaIwgog>
    <xmx:AeHuaRqVrGfiTCOd3JAG54oM1lUEwk8v0QPsjPK1qKAKBQUU6DAJhZoe>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:07:25 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/19] efivarfs: use d_alloc_name()
Date: Mon, 27 Apr 2026 14:01:29 +1000
Message-ID: <20260427040517.828226-12-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260427040517.828226-1-neilb@ownmail.net>
References: <20260427040517.828226-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EED1F46CF4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21146-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:replyto,brown.name:email,q.name:url,ownmail.net:dkim,ownmail.net:mid]

From: NeilBrown <neil@brown.name>

efivarfs() is one of the few remaining users of d_alloc().
Other similar filesystems use d_alloc_name() in the same circumstances.
Now that d_alloc_name() supports ->d_hash (providing that it never
fails), change efivarfs to use that.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/efivarfs/super.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 1c5224cf183e..232d9757804c 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -189,26 +189,6 @@ static const struct dentry_operations efivarfs_d_ops = {
 	.d_hash = efivarfs_d_hash,
 };
 
-static struct dentry *efivarfs_alloc_dentry(struct dentry *parent, char *name)
-{
-	struct dentry *d;
-	struct qstr q;
-	int err;
-
-	q.name = name;
-	q.len = strlen(name);
-
-	err = efivarfs_d_hash(parent, &q);
-	if (err)
-		return ERR_PTR(err);
-
-	d = d_alloc(parent, &q);
-	if (d)
-		return d;
-
-	return ERR_PTR(-ENOMEM);
-}
-
 bool efivarfs_variable_is_present(efi_char16_t *variable_name,
 				  efi_guid_t *vendor, void *data)
 {
@@ -263,9 +243,9 @@ static int efivarfs_create_dentry(struct super_block *sb, efi_char16_t *name16,
 	memcpy(entry->var.VariableName, name16, name_size);
 	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
 
-	dentry = efivarfs_alloc_dentry(root, name);
-	if (IS_ERR(dentry)) {
-		err = PTR_ERR(dentry);
+	dentry = d_alloc_name(root, name);
+	if (!dentry) {
+		err = -ENOMEM;
 		goto fail_inode;
 	}
 
-- 
2.50.0.107.gf914562f5916.dirty


