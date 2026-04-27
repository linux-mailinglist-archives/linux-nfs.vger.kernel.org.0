Return-Path: <linux-nfs+bounces-21125-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLL0FXra7mkPygAAu9opvQ
	(envelope-from <linux-nfs+bounces-21125-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:39:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC92A46C7D4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AE2A301DAE9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 03:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1BD35E95A;
	Mon, 27 Apr 2026 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hGDZwz37";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rejt0VGx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3735C1B6;
	Mon, 27 Apr 2026 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261056; cv=none; b=KEW+qgogN9uZeIY3/s/D86eq2UjZvIB0WDQgO5IO/GmcRKZtLVRXiv2GzHILJ02FRBqKTdw/NCBqgzbpOj9EAh0xl1Lx+ZogODHvzjReFKrLVJz0wk3Wrt+ca11U2WaaMY2MbVKbd62n+vJRc4cNU+v9e5aTLFJRcM26QDRe5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261056; c=relaxed/simple;
	bh=Ry03XapnV8ZPqRwD/otU1U6sq93iLJCjUmdAQ3JSF0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZB73Fhliy36vpUwIwYxAcPKyHQhwOXz25YV2KNRbFM9DT1rcbMdDDTsTpXxbmZba9Z5bSAR7pDI8C0kLVfOwJ31oq5DZIbjUXXbBzIiwvDPh3FBRvG+RSENoT6bqw1Z762ehVMVY47PO5gGY2ZumZKGvxsZLuwq2Tubkb58OX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hGDZwz37; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rejt0VGx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAA8614000DF;
	Sun, 26 Apr 2026 23:37:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 26 Apr 2026 23:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777261054;
	 x=1777347454; bh=V1Hs5eklgfQn0H62/n/RsRquBHKKGkv3SWjXFgqWxeg=; b=
	hGDZwz374rPy+fW/ZSpT73WhUNiNzmcKINPnoVegB/aT9g98hVtuo+tVBVCQHJi4
	1NJJ4cZ5qq4N0w5ylQqTOewM0dqFfUa33xbbiowdFqAKe3U6lPosPDK28AoM072g
	KS1UaPPzagARklt/p+dgsxx57WhupxSfh7seSq8XEySetpVf73kDU+an4XA8/SdZ
	cTnfdpOwDXmCDPynvIKwATwWGob7SEBlIQtTwhzJwfyehODk7XqHJ+POKCXTR1Ou
	np67W8No7Ozkpd7My8qyPSfsCrdr/GzU9079Osbx9R5dp2uafNH6YwWR2XxwOMzf
	D8h4or+Y/zFjqhLd5Kbk3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777261054; x=1777347454; bh=V
	1Hs5eklgfQn0H62/n/RsRquBHKKGkv3SWjXFgqWxeg=; b=Rejt0VGxu/6vukMBq
	0a57bgyHL7uRDe7hUdfs3nvRzFPqmP+I8LEoRc7ocT0QiQgk0eV6HVcSmoCm93xY
	SPppEalayixsbaR7FHHh7+EqD3lxcdeorxOWDHQOQLBtqc0aILi5YWeBXbN9wkvE
	p6EB/JcZWBItNtR97PwoKRITydBrfFIMBqhRG+EfRLfRQ1fSovb9FH4k/iIGz9/p
	41Nl5JdEaT6rsC6QqssIA4i7bx3sj7SvMTyY0iKZt22TMXnyU0nL3DIXWINCCSQP
	ryBcAQA/X+V6VZKiYTAbnC5gqpimhRAowdb9wCkpScLS0RKKH6Ju1ScP3M+x9yUw
	sZBAg==
X-ME-Sender: <xms:_tnuadXxcuCIKIeYkEV7L6D-6Gz02bAaVySP8cg4tzmbpA7TMJuMiQ>
    <xme:_tnuaYQuOJ-BoJdSNULx5FYpJyWbr4El8XOx5CqUgKhj_w9Pt3rgQFyMDPc8xE_IE
    eRciWw-e6VNigtLe6fHRpkzFXmOfAk0HLG16xj3shYKrDed>
X-ME-Received: <xmr:_tnuaQAZJqvbpWfTOaXTxOA2hGSY2fzVVUA08E0aW052matoxpMEtUt5fom1Y2i5F1owLtFkr4u1PGW-slkWUXiNILsukHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdprhgtphht
    thhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtghksehsuh
    hsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:_tnuabRA18IY2KMHU5-YGbAwo4NoTwttiAnSNdZObct5P3Bka3QibQ>
    <xmx:_tnuaSRkV2IJQx-AB9y8FHHRwr6lT9BKuG6qftQVhWtwiYw2g8GDpA>
    <xmx:_tnuaZKSeE4yA7mslBhQh_KBv3gvGPI8J2nLVg4v9nrjJ6vmr8I6pg>
    <xmx:_tnuaZFTVBO-1ZBoHClh2viH8Y65gz_uZnrswq14pfA61VXeGQfFXg>
    <xmx:_tnuaf4rHfjlsEL2JR39xrS0WU9Qxy0haAPfWMMKbAEvGJNk_gJ1OTj_>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 23:37:29 -0400 (EDT)
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
	Ard Biesheuvel <ardb@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel
Subject: [PATCH v2 11/19] efivarfs: use d_alloc_name()
Date: Mon, 27 Apr 2026 13:29:44 +1000
Message-ID: <20260427033527.773006-12-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260427033527.773006-1-neilb@ownmail.net>
References: <20260427033527.773006-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC92A46C7D4
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
	TAGGED_FROM(0.00)[bounces-21125-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:replyto,brown.name:email,q.name:url]

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


