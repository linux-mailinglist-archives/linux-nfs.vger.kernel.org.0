Return-Path: <linux-nfs+bounces-22147-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIHIMXQuHWo4WAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22147-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:02:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91C61A921
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9E983006805
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94733806CD;
	Mon,  1 Jun 2026 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="XVw1k1cs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dv6Wqn/p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748C33121C;
	Mon,  1 Jun 2026 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297296; cv=none; b=MgtB9qPDL4M6ZCaZaREmNfzNa0U3FLXA6wQz2VCpmFn1ZOYGiWZe3xlmkFsok+eU5GsW4MIpOnezFsBE4VLZPHDnkZUDl0+FfN7IL/APqGvm6c78TgZnRNDXDvSfixJbygJhhhMAW7tXJxDdkTErBHr+Ea03+Ci4643aFzJzG5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297296; c=relaxed/simple;
	bh=IsoszdJI+MjeFA8R90w++m9uRmo3LGafz6vpcYathe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRV9K/V2qUURDxcx2HO2tP4etZSH8xSA0g+CQkJ0/0mvk+sGmWsdAdlB26ZYBLvJuqdgxvtqEZBsyuC3BPA9gAKlOjuOVlMtKn0eqxNykj45C8rvlalvzx5oE7MazB9iHSxErGDjycydnnnEXXCVItS0LMi4/cF2p1dFiNqdfhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XVw1k1cs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dv6Wqn/p; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07778140007C;
	Mon,  1 Jun 2026 03:01:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 03:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297295;
	 x=1780383695; bh=1uP11aOl2TCDgH/OKmTUcxEkpVnSBPzhxVNBqawZNiw=; b=
	XVw1k1csze24Fu/1T0FSQnM1i5hqQuA02ZNip/z5TKRUY5TCn+RdCqish4xJctBY
	/5Gn8TJFTdQop8RVZiuDSfbi4fvt30Ml0ZMjYCx2BBgMQ9VjhF+hhyhHP36W1kIF
	jR1gMh1/Z0yP+eCD5iXIjA0AWyGxR5xF1jr7qpajTa1+swZVEp5zKn4GSpytNPVg
	LlSTHkCxbe6IpzmuD3TKAhdYlIsQyPt1LFjMr+sQoN+mcTEtOOn0MRuJhK8AYjPf
	ldFER6i0yc4xaXPhQyIBZCwztnZUoQ3iXi6ab7hAX70gl5c4pLPVJG4UhA4UD0fG
	lLQa2hIaJjapwcu2w0se7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297295; x=1780383695; bh=1
	uP11aOl2TCDgH/OKmTUcxEkpVnSBPzhxVNBqawZNiw=; b=Dv6Wqn/p4BcOM/gwp
	gKo3CKeqgNDsptH9+nR/SEuT3z01wYdXT5KT1zB7rM1DVm3i15w/7P1OuOpvYHov
	GlQ/2tRc1wFBVWARske6crgMmH5+aU7GSaL/C6xcz6qofwFbYy9DU+qHASzg58Wm
	qbKhSs1I0Da5MFVGXZoZhu+pMTXaS32oG8429XFMcEIgHeq1n7KO7PUAt+9M0l2x
	w0vqVN7jW7/reV+psAYepisrZpbd8HEEZkUuugMRKgAiazr78YjLNIzVtibQKxM8
	0MaaEfndz5nTNu8LHDLPfYMcAelt6fZkf2tXT9bdepSpeDdkYaZjMkQ08uOWC0n0
	ZDXZA==
X-ME-Sender: <xms:Ti4dasbHhNR1Pt2JzqcsypZ65MMf5Bw692lhCWeXuq2k8l6zqFnQaQ>
    <xme:Ti4davkD_2iKFIkmIfdyng--T5qZ54K3W5bMUJyJQTyMXcMb5pELoJ5YZ1x5s832B
    nU6dDdxK0l6nhMVsskgoCC_cerToQzVZZcAmKbAuWc3v4WP5g>
X-ME-Received: <xmr:Ti4daigpLfPdI7REyKpYHs0Yj1erOw9kI_DrZOmFVuyfkFe2ercXrhexKSwwaC9MDp2UfIymYiR8N4S19HiKmXjNEWa3sm0>
X-ME-Proxy-Cause: dmFkZTFNn2voCuMJwaZn4mQi+8OwFwP8MbOGesQswPxVACwdUxRDwWa/f62FrT4OS5+etX
    lpbG0CyNEC5ZEzEebDdmEkKKuwA8JYmTcJZDLGOjQuIsuC+VlGFN4cDtTpsp4TJxEBMQJN
    5UaE10g4X93jUBy1AA+vqprc2pKvYMKhkYGmTUuEeZluqnZwRRSGljv9KpJxnsuimm38u7
    Jp9HDBymSY6zDSdT1QCsnlup35Rls5SW6aC9Hwu2QHQS3M6fNepFkcCA+NA6zsxp9+rhtV
    lYy3c44qrxynOl4BJrfimD+Q/JXYY7JxRkwisEy5dkxg8tlTtB+eaV0PCk5+Kq5N3tTrdC
    jKo94p9Fdp8j57aNsueiewwqOeUUhpVJ2cvi32qUGZyPNRI4rnTCv3e378LRbEaKHNUK34
    KoT9QVQwefqWETSQNsgVxQMJDSPsI9zd/lrxvC6OlTsGaRCLJJLyuE1mjLNA8eCendH+M9
    P4JZvX1lzlziWXVw5NOqc83bT/EzKqub99/iyefPXhOi4A7iM4A1CKXHq9ZSDni/AROCnw
    isQOOKNh9uq4Cxgi3ClDFRAGqd/JOwbpF6QghVVi1BbUY/0WTwbcsYqd7EBg/2/Et8KoVU
    z+qV+X5H+psmqdeJbm25AZnUU8mDfNKR84YzgW17iWOCEzbWMa+eRIHsgEEQ
X-ME-Proxy: <xmx:Ti4dahT8jCDA_qyH1Z8dtmJyR-H9esXeSiPwy6jhwFwFifMHXp1jkA>
    <xmx:Ti4dajaQPzgiW0OdJDwsSmVNtOzwfxZM46ToQ4RPnkVOXjIsfUVOew>
    <xmx:Ti4dauS9TcugEu8aKO7T6UAe2vLkp4BupRNtBBnrLLVwnU0FWRMdtw>
    <xmx:Ti4dai_Nr_5IiW9fAjkek8lTvcPnfyTd4EEf7pRJyuxV1TNNtK74Ag>
    <xmx:Ty4daufbFAYBPLenBxSUEKkRlDiDYB3PQtNkJY40-jHZIB9wI9fXV-m5>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:01:31 -0400 (EDT)
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
Subject: [PATCH 07/18] nfsd: move fh_want_write() after preamble in nfsd4_create_file()
Date: Mon,  1 Jun 2026 16:37:55 +1000
Message-ID: <20260601070042.249432-8-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-22147-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 9D91C61A921
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

As part of separating the nfsd-specific code from the VFS interaction
code in nfsd4_create_file(), move fh_want_write() to just before we need
it.

Also restructure the "if" statement in that preamble to only test
is_create_with_attrs() once.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f642be31b239..5235db3d6a96 100644
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
+			goto out;
+	} else {
 		/* The dpacl and pacl will get released by nfsd_attrs_free(). */
 		attrs.na_dpacl = open->op_dpacl;
 		attrs.na_pacl = open->op_pacl;
@@ -293,6 +289,10 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		open->op_pacl = NULL;
 	}
 
+	host_err = fh_want_write(fhp);
+	if (host_err)
+		return nfserrno(host_err);
+
 	child = start_creating(&nop_mnt_idmap, parent,
 			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
 	if (IS_ERR(child)) {
-- 
2.50.0.107.gf914562f5916.dirty


