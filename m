Return-Path: <linux-nfs+bounces-21152-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJifFsjh7mkdzQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21152-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:10:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A20D846CED4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCAE4302E7E5
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E6136E469;
	Mon, 27 Apr 2026 04:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="M6gre33J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AoUOd+0W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123A36EA9E;
	Mon, 27 Apr 2026 04:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262919; cv=none; b=XQ8PJm/GX24okyY4RLNoa5MW89Hri9YI7gfZxNEgp6tD1xX5zN3CMCRUlJjZmQuOH4vVcAWHD2Xlnh5p5UDMiVnXI2tKJr8sjuTclSDIHQiW/R6m8H/1IMzRkcs8FRcDRXOhG4zpQIoRaAF2K/roC0gxtrXPg9tLRItZDxFJBis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262919; c=relaxed/simple;
	bh=sJ0OKrbcNy7ViG3ZtEwAeD/8P3abw5/k7zYuO3E4c2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWgMLFlla3rgn0G3TE584x4AW76ghmwunnEdUNn/sl2tu2EysZQrPDbL8v619AYb+huaZphw3XQmdGhNjNRfkj6KXbCNnGXG2L1NtBFYy82JAO1a/kcQ1IDQEfwmPcaxKBGwOlykaFD1x53cM922e/E3gVe7/N/ZvYcDKX/YnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=M6gre33J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AoUOd+0W; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D40514000B0;
	Mon, 27 Apr 2026 00:08:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Apr 2026 00:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262917;
	 x=1777349317; bh=4j9tOzZwP5C+qc6DcPPl90vS2q7sDqXcjzpYh/ZFii8=; b=
	M6gre33J5RZfacJNeKaQCr+MLZwIdJiXZlsFgfxCGsp2g6A32VmusdgEBJ/fOTV3
	E2Np3zmF2mcweybUZCCm7rbt60dseeebOKZonODwVl6H8siT1rDW+IwMN3SGugO0
	RzeG/hDt7adgUuRSfCjAKK2eT2saPug3RjV7OtqIu6tfritBzUm8VKdxz2LQaI/R
	7aMYlVd5JqU0IRWWe2OWchj9vWq0+P4hXei6iYT+ii5T5WW4GbKRWmg/aZrjMwXd
	Ue5i9ssWGKgxVp+ZignejbupWroIOwF79pe+klTvjDNf9sSZzT71hOB8srudlib0
	t2HLB3myfbbDF//S0KXWDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262917; x=1777349317; bh=4
	j9tOzZwP5C+qc6DcPPl90vS2q7sDqXcjzpYh/ZFii8=; b=AoUOd+0WDVDjST93d
	+Javtw/R6gbnHIN2svHB4YxenGRHKCkslPTh8+tY4lm5JaIeyHesOO5e0tONhKUY
	bNypjARVZ9geQHLO3eq1yHbWh3GUKZ0YgWXe4O1tZ/NNmKJ89s7TS2qzFll9VgYF
	Tfl3+iv0sUS4SAvdf2AyVdKFyNP2a9rHW1Q1Zl4xSQlt2jYMDjXOv2BUx8wX2wuS
	pc3UCo9HT5eyg8beQuPKbPPvlJ1Zamyz/SD6g+QVeTk2c6R96EGUpTaIaDzN2nvJ
	iOdTo+f9dWNiWYoyznfMHJs0HVNoyU5bSDJT4rfQQtCfojXj+3d9Q5tpgrr1QUGi
	7M8OA==
X-ME-Sender: <xms:ReHuaQhmO6HoLp2fpcaPGQ3PwFDV2Mb4Pl97D87u0QbdUUMGyWgT0Q>
    <xme:ReHuaVVr17BykDnmW24hl9GWR9QF6HhXEEk3xlXWuM0bf2TtPPF-lckWW5H7OY0Nr
    0qoO_254xvLKOfbWYxRixVuX6HeLnyRdo-6IGS5Jn7DXUVP>
X-ME-Received: <xmr:ReHuaZuzeDijO1neC6QAj-jLM3j7lr3JalnXWadokKdsjf3NHt8SGXW6xIcijc9z5dTGMeS26WmZeCRaTd6cG3DJ0oQDjIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeilecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ReHuaeZ56sK8B-VB-LL1vRgkcic4Ww3Tra8pPj-tIKxbhmS8SgI8EQ>
    <xmx:ReHuaS4nRD6bTQYYE4gMVXdjoh5Rj2MdQklGmMDzc8xS_d_bsM0IBA>
    <xmx:ReHuaWnbReM-D4ugXv5zYksGK3gMYILvMabQaNYMs2-W_pvhg-YjaA>
    <xmx:ReHuaYF0aufjQwf_lmudNsidexvd_do-KEM4c4AkYK-gIaXz4f_QFA>
    <xmx:ReHuaZxLbGy2un40vR0bFmgDR1oGSfnXNPt7oIsQc_E9SnhEs2k4VT0i>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:08:32 -0400 (EDT)
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
Subject: [PATCH v3 17/19] nfs: Use d_alloc_noblock() in nfs_prime_dcache()
Date: Mon, 27 Apr 2026 14:01:35 +1000
Message-ID: <20260427040517.828226-18-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: A20D846CED4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21152-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:replyto,brown.name:email,messagingengine.com:dkim,ownmail.net:dkim,ownmail.net:mid]

From: NeilBrown <neil@brown.name>

NFS uses the results of readdir to prime the dcache.  Using
d_alloc_parallel() can block if there is a concurrent lookup.  Blocking
in that case is pointless as the lookup will add info to the dcache and
there is no value in the readdir waiting to see if it should add the
info too.

Also this call to d_alloc_parallel() is made while the parent
directory is locked.  A proposed change to locking will lock the parent
later, after d_alloc_parallel().  This means it won't be safe to wait in
d_alloc_parallel() while holding the directory lock.

So change to use d_alloc_noblock(), which removes the need for
calculating the hash or doing a preliminary lookup.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2e8389968317..ee4b9b1a484f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -749,15 +749,12 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		if (filename.len == 2 && filename.name[1] == '.')
 			return;
 	}
-	filename.hash = full_name_hash(parent, filename.name, filename.len);
 
-	dentry = d_lookup(parent, &filename);
 again:
-	if (!dentry) {
-		dentry = d_alloc_parallel(parent, &filename);
-		if (IS_ERR(dentry))
-			return;
-	}
+	dentry = d_alloc_noblock(parent, &filename);
+	if (IS_ERR(dentry))
+		return;
+
 	if (!d_in_lookup(dentry)) {
 		/* Is there a mountpoint here? If so, just exit */
 		if (!nfs_fsid_equal(&NFS_SB(dentry->d_sb)->fsid,
-- 
2.50.0.107.gf914562f5916.dirty


