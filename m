Return-Path: <linux-nfs+bounces-21130-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QODuDv/a7mlFygAAu9opvQ
	(envelope-from <linux-nfs+bounces-21130-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:41:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE2546C867
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA713048751
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 03:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE783603ED;
	Mon, 27 Apr 2026 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PQWF9Dm/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EROSlmZI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB60361DD2;
	Mon, 27 Apr 2026 03:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261090; cv=none; b=FYwWLZ6qkF8FEwUL3oeJqWKo4JqJ6M1PvhWkoXCaDzTDnsnPHYGiQlk+dMEuNZ7fNH28F6sGl9JWc38fbaMAaIJCULvXWTeE0sLOg9e1w8wVcbNhnkOA2nfzfXWikT/Ivv/n/rWmdWCCTdybPfNJsdji4Z83N13uDjmVQFQylnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261090; c=relaxed/simple;
	bh=UdHx74w74FKyyoZPCZRo5KwN8rAmJt9dfE6PwQwR2No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fr4dISMV0Q34NNuhDv4LePK/TgAKQbREvHxjRmz9xF7z5faGgZq6XMGySpK5HpMX7/0F6goWu2nDD2dnXvJrnfY0JIg2mSnK2w1wVemmwMO6jeblMJ5xNyGE84W4FDB4XWTAsw/16rrdkrujv3Nq4jsWYLY4+eCqoJ/nfcXKaJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PQWF9Dm/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EROSlmZI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6BD8514000BB;
	Sun, 26 Apr 2026 23:38:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 26 Apr 2026 23:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777261088;
	 x=1777347488; bh=KHyNw9Kek3PXArhCrUWi6Hbw+BW16EEF6MFx35HefNE=; b=
	PQWF9Dm/JX7qAjaVafFwBVlMt3j9oqKQskyMmgS2eeWs97Cfin1Shb7qeuutVEON
	b2YVazRvxdLDZJ2EAt9z5kw2VBdzNj7B7ZVQ63lTGpr5gr38D7RS7Ps4bEi5NbSk
	Sp9UYgU3fUtDZin64RIGzMXFjR/nejHx2Zzlc9FHWAGKsGOr6qZVElQpjV5CfhOS
	wUkPOYSscluGIj+NwfsWZdg5UmtUblounpHPYDg9Y+07RZRQxGQi4nC+6mepOA8z
	csS9nWjNv8+qKmcddS0zuidF22ZqhcS+NgxWQI8Z1UnSj3PHrr550ZjtTH9uHSOm
	UZkcCg8LjqUNWmVdPHwx2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777261088; x=1777347488; bh=K
	HyNw9Kek3PXArhCrUWi6Hbw+BW16EEF6MFx35HefNE=; b=EROSlmZI2S7xxggjt
	l5yFxZ5olJiApKN0hM/jMMXq0NFqOFFYCcC0d4W3oPDhbG8EaVqBmOqmo3s7ICYk
	fpQHsikV3J2KD4uDbtrJoUrwpDA4NGm3HNEn1Xjw9F6zW/bTCYMYD7Nvk60hctMg
	cIpaxvGD4TRi5/QZeNzJ6zycQhS+ZvSYWeIOBtrOxhurClMJWI0mtftJzBKIDRGO
	SF5dJLcsbAAdBjqoAenWgwlqBWTc9VkoqA/DAofd3z6/3ASg3pN+7OT8XBcVB/8r
	36WncM2QVk3ijnPC/J8CMGgZZvtJR2BTbsbamqvJhbbllvQC/Uft7BOeTa6bWXwa
	osBRA==
X-ME-Sender: <xms:INruaeVFp_BKccZDcgD5qJrwJDgJK8T_uW7sA9j27jVPDfW80S4IaA>
    <xme:INruaVRZxudHlntHFJCInhuzVUM8vDTkWXk5YrOHuK8DuhM99YxKAqwTVh-42ovby
    Vui27jKd307rrpvtcDvMJEMT-tCAhZgiTulL6FAx8BI1Gtbk_c>
X-ME-Received: <xmr:INruaZAz5SEYO58uFvlqtddGnjMb6NpVU-xaVOMmai82DCeFBz9Bj688r7pmqIK1xHuCsM367zUMcPoLx2zXHwjxzHUvBbo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdprhgtphht
    thhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtghksehsuh
    hsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:INruaQTw0mBOSZ5dEsEn5MNBz16kOboZyb9nCHyAnIURG8JHhQyk8Q>
    <xmx:INruaTTpwsP9kfFYIy2qJwVtTdKMIbSQCC6LMPLDe8x1eLfiP4OUew>
    <xmx:INruaWKajO3uhNnAWQHPYML3O4aGCLuM-UD4QK5nuuLUR9EpmvQjTg>
    <xmx:INruaSGHoGHg7b_qKvj8xyNprIp9tb93VHDsbucDrYXPeJ_HTtYD2A>
    <xmx:INruac6kVtk8XKPAZ_xxuciGNRDYsbzKzGy5R-2X7xACE8WM4uBQnNwd>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 23:38:03 -0400 (EDT)
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
Subject: [PATCH v2 16/19] nfs: don't d_drop() before d_splice_alias() in atomic_create.
Date: Mon, 27 Apr 2026 13:29:49 +1000
Message-ID: <20260427033527.773006-17-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: DBE2546C867
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21130-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]

From: NeilBrown <neil@brown.name>

When atomic_create fails with -ENOENT we currently d_drop() the dentry
and then re-add it (d_splice_alias()) with a NULL inode.
This drop-and-re-add will not work with proposed locking changes.

As d_splice_alias() now supports hashed dentries, we don't need the
d_drop() until it is determined that some other error has occurred.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e1d56400fc6a..2e8389968317 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2178,7 +2178,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		err = PTR_ERR(inode);
 		trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
 		put_nfs_open_context(ctx);
-		d_drop(dentry);
 		switch (err) {
 		case -ENOENT:
 			if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
@@ -2187,7 +2186,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 				dir_verifier = nfs_save_change_attribute(dir);
 			nfs_set_verifier(dentry, dir_verifier);
 			d_splice_alias(NULL, dentry);
-			break;
+			goto out;
 		case -EISDIR:
 		case -ENOTDIR:
 			goto no_open;
@@ -2199,6 +2198,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		default:
 			break;
 		}
+		d_drop(dentry);
 		goto out;
 	}
 	file->f_mode |= FMODE_CAN_ODIRECT;
-- 
2.50.0.107.gf914562f5916.dirty


