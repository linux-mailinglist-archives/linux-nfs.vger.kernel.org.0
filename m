Return-Path: <linux-nfs+bounces-4457-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290D291D65E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 04:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D71B1C2100B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 02:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83758C13B;
	Mon,  1 Jul 2024 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iOuNDlXB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lQWFcZo9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iOuNDlXB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lQWFcZo9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0FD534
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802748; cv=none; b=UigQoFG1hMPHDHmgHjOXq1Uyl2bCeXVuqf4EPKdsJIt0IQTHLDXlGUUSkP0Il/8MU1vr2YNhZeEEqT+pvyyxLuvIGCgzYxmbuMah3TstzmdzFoEO2CWJYvQSTLlpL7huJjhnm8BrXSnG/5VHBDxqBiTFgwK1FtPxk1aY29Z1DIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802748; c=relaxed/simple;
	bh=Y+lyFMUuCk9qEzqKZ3u6uFvEwtM5gjdrJtEW5AsS9Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sp9JRSFIhhJdov9kDcBHtQ5HCboqt1tINEbzrmx8t7+oaKc9z2I9bRpLB0UR4MltTY3/uwSBTUjesrWF2Nn2+UBhsOhKoh80RQZta58xPVULsmEx31UjJJaMJjfPtjdyctzwnlO/W8Aqioy76Q4wnPnbGixSeQjXlCkt1pSVBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iOuNDlXB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lQWFcZo9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iOuNDlXB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lQWFcZo9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E3EA1F8BE;
	Mon,  1 Jul 2024 02:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zu3buywb36GykSG8DupHx41IOIDVysa3ccHKJyWPgk=;
	b=iOuNDlXB1SV4Ue8wMUUGY4FuR+h4tVFy1NXfaPneVYHmPkn5sWE7TRA4/D9jzaBDDQ62bl
	O9G873VONLXvL4B/dHzRBvS1dI0tjypuxCmBjDrJsYLpJeDKPXq5a+HFiO6ICSrgi+k1o0
	O7X7dLhEvsa6QyDMzAhcw1joM98cFek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zu3buywb36GykSG8DupHx41IOIDVysa3ccHKJyWPgk=;
	b=lQWFcZo9+2UmBRUa30QNl0xtGn7j8e48zuoTJLwOAMwRYpJPXaSK7qJxKfHfMfoQDBhriS
	u7sxk8q3j/8bhoBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zu3buywb36GykSG8DupHx41IOIDVysa3ccHKJyWPgk=;
	b=iOuNDlXB1SV4Ue8wMUUGY4FuR+h4tVFy1NXfaPneVYHmPkn5sWE7TRA4/D9jzaBDDQ62bl
	O9G873VONLXvL4B/dHzRBvS1dI0tjypuxCmBjDrJsYLpJeDKPXq5a+HFiO6ICSrgi+k1o0
	O7X7dLhEvsa6QyDMzAhcw1joM98cFek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zu3buywb36GykSG8DupHx41IOIDVysa3ccHKJyWPgk=;
	b=lQWFcZo9+2UmBRUa30QNl0xtGn7j8e48zuoTJLwOAMwRYpJPXaSK7qJxKfHfMfoQDBhriS
	u7sxk8q3j/8bhoBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 789491340C;
	Mon,  1 Jul 2024 02:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id otWZB3YbgmYOLwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 01 Jul 2024 02:59:02 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5/6] nfsd: __fh_verify now treats NULL rqstp as a trusted connection.
Date: Mon,  1 Jul 2024 12:53:20 +1000
Message-ID: <20240701025802.22985-6-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240701025802.22985-1-neilb@suse.de>
References: <20240701025802.22985-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	RCVD_TLS_ALL(0.00)[]

The final places where __fh_verify unconditionally dereferences rqstp
involve checked is the connection is suitably secure.  They look at
rqstp->rq_xprt which is not meaningful in the target use case of
"localio" NFS in which the client talk directly to the local server.

So check these to always succeed when rqstp is NULL.

With this it is safe tocall __fh_verify with a NULL rqstp providing nn,
cred, and client are not NULL.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/export.c | 12 +++++++++---
 fs/nfsd/nfsfh.c  |  4 ++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index ccfe8c528bcb..9e3e2380f8ae 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1077,7 +1077,13 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 {
 	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
-	struct svc_xprt *xprt = rqstp->rq_xprt;
+	struct svc_xprt *xprt;
+
+	if (!rqstp)
+		/* Always allow LOCALIO */
+		return 0;
+
+	xprt = rqstp->rq_xprt;
 
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
 		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
@@ -1185,7 +1191,7 @@ rqst_exp_find(struct svc_rqst *rqstp, struct nfsd_net *nn,
 
 	/* First try the auth_unix client: */
 	exp = exp_find(cd, client, fsid_type,
-		       fsidv, &rqstp->rq_chandle);
+		       fsidv, rqstp ? &rqstp->rq_chandle : NULL);
 	if (PTR_ERR(exp) == -ENOENT)
 		goto gss;
 	if (IS_ERR(exp))
@@ -1198,7 +1204,7 @@ rqst_exp_find(struct svc_rqst *rqstp, struct nfsd_net *nn,
 	if (!try_gss || rqstp->rq_gssclient == NULL)
 		return exp;
 	gssexp = exp_find(cd, rqstp->rq_gssclient, fsid_type, fsidv,
-						&rqstp->rq_chandle);
+			  rqstp ? &rqstp->rq_chandle : NULL);
 	if (PTR_ERR(gssexp) == -ENOENT)
 		return exp;
 	if (!IS_ERR(exp))
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ea3d98c43a9d..fb5a23060a4c 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -106,10 +106,10 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 	int flags = nfsexp_flags(cred, exp);
 
 	/* Check if the request originated from a secure port. */
-	if (!nfsd_originating_port_ok(rqstp, flags)) {
+	if (rqstp && !nfsd_originating_port_ok(rqstp, flags)) {
 		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
 		dprintk("nfsd: request from insecure port %s!\n",
-		        svc_print_addr(rqstp, buf, sizeof(buf)));
+			svc_print_addr(rqstp, buf, sizeof(buf)));
 		return nfserr_perm;
 	}
 
-- 
2.44.0


