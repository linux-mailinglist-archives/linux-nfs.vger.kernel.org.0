Return-Path: <linux-nfs+bounces-21150-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN3OG3/i7mkdzQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21150-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:13:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C92C846CF93
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712213032990
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E816299A84;
	Mon, 27 Apr 2026 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="D8Bt587J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h5mognow"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244C23EAB3;
	Mon, 27 Apr 2026 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262905; cv=none; b=A97NGZajG3jvlpnnSDgESsvSNZpIV/eB28nFovNNus93Oq5t7SIOvMK7AJ21Eif3WTR2wlcayC0txq0hNE99h9XwSHkSGNcuiCZbh1iji/OPTuUECKGiVNh0prjm2b6DjOBwZ2D9e+FOlV9p22FaF6ZWOReC+Q77/8rgb7ziA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262905; c=relaxed/simple;
	bh=yu2CmD9YSye1yc1J/CJYEDi4OTu8Iv0aFTQqvMYN9v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2rp9UDnE0c3BSQT5zlB1Rkc5lBfVG3/WFQx18N/cUpL7wmmBtXUALrzNQUG6hE6WLhggwOrLJyJa06nWf/WY8Nw63bPfvWC/sNSH2nT0ZN5RMVtUzvoDJdrRxd4IUjVLdHJ/gsa+jfr5j+KJ2RX+W5PYzNSdMjZcNFwuWJOU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=D8Bt587J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h5mognow; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 41922EC050F;
	Mon, 27 Apr 2026 00:08:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 27 Apr 2026 00:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777262903;
	 x=1777349303; bh=eWLZ+jMmYCRM3nin9etjMLs+lfC4IZ3wcbDwBF+yVeo=; b=
	D8Bt587J5yweRGAJ3IT7Y+dX09t95nu8rJPS2NiYEO5o+vYyqgL0SQ/pHZd9WA5E
	yTLGyVABbQfgaDSs/AyjuX9eMMkLQiy3gmyStnvnMvf+u7vrlTvhI0c/KkKH9xN4
	MyjA6hIoRKv1eX75P7pHV7rNhi509jt6L7hnuCVW46imr8QtQdy7mfpb+9pVi+6w
	Vbf165LvbJM02WzH+ssK+4NnGCD5hfAVz4PrFMDzMkO2O1Qjxb8No1bwelqeCiVy
	3ri53MoPkzMXOpyesyOdtyJIZQulKS3b5yKpTAI3n1xRJ1rd++o45sdSksHEIQf3
	Y4mGA9ZccU7bTbG2coGG4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777262903; x=1777349303; bh=e
	WLZ+jMmYCRM3nin9etjMLs+lfC4IZ3wcbDwBF+yVeo=; b=h5mognowTF2b4LuTg
	vzrCVIi84wJH4lAopCB5lfzcN25sOU2PkYN066nJrKYkBqoxk1ezkP9vdfOZ13wF
	WQBjST+eQuujXNm9cWWVIGR3DC/q6L5VhnyvN8GmMqi4Gvegp5nLGgXzGOvDGTi8
	HozKKLTKLkIDC0ClgAuAo4G3qtyZcm/SR3kJcxYN4aniIg8U+wdacBpA+hq7R+Mt
	sCCynBJJNic8la9Vhjs9Cmdxk4pOc3aYghg2AGGspohqj8HnajlJ2lj0JaWrSW2N
	pxtzhwukr9u+gLqx1+Mp4P9LXXs7Ew0inCBhFh2A/oa9YqWp2u1QQagoPkLH1pAu
	1b6Bg==
X-ME-Sender: <xms:N-HuaQzg1OQCh0Kk5nOt_VGWnWoPgfTB44rDlMYb53RQjhS7Y5yoHQ>
    <xme:N-HuaYbP81xjkQoYWy3XGpR1eX52XmDqN8uzs1u0xY9tITVffSJfd7cK6bXjrR1-M
    ycwT9S-fHbx8mUmqpSKYpXHAOOz0HjMnzxk6rkjMFbKuajz7CE>
X-ME-Received: <xmr:N-HuafV-Dm0Ge8TsDShxspilm6O6zSP2EEln02WFkbA8xZPY7SF-JgZv69jklMWudIbgoR7v5Obo364bqxq-XdoUsYPimAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:N-HuaZHI-bdUV_EX-_EXvWPHo_wvRuda9gI2YZ2DdfdMqp_vn5S_WQ>
    <xmx:N-HuaZCE3oX0Rttwqe7MqIOKaSHExX1YDvgcBTJVO7S8VaJr4oGXdw>
    <xmx:N-HuaRyEVwxSTyVZ3zwBaNX_mSTBABHqCSfW_wS0Cbl3Fcc-gv6M6w>
    <xmx:N-HuaaAD7ZB_Aty4Apb9cLJ8miOztda3LWlPJkwfLKRWAlxohzTRiQ>
    <xmx:N-HuaRmOn8RrWF8NRe9dEoO090FbbL-0bsztIjj8PmaZ6d673WhZ9eAo>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 00:08:18 -0400 (EDT)
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
Subject: [PATCH v3 15/19] nfs: don't d_drop() before d_splice_alias()
Date: Mon, 27 Apr 2026 14:01:33 +1000
Message-ID: <20260427040517.828226-16-neilb@ownmail.net>
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
X-Rspamd-Queue-Id: C92C846CF93
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
	TAGGED_FROM(0.00)[bounces-21150-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,ownmail.net:mid]

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


