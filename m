Return-Path: <linux-nfs+bounces-21133-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMRGL0Da7mkPygAAu9opvQ
	(envelope-from <linux-nfs+bounces-21133-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:38:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 751F146C769
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C839B300B871
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 03:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951EA35E92B;
	Mon, 27 Apr 2026 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hijXe/p5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eWDh03XU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2E335F5F8;
	Mon, 27 Apr 2026 03:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261110; cv=none; b=aS1xE70X30czKoKcek2Vxk5gIRLXwvcxZp3PR6T21fd7r6NOt01cCUS8nRLYN3AU1KM/vxAe6823QYCJg0jy8pwxIqZ0habhzFX21Gf270Iokhd8Gme1PEe92H7d3HhFDi2gD8Eo/mLwubdv/3f91cwEtGqwro09ICacHI0QH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261110; c=relaxed/simple;
	bh=OZQWUCnhioPXbHh6CEr0ZrXkezJBRAJa3irRrT0VBn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EO+hQNC0C3UfUkV9TSzPkSk68ePC0RADfOtZdwyi7NsgNiN1HJG6swvZr1ca+QGltgiiU+77zASxi7CNyJejip2GrbLtEmYXsj69MgaKIO1F7mYIhkhtkTmxTYetzzx+221CoFIpoeY9slc4QjTqFHbYdO2aHv96I3qv5ISPhEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hijXe/p5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eWDh03XU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9205D14000D4;
	Sun, 26 Apr 2026 23:38:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 26 Apr 2026 23:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777261108;
	 x=1777347508; bh=d0uUDizqtFn5TUR93S5pcu2hPzZI0J+S0qM13hNSWw4=; b=
	hijXe/p59lm5VAyWu4/5fOUPxLG5POT3G2UwtwwdHk2CTFvOrQathIVCy8jXGjt1
	S8zp7cLunv7fYOGqWQ6DKXfpFB65hdktuyCJnUTIlMTyiMWktO28uxZk+GUWqDBo
	m7l2jBdSL4Ll7YT0lJuMZTt0rm3juh2KvEX+16N1jRp4zx0QX+leMW/VF+LSlhOs
	wYUwx6TLjPFS/5zm3WjZCuLRyMCqJD0Vu58q4mjLZrxmaj2YvuZKngnhHgRnRZfX
	SqAIN+qRzSZCD/dT0TchjQRGeP+n8hl+fwFj1ZXzH3Z/k7P5dYqT9DDkDsbNg9wX
	U2kEe9XauFjWOd2fZ9trfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777261108; x=1777347508; bh=d
	0uUDizqtFn5TUR93S5pcu2hPzZI0J+S0qM13hNSWw4=; b=eWDh03XUzL3d9HgpS
	OdMc6goLtXJjkBRhdI1Kc8ahZeQuS6lYVjzgyIUuROdYpSxccSFusTSOihV/1Trr
	6Lyg3G/9snsRaL4KotmkQeb37mefyGuORUbnUZGJvFMm30knu5h8d4+bF9Vdi8md
	MPpeH3devEjtFeUkOd9cV/RagSLyjNXWPO1PgZCsnqV0SbhsP/eod9bRY+OcRcYC
	bvBZcwsIq/pWiOdo05KaX+C4mgN0aBARnf8n3lcB8lYuYFV2YULesddovpKFvuAR
	K4jjIW1CMkLuY+MuKDJLMyYsTjyRmkNT2e2VMGZKNsRIN0BU7FEaPvBRdyFh4DWa
	ulb8Q==
X-ME-Sender: <xms:NNruaY5hUPpVa2eRP2w_W2XjQcwJR2djWtX99JHP0xc8Hcm0Lmvvrg>
    <xme:NNruaUn2bAGiDBELNBKxzVhSAd0iZFN6ZpjBoYI3cQjJmMceIwxj_g7ZOKwdbha1c
    nqO_FaBS_uesaQ50C7UQS3dlsJqsXllKJhz4pjwPDF-pG8tTQ>
X-ME-Received: <xmr:NNruaeEltuYUsqUrB7a5a_JYc1ofK0dfHwq0WC8BjJndkig71f_XMQjhVAdjtP8qO8A4z5rHtxg6YxWtiUgi41dT7PzrPRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdprhgtphht
    thhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtghksehsuh
    hsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:NNruaYHiKoiSDTixFZw8GEbHCtfbk-tCsdOUAgVkjtjMJfkpEnBYAw>
    <xmx:NNruaW12TXkyVgU9pofOL_5tE69QBDslI8rr3jOMo46UKewlpFpu0A>
    <xmx:NNruaafx91IQ6eyPz7YtaZvA6CCWRtfI1IMhgztbWpz2vUWUClapOQ>
    <xmx:NNruaYKtWEqctjCX6JPSEOyGVdtSh3m2iZB3lTjHtPY0aBNboB_FCQ>
    <xmx:NNruaaPxDpBMjJRzVb561gKoKGEtBzG6G-dFuraG03PR6PrpT7NDwOiw>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 23:38:23 -0400 (EDT)
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
Subject: [PATCH v2 19/19] nfs: use d_duplicate()
Date: Mon, 27 Apr 2026 13:29:52 +1000
Message-ID: <20260427033527.773006-20-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: 751F146C769
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21133-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:replyto,brown.name:email,messagingengine.com:dkim]

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


