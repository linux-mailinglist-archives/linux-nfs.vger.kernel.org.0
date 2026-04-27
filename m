Return-Path: <linux-nfs+bounces-21129-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DJgB9ja7mkPygAAu9opvQ
	(envelope-from <linux-nfs+bounces-21129-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:41:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E1A46C847
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD5B8303EC30
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 03:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862BD35F60B;
	Mon, 27 Apr 2026 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="U5T7rVqi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AbXuKpSA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA43624D3;
	Mon, 27 Apr 2026 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261083; cv=none; b=PdztnomfW0JwdkfSe5AOZluMFCNGwH+qqYcwuAKrrRfXIjzfruYlvSdlmNrYk0Yl79Smnx4myVbZqDjoKZ5KDwNIjzT6hec77TQxiPOGrZfJqV+IyxhQZPh/WzVDkAbu6KdlvuIZEgo9YoM9v7iK7txDT7Jlypus/L2j7nkb6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261083; c=relaxed/simple;
	bh=yu2CmD9YSye1yc1J/CJYEDi4OTu8Iv0aFTQqvMYN9v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GU/GBaJrSxw2uI3OIjqPc0SUqzI23Ki6WHub8EnBiWjbPuvCqSveYyfUwCpESejZxCCAGqhCyFFn9UHCH45JyE8xANB8Cl27qPT1U0t9qW47YDg8AT7DAgQLzl2SXGPZbAhD6iFXsze4vXcTI9YpxV+2R2H+k15uSBct165AWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=U5T7rVqi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AbXuKpSA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E87C14000C1;
	Sun, 26 Apr 2026 23:38:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 26 Apr 2026 23:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777261081;
	 x=1777347481; bh=eWLZ+jMmYCRM3nin9etjMLs+lfC4IZ3wcbDwBF+yVeo=; b=
	U5T7rVqi926OjIJDYW19XzyjTLe9fbTRexEeZ9yvbjfCY7IHnwWfFqGX2LpxHVSL
	m0aXLMhKxD7G7yrqcRQNt7dFDiegnrsRL86WlA2HrxH4VV7LCHRjkk7xJQEGVvQa
	XtunKm5zYG0/0vMr831J70DLcYKcDFqRMqXwu2TyVie6H5XEwDMLydWyQIUO/NS8
	V1QLdkqatDtqN+yttHuvEeXw3tvbtXLeQ81V/cn5P0nI/LTl9bNLpifVBgE0fYYO
	AYG99W1iUd65KyZzfanswK+D1VO8ywjW7HJvMz2hWBSHXAqYdM4nWDj5F/j7gNcF
	n7sGMFrg6TTK+84uomluYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777261081; x=1777347481; bh=e
	WLZ+jMmYCRM3nin9etjMLs+lfC4IZ3wcbDwBF+yVeo=; b=AbXuKpSAqnnAervuk
	Wu2IUsvfgu/aUJWHSIApBpdJAtJPgx5uZtCXOGu+PJ1JRqz3rA1YArRjQeAM13wt
	YXqUSlhASyhtYc7+qgzQFpYE/H2XwHaxb4JQXvfbvt/J/5yyv8leLzgpLG4ri1CT
	KIiwq8TSa3t8DGbBgjaaFm5tC75k+gAJTy6Rz+B5K+JRl4MtfYGS63EoRvxpmE9I
	+eF8SYmuMsM8uq3SaIgimb2lkuKPNBoeSkOq3+ZcP+2o+VApmMhRhHvaVA5dG4a9
	eMwhglhuDEZ+8v1Mb9dia9m1BluYnOCi2aDAkq4Vd7WjIWXJYyeGQA4rSU0Z1gD+
	jG57w==
X-ME-Sender: <xms:GdruaVWVXaX7UIt-VIgHeNAt_Pi8voCG9vbMjDxbIG23x1FevuFa7g>
    <xme:GdruaQTMBACsEbDOBrGOq034XHBFDMdMcNETsemDz2bwu81OiDFiVDPxOb_kOlqhS
    ntiKZQPzcyac1FybhFM9eMA5R4cOWZqT_0uvXTlv8952o8>
X-ME-Received: <xmr:GdruaYAoxunOuiaudFZOukvpefjDAu-YG3dS2TX0EqcKsFiCxjvhwpVVyWmnnRHmOcxVbWcQCYENmph7yL1sXPqj8DgFE6o>
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
X-ME-Proxy: <xmx:GdruaTTa6oQugGWAiFD8H-5cIFxTMmegE3QDIbXs_-czO2Z2DiXzuA>
    <xmx:GdruaaS_mCIfRcmUsnqi_mJUjcGIaPHRUdu79IY3U4pgf62B_NvkJg>
    <xmx:GdruaRKIgTxnxbz5pkz_wwrXBF4mT7hHkFYXt8rS9MsWkQ-lgTnUdg>
    <xmx:GdruaRHbtcv0UHAuebMFtzMLeXXtBKQripKkrIHeXfKFJX2cfIyZww>
    <xmx:GdruaX7Zmu5qU5CIfZZpEZcSptcsr-EPW44A1OSNnXcLde8n-u5Z6HJ9>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 23:37:56 -0400 (EDT)
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
Subject: [PATCH v2 15/19] nfs: don't d_drop() before d_splice_alias()
Date: Mon, 27 Apr 2026 13:29:48 +1000
Message-ID: <20260427033527.773006-16-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: 72E1A46C847
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
	TAGGED_FROM(0.00)[bounces-21129-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]

From: NeilBrown <neil@brown.name>

nfs_add_or_obtain() is used, often via nfs_instantiate(), to attach a
newly created inode to the appropriate dentry - or to provide an
alternate dentry.
It has to drop the dentry first, which is problematic for proposed
locking changes.

As d_splice_alias() now works with hashed dentries, the d_drop() is no
longer needed.

However we still d_drop() on error as the status of the name is
uncertain.

nfs_open_and_get_state() is only used for files so we should be able to
use d_instantiate().  However as that depends on the server for
correctness, it is safer to stay with the current code pattern and use
d_splice_alias() there too.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c      | 3 +--
 fs/nfs/nfs4proc.c | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2c1315a02e52..e1d56400fc6a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2329,8 +2329,6 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	struct dentry *d;
 	int error;
 
-	d_drop(dentry);
-
 	if (fhandle->size == 0) {
 		error = NFS_PROTO(dir)->lookup(dir, dentry, &dentry->d_name,
 					       fhandle, fattr);
@@ -2351,6 +2349,7 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	dput(parent);
 	return d;
 out_error:
+	d_drop(dentry);
 	d = ERR_PTR(error);
 	goto out;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a9b8d482d289..185c933fb54c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3099,7 +3099,6 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	nfs_set_verifier(dentry, dir_verifier);
 	if (d_really_is_negative(dentry)) {
 		struct dentry *alias;
-		d_drop(dentry);
 		alias = d_splice_alias(igrab(state->inode), dentry);
 		/* d_splice_alias() can't fail here - it's a non-directory */
 		if (alias) {
-- 
2.50.0.107.gf914562f5916.dirty


