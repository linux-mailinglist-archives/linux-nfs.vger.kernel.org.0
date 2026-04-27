Return-Path: <linux-nfs+bounces-21131-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCgRHgzb7mlFygAAu9opvQ
	(envelope-from <linux-nfs+bounces-21131-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:42:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2469046C87D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0748E301545B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 03:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027E635F5E5;
	Mon, 27 Apr 2026 03:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="lpMZYpxt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3PZDIBE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879F35C1B6;
	Mon, 27 Apr 2026 03:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261096; cv=none; b=ImDNu9wFPUXyOPM3sq7q71yX9VNMy11xwdeAPw/bQkxroQXzybC/inLcv85kGrobHWmpP4ebVhdsKYZKNuSlX5XBS0CwmVfT9JG8LTd4DS27nBuNUlIPyn/0LnHdV9ZPS+KkCSIirn3YBrvN6WajV44fgyanJde8Y4zCifrbA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261096; c=relaxed/simple;
	bh=sJ0OKrbcNy7ViG3ZtEwAeD/8P3abw5/k7zYuO3E4c2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=On4Y2oIeDetGJnrwMGYdwAMLW16waZ4dB9C9EUrDGjCQuKUj113T44Fm2g5GgUNHIPBmATgsvR8t43jOPZAsWna8/3M2ZxHce8gnJ5ayfv5YSBUit8aPB8wto3YQcfZ/CNpnvke6PKovk3gMYZ7sFIhM8AAqyNCZjUkL6Na2T3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=lpMZYpxt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e3PZDIBE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C84CEC03EF;
	Sun, 26 Apr 2026 23:38:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 26 Apr 2026 23:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777261095;
	 x=1777347495; bh=4j9tOzZwP5C+qc6DcPPl90vS2q7sDqXcjzpYh/ZFii8=; b=
	lpMZYpxt3hmTnrwTgkRVxsr+XZPfb2fTusSvQ6IVKp/jbNyJYDopriaAW8At4q1K
	huiwMVFkW9Gh6Us4FBIbBXhsLh5FzxxyWldIDjWh3/Xw+5hFjWOM3RznTjD626iX
	BOwO+jH1m5NHqlXyA9yNdOk7K5sM3CBmtTRqix4rQVOQVJCF+RqRebQkmtECrLqK
	1zRO/fbqJKErz9x58lhjW/23nBrpMqI9RLSbuUpyCfE7dmtj1NHK08uHySgrtfRt
	29THlrKZj1fEq2RFWdx6teYUWd76kfvto2r2e66bL2b4u7MSsQJkwv3PB6nQsJFS
	IE9pATfToNkbBR/a7w0kaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777261095; x=1777347495; bh=4
	j9tOzZwP5C+qc6DcPPl90vS2q7sDqXcjzpYh/ZFii8=; b=e3PZDIBEmrOFj4AJn
	Ki7dzYGjrKJLR547f8vr0+/a4CeZWUybxpVWaqxTV+b5P6BfayiQwZQbtYtpfxEW
	pmESs2rxOYuj+yw1LYqVlW/DioVv5sIKxlDfLHeNnIXb5XfvKJPlK4LVnDKAgOOj
	LtvWALWkVGXmK758lJg+T01Oq2nF3yWpkMipuu6JuVo7fsApOu3RF6qKuTChNpIU
	C+lNeRd1KGg2m4fmwwsLVdtKUWs8PqO7TFAr3JRN48WlMSYUMBoxpvyWEN/PvMi1
	2kEUSSvFJxvYbyeH3HuESv07gT/pFYfIcwYMt1P9s7/iz3zTRurkhbwa+onKaAbs
	DpGew==
X-ME-Sender: <xms:J9ruaTKVENr_ufEK7HtKn-W3HiAiMVQKUdLNYksK5DBOoeSpx_-BwQ>
    <xme:J9ruaR1L2MfixDrfmYPdOYDSDToaUKV0JcOtw-km_Zm4Bbh6oQyrfmC-SViBACsWS
    JSZRT48pYAmHjAx37rr9q0jVzNJeFvra_9JhTfJXpznhVVDnw>
X-ME-Received: <xmr:J9ruaSW8D9zcKkQwOTyISj4pDtsm4ts4H5xTIpiH7_NTHUTZBewZjkFbHKBFdiMRf2Mu9KDZsCKJftiwGKqaqaPiozGc5io>
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
X-ME-Proxy: <xmx:J9ruaXX1APvZjsQai52PTFz5O_aDnraxLKyWHWdF4NCouX1Pl9Lbcw>
    <xmx:J9ruaVHAasQlLH9MP5unOHb3iCTFFNN7tXGiFJT68auGHeMHGjrXQA>
    <xmx:J9ruabs_A3Xtw4bbQN0pNN4O8zbA2sDgdOHGlNYHNVN5_VKpMx--Ag>
    <xmx:J9ruaQbkvkOERKUGImXx2RRLgy_KVjHUrN_h42tbMDNyaQOT4Uf5hw>
    <xmx:J9ruabLd8i0e1Vq50dbyMtW_sY8VjpPPl-jsIVSaZL7IwDMmnLsl5U3v>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 23:38:10 -0400 (EDT)
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
Subject: [PATCH v2 17/19] nfs: Use d_alloc_noblock() in nfs_prime_dcache()
Date: Mon, 27 Apr 2026 13:29:50 +1000
Message-ID: <20260427033527.773006-18-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: 2469046C87D
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
	TAGGED_FROM(0.00)[bounces-21131-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]

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


