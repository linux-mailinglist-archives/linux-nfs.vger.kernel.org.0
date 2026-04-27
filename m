Return-Path: <linux-nfs+bounces-21154-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLsUD8Ti7mkdzQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21154-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:15:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C9546CFC6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7CC63039C86
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180982749ED;
	Mon, 27 Apr 2026 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Qj7F6Xm5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bZaVOSKj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8427A916;
	Mon, 27 Apr 2026 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262945; cv=none; b=FZkbuqbOVa88QtLSqUJ2N+j3ug2lITAKHQuakcJZYtgyMcjSIT/J0fIztnCe/P6YAGqXpp+iYpiGtbTzZK82dK9TKZnJtrJnoOxrUgoWCNVVPmUzabofB0fliK38epGBHpSy/eeuRzBcSy/NwaLJVLdl9wBhItauGqHjFxBLrQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262945; c=relaxed/simple;
	bh=OZQWUCnhioPXbHh6CEr0ZrXkezJBRAJa3irRrT0VBn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpQ2ay7Ht5FOwbepBSiAxsh/PVPhSyqEnUlUMth/3IgbdLqD1CN83iNFKNQ7U97AIYc8TIJnEC5OnoQJ5Bsph7xhlbZYeODr8ltlatpZRq+Ys1jPM+nSt4hCsm81j2bkD24m3iKAlJSDMsGz9ZnhZK+eR9vz2cgmOlULLmthn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Qj7F6Xm5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bZaVOSKj; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1919D1400046;
	Mon, 27 Apr 2026 00:09:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 27 Apr 2026 00:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262943;
	 x=1777349343; bh=d0uUDizqtFn5TUR93S5pcu2hPzZI0J+S0qM13hNSWw4=; b=
	Qj7F6Xm55Vz3afo9WAApJzy6zCpM9TLM9IwdldIdQhhJX/qNYByVECsXLu/XRj/v
	thF1ve35Gtoz0APpDu+mKucCUzLh/ZXj0kfcqnb/YSJ6JtK4Ob2tMUPUCsyMXxwA
	SE5YOs0AMT9mZm8IHClG8sYzbRLaEzVnoLLWQjw3K23kJZvo6aX1s2cn19eRStj1
	HrhGxKeezdRvdh6ZD11FOtDXacdwjAvLn8sNLmYQUa1GqbUpgq4pwy7VLMNs8d5h
	HgrDRDhfkDbG0DeJKvfQjYz/sR/Aav3Ve+Lg+TfIXTzjGkYKKgfMjKFjKtkEohKp
	VudarelvhhNrpnOt6Fxk0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262943; x=1777349343; bh=d
	0uUDizqtFn5TUR93S5pcu2hPzZI0J+S0qM13hNSWw4=; b=bZaVOSKjGXSAIodvv
	gXr96tNhrFlYuQmCk5SYzWOmXpzCR5jpxmOekC0DKa5P5hxk5NGJBoDT/huI81JP
	jcR3AFeil45vE0GdBbCNFY+WblMpz3+p0F7ekYaoHpLg3vNVo03fllDfFJvdkshq
	xDC1GypmhrXXrF3oI/YfHnJI76A1ZlCgjbhsB69AWZl4fvQUHDc+2aVOyw/ka1SH
	A/xSjkZrGJK/0/feddvX22FPWsywfsXllPZ429vi1yDHpzkQqRmADwd9d3RQHVQb
	r4JXxb1mk77CZ8+dZ/tC9YAZG0KoAefnNu/JXZIOJnQq/rgtkkTZXPRJBENa1TU5
	+kSKg==
X-ME-Sender: <xms:XuHuaYcfoY0tU1Wp8-c6NwE0aqwZ2ovvnXp77EBdGPHgKbi-yA9t1Q>
    <xme:XuHuaWiA49-tXpY7CSou5wgPQ-mRvtmshnG2NNemRDCpAx68vrHcEunlShGZGl57U
    PXazF6xoRp5sT4hWIDe6fXOpRSpfWGz5X_UbXW3ASMY-TnU-g>
X-ME-Received: <xmr:XuHuabK-EAPGCvWVNaqtdOZmlwaK-TJPqsCoGkFu7A56dC8OJOIRBVvUE6V8qj9ciLtrlM70U3MzSMohsFFfYgoWgZqQfKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:XuHuabHc0cpfVwD7d1KLY3irm7c-JclHJBTJDZBMulZFKzaDSIKQLA>
    <xmx:X-HuaZ2Zr5uMfDdKacVx3is4dMzP__qgfyVxbtL4Ahlt2Yy47UuGnw>
    <xmx:X-HuaaxOKfPlHFWrChDGsGrRqhFxNIjtrdIQuhM7kNfgTyoy8BCz5w>
    <xmx:X-HuaQi6lGCC_64z5U8LYeO8qJXYhBRsCLWeuR3zmFxWvK7GAeWNsA>
    <xmx:X-HuaSOuXsrzxmcVhGz-CJhMbtBe5xJqjSkriHx6a3BP1pZGTnDmyyXT>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:08:58 -0400 (EDT)
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
Subject: [PATCH v3 19/19] nfs: use d_duplicate()
Date: Mon, 27 Apr 2026 14:01:37 +1000
Message-ID: <20260427040517.828226-20-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: D7C9546CFC6
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
	TAGGED_FROM(0.00)[bounces-21154-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid]

From: NeilBrown <neil@brown.name>

As preparation for d_alloc_parallel() being allowed without the
directory locked, use d_duplicate() to duplicate a dentry for silly
rename.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ee4b9b1a484f..dd48dea8bc40 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2778,11 +2778,9 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			spin_unlock(&new_dentry->d_lock);
 
 			/* copy the target dentry's name */
-			dentry = d_alloc(new_dentry->d_parent,
-					 &new_dentry->d_name);
+			dentry = d_duplicate(new_dentry);
 			if (!dentry)
 				goto out;
-
 			/* silly-rename the existing target ... */
 			err = nfs_sillyrename(new_dir, new_dentry);
 			if (err)
@@ -2847,8 +2845,10 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		nfs_dentry_handle_enoent(old_dentry);
 
 	/* new dentry created? */
-	if (dentry)
+	if (dentry) {
+		d_lookup_done(dentry);
 		dput(dentry);
+	}
 	return error;
 }
 EXPORT_SYMBOL_GPL(nfs_rename);
-- 
2.50.0.107.gf914562f5916.dirty


