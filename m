Return-Path: <linux-nfs+bounces-21151-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHcpLETh7mk6zQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21151-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:08:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA1546CE1E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2352130054E0
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B58B27A916;
	Mon, 27 Apr 2026 04:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="dmUwfLyI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSuYOAL+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1C23ABBF;
	Mon, 27 Apr 2026 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262912; cv=none; b=FFlNjVmzaTBxhYHf50+SbdNfjXuMrS9tecaJg8prZRtZPTk2uIfVfbgGowK4tLriFtURcUi9pYh9o0SZ2Q2WR/kITk4t70yk7BtLLMtuv5m1VYyFaXfz7XNy+TJv4pKlfLTICmM5FOAg8TJj3SlS6CrkIToodDqd9CoksgimcFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262912; c=relaxed/simple;
	bh=UdHx74w74FKyyoZPCZRo5KwN8rAmJt9dfE6PwQwR2No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2qx5YgQo4xuXvqiaKnUhVeLReRA0Pp1kML8nYr2wLKIkbwyfDDZr4El3zLQRz7gpcV8KWdGfCcK6+h1TIylhKKJTO2xvtavMbc0VyqXj3kE9Ksnk9qxPV/eeAEOoU2GUBzI1H08rrLsM6pdihXG3sGjaHW7aFERA1QNlKvG3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dmUwfLyI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSuYOAL+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D15C14000D4;
	Mon, 27 Apr 2026 00:08:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 27 Apr 2026 00:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262910;
	 x=1777349310; bh=KHyNw9Kek3PXArhCrUWi6Hbw+BW16EEF6MFx35HefNE=; b=
	dmUwfLyIco9/hkGiT+fR6A1e+VcjqfNe8bTgh6HVT5PdMX3aIGemgaFcqGABFAm0
	EPunmabBlhyKZtAuXgbDL06vKBPwl6zoSK0k5J1mIgzp2Edca+rLCX5TypDkz4ge
	NH2nf2B9yBJZqgyFLRiv+RCpu4q/GLCaQkNoyawBaXHZTI04s5Mi49i909ilSzhP
	xoUSYRWUXA21aY6t3z9dbM44S+1VI6PLcB3INnGfwY3MScTHZJaHCLYC1/pmBFz6
	5uuh7qVdE68EBLr/j1AqEN6NvgRYvol2lBzazf0BA4iETEFBc6ZsSYBUcsc4m4Nv
	oL+d61IbhunJuhM73vigqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262910; x=1777349310; bh=K
	HyNw9Kek3PXArhCrUWi6Hbw+BW16EEF6MFx35HefNE=; b=CSuYOAL+yh/s9medm
	mNsLGeLxYCA1lVt6BFMT0+cW5FuFo+68dYh59NSreooRojh2zA3hY1tP466yoEB4
	fEQ2kgWGkxFf22QRJLpy40Bte0RNXORCn/Ie3PFHANGNU27RCV8XpgElNdXHn/fV
	ru6q9pywO85b4AjiNOwgtQKcFhosZVa8RZ4m4XD82S4nQmPplbq5I1O4EHt2ctAL
	EbWxG4/hBKMo19+E4LS5xk9JE8N+XrhVQNkZhlJfN0ZxPA6WFhGjvbTifGExLhzc
	pMIqZ2g5vRbySKKWfILiLU9TY7sbp8E9SCr/s5hr2jXld/sgodA1P+URVcSz7fBV
	TfxZg==
X-ME-Sender: <xms:PuHuaUZ5ybe6UZM8XXb8_T445pYb0ZAQm_fRAcS0Z5r-fnSt7QnSoA>
    <xme:PuHuabtQx3G9RNipc9kzA06XY-RmrggArw02oO5ZszR50PVsD8H9A7p43Hps5K7Q9
    ZVeCqkZnkQOIJ4L7vvMoKe4mSBEXKUfk0xYVeKcevzqC647>
X-ME-Received: <xmr:PuHuaQkEv9QF55gKYa3WtTJQij-XbzrVsDFvx_fAqHHNrNbubn8M5fLPH2VzBql4PCFTJRBaN0ptJvsrIsBmV83Us6-QQb4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:PuHuabyMhQLJ8bhL19Ze86QYsmoBYQpjA5s2nMJxx8AlunONNjKTfA>
    <xmx:PuHuaUxwf5cBx15sIE1ejCmbnDoGVcYBhcjOrJ1uymjlM2mvNYGpDw>
    <xmx:PuHuaS_x3JC1FVnYVYKSilP46O8Id7SL3_KmGdXxFAG2oaPBegEW_A>
    <xmx:PuHuac-d1lRf3dHHpYlhurePnrViw6TANf3Bg5rziK1a96tZXbWIHQ>
    <xmx:PuHuaepuYWQNqs6TrJPK6YowZb700v80aGJ6DDMFdDWwh0a-vXta73PK>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:08:25 -0400 (EDT)
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
Subject: [PATCH v3 16/19] nfs: don't d_drop() before d_splice_alias() in atomic_create.
Date: Mon, 27 Apr 2026 14:01:34 +1000
Message-ID: <20260427040517.828226-17-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: 8DA1546CE1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21151-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid]

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


