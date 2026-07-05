Return-Path: <linux-nfs+bounces-23001-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kgCrNu7YSmpbIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23001-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E72570B9BB
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=dNiXKnbB;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=SFxFmUTV;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23001-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23001-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56894300A13D
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DBA253958;
	Sun,  5 Jul 2026 22:21:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A335F193
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:21:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290072; cv=none; b=nhrIQGuztWNVpv9d87eKZWYQ7bmBGoddWsotpil9A5OINlOdVnMwsKU8My7GvNb0BCP6UWtZnFV+5NcHLLrL3tjWD/oSIm/BDpUqTv+JH7Wh+GItti5wuZm+i6HYdSpyRb92NEK79f0KdWv6uHVFbMAEYFUA+0chOCIwT0gn9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290072; c=relaxed/simple;
	bh=MTaMMB10iqml21RbkFCH7N+w8dkf81NsDcJxQ0tIDuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGPnBaClGF8vls10NXb33G8Tgug57v3W21GHhkLoS/PnF4ZY5abvaeE98k7Fe3tNaNJeXIdKrGW0oZvGrM0jJNfPCGNK+hFvKCMtOrAcUEH6vqmz4Ig11K8yNmRy3Fl7l8oXjDK7ODl0jl8zamurNeeDTCk+v9VOcfjZbMN6xL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dNiXKnbB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SFxFmUTV; arc=none smtp.client-ip=103.168.172.156
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 42D951400012;
	Sun,  5 Jul 2026 18:21:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 05 Jul 2026 18:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290070;
	 x=1783376470; bh=shT8bVj7u3GSu6lMxYenar/PpmP+hXXuGrbkrF/CiPI=; b=
	dNiXKnbByb89xD+6wHJVEyU+X8aaZQzmx6IZhYiSY+41wfBAUsz1GhrQGog++EGs
	I/rLMqJeaZ/8Cuvu3tTjrmKruGVtJgkMgz9W+/31+KGAWuaHQ3fuw8MtvR7DcUeG
	tQi7z5i010H5Q4/DJNCN6qq0LqgQg7q7mu0iGovF+wKuDUbfHfKEUZq00zNMWs14
	s54MCVIEOoKHbc8qG80+qHnxitqHYB7nrl6OHVQzuxMAoARubeZS47RlolpXpora
	2aGnAG9CfxMDVigpu8MZtd8ahNavlRAWqacKgvB9D0gRv01VnrzCnd69yFLtT9dx
	Xh2nbXmEkGcl9gVvyLrl6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290070; x=1783376470; bh=s
	hT8bVj7u3GSu6lMxYenar/PpmP+hXXuGrbkrF/CiPI=; b=SFxFmUTVdHk1FWXnk
	DjWLDAdWxOte/Z1Ok/YVIddGaTzFCgMkK2O5dfVYnp636m9um4yRkyX5xGwFxBTE
	Wm9mLu+T/R/KVzNMDDbGhYgIhlvJn47rp6ssKxb5qL2XodncHe0AqT/YcBb8YVmC
	vdwkOQ7alOb+QwC5kHBTpPD07C824yzy1wDUpKhB3L4DG5twR3nHZEtfpeNHMnud
	Ds/lPb8J37rSOYl+ZQTdfRBKKvBt420cNQknz1NFCmBUc7peZPwT3U7ewspdgCff
	qYL1l8GXhChbgNslxJKAkshx5JjxHiZvDtvcbLDxEgN1vVsc1hzlO3P88Wf3/BOr
	kLIiw==
X-ME-Sender: <xms:1thKaouPI7SC-xu8aVnw2zG4Gs8OpTWyTpM9oL0iZDobPMpz5ev4Ag>
    <xme:1thKapJBsHui0cGJguKUWSAfHpIbjbSfwFwu0inFAtKXVT248F_Rib0hVuINUGdrK
    XRzuYzIYBUtMdqddz7b8b1Ic_aDNjnl1rKbw1px57AiRx1GbQ>
X-ME-Received: <xmr:1thKatlxUFxdz7K_S4tZbkkdDFn6qNJYoa_trOfSixYybigS82UJHuaAFRQgtKrqkhq00u70oGyqHL-mbrWFa-gCxqhDpjs>
X-ME-Proxy-Cause: dmFkZTErMAdh0PO5/SmQA5niNOZljaHMTkfhLKVcydPCRuIYEgeCpwNzmZMjkoUgxqFWu/
    YMfLhryAuXf29i+O1RP6N9SNW1cAwyvbrnLX3Q8tEs2vpIyBAQzdN6QpRE9F5PYiNP/Ai6
    FdTJG7jvkY7lFiaf9jq2XJnBFzx3ycbYPXka/Jw5locHtkKiv6Wmjja0airzqO6OOdos3M
    v8djOo5IAnHKx49LFvgO7ipfCT6lPV3+hcDbBk14OrlslPtYDRtHJ3nPSQUaI2ZNaJNiIQ
    fMIwxYC+x1amSEvRHr1JmsaI1HhndEWvkl9fQmmFoR7262jRSTDd8zeYh06rmyzCsM9gDs
    wqmzhbL1VR6MS7JCPRdZfn6Ex6ngQtrJwyi1Rm5y21/DaLgbLgCT6N3LjmnuPOhstVVRDq
    1fIgr3moUELxlypPQvlYpR2hR019wIlvCpvL2hv4Suk1Y+O1hIUko16nUIdELPKjtuQZZ5
    j7XN0QlZNiF00fXJQuBUgO8wVNKmt0hKSwC7VeIdHWDcTzHk6712OtgrTggos8syZQXBX9
    6+nZV4FtzVck4OwuZbkQshLwNKRj7Fro2akmDQ6vTB8XCkHIqMSkWK2kAGzHmabI/sYoNq
    BMjFKlSLexAzS1EsJMRxj6AErgHhkvPoYLWVsTfnFHdrPNbY8sekuS31k2hw
X-ME-Proxy: <xmx:1thKaiLfgppVo6g5Eupd6EX6sCZf0ph1EqH7Qytz5yaiQRaXy6YmmA>
    <xmx:1thKaq5c__PjpfdVY0cssDt4iPrFwWGE8bD43cwNdtdfvRjuwDOJjw>
    <xmx:1thKau3oljRIzEaJp2HZs1swGUZuWESkZzI3bZ9pRO1RV8-cOTkwQQ>
    <xmx:1thKaoeRCkj84Kr8mo0kxJgVUnk0fcfu9RPgqEnQD-Fo9Chx4dj8Jw>
    <xmx:1thKamMcW_HNUdDm80gM1NzY3EnxsOuMVDe5Ey4iRRQcQS_E0JNBFBhT>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:21:08 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 06/14] nfsd: in nfsd4_create_file() let VFS report if file was created.
Date: Mon,  6 Jul 2026 08:19:38 +1000
Message-ID: <20260705222032.1240057-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260705222032.1240057-1-neilb@ownmail.net>
References: <20260705222032.1240057-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23001-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E72570B9BB

From: NeilBrown <neil@brown.name>

nfsd4_create_file() currently assumes that if a lookup failed but then a
create succeeds, then the "create" operation actually created the file.
With atomic_open this may not be the case - some other actor might have
created the file between the lookup and the create.

So we move the call to nfsd4_vfs_create() earlier and set ->op_created
based on the FMODE_CREATED flag that it set.  Then use "!  ->op_created"
to trigger nfserr_exist handling.

The switch statement is split up into two if() statements.
First we check for the possibility of a successful exclusive
create and set ->op_create to true if appropriate.
Then we check for NFS4_CREATE_UNCHECKED to decide if a
pre-existing file means an error or success.

This allows us to combine the two fh_compose() calls to one place.

A subtle difference here is that we now must only pass O_EXCL to
dentry_create() for NFS4_CREATE_GUARDED.  For the EXCLUSIVE create modes
we want a successful open even if the file already exists.  We then
check the verifier after the open succeeded to see if it was exclusive.

The above requires changing dentry_create() to reliably set
FMODE_CREATED when the file was actually created.  Previously it only
sets this flag when atomic_open is used.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c         |  2 ++
 fs/nfsd/nfs4proc.c | 69 ++++++++++++++++++++--------------------------
 2 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5cc9f0f466b8..e0a62198fc60 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5073,6 +5073,8 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		error = vfs_create(mnt_idmap(path->mnt), path->dentry, mode, NULL);
 		if (!error)
 			error = vfs_open(path, file);
+		if (!error)
+			file->f_mode |= FMODE_CREATED;
 	}
 	if (unlikely(error))
 		return ERR_PTR(error);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 69cdbdcde7e9..f59ee074c0c9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -210,7 +210,11 @@ nfsd4_vfs_create(struct svc_fh *fhp, struct dentry **child,
 	int oflags;
 
 	oflags = O_CREAT | O_LARGEFILE;
-	if (nfsd4_create_is_exclusive(open->op_createmode))
+	/*
+	 * For the EXCLUSIVE modes we do our own uniqueness tests
+	 * so don't want O_EXCL.
+	 */
+	if (open->op_createmode == NFS4_CREATE_GUARDED)
 		oflags |= O_EXCL;
 
 	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
@@ -333,22 +337,30 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
 		if (status != nfs_ok)
 			goto out;
-	}
 
-	if (d_really_is_positive(child)) {
-		/* NFSv4 protocol requires change attributes even though
-		 * no change happened.
-		 */
-		fh_fill_post_noop(fhp);
-
-		status = fh_compose(resfhp, fhp->fh_export, child, fhp);
+		status = nfsd4_vfs_create(fhp, &child, open);
 		if (status != nfs_ok)
 			goto out;
+		open->op_created = open->op_filp->f_mode & FMODE_CREATED;
+	}
 
-		switch (open->op_createmode) {
-		case NFS4_CREATE_UNCHECKED:
-			if (!d_is_reg(child))
-				break;
+	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
+	if (status != nfs_ok)
+		goto out;
+
+	if (!open->op_created &&
+	    nfsd4_create_is_exclusive(open->op_createmode) &&
+	    inode_get_mtime_sec(d_inode(child)) == v_mtime &&
+	    inode_get_atime_sec(d_inode(child)) == v_atime &&
+	    d_inode(child)->i_size == 0)
+		open->op_created = true;
+
+	if (!open->op_created) {
+		if (open->op_createmode == NFS4_CREATE_UNCHECKED) {
+			/* NFSv4 protocol requires change attributes
+			 * even though no change happened.
+			 */
+			fh_fill_post_noop(fhp);
 
 			/*
 			 * In NFSv4, we don't want to truncate the file
@@ -356,41 +368,20 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			 * some other reason. Furthermore, if the size is
 			 * nonzero, we should ignore it according to spec!
 			 */
-			open->op_truncate = (iap->ia_valid & ATTR_SIZE) &&
-						!iap->ia_size;
-			break;
-		case NFS4_CREATE_GUARDED:
-			status = nfserr_exist;
-			break;
-		case NFS4_CREATE_EXCLUSIVE:
-		case NFS4_CREATE_EXCLUSIVE4_1:
-			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
-			    inode_get_atime_sec(d_inode(child)) == v_atime &&
-			    d_inode(child)->i_size == 0) {
-				open->op_created = true;
-				goto set_attr;
-			}
+			open->op_truncate = (d_is_reg(child) &&
+					     (iap->ia_valid & ATTR_SIZE) &&
+					     !iap->ia_size);
+		} else
 			status = nfserr_exist;
-			break;
-		}
 		goto out;
 	}
-
-	status = nfsd4_vfs_create(fhp, &child, open);
-	if (status != nfs_ok)
-		goto out;
-	open->op_created = true;
+	/* file was created */
 	fh_fill_post_attrs(fhp);
 
-	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
-	if (status != nfs_ok)
-		goto out;
-
 	/* A newly created file already has a file size of zero. */
 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
 		iap->ia_valid &= ~ATTR_SIZE;
 
-set_attr:
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 	if (attrs.na_labelerr)
-- 
2.50.0.107.gf914562f5916.dirty


