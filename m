Return-Path: <linux-nfs+bounces-22148-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEBkKXwuHWo4WAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22148-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:02:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 439BA61A940
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3F9030022D3
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B483806CD;
	Mon,  1 Jun 2026 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nQ1jrpIK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZDlj/rB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260D331209;
	Mon,  1 Jun 2026 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297302; cv=none; b=hnEJuYzP/ht+k5/adP1gMX1lj9/gcSaVcE8JUV186EPGvqXiPHK2eRnfYKeKCbPkTXu/JFMjrq+RQ/uzkhAqEO/J7v35IVcjL4h3YoGl6tPUltLdZ0giLeLUUafYWk8nQr+jhp/8vPZHFDIVQAcNuiVu/s0iIMIbGNQ0GW132r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297302; c=relaxed/simple;
	bh=5nUrab5bZ3WtGa/gKd7FTeYHib3KDt9JarXEYQ6Lbko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vf8UxsntTWB55LKXuExryNiOuE2nneJVs/1+XmYnZrnJ1BhAAMlKIylvDcqfrmFcyx7VaPhTxmbpWoM2vKRVQ45+sCTmZSKM7Xi47IqMlXUOvuj7AfNKyQmrHe58B68zymwqWbfU0hGtd+ENo9x3DSqOCogNUMweS/lJZtWc+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nQ1jrpIK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZDlj/rB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F384140007D;
	Mon,  1 Jun 2026 03:01:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 03:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297300;
	 x=1780383700; bh=D6RX2ZWXeupkYZdqlqqXAZ1LB0sE4pRfYy10qir8fDU=; b=
	nQ1jrpIKG/xnLwsLUshCo2m0VA7oGxkBbzbMFzIIzEQngNcETph+7yGjBDGPoG9t
	5D3ioUIrDaYk+dNCvQzYhfgjUTiW6HraZofacGmXOXrp0jszKn03TgXHc5p8LTf7
	nYNbyCpedzS2oekrtog7TQEGHi3fv6d0EEiS7w0Rd7aofMThWzdV7EbTLy1ELRsx
	zW4XqHVQa2Zr9sN4h3Mknn+vOLPZQZZwJuMeZ3TgizdBVoCtmH+rfSWT2wD5b0i4
	iJUwLBolknSQCLyEcV6RXNhprcl6TNaW62uFBgJUWCkmgu49o39IxJt43gwDkMVu
	49oT0Sy5x+xNHmDuqBO2nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297300; x=1780383700; bh=D
	6RX2ZWXeupkYZdqlqqXAZ1LB0sE4pRfYy10qir8fDU=; b=dZDlj/rBJwpN5xXlA
	iyE26QpP+Sy05lz65pkJ7Hq+mT0m1DZOA6MVdSdUC/1+2YbODmb/RiXto1M8YG+t
	c9YJF+yukwjXgc9M+SsaQW5M44rPYrqaKwLhvy4Lo/W94S+22glvXMhJBpKrq6aN
	hdFjr+7GzOsUSHkXT6u1QbGAbRo/64o3uJboTtSFrqKwkqqUtjtGjYlAyuBTwN3h
	dTvvyOi9RXFJE1dXbeTKYR41HZMPmBxTny3BOgS1UFQd7JLqimOmn/k4DnjaB0eF
	VBvE3WeXv1AWH0SHXaTX5z6PwYWJokZeUU4YkgKYoKUgq7+1vfTy7nGD6sFVjwt4
	dTycg==
X-ME-Sender: <xms:VC4daht6m_5sqqnzNbBTlh1EKahAawNUI4fxGS2RhS1kDNfNIb-KDw>
    <xme:VC4daipQPdXG_hysz-8KnJvRhySWGWqU82EAZV5y1aAdyXBJ_I9BpfMAIdLXQ_grG
    k1XQu5yznpp6ELtCpSoQJjeACpyequ-k6GLrapoSB8Ka4Q>
X-ME-Received: <xmr:VC4dagWgU72OLf__gglE6zZQJAZ_funxP1LapFQz5iIzYrPQ7RB8HiHyTAj0McmvdWvlLKf9OlW-DjsbYBOrFnbip7yyEKg>
X-ME-Proxy-Cause: dmFkZTF/0v9QLWqKGcDzcPcERvNp2OuvpaLQnhg1kVCZ737817GhipXMBb0AeZ6JBhuU4x
    GJrqzBUJbWPaZjirZQ5Vg29YWKz7XvSof4yGflEzDHc/NhOtmChI7M3NC+sT51Q2HtjBGA
    Ox0luTlKNNxokRBhJ+iYrXPeMs1uw5hg7ApCBnw81P6jLjTjx+DLUI462DuvIzBep4eqUb
    kcu9GFFH1pkG2Mz0R9MDbHL4NVZuF7K1GyrsyBBUmwhVfQ9DU0KmxDI1vM0MJ9YttzwuX9
    8bZMaqp0pRg8egOeVEhrVJC7lgaMNtMxPQ7Kv7qmvLuuQopt9LMKtybKT/rZx6hjH7WBQB
    M7OZ69atycfFOkDDql+h9LU0hq5v84ehvNEGNOnVAXXCWGyNZDcsFaoWAfWNe2uL8yxTLo
    cMg9ZndAMQM8r2RYiecg1AEFsvGAWYOgg8RPnPDn+4mEHliehvy6xohV8x+uRUu+XGkC32
    Wn/IttZ/iKpEUljyWYhD3w/EeAAQVvsXmqMKSTom+uY72XwhzeNc3PpjTZbcwoQZZBzYHe
    wjbwiwqivezCuAlg3+bAp1puPGm3MkOwKhkjGDBH3WP74vb3y9mAWbH5mXmut+xNBZRY2U
    7ndlfnEdLuiauGx1CtPmRK4MRFd5fgcAH3jloaKAgDdaSUHlBxgqkbiEc/Kg
X-ME-Proxy: <xmx:VC4dai0mdPuKZlhuFOkYGFLgbvYaUmGDNHm8K0Atmfhzxe69xCmyzw>
    <xmx:VC4datvyipn8_PQxHHYeIe3vgB_Jim99Nt5ba_HD50xCeWo2h2YcbA>
    <xmx:VC4daiX8IvlaX__QmPwQSA47y7p0TCsyOyn5U8-tdSAiytGh0gO9KQ>
    <xmx:VC4daty0VdoE9nvllbfGKAl24HpfD9ogHXKWB49IqTTZlkUn-i9Ilg>
    <xmx:VC4davT4PytdN3KPLGV1V6Eq9Gc52Q-QcLgz3e7qc8b7jpxzBCJw3w-L>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:01:37 -0400 (EDT)
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
Subject: [PATCH 08/18] nfsd: move more nfs-specific code into preamble of nfsd4_create_file()
Date: Mon,  1 Jun 2026 16:37:56 +1000
Message-ID: <20260601070042.249432-9-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-22148-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: 439BA61A940
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

Do NFS-specific prep before interacting with the VFS.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 61 +++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5235db3d6a96..b798939821d2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -270,6 +270,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	parent = fhp->fh_dentry;
 	inode = d_inode(parent);
 
+	if (!IS_POSIXACL(inode))
+		iap->ia_mode &= ~current_umask();
+
 	if (!is_create_with_attrs(open)) {
 		/* No attrs to check */
 	} else if (open->op_acl) {
@@ -289,22 +292,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		open->op_pacl = NULL;
 	}
 
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		return nfserrno(host_err);
-
-	child = start_creating(&nop_mnt_idmap, parent,
-			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
-	if (IS_ERR(child)) {
-		status = nfserrno(PTR_ERR(child));
-		goto out;
-	}
-
-	if (d_really_is_negative(child)) {
-		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
-		if (status != nfs_ok)
-			goto out;
-	}
+	/* A newly created file already has a file size of zero. */
+	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
+		iap->ia_valid &= ~ATTR_SIZE;
 
 	v_mtime = 0;
 	v_atime = 0;
@@ -321,6 +311,30 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		 */
 		v_mtime = verifier[0] & 0x7fffffff;
 		v_atime = verifier[1] & 0x7fffffff;
+
+		iap->ia_valid = ATTR_MTIME | ATTR_ATIME |
+				ATTR_MTIME_SET|ATTR_ATIME_SET;
+		iap->ia_mtime.tv_sec = v_mtime;
+		iap->ia_atime.tv_sec = v_atime;
+		iap->ia_mtime.tv_nsec = 0;
+		iap->ia_atime.tv_nsec = 0;
+	}
+
+	host_err = fh_want_write(fhp);
+	if (host_err)
+		return nfserrno(host_err);
+
+	child = start_creating(&nop_mnt_idmap, parent,
+			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
+	if (IS_ERR(child)) {
+		status = nfserrno(PTR_ERR(child));
+		goto out;
+	}
+
+	if (d_really_is_negative(child)) {
+		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
+		if (status != nfs_ok)
+			goto out;
 	}
 
 	if (d_really_is_positive(child)) {
@@ -371,9 +385,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out;
 	}
 
-	if (!IS_POSIXACL(inode))
-		iap->ia_mode &= ~current_umask();
-
 	status = nfsd4_vfs_create(fhp, &child, open);
 	if (status != nfs_ok)
 		goto out;
@@ -384,18 +395,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (status != nfs_ok)
 		goto out;
 
-	/* A newly created file already has a file size of zero. */
-	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
-		iap->ia_valid &= ~ATTR_SIZE;
-	if (nfsd4_create_is_exclusive(open->op_createmode)) {
-		iap->ia_valid = ATTR_MTIME | ATTR_ATIME |
-				ATTR_MTIME_SET|ATTR_ATIME_SET;
-		iap->ia_mtime.tv_sec = v_mtime;
-		iap->ia_atime.tv_sec = v_atime;
-		iap->ia_mtime.tv_nsec = 0;
-		iap->ia_atime.tv_nsec = 0;
-	}
-
 set_attr:
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
-- 
2.50.0.107.gf914562f5916.dirty


