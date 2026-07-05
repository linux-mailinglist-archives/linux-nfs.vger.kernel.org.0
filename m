Return-Path: <linux-nfs+bounces-23005-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LA6cFgTZSmpiIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23005-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A98C270B9D1
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=cQosEkGF;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=Uq7uN57o;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23005-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23005-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10733011591
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E072253958;
	Sun,  5 Jul 2026 22:21:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3547F34DCC8
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:21:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290089; cv=none; b=QL6+21m/vQtG1/AemcqZx4tgD62gHxvro4laVUFYF6+2ZLXiOmG42/wlm7hs8wG207leW5/+q9oAqXbvmf/luvbrFHvR3jU1jgRT0BpNPIGnIUNT0mfBPJb7SDa4jrb4xTB3EWGFN0IIZI2c0IPWrslIsH9Xsu/uXMPGSYv89bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290089; c=relaxed/simple;
	bh=BBQvco99D7DN7MRaj8pDDiPhIro6Ymkz+OlQZWg2laM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3t3rUy7ME14MGBCL9laJkV+uTjUifRjjsaYAydd+Eedo0tq+5Ia9gRa/8qo7jPc8Ep1FggjqZO7KopEnvtj4xPj3b+AGMUbwsZaz7OXxEQ8vOVtO6ihGM4FYy34eMdGuEhffQ2XCwNWaPi83Udso3CC3c4+WKVGvMb49Do64BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=cQosEkGF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uq7uN57o; arc=none smtp.client-ip=103.168.172.156
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C66A1400045;
	Sun,  5 Jul 2026 18:21:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 05 Jul 2026 18:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290087;
	 x=1783376487; bh=rFKTDtAoM6V9i7JLJOq+6+Ah164GFWu3Bn19e5agFxk=; b=
	cQosEkGFLuz0dGxNWNeUVdDC2AUVHfBwHcQE3zxC2GpKUtWzRUXK2Ru9Q9/eoFkW
	OPiGuzk8E6vpqaZgwN3UziVlZrkVqPZWO3i+I6o7zZ6vmhGpDoeN2djUeIgRAJ0U
	IWo6U7aRX7ioVyPptsCS2jw1XeimICxMcf1eGnTnRdYGeFmOfflHLag29P2V/6rr
	0KJ4RdHsEhstutIPziwc7MOsGprWTVhcnBYKz4jsrW639gjANGR00QVq7A/BmGdw
	CQ/0W8J8K1AhhdKSsiMfL+YMjzS+06tTeUE/wJ/E46J0I9iRpdZFiyGIuzHYCYht
	UJlJdLxolXzt1bSKVeK4cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290087; x=1783376487; bh=r
	FKTDtAoM6V9i7JLJOq+6+Ah164GFWu3Bn19e5agFxk=; b=Uq7uN57o2IEQQDB2/
	WVuI9k5mc9mnmRifgbFkdbp8Lm1a0lV9lmKjLr3HhGDwAzQkfWnX6XfjlPPF4Plp
	PVe/EEerSK+89nUu2WxKaGp/I9Ey8duNMWunvlL5+5P50bwd5+1CwUKL8F5WIyGB
	ae46ipAQoR5WzzP6y5gllNJSm3vywn+lJAhn+uwgCWngmnm8N9viAysf6UdViJ16
	OLgOwUeMx7lUDs0hf8rLtyJ2mbYc1HuAFObQPl6OuZXEw1/PLLPgf+j5VOO2v6FN
	6dt7Ybb6McJuLvbCp3pWS+e2s6exuLCJga+iwB45V2BNOetnb17RRGt4ZlQ5g/py
	tFUpQ==
X-ME-Sender: <xms:59hKaluwajtoMEnrco3tlGwh-diK8MFGeq4KAIn7jzKfy8tuyvGiFQ>
    <xme:59hKaiIaNJzjn-Uq59nlyG-dNsT_mcYMAXEXfpzeS9wrbdcg6SPxmq06eNe2Jv2Bx
    CcGz6s44hwt_RnGxf55ss-6rqirperJFle92p01m5vb9R2xzHI>
X-ME-Received: <xmr:59hKaikHxS1Gcl1qEZdiWD3lWx53i5obZi3rtvqe-ABvOIJtInCN9c24pitIgUxIrV13sFVksGdMdhraHfvuQpWxF1XOJC4>
X-ME-Proxy-Cause: dmFkZTErMAdh0PO5/SmQA5niNOZljaHMTkfhLKVcydPCRuIYEgeCpwNzmZMjkoUgxqFWu/
    YMfLhryAuXf29i+O1RP6N9SNW1cAwyvbrnLX3Q8tEs2vpIyBAQzdN6QpRE9F5PYiNP/Ai6
    FdTJG7jvkY7lFiaf9jq2XJnBFzx3ycbYPXka/Jw5locHtkKiv6Wmjja0airzqO6OOdos3M
    v8djOo5IAnHKx49LFvgO7ipfCT6lPV3+hcDbBk14OrlslPtYDRtHJ3nPSQUaI2ZNaJNiIQ
    fMIwxYC+x1amSEvRHr1JmsaI1HhndEWvkl9fQmmFoR7262jRSTDd8zeYh06rmyzCsM9gpZ
    MepzCHVqkDuiWTekAIsAVFfcTHSvPAUVRwDRuSnr+9X286MFgTXAl7rfedmshEaWmZwAje
    tkndmrw7BnBpUszClJgGIdXsyKihNeKBacHBudrUIiO4dVRHyjsCVaZzvd/DdlXMuY6AnB
    5wq1LufWZmU6J8uN2v3P4nv3oKM0GsAWY1v+0fDIOW2usWvBlPGfACMusRQbyoAjumSVx9
    QmzuMwSLtVB0WLI9LRckXf0zPl3Pa+/nWdv3FNkSxIDRIUmO+BProbdvopvouI6x8G4+Ug
    xm5znELAZC77u9/alSTLs0PTT6mVA75v3Qun43js+LpW6gq8b7YhVNEzAKrw
X-ME-Proxy: <xmx:59hKajJSDI1lOzLrI3v0KER-jnIEJKAVNPl7xLEcJ43VviaEJUYTBg>
    <xmx:59hKan66pajIfoZpvxLGIZaWS0jfhPT5c5acEY3cJBT9PYzIc0l9Vw>
    <xmx:59hKan26dXPr4YqEpM_qiZWyeDP7Tw3cWJvq77F_s72h3ya-2uSbHQ>
    <xmx:59hKatcr8U12_OQAUQMcS6ht0gCTlwPEKzerKxXD0ipNaaZ7OifndA>
    <xmx:59hKajNhtWkwWjABXePeOILM3Jto75ocYfDNkesGZqIVxGM9T7mioRDN>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:21:25 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 10/14] nfsd: open-code nfsd4_vfs_create() into nfsd4_create_file()
Date: Mon,  6 Jul 2026 08:19:42 +1000
Message-ID: <20260705222032.1240057-11-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-23005-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: A98C270B9D1

From: NeilBrown <neil@brown.name>

Having this sub function separate doesn't really add clarity, and merging
allows for some refactoring and ultimately using a different VFS
interface.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 76 +++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 973beda7f161..a34731e1714f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -201,46 +201,6 @@ static inline bool nfsd4_create_is_exclusive(int createmode)
 		createmode == NFS4_CREATE_EXCLUSIVE4_1;
 }
 
-static __be32
-nfsd4_vfs_create(struct svc_fh *fhp, struct dentry **child,
-		 struct nfsd4_open *open)
-{
-	struct file *filp;
-	struct path path;
-	int oflags;
-
-	oflags = O_CREAT | O_LARGEFILE;
-	/*
-	 * For the EXCLUSIVE modes we do our own uniqueness tests
-	 * so don't want O_EXCL.
-	 */
-	if (open->op_createmode == NFS4_CREATE_GUARDED)
-		oflags |= O_EXCL;
-
-	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
-	case NFS4_SHARE_ACCESS_WRITE:
-		oflags |= O_WRONLY;
-		break;
-	case NFS4_SHARE_ACCESS_BOTH:
-		oflags |= O_RDWR;
-		break;
-	default:
-		oflags |= O_RDONLY;
-	}
-
-	path.mnt = fhp->fh_export->ex_path.mnt;
-	path.dentry = *child;
-	filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
-			     current_cred());
-	*child = path.dentry;
-
-	if (IS_ERR(filp))
-		return nfserrno(PTR_ERR(filp));
-
-	open->op_filp = filp;
-	return nfs_ok;
-}
-
 /*
  * Implement NFSv4's unchecked, guarded, and exclusive create
  * semantics for regular files. Open state for this new file is
@@ -363,9 +323,41 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	} else if (create_status) {
 		status = create_status;
 	} else {
-		status = nfsd4_vfs_create(fhp, &child, open);
-		if (status == nfs_ok)
+		struct file *filp;
+		struct path path;
+		int oflags;
+
+		oflags = O_CREAT | O_LARGEFILE;
+		/*
+		 * For the EXCLUSIVE modes we do our own uniqueness tests
+		 * so don't want O_EXCL.
+		 */
+		if (open->op_createmode == NFS4_CREATE_GUARDED)
+			oflags |= O_EXCL;
+
+		switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
+		case NFS4_SHARE_ACCESS_WRITE:
+			oflags |= O_WRONLY;
+			break;
+		case NFS4_SHARE_ACCESS_BOTH:
+			oflags |= O_RDWR;
+			break;
+		default:
+			oflags |= O_RDONLY;
+		}
+
+		path.mnt = fhp->fh_export->ex_path.mnt;
+		path.dentry = child;
+		filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
+				     current_cred());
+		child = path.dentry;
+
+		if (IS_ERR(filp)) {
+			status = nfserrno(PTR_ERR(filp));
+		} else {
+			open->op_filp = filp;
 			open->op_created = open->op_filp->f_mode & FMODE_CREATED;
+		}
 	}
 	end_creating(child);
 	if (status != nfs_ok)
-- 
2.50.0.107.gf914562f5916.dirty


