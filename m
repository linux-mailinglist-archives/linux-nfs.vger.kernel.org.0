Return-Path: <linux-nfs+bounces-21138-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA6TGhnh7mk6zQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21138-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:07:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0955446CDD1
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43E643014948
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8AA3264C4;
	Mon, 27 Apr 2026 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VfuxPkre";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XZXu+OZa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1EF2749ED;
	Mon, 27 Apr 2026 04:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262770; cv=none; b=qYYxWlU/38KI3fvXR1Xp/cudjNzeQoiG2/ObXFb7+rFnHsrj9p4I9kZDltd73SHs+wOyDrD6eZFltk5Fwgj5uxT2dOqn0Qigxeyq9+8eJiFIpSsDefOu2weXinkxPrVrQAcT4VMJsHfusZVrpqt6272D7dRCRFLKUOndefT+Xbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262770; c=relaxed/simple;
	bh=s/WJXqScoUb+XDmgBWVvSpncv6x4V4yZ9QvNOvxlLFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxInazkNbhcay6/vFLM/7xz4j5Hh/vg9Gspoxp7Ot7WU+dY4sTBc87B3sF1CFovd9rm3nnuGuN5fzZ2NH4KWLaWzOjqWURrvthWqGf593UPRg43IpnUCXNbYfaZ8mi34FfZ2DuD7pmoR2ywi0I1ZI2Eyvbe07W+NYb9a4SoYd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VfuxPkre; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XZXu+OZa; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B3161400018;
	Mon, 27 Apr 2026 00:06:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Apr 2026 00:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262768;
	 x=1777349168; bh=g8SM3Dg2naVtDlBlkJGj5seH51i8ZJRCDyDc8L3ShjQ=; b=
	VfuxPkre9XHX3HlrcmM02xx1B1pWS7FixmGdHSgOnlmTKlgMaUFz7oCkcmQdXwZE
	0ePQuwhcekwpXYrYOalE0feLIeFxS56XwNst6r6GqjAz1jVyIgMb09+5wOVGR/GM
	oT68SN34xT2u4ea9s3EzES5pfdiuqRUXvK5woV7wG3hHFTVurRC7YTivW5HiAGlZ
	JoWxKpdLgwVfsXJhGQITP1/jCKM3Zg0TNiBDIO+2m3g8kp3BTxi0tWPAI7xam9ie
	Quwk/SgSGdk673hfuJYNFZljTmtilxXQ0zEn7T+0B1yZcuERSAbRDH9gsMiJAMvZ
	rmonSvgzudKO8JOAr4MjQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262768; x=1777349168; bh=g
	8SM3Dg2naVtDlBlkJGj5seH51i8ZJRCDyDc8L3ShjQ=; b=XZXu+OZaBidJ+mBjB
	VCIKrKF8S1v5z8o2qv+iQjCY7GlrD+Ys3ePlu+wUqcSVpigv1Ng++/S+tk3aE/j4
	2/zZCUnP08HAfgtGXhlBP/zDfQDbnVxuPq92M9zvxFndU1WCU3UL0Pk5bhphKgks
	RF/PK3H5FMefyAVvLCNw0vgdtKYlmdyrEXzWXzsyF+cMT/QE1PjrtzIZ3J8ktqAe
	hC2I1cIieNgMEXWSO2VuKykdVaQB8YyN6daq8fqXm8C44Ex4EK1IewPSfG98HZnl
	fa3spEE4B9Lx3Biw8u4aKiN0RG/Jx4sfVUFV5UqF2P020KBemlvAWegt+M+fgDlv
	z9gng==
X-ME-Sender: <xms:sODuaSiQHs67of32EGSeEF2SWSPas8NtwsoGY0MDon2JRyihN7VIvw>
    <xme:sODuafUa6XoJWYFCq9oLG8nsA-R2m1B9lMUmH8KFS0oxrWNLlD7ZKvgLfTDXiaVA8
    2r22mJ3s_0hp1EtFJSfWz7_hUX6ZXfvRLvTzkEMXvJ50YM>
X-ME-Received: <xmr:sODuabs6Ss2UEBEO3_EpKEaNKfynDnLpLB5CnlpikNDT_1K-0MwN2-dlHZxmgh_-agSLA6ZQdDm_5-yP_x63-P_IZFIYnUw>
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
X-ME-Proxy: <xmx:sODuaYbCB7E6IGfG-eIbL2pJPZ-fQdz29uUNy7qVo4DhuuNvB6DGLQ>
    <xmx:sODuaU7Te6P-bNV3NdvK-9de31bhvE_obPHsfhBlM_UEpgHN0mmrqQ>
    <xmx:sODuaQnlHm7FmtkHMxU4pRpz_sh99ABVHvfgoWs75Z6YpTL2ghzNvw>
    <xmx:sODuaaFN-aP0VNHczd94x9SRIkCOkAU-wQ2PQeFWbBkIczWzVGyToQ>
    <xmx:sODuabyExQiGKMkMY0Y1o4zHNhoT5K7bsPzB0T5b4Str6tuckJNi9LKh>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:06:03 -0400 (EDT)
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
Subject: [PATCH v3 03/19] VFS: allow d_alloc_name() to be used with ->d_hash
Date: Mon, 27 Apr 2026 14:01:21 +1000
Message-ID: <20260427040517.828226-4-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: 0955446CDD1
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
	TAGGED_FROM(0.00)[bounces-21138-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid]

From: NeilBrown <neil@brown.name>

efivarfs() is similar to other filesystems which use d_alloc_name(), but
it cannot use d_alloc_name() as it has a ->d_hash function.

The only problem with using ->d_hash if available is that it can return
an error, but d_alloc_name() cannot.  If we document that d_alloc_name()
cannot be used when ->d_hash returns an error, then any filesystem which
has a safe ->d_hash can safely use d_alloc_name().

So enhance d_alloc_name() to check for a ->d_hash function
and document that this is not permitted if the ->d_hash function can
fail( which efivarfs_d_hash() cannot).

Also document locking requirements for use.

This is a step towards eventually deprecating d_alloc().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 789544525c56..d0a504fc62e5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1945,12 +1945,31 @@ struct dentry *d_alloc_pseudo(struct super_block *sb, const struct qstr *name)
 	return dentry;
 }
 
+/**
+ * d_alloc_name: allocate a dentry for use in a dcache-based filesystem.
+ * @parent: dentry of the parent for the dentry
+ * @name: name of the dentry
+ *
+ * d_alloc_name() allocates a dentry without any protection against
+ * races.  It should only be used in directories that do not support
+ * create/rename/link inode operations and so is particularly suited for
+ * use with simple_dir_inode_operations.  The result is typically passed
+ * to d_make_persistent().
+ *
+ * This must NOT be used by filesystems which provide a d_hash() function
+ * that can return an error.
+ */
 struct dentry *d_alloc_name(struct dentry *parent, const char *name)
 {
 	struct qstr q;
 
 	q.name = name;
 	q.hash_len = hashlen_string(parent, name);
+	if (parent->d_flags & DCACHE_OP_HASH) {
+		int err = parent->d_op->d_hash(parent, &q);
+		if (WARN_ON_ONCE(err))
+			return NULL;
+	}
 	return d_alloc(parent, &q);
 }
 EXPORT_SYMBOL(d_alloc_name);
-- 
2.50.0.107.gf914562f5916.dirty


