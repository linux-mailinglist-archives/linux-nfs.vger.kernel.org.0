Return-Path: <linux-nfs+bounces-22154-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGz9MdEuHWo4WAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22154-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:03:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A31361A9A5
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C7663018787
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC203491D0;
	Mon,  1 Jun 2026 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KeRg0/E8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ksks0v8a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49496347BBD;
	Mon,  1 Jun 2026 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297333; cv=none; b=XZxTdFNqRKyIN45hikxnxQHCuWzopgQgR5wp5MbTqwOF0j7B+Q+TChLwKQj3hb3FY5Rh2cGRSgOUAfflmxRPu1ETNRTb87OG0ZLn6rGFVh/ek2pJ1/1zgBdoFfeXP6oBhbFyArs1jedMLzENGXENvlhotfqjtM9cFwVxINH++0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297333; c=relaxed/simple;
	bh=c0oU/lyCCFA/wAV0w7iVIy2K09e+ih8+n1e01J1+7uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIhqzzd+6izEBslnuOUWcfD0nuSWBk/k6A0OqAyNrvhYzD635bdhRzEZqKQDls11j2p3hYlpptuJ16exKqr/doJmMnlKCAjspls7E4dUV5pQLoS2ELoZiC2TaYeaFgWuK4Fy1Dakst32sWtCMsN4nniTt7kqnyty1dXQrb0W7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KeRg0/E8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ksks0v8a; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 92A2DEC0064;
	Mon,  1 Jun 2026 03:02:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 03:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297331;
	 x=1780383731; bh=O4WMb2YgUoourN6IkOvHqZeXaKDvIpyfKljNaUFNSgg=; b=
	KeRg0/E8/V+WT5qNZnqeN268QPAfDII3dMJ9WZRf/Jqd4wH9iC9GgDaJDoQO7r1m
	KGxonyI3TGzZs8XlXQDHXcKclSF7Fqi1VhNJEDy7yzgw9eBM/6QTNqOAkih4koBC
	fHS40Vn8yUu/bt8jaYPSHLKl/yU8Y/T/LxARQPMDA1nfYN5m3b2Qq6nf0Nn6jVpk
	+yeF8wCNjwLtfhgbwD/189f8ZH46oNGOJVvzG+9E+8CG2SfBj03HBHLu6ZGUDk0U
	JsNlEI+/FPjGiYEAVDag+mj/quYZcWkw3YIxHXixFo1b/wDPeorT7WDHF6UZcVFY
	DfcWUHNQec8zvq5sPzsvNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297331; x=1780383731; bh=O
	4WMb2YgUoourN6IkOvHqZeXaKDvIpyfKljNaUFNSgg=; b=ksks0v8aYIkwEneH6
	hZ6N01ehBYrENR2lYmT/hKa6z1jMu5pGmzut8rbmz+Q1Ss6KJ1pbHx9QsY/e9zqu
	metJerV8YMRmsTyxJQqnsYiCkqa/VbuWst/DjJ6Rz3HU/NhhmJbSWs9KlnZU8Q7z
	cbje3MA7L7u8RvtUlYgMqXfu4xuX/b4NPCHrTljdpurKDVOWOoi706Wjzc83zRx5
	6ZfkkPsd/8DSWh8+A5+9DFW0cAvy0OH4bQCgQeCuBHdo+7eHJr7vEovQRAll+O5q
	DvEGyAO0JWAxgQw6sFKHCfs7DLzl/dl8MB/McTHBYYz7PPJo8tSH2cRuUp7wiNU+
	l2oFw==
X-ME-Sender: <xms:cy4damwM7n2LnX6IEx2ZJutZlzhdmOWhwZ_ccub4AxJ1LO4O3zMQSw>
    <xme:cy4daqdihlsyYN9so1X4hXW1r1QjpnpLOiTBdXqS3PJSUH4oE1pSdbQqOsAcQMASZ
    aKbrb8yWqf1bwKYXRim4a4c15LLoTgmLn_qKWITCfI7BS9CVA>
X-ME-Received: <xmr:cy4daj7NSAJIWb2KqliNB5V2_-xoFfrXmhXQ_HOIlGsfLP4FoD3Mfbec-EGmPRf0llsj3ip1IMzs4R4kFmGW3R_Ms0f_OHY>
X-ME-Proxy-Cause: dmFkZTEt19F0SWOmsOMHfhjin8Ucu2EdGVXq1OJEBJ7RMmCKkCUMWjL3GkdDCaMKp3bMja
    U3fB97RKZtCzccgpgDvEVpFTtkH/0QZH/WFRMydkNuRo1IyEwrz45xGk1pShzk7Qcf2RtH
    zLZdS6y4HFTT6o0W2wkWMsi2PNuODiTCFgwnUWcs3amTJNRHn0/74gonMz8GwckD4TUV0t
    XES551bsx7Qe4R3x/ilu1ujkH3Rm2TcmRgjfcEIC0W7ypNyGxvpOn5vcjUuU5oGlaMLMdA
    ULdj97P8LVYkTTgpMivIbo/bhJ7vr3oTvMUS3uM47NT+1zHPUXL1ByKoBaQRE7sKGyhcRy
    A1LTnU0uBN3w9K1ZEMo+ZGm4E63GLE3puByTjp/5Z7rVMS3AXTi+fLN+N/vjCmr0PuFkud
    2Jjg5r6ijxcHF+5/1XB4kYIRXoA8MrT/HoBcitWFxnE1uQ3zo2K9u1rU6vrOx1Iv0hktjA
    dJMHY+c4NonKDtLq85dnX6qzv0kkstv9nFrJplUOpEp2UsMxPB4EnTpJzQOWpgYK2MnBqD
    4Q/Zcf6HuhHlpUf531zaKj9RJzC7A6pQ3/X3pMJb8QcVWNjrtp2ajvrg8jQnez7vKtxtfi
    hTNf7ofOUsLsvepStkGGZS9S9X3t5bhLFQ/C28SGa7jpLZtUiOTjpOhoY7fA
X-ME-Proxy: <xmx:cy4danKdBb0p8jY1Qvj4EZbQ1kf1DvcqVli8aLT6kdDEBAcXBYFhxQ>
    <xmx:cy4dajy5Pn8b5orZFfY-WKOTftB0Og7aKZD7cSJu7EMAzdF6UUQQTg>
    <xmx:cy4danKZVUrjLhKhgvS_mPVMro2fckSbl-LJ1F8mlavvHT5erglyXw>
    <xmx:cy4daqXcMa8oRbxGVkvt-3BAOK_OgPrAe79d2OhevPD0ZLUPgxWkGQ>
    <xmx:cy4dap1WbyyCfzfNZ-pKdPITMLEGEiB92gynlxpEgDJoUj7r3LZXPXsy>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:02:08 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	"Jori Koolstra" <jkoolstra@xs4all.nl>,
	Benjamin Coddington <ben.coddington@hammerspace.com>,
	"Mateusz Guzik" <mjguzik@gmail.com>
Subject: [PATCH 14/18] nfsd: move some code out of the d_really_is_negative() branch in nfsd4_create_file()
Date: Mon,  1 Jun 2026 16:38:02 +1000
Message-ID: <20260601070042.249432-15-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260601070042.249432-1-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,xs4all.nl,hammerspace.com,gmail.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22154-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 6A31361A9A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

The benefit of this code movement isn't immediately obvious, but it will
make it easier to switch to using lookup_open().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 49 ++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6a564f1dc2f8..03eb93f696f9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -218,7 +218,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
 	__be32 status;
@@ -283,6 +287,19 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_atime.tv_sec = v_atime;
 		iap->ia_mtime.tv_nsec = 0;
 		iap->ia_atime.tv_nsec = 0;
+
+		oflags |= O_EXCL;
+	}
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
 	}
 
 	host_err = fh_want_write(fhp);
@@ -295,40 +312,20 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		status = nfserrno(PTR_ERR(child));
 		goto out;
 	}
+	path.dentry = child;
 
 	if (d_really_is_negative(child)) {
-		struct file *filp;
-		struct path path;
-		int oflags;
-
-		oflags = O_CREAT | O_LARGEFILE;
-		if (nfsd4_create_is_exclusive(open->op_createmode))
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
+		if (IS_ERR(open->op_filp)) {
 			end_creating(child);
-			status = nfserrno(PTR_ERR(filp));
+			status = nfserrno(PTR_ERR(open->op_filp));
+			open->op_filp = NULL;
 			goto out;
 		}
 
-		open->op_filp = filp;
 		open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 	}
 	end_creating(child);
-- 
2.50.0.107.gf914562f5916.dirty


