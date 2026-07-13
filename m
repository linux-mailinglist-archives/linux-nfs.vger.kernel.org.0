Return-Path: <linux-nfs+bounces-23296-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YyjADo2EVGpxmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23296-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:24:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A722747831
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:24:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=clIjLjLY;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=Ec17qBtF;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23296-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23296-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 780C730247C6
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706E35FF6C;
	Mon, 13 Jul 2026 06:23:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B83624C9
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:23:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923821; cv=none; b=nKHlvt0lqy7JyEZTuNCShRaSE10WSX4dwU6IXaISTXGaM4byACpGM1bL7C5sKL4JBCiYO2DyLH34iVpoVjy4UxL/2yJ+n6HpYjsZiL7wITf+SpB0ZWdZDbwuIO/A7IqLUka+48rOWNtB4i6P1Y9oPRqe/OoQhmODEvqgNirMdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923821; c=relaxed/simple;
	bh=QL0TAkjCAYdQ0HxpJHUS23RBa9MMLHOK0h3iyx4AWhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9yHqS22REW3YQVw7nGOgj0uh39Pm8ozws3VodCX5sS7rSnp/5yOzp+r3hj6Kg6YI8hZvooxpVpkQCmbPMSoAPwuv8QVvj3Lszaqcpq2iNKnYJGTtMcjMXmjONf1VlsDLZkvkUCTN3z3l5+8oHRfhKujHvUpIaCRvIrrSQpnFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=clIjLjLY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ec17qBtF; arc=none smtp.client-ip=202.12.124.148
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2EE921D00037;
	Mon, 13 Jul 2026 02:23:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 02:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923819;
	 x=1784010219; bh=CtEurziv4dmJP7k1AI9BOpEAYMEEQuh3Bv8XKA/peGE=; b=
	clIjLjLYW6NTUxFv7TEHgwQS/dyYQSm7/FdBoog1/aCDsfXoLCOHPitLjAfSJixL
	0d51kPqiZQOQvgedxbC3TSEYN+4AFJOwmjkxVuzEWg9RX319yOadTMEq3kgb1t2n
	MPM8yPHXQnb0VOnhug4tq+3CHQfqvSGHORLgjh2gOUkrDGXhVnET4ug+P3euJhhO
	A9qXBP5St5js38vvBFpsqVboDngtKoGaa4XnOJVt7PYTdhwHR+Ww4THqc9G4udpD
	WIcH0Ljz/ePjf58bBrIgkUjk/pP3yWJ9ulaqbU8lZONrWYA1k1tZkfKGR8KbB/Gu
	BHd3o2QmJaHpQ9jsFQyRRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923819; x=1784010219; bh=C
	tEurziv4dmJP7k1AI9BOpEAYMEEQuh3Bv8XKA/peGE=; b=Ec17qBtF43OqMoEHy
	o/2Zgs3cd47AjbDPMzwKKdpXfuhWXfitz8ZMhjBAM6PjongZV5ESJ9g3AjUlEFSf
	JuvIZlKCBsx04t4YHzn0mdpb2WNXNDTZVEVLEa34j+aDUYlgsgqb1qqJh3yN6weB
	XFuiX6KByAZm9VvyvRg4ll8O/odaPB2yu8ZxcEL6N/SZWUfkazOYku2pBsedOb5x
	hk9I5gOCZ4h9HhnhjYfTpvwTeQ8TZJCkeCCtrsZNzem1bN5gRe6VB4rDddIPCqFM
	2nfKsJ3f/UHmOu9dAT+f6yyWFKW4pZsfh9nIxWwmeBfjzAdjaJR2/YP5WI2sGGlv
	zWDzA==
X-ME-Sender: <xms:aoRUaukYOqIoSw-Z-CKg-P6oskoBTy9pGoS2CwQVQyU1Ev6fMGCXzA>
    <xme:aoRUapgyW0EgA3UMq-peirsHs8PLQTh7K8_VdudTbcgPK-bc7Qlp6cIFKiMUNGz0C
    YIx9ET2M1WC2uzd3vZUmfdLfG23sUybbQ-xQYwny_YH9y6ZCq4>
X-ME-Received: <xmr:aoRUamd1LICnB5GZwh7fyIL5m6mitn-pIQla9ugTT4TeCdvwQ6XE7CQIUx81GSeSH_kHeMbRBzQVCyNbHO9oAfbtRbKwuew>
X-ME-Proxy-Cause: dmFkZTGmKIeXgeiDMHGC6kOzubAdf/Hemd0/b8bpy5s9p3wj7kq9tvae7xOTLsi3sO9Asy
    rLzqsYz8SQGdBMUO6NMbl6+nBA/yUPbyh4J5EN+rXJ7kXw4zoKm3fJRez79xdYM3k5Rp8h
    67KxgNA8uwOc3Y7yiRCAr6cD3zkjyMbkxEkhKGR7JeeZ1OUCOSkTaJr4g8tYKOzhhaH//v
    De1kNErXz3EF4HKVdZNjZSEYk6fhxCyZFXZxuu1vbDbOnb+AZxuNRSNXlGIsWoBw7KUpkt
    1r+h/UEJlQMvkx2nyQUPGIS7PhqzU0Qghj2GuIAJeyS9DnNYHtQvfa2tKsX/BWq4c/kOb5
    VhMvc/Y7QmCGsYRwN//AhZ8UkxQsopGoDaAZNlzDE1zFaSut/dGZYPAZUSTgno80pAOtH0
    xxJ7mj3WTWKIzm+itRjFRYiTyvsApaz8oMAtudpfei2Kytaa8xpnsbnk43L4i6N6J7YH8E
    iu5YRu+wzwTQvebZZXERrTCl8Y2n/NzHtbYDprk7e8dINY59Nu60a3WzHkQRaOIxa8sbUL
    IaLzETJpD5QDW8kADiO2qPORA63md/5i4hkinY2KDt07+C75bkjKJ/KBJKC5hdoTQLsAd9
    9hLv/pYg3fH5559lj5vEyD3mwiWJF8EyqFJ2N+wfm0YwZ2Odo+zxN0XL4/BQ
X-ME-Proxy: <xmx:aoRUapj2SfUY7swNcR5UX2jQHswfGhAal7v6LG-pp4bDdQ_4MXkKHg>
    <xmx:a4RUauxdoG5Rw7BsE9hk0kSXXiMuv50N3_rLWNI19OnvI5pWQlAKGQ>
    <xmx:a4RUalMkavsmGZ2npozvW-gYyBIGC4R-HIEsm3qtZatUCli50nV6cw>
    <xmx:a4RUavV_YO1wkJ2jvoeLGATPlZ-vnuJl8yZnDUB-sLjfOQK198kxUA>
    <xmx:a4RUakHHWYlK0fHDhVeErjBhy4sZ_1o3IJvzpNTMi2pGgdjBVt5YX_Qa>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:23:36 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 13/17] nfsd: move some code out of the d_really_is_negative() branch in nfsd4_create_file()
Date: Mon, 13 Jul 2026 16:15:36 +1000
Message-ID: <20260713062219.6399-14-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260713062219.6399-1-neilb@ownmail.net>
References: <20260713062219.6399-1-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-23296-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:replyto,brown.name:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A722747831

From: NeilBrown <neil@brown.name>

The benefit of this code movement isn't immediately obvious, but it will
make it easier to switch to using vfs_lookup_open().

One immediate benefit is that common code in the d_is_positive() branch
can be discarded.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 73 ++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 45 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 32b6c0e507ea..adfc1f5ccd98 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -219,7 +219,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -268,6 +272,24 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -324,27 +346,13 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		status = nfserrno(PTR_ERR(child));
 		goto out;
 	}
+	path.dentry = child;
 
 	if (d_really_is_positive(child)) {
 		/*
 		 * open the file so that we consistently have a valid
 		 * op_filp and consequently a valid ->f_path.dentry.
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
 
 		status = nfsd_check_obj_isreg(child, cstate->minorversion);
 		if (status == nfs_ok) {
@@ -358,39 +366,14 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


