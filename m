Return-Path: <linux-nfs+bounces-23006-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c/fLCQjZSmpjIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23006-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:22:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C78970B9D6
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=Fh7mcmHy;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=pScY40ZW;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23006-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23006-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F00F300877E
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267A2360ECD;
	Sun,  5 Jul 2026 22:21:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2135F193
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:21:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290094; cv=none; b=J89o2P0uaWvOxGDOyPwIbLfs85NayICAPeH2V8wl81WXCA4P9fMDnDCsaLjRs5W0Rm8Q2eKIDpxakl2UySxBwH26nfOFWGzhqIn/xdlb+/L09i5F5Yv4uSlxRFmKkF8pgfpFMChJZo3BXDrMvfmjNSvjG643j7SNPlNPD5TR7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290094; c=relaxed/simple;
	bh=/02r4gZZ25F1FBrtELMzNzyqXvM2LoEZ/L2Pnde0bbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLG8EJoIscvleYCEpsDwPzAJ1fYHDTyS3nJbSn1ufv0gLCDBEmLtVetU51Dt4Q7uZioi7l9a3NqIp4Y5Va6440f9mhr872cuPXeqkF8kS/EkveQ/AQrMChqGqY/B0eEkexqrAsZnYKOQdObN3eCzU8li++Z+fWptLydSotVNeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Fh7mcmHy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pScY40ZW; arc=none smtp.client-ip=103.168.172.156
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F133A1400093;
	Sun,  5 Jul 2026 18:21:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 05 Jul 2026 18:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290091;
	 x=1783376491; bh=4lnHIQymTbDN/5uodu7O3Xpzsi+fWJVg9wXXYoANW9M=; b=
	Fh7mcmHygX0K8+suMhAuqM8Z1/+4LQ+T6XO7K4UiVoUMpK2oKHV72Z+TLf5wJF91
	YtCh7jj92AyrAjlGxkgguku3vfnPlVjYzisaLmCueypg9Z7SsBo40E2NUds1syS4
	/HNzielAYd9JyqMbOD0FwwuOSZOyD3bRYSqYO47yVTAExrlfNgRGexWc4rPgMazN
	x2aFw24L4jYfQTq9xaozQv5iTS7Wbn/051CETwoVbEZ+ryBmOyE1avgKhI3ZsyVz
	wc4K3jcXoZ4udh9oom5cSCiN/+xyI94ZIbUO9iDUGyCazW8rMWJgTG8TNjMMASW1
	TUD+0f1dScFKym30kUPZdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290091; x=1783376491; bh=4
	lnHIQymTbDN/5uodu7O3Xpzsi+fWJVg9wXXYoANW9M=; b=pScY40ZWgsIVhT+6g
	AfrpEWXQ5TVtIKJcyskgqZxDHrPMYibErUwVEa67+oxJMACtWhb4f20IZ9nKF0YW
	wFoHhR407foc1Rd4iNK4+tvboeAW7qeBTuEi+rLQBP2I9aADUoopj1YeQTA+mS2H
	Pc0QRNeQD6q/whSdHqXkTHkOGXwr/k7gu9zvS/Wt5h5dWTGK6x/x1k7suw3/c67F
	VEjTYk1DEmyaOKZfKksPAvWFjOYiKFExFLg3aj1TArizG5UbDJCezHzUYsnLoFIk
	/krae/cGnnzAOUs18rmshQsoe/72nlqPj0osZaolO6tF6o241s0thkSJJe7JkKo8
	3ZVoA==
X-ME-Sender: <xms:69hKaqK-64haYRe-5raOPsHCo2L6sg4rnbVpNcDtB7jo5pUNxtFddw>
    <xme:69hKal34bkpiM-0PNA35YDNBczlEtadJYBPYtAjW98-n8BRr1YzY5iid6F-A7GOjV
    WR1nD_y5LVKLbXBzg1F0vtuA6aBwL5BdIL6A62vn8M2Lq6slA>
X-ME-Received: <xmr:69hKakio4kjRe-G30CHo4TxyG6DbOkLhzKGJobvbai7BhcyGzyOKWiQViaEgpzneOGPQ417HQ3zz_n8KaDc2BDZcEeDp1Ek>
X-ME-Proxy-Cause: dmFkZTG3gRBUMFZjuZQr2v8bwB40mePp+IK+Nauods6UW+Wi1FNkLpGh/DMdP1rPoc00/J
    GXLrbQXux+QGv98aV+fyXq4RdYJ7iSZwn8WGxUG97tZC+ifnZ/u8Os7viYbIdlkEILLfin
    83+VeNLXZdJEFJFP5ctkBR+zhLoLj49aIx958pb8uUvz3sAdPrZTH+mwnL344+SawuzCw6
    /56nKrmYZRoUXS7CYw6xJjM82b91mGtEciva621yafYM2JeGpc0Ck4F89aQ4F4arydfYeM
    8N7reNs0pVq/tt+JKQA6TQKYs+nQa6cWkomfOhsXEZtFXu5WhqGLOvvmnSl8vVO/e2l7F2
    4mgik/B5fpa2T+mdnGKLCEP2i31xxXschJ8M74xWTI35rRvDcuoFHpmECogF6Ca32kszEE
    f17JivwQua4gUlZr+3wWi1Wdfa1MgnAyFfgcOYe8+rN8kwHGAUG3kZntOfZJDtok9HJTFt
    yt0l70ooEVunnp3T99u7SCKO1g8bHiU++Fo3lN7svb+vUPoWhX51WJ2qAc6D1N+eE+QLgJ
    9htvMAZIkLSWC9Y4i8Oci9efPekzP5f7D0Tdjd6cBreXZ5G7jNyo9GCiNTW/1EPK8g/8k8
    mgrBeK9day7wAsYFgacFyDFJHaQpbZyHaCE7n+qhBLRxIQfK7im/7QlHQfbQ
X-ME-Proxy: <xmx:69hKamXG_yHl9zAqMg-6wl_n8idod37q81-kCuCgUVorsIxNGtmERQ>
    <xmx:69hKajUGuCfCOPZWR7knKOjTho2g2aKdxwqUaOLCO36KcVsMrE7JEA>
    <xmx:69hKamhh-nz6ajMd6Eu8_GzOIbnFbXVkWrwRRMODeGE6vN77JSRWWQ>
    <xmx:69hKauZfBzR9wy6iFaKp78L05kkGJEjSHLR8XxJwO26-2_4nbJkbMA>
    <xmx:69hKavChuoYVEgnVkMW2p_nWW6tZwempas8E6aFNg5Cm5d6Z277a7ZIb>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:21:29 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 11/14] nfsd: move some code out of the d_really_is_negative() branch in nfsd4_create_file()
Date: Mon,  6 Jul 2026 08:19:43 +1000
Message-ID: <20260705222032.1240057-12-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23006-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C78970B9D6

From: NeilBrown <neil@brown.name>

The benefit of this code movement isn't immediately obvious, but it will
make it easier to switch to using vfs_lookup_open().

One immediate benefit is that common code in the d_is_positive() branch
can be discarded.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 73 ++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 45 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a34731e1714f..7bb476311195 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -217,7 +217,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		.na_iattr	= iap,
 		.na_seclabel	= &open->op_label,
 	};
+	int oflags = O_CREAT | O_LARGEFILE;
 	struct dentry *parent, *child = ERR_PTR(-EINVAL);
+	struct path path = {
+		.mnt = fhp->fh_export->ex_path.mnt,
+	};
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
 	__be32 status, create_status;
@@ -237,6 +241,24 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
+	/*
+	 * For the EXCLUSIVE modes we do our own uniqueness tests
+	 * so don't want O_EXCL.
+	 */
+	if (open->op_createmode == NFS4_CREATE_GUARDED)
+		oflags |= O_EXCL;
+
+	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
+	case NFS4_SHARE_ACCESS_WRITE:
+		oflags |= O_WRONLY;
+		break;
+	case NFS4_SHARE_ACCESS_BOTH:
+		oflags |= O_RDWR;
+		break;
+	default:
+		oflags |= O_RDONLY;
+	}
+
 	if (!is_create_with_attrs(open)) {
 		/* No attrs to check */
 	} else if (open->op_acl) {
@@ -294,27 +316,13 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		status = nfserrno(PTR_ERR(child));
 		goto out;
 	}
+	path.dentry = child;
 
 	if (d_really_is_positive(child)) {
 		/*
 		 * open the file so that we consistently have a valid
 		 * op_filp.
 		 */
-		struct path path = {.mnt = fhp->fh_export->ex_path.mnt,
-				    .dentry = child,
-		};
-		unsigned int oflags = O_LARGEFILE;
-
-		switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
-		case NFS4_SHARE_ACCESS_WRITE:
-			oflags |= O_WRONLY;
-			break;
-		case NFS4_SHARE_ACCESS_BOTH:
-			oflags |= O_RDWR;
-			break;
-		default:
-			oflags |= O_RDONLY;
-		}
 		open->op_filp = dentry_open(&path, oflags, current_cred());
 		if (IS_ERR(open->op_filp)) {
 			status = nfserrno(PTR_ERR(open->op_filp));
@@ -323,39 +331,14 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	} else if (create_status) {
 		status = create_status;
 	} else {
-		struct file *filp;
-		struct path path;
-		int oflags;
-
-		oflags = O_CREAT | O_LARGEFILE;
-		/*
-		 * For the EXCLUSIVE modes we do our own uniqueness tests
-		 * so don't want O_EXCL.
-		 */
-		if (open->op_createmode == NFS4_CREATE_GUARDED)
-			oflags |= O_EXCL;
-
-		switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
-		case NFS4_SHARE_ACCESS_WRITE:
-			oflags |= O_WRONLY;
-			break;
-		case NFS4_SHARE_ACCESS_BOTH:
-			oflags |= O_RDWR;
-			break;
-		default:
-			oflags |= O_RDONLY;
-		}
-
-		path.mnt = fhp->fh_export->ex_path.mnt;
-		path.dentry = child;
-		filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
-				     current_cred());
+		open->op_filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
+					      current_cred());
 		child = path.dentry;
 
-		if (IS_ERR(filp)) {
-			status = nfserrno(PTR_ERR(filp));
+		if (IS_ERR(open->op_filp)) {
+			status = nfserrno(PTR_ERR(open->op_filp));
+			open->op_filp = NULL;
 		} else {
-			open->op_filp = filp;
 			open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 		}
 	}
-- 
2.50.0.107.gf914562f5916.dirty


