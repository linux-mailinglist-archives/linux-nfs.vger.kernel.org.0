Return-Path: <linux-nfs+bounces-22928-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8DM5JsHCRWo3EwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22928-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:45:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5436F2D88
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:45:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=l1tdcZKl;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=EkU6ftZU;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22928-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22928-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA1CC306473E
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA822BDC23;
	Thu,  2 Jul 2026 01:40:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715629ACC5
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 01:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956423; cv=none; b=uN6Ltz6VQt49XMf3Z8rsfuaNfww40Urbvx6gAOywsAMYkFaVw7RLwzO46CZbFeMwmsJ2aQHyMrZBOEfSZ/0fPs96TsleYtFd3X8ArBngKEwPFZ+sfwB/rDLRTTU4OkXkUB9gNeCw65coUpX3dwvOIISPnJidrCsBYSAAbfz+K6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956423; c=relaxed/simple;
	bh=AjpJwQGjkchBQTKjJAvt/pL1GysowI8yE+91uFnSOag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRFTPxAxnQvzXAaeTSK0PUgDkc5iEgZGx8vtE/XKROj51IwNNNMLgL9MzcAZozdcFnLeWMW4Dkgvg4rpQGQDjUkoauhNYPEK1Zha6BnSo5Wffi9XPInvH+bbev/knEeHbTryfussj5gcWZkhj8PzTASDYNr/A26fMAH/WcK4fmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=l1tdcZKl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EkU6ftZU; arc=none smtp.client-ip=103.168.172.147
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id F3EE9EC0081;
	Wed,  1 Jul 2026 21:40:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 01 Jul 2026 21:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782956420;
	 x=1783042820; bh=R5LpaKlakh3bs5cwH2O3klfFFzL3KhZWdxNF6hUcNFA=; b=
	l1tdcZKlKUTuEQY1SerGeOqZY+MdyxtrfmJn8PHr2Oy/qULZMdrD7Wtw9IRWMmBe
	sIRjBRJpeBcVRVoR9Jn8ukYzTvje+BCgUNXU48kum/R4HPuahAh4kO7nOurOOD+g
	pvfAxvXuGZbHt6KpQAsglYie7kewf7u9j1O+FGidDk4IbDerE+2zYHZrGhHYyj1p
	27mou4HjmpU1egOy+uIse/hsocagUuh0JmWCAG3vrLBakLjjYk6NXCZlVqoR1i6X
	iEZp13+4n2eVhleTEnQwPgLcocXpE2lQEWT7OS6PGZdqWzOpLtVAxFSk9LQcPClc
	Xc9JyRZZnZS7v7NM1+uteQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782956420; x=1783042820; bh=R
	5LpaKlakh3bs5cwH2O3klfFFzL3KhZWdxNF6hUcNFA=; b=EkU6ftZUrA+zKTziZ
	kKeoTZb/zxIyLE9U6F6VuQ8oQdsAPgxtCGCPfP5CytFM2Tkb8Oto+muKD6cUGX7E
	Va4AMcbPdSXGkidqCQGWddfd1/dnmUjG1wOLT6l1yNqQUnaRQGXdFM7Wii1P7nae
	F+BnWBiNOXHO6XlRFvK/frVJH2jKAlZMA12WrB9PETGxx9YJrUoGpzKmfpf0Yq7z
	yOi15Bxe5K0L48IW8Y+2lUS2YZwd43A+bIo3sSCYfsqcqbQmdYD0MCDveQfBsbZI
	f9/2+6r2okxnC59FxRj/yjIRAlsiPT8oknVSspxzyGnr4oapjPlnLwYQ2MtgVelu
	FJlBg==
X-ME-Sender: <xms:hMFFaub1RwXF8f9LHhky5NJ1lacpbf-idjog99whtxk86FpalLMOZA>
    <xme:hMFFalGYCQJNdnVe7mak3uCR-n9ko-DlNRtpgz9B-Yh1AkzGVElk6SE5Zqm3DfrQY
    j48J38cqlTtIH-_GNB31wgGJsScPOP6RnLXtBRL4SAvYCVy0A>
X-ME-Received: <xmr:hMFFaiz7XW5Lo3ZmRuqd0Y6n3XdHU3FLfijE8lUg0bA1OvJ2ffjTEnJmpgnkqFrm9RJYDlAM22GdoouHqY5K6GAuriQ2VNQ>
X-ME-Proxy-Cause: dmFkZTGxxG3WYOxUHoAfQ/lPCCBtpuI/S7RhXZdDZo5R/zg8oB5VVkJeqNXv4+5JHOpq5a
    +KGMHLUceWZQbXPkcZMChswAkz7oDBNzn2AAW712K9zA+2pVUC0R25sTJVNA5GxxGZFPf1
    pbUOYpi4dQLmAi8WqifnbcWGv9caFABP7KC0vD8MdlGlpjn5roAZxmnOAYWdGQbArFc5Hb
    UEMPfmUhw7JKuGB/UeLW6QzhMn9rUFgblOXzq7GYDHlxGkjfNMCQ4PJDU4+12b6NAKgXbl
    Rg1mGujmSEJHxyDH3iqFB1G6ofNBMwYgggnhxc3EKZatNVAxTrXJlSKPeBcpJnvqZuoCoP
    zNTNT/zPFNDx/hnqK3GjDXLBLbebWVD7RQ5Upg9eiYlfe5AtCWRbxeqaaQuN9gvhGJ/ysl
    sRCNu4pPBbP1JxoSR15ey5F7FAUuPG62DVrONWcZ28Oa4OjZ/5JbfAsSwJGQNP8rqhkRUd
    LplpdymwlcNCoiBa8BxLGbexE5sHZcRSw/RqnahPA+lgxF3xTUzdSeyq6gXOBSoNUVJOlL
    qsvWeyQQFpfMCqKeqsPFHwFbhma0ouD1c14ZEmroSpcoKu+86O8WrJD0Jie2na2ZDDlQKg
    W/30fNViaQcgrV9jVMkhNyS7jx7WH9eWMDw2pRGb4pXFpB+tVJ1xRnbtPTlQ
X-ME-Proxy: <xmx:hMFFannpKgbTo5CPewY7ANqQRb0uwdwnwGbyxdySILfKrWMD40HMWg>
    <xmx:hMFFarntCb5nvqt4CZdVt-eUDXEMtlunxqQyUkYgMz4rUY-a7i5kLg>
    <xmx:hMFFapyMivmLXqTwTq9e79oAl3iEC6zCTcYSd4YuU-vqfaJ01I07uw>
    <xmx:hMFFagp9KrBJfJYlCu6Iye3x9mC-xnZVihe4zT10Mty3CqQJ9KLcyg>
    <xmx:hMFFan7iYUAugeFu2x8oDyx328BXr5eOPEM5qR8y5pD8dHCu8gvJuXA6>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 21:40:18 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 02/10] nfsd: move fh_want_write() after preamble in nfsd4_create_file()
Date: Thu,  2 Jul 2026 11:34:21 +1000
Message-ID: <20260702014000.3397240-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260702014000.3397240-1-neilb@ownmail.net>
References: <20260702014000.3397240-1-neilb@ownmail.net>
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
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22928-lists,linux-nfs=lfdr.de];
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
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ownmail.net:dkim,ownmail.net:mid,ownmail.net:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE5436F2D88

From: NeilBrown <neil@brown.name>

As part of separating the nfsd-specific code from the VFS interaction
code in nfsd4_create_file(), move fh_want_write() to just before we need
it.

Consequently errors in the "if" statement that this code is moved over
can now be returned immediately rather than needing to "goto out".

Also restructure that "if" statement to only test is_create_with_attrs()
once.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 06de0cfd8e90..9ba1e654f1ec 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -270,22 +270,18 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	parent = fhp->fh_dentry;
 	inode = d_inode(parent);
 
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		return nfserrno(host_err);
-
-	if (open->op_acl) {
+	if (!is_create_with_attrs(open)) {
+		/* No attrs to check */
+	} else if (open->op_acl) {
 		if (open->op_dpacl || open->op_pacl) {
-			status = nfserr_inval;
-			goto out;
+			/* Cannot specify both NFSv4 and Posix ACLs */
+			return nfserr_inval;
 		}
-		if (is_create_with_attrs(open)) {
-			status = nfsd4_acl_to_attr(NF4REG, open->op_acl,
+		status = nfsd4_acl_to_attr(NF4REG, open->op_acl,
 						   &attrs);
-			if (status)
-				goto out;
-		}
-	} else if (is_create_with_attrs(open)) {
+		if (status)
+			return status;
+	} else {
 		/* The dpacl and pacl will get released by nfsd_attrs_free(). */
 		attrs.na_dpacl = open->op_dpacl;
 		attrs.na_pacl = open->op_pacl;
@@ -293,6 +289,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		open->op_pacl = NULL;
 	}
 
+	host_err = fh_want_write(fhp);
+	if (host_err) {
+		status = nfserrno(host_err);
+		goto out_free;
+	}
+
 	child = start_creating(&nop_mnt_idmap, parent,
 			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
 	if (IS_ERR(child)) {
@@ -409,8 +411,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 out:
 	end_creating(child);
-	nfsd_attrs_free(&attrs);
 	fh_drop_write(fhp);
+out_free:
+	nfsd_attrs_free(&attrs);
 	return status;
 }
 
-- 
2.50.0.107.gf914562f5916.dirty


