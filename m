Return-Path: <linux-nfs+bounces-23002-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PEaiJfPYSmpdIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23002-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A4970B9BE
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b="D91abf/w";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="ZF/lI5GX";
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23002-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23002-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02FB5300C90A
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFA9253958;
	Sun,  5 Jul 2026 22:21:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB03370D41
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:21:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290077; cv=none; b=j1DYzM//F55teuPAkBq+D3hda2iKosptlaVS9YB6dTtJqU2xhVSG6k/O6baMkgdzEHUhwmizjoXcqFGW1xQ1SGx8UrElPF+qFMCfXgi244jiAU09C4gPclhrN7bYetXP9KKAN2km5tdoOycTb/1GP7hfddJxcNFl//iOHzjONfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290077; c=relaxed/simple;
	bh=LjaA7tRxoMNXZSuZLCocIks1hHekPHERCXCaq2JF+Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AO+m5vwGySp0Abzkg68MSgJp88OeGXT1RejX1GZnjdshhPyp8KUniAmvjGdLkFW8LLjKKdqnsVWsVyyEUZttaaq19GXoaRfxVPf9ZO1Nj0U/tuoYsjFMuy5rt0YyM86OG0351Yzm2mMBuCPm253QAMXXgzBTKZsyMUjyw79to2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=D91abf/w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZF/lI5GX; arc=none smtp.client-ip=103.168.172.156
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 953E8140003A;
	Sun,  5 Jul 2026 18:21:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 05 Jul 2026 18:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290074;
	 x=1783376474; bh=RW0x477CBA9ud1iNgTzhWJkS6anh5vNFTDiLVYsugSI=; b=
	D91abf/ww19BpTTSdjk8xbMq5Za/jN43TdqI7wgCtjB9l6tg++pmmPndX8N39bbi
	uBELDUQKmpMzZhjB8kGMrn0mnOTUhpe7+UsfB0iV3U1X9d79dYdP2GS09ow5GJGC
	hTrKuR4aYaVeKtFiFx1OrG206uHCIFHGFQ+3ryqh2qgLNSxlgcjL7meBybNzDnIC
	2MLfF5OBF4ztrzdHsD/b1kdkCWC/SzxIenqSBcJ0EGPOhyFejgy5rO2+/0WMb9xJ
	vYMLoBtDKY2nzOaZRujVy1cSX85H03s2BAa0TMhWrL4O1EBO1iHxsB3e4kO8ljpz
	xJy93/4R/WWE9nUNw3SZYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290074; x=1783376474; bh=R
	W0x477CBA9ud1iNgTzhWJkS6anh5vNFTDiLVYsugSI=; b=ZF/lI5GXOkCfPU/6h
	i+8kSFABAVKIhFkFfvS83+U8YabS40irBXwLUyMeMmfiplttMMIgbplZ7ek/zPW+
	G8Wc4AL232k/Dr3c0KgNu5/gqGORKCS9552s2w8CgLFNtUTRi+4Q5U66+TQexkA+
	UPHZgNwMYnLZIRpS2fAblXQK5wK1k0vxeCHvj6Lmj3gqm3ChDo00gs251nlSsADK
	yA93viVriZEookBMQtcJWtNIgxDBlEkpNNJRmsH2uz1sZGbJlxvFEINt0dKu/cC2
	8kW+dalBBlpkQdZKUfvwyAVeBrYl/0pLadvnBddv5EiSKw36BzEzN5rYKwLNK0Lg
	mvRKw==
X-ME-Sender: <xms:2thKaiAFC7LOEE_grHppSnGSY1QFIsqJcnpap4R6-EXylx9MuRf0Uw>
    <xme:2thKagMwPSYfyflanDHkjOHRjN3iMmy3qX42pf-yuoxk4jZuHP8UsKJkHKXrkJd5I
    fo0Se25cw-x0Ud_GPkYY1ehxX-lbVV1R47SABvPBBlxcKEfGg>
X-ME-Received: <xmr:2thKavZ9t2YoFM-tD6cE68KduW6B7MBVsVKhmVI-U0rUTFU6sr7l2EckLAPa009jbQEzJhtyftg8wXJmwaFtz2P9JN3RzBY>
X-ME-Proxy-Cause: dmFkZTFSCOFMFdKhTvthIvFGgULWl4RkaecRF7omF4dpVpGrWET9ShlC6lX5NBMdCDCUPk
    6C6D2bLkm5/FTE6fKGGBd6/TQMOpPG0CuZt1d+Hj69Z8HE3evOROGxCsb/pIWrtPO8Qmiq
    2rEAT35orGkWyxEgJQH4gmsexynbNQAySJYv5+a3uqB+zQJzsqA1DKSDMl7aVjji0ccWZL
    KhX1IB8ZlIE387s+/N7oH/2uc+Urotv2yFFbH+AS0DEb2Cv6K2/LYp9h3rvUaeQXmToQ8U
    MABRGmGxWPWPs7Yav5SW70XYb7VAQwrmoa5D7Qx80OWCQSrXpdEj7ZfuAy2ZONHn2aTEUo
    hPv2CgK7iZw1yTI8ZPDK1Vow1P2bwSIe+MoVfA6Sv3Axn0O35lVgZWdOvL9vOmGyoGscm9
    M0kvCWOtwn9OwL/1JegOq8dCpiL1sibzVsyrUdkvLYF04gcdr05pxseOQ6fkzIqYxgekXx
    PlRP25BKbyDwB0Oayoyl+ujqjecmu/TADiTN3E0I7Ar92Tu/SCZP1auznzEpfZQm0OFmHA
    DUVXpN0AqGH/G2CKBmEudRkDN4VjT2up1qKUWdYb61UUNV0xPfD47ur1HaoXVSzs3rhLgH
    rIqbuxFY20JDuSUFgZvHFSWPvvUq1svL9KW0pcUxwVymMAclJDPR/0/5YMxA
X-ME-Proxy: <xmx:2thKansVAe7Qbjil-u5iqvshmZ6jEjgX1tVHMud1BEt0K9xaipOn-Q>
    <xmx:2thKapN2nC0-dPUg1LmlX5E_w9Tt2QNfy4w2GBAoBiQ8mu5IoCRL0w>
    <xmx:2thKam6t2layzGiVJvHZH-5vr813TI_sGaJS-S6Y7iuDol5Zj27AcA>
    <xmx:2thKanQiXcbRNxcZQ1S4mfTFyU8hieY_CGv7ERN9i3BB8otT9SPzfA>
    <xmx:2thKahalNlIhhCXgDEHZ0bTfD0DWJgoB5xZD4oV96gbR59MN3MKRb8bW>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:21:12 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 07/14] nfsd: nfsd4_create_file(): Move NFSD_MAY_CREATE check earlier
Date: Mon,  6 Jul 2026 08:19:39 +1000
Message-ID: <20260705222032.1240057-8-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-23002-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: E3A4970B9BE

From: NeilBrown <neil@brown.name>

We only need NFS_MAY_CREATE check if the file doesn't exist, but it is
nfsd-specific code as it needs to check NFSEXP_READONLY and I want that
to be separate from vfs-specific code, which eventually all be provided
by the VFS.

So move that check earlier, but hold the error status until needed.

The if/else chain here looks a bit clumsy, but it will make a later
patch cleaner.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f59ee074c0c9..95e46c15c5a3 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -260,7 +260,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct dentry *parent, *child = ERR_PTR(-EINVAL);
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
-	__be32 status;
+	__be32 status, create_status;
 	int host_err;
 
 	if (name_is_dot_dotdot(open->op_fname, open->op_fnamelen))
@@ -320,6 +320,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_atime.tv_nsec = 0;
 	}
 
+	create_status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
+
 	host_err = fh_want_write(fhp);
 	if (host_err) {
 		status = nfserrno(host_err);
@@ -333,16 +335,17 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out;
 	}
 
-	if (d_really_is_negative(child)) {
-		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
-		if (status != nfs_ok)
-			goto out;
-
+	if (d_really_is_positive(child)) {
+		/* No creation needed */
+	} else if (create_status) {
+		status = create_status;
+	} else {
 		status = nfsd4_vfs_create(fhp, &child, open);
-		if (status != nfs_ok)
-			goto out;
-		open->op_created = open->op_filp->f_mode & FMODE_CREATED;
+		if (status == nfs_ok)
+			open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 	}
+	if (status != nfs_ok)
+		goto out;
 
 	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
 	if (status != nfs_ok)
-- 
2.50.0.107.gf914562f5916.dirty


