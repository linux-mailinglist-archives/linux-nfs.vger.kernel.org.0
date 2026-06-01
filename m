Return-Path: <linux-nfs+bounces-22146-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOHKIW0uHWo4WAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22146-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:02:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3961A90C
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA917300616C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D123135C180;
	Mon,  1 Jun 2026 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HNUYPk0M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fCv4sLMY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71965331209;
	Mon,  1 Jun 2026 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297291; cv=none; b=dTVtKqk/r6auSpbz2DIVJObnDlS+9e2VkYHaOsGg4gmsHxxtYfwUFHf+u8u6iidox+u/b6rx187VWpRrpSAwWgnTdapWTjjpB5qVvB0Leg0wt/1aXOHIUg2rm0+8C3UE48Y6CY7xzk49cWLAPtx+PzfgqEXVhrMymjz7+QRIFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297291; c=relaxed/simple;
	bh=h+umMeZejKqSaPNJCRhJSeQ3lVHBknuHj61IiehZQ6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwDi+dAs8pCxlQqSRKU+yONWpaVaRZRJGojdZO6K9hQCfgGgVJSa/YK4e8c1s1SRYGhwDKaDLoTezitHXSbjWP70L6OpnZ4vSWztP6j50VN5CVBGy03hy3Pr7l6HTxaO8N58BDblxq3+ITsAoFTUBMVlbJZqMlolgfc3yt4mb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HNUYPk0M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fCv4sLMY; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B5567EC012A;
	Mon,  1 Jun 2026 03:01:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 03:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297289;
	 x=1780383689; bh=inz9JAYH8Rf4QWvyB7Wus2Sh1SSkUBOBJkzG3eXZqGA=; b=
	HNUYPk0MkovQLwMk6HuGqhxsvju0DIkh6AvWacyR268+S/VcN20jOex14tBhT/VJ
	NvQBtao21zY2TwjGOQPMyhemSjRUJTRyD2VC2RG2oa48KzawUrAmW8HKuTvxDNB7
	PmaA/n3sCZtYcCuwcyEuUa0pVZ7kmGtsrWk1KcqfkkubTKB03kUeTQy3OakMfsjd
	eiBOy6Dz2IVwySsJ74xnHY2AjLIfhWr/Bp4qle+Ulh6AhYpWQWJc23iH6Ovq/YWN
	kM1EFsvUYvOfRluOSmxEg8m4M7JCImSxjOAmF2kuqbUASVYmK9QfvlxifptrVPfv
	HeGSVXGsSN0ssaENQVf++w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297289; x=1780383689; bh=i
	nz9JAYH8Rf4QWvyB7Wus2Sh1SSkUBOBJkzG3eXZqGA=; b=fCv4sLMYiDi1rX8XL
	R+9EPAU0Z/kQ/83spJ/BKX/q4nbE44mbqj5mbkSq5Da7VDzeRbbo09bPZ8g/LALE
	JnCfXH/keOGFp+Rc0bDuFCRlHQjrY20cSvLdOrV421DfdWKBCVqzNWd1sycpBcxI
	wkiv5kTHyM/+O9icOZCLANqUQDjnmAFP7jH/bvpSrUtiAAAsIpYqjva9NT1KwdZ5
	ApG2Ged9TlKY/A1Ct+f++g/66P7ZR2UvBIL74EbB/InU3POI6NhagzV/QnCR0BCM
	M0DdPNpnm/h2A5Braqm/MRp9X+HQLIp6wvE467l6FzkSBusAeUfiGmdtzyVkJdjq
	3gF/Q==
X-ME-Sender: <xms:SS4davmexmUHscQD21wqsWaJMG5wqNWtdT9POatrYaNx7KVPCKvCIQ>
    <xme:SS4darB2YwbtGEt5skDkkvyGhZctXNiIdd1nQ_97K-FGf9WTO_Z9eC3N1YGmVhNWW
    ZPpsTqEQBs8SCRPAllQz8m3lgHbLuI7E5GRLeaOcqGd-Tc>
X-ME-Received: <xmr:SS4dahNrtqge55RySgG-CIQTP2-TL2DLcpYkRLuOStKbdtprcjBAVZf-1zi1x7j3GX-tMasqTTnKwPBxOuZeO7rIrJgKM9Y>
X-ME-Proxy-Cause: dmFkZTFNn2voCuMJwaZn4mQi+8OwFwP8MbOGesQswPxVACwdUxRDwWa/f62FrT4OS5+etX
    lpbG0CyNEC5ZEzEebDdmEkKKuwA8JYmTcJZDLGOjQuIsuC+VlGFN4cDtTpsp4TJxEBMQJN
    5UaE10g4X93jUBy1AA+vqprc2pKvYMKhkYGmTUuEeZluqnZwRRSGljv9KpJxnsuimm38u7
    Jp9HDBymSY6zDSdT1QCsnlup35Rls5SW6aC9Hwu2QHQS3M6fNepFkcCA+NA6zsxp9+rhtV
    lYy3c44qrxynOl4BJrfimD+Q/JXYY7JxRkwisEy5dkxg8tlTtB+eaV0PCk5+Kq5N3tTrZD
    0sUOTJ8/xqsC0ioLd63GtGk0HA5+fjEVaCjigYDuKceTMXwG52PrkfpvUZVs5r1Q4/99ZX
    dMqR/lWcoqxWFKdaLShtGEiiWiDfuiV0A2wfDbN+rp24iyUVYPon4pOvMQxUTHK7+v5ppk
    tjq26D1R79RbRqNFXPMiumqvex6GiLbdCOTFP5uVagIvOjgiJYbpd+8RLc2nju2GYDHR1n
    FuuEx9utalDjY2qJ8CI6H1ToZJH9TUSXUOGRD47KQEoB6WIzXbGjjYhXsp1TC+66EwpTE/
    DK2Sslhh7wmTfVD/bwnpb6tkSeixRCZKbI80XDh+ozBIv3QzDMsU4Lf1DORg
X-ME-Proxy: <xmx:SS4daiMv20vFGFNSDWncNBHzmBd77oOaeOaN2YxXB-g9Hpal8ydxUA>
    <xmx:SS4dapnHPv7SYAIp-DwNWvkTIj7OfphIZbycJrBjOs14H3PJgkIOLA>
    <xmx:SS4dagtF_03TdGbbuJNMXAnqz5RvvIvrP6KqSUOUOubGAbaqeG8WRA>
    <xmx:SS4daspip43U0TVDYvYFS2G_oIF1EWq_MFk6lhslosM9SSLqJ8r5Gg>
    <xmx:SS4daiILIrxcgq6QMRcAyHVfdcg5FY4-j_ivxXORe91XAiNfksmnlN6D>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:01:26 -0400 (EDT)
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
Subject: [PATCH 06/18] nfsd: replace fh_fill_both_attrs() with fh_fill_post_noop()
Date: Mon,  1 Jun 2026 16:37:54 +1000
Message-ID: <20260601070042.249432-7-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
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
	TAGGED_FROM(0.00)[bounces-22146-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: 1DE3961A90C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

fh_fill_both_attrs() is only needed for open/create and is used in the
case when the target already existed so no creating happens.

As part of refactoring this code it is changed to call
fh_fill_pre_attrs() once early on (so errors only need to be caught in
one place) and then to use a new fh_fill_post_noop() when it is
determined that no creation happened.

fh_fill_pre_attrs() now stores the attrs (which it had to get all of
anyway)_ in ->fh_post_attr.  fh_fill_post_noop() simply marks them as
valid.  fh_fill_post_attrs() replaces them.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 19 ++++++++-----------
 fs/nfsd/nfsfh.c    | 40 +++++++++++-----------------------------
 fs/nfsd/nfsfh.h    | 13 ++++++++++++-
 3 files changed, 31 insertions(+), 41 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5f2b9bfc3a84..f642be31b239 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -327,9 +327,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		/* NFSv4 protocol requires change attributes even though
 		 * no change happened.
 		 */
-		status = fh_fill_both_attrs(fhp);
-		if (status != nfs_ok)
-			goto out;
+		fh_fill_post_noop(fhp);
 
 		status = fh_compose(resfhp, fhp->fh_export, child, fhp);
 		if (status != nfs_ok)
@@ -376,9 +374,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
-	status = fh_fill_pre_attrs(fhp);
-	if (status != nfs_ok)
-		goto out;
 	status = nfsd4_vfs_create(fhp, &child, open);
 	if (status != nfs_ok)
 		goto out;
@@ -464,6 +459,9 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	fh_init(*resfh, NFS4_FHSIZE);
 	open->op_truncate = false;
 
+	status = fh_fill_pre_attrs(current_fh);
+	if (status)
+		goto out;
 	if (open->op_create) {
 		/* FIXME: check session persistence and pnfs flags.
 		 * The nfsv4.1 spec requires the following semantics:
@@ -495,11 +493,10 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	} else {
 		status = nfsd_lookup(rqstp, current_fh,
 				     open->op_fname, open->op_fnamelen, *resfh);
-		if (status == nfs_ok)
-			/* NFSv4 protocol requires change attributes even though
-			 * no change happened.
-			 */
-			status = fh_fill_both_attrs(current_fh);
+		/* NFSv4 protocol requires change attributes even though
+		 * no change happened.
+		 */
+		fh_fill_post_noop(current_fh);
 	}
 	if (status)
 		goto out;
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 429ca5c6ec08..c781c942204b 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -782,26 +782,31 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
  * fh_fill_pre_attrs - Fill in pre-op attributes
  * @fhp: file handle to be updated
  *
+ * Post-op attrs are filled and pre-op attrs are copied
+ * from there.  The post-op attrs can later be replaced by
+ * fh_fill_post_attrs() or activated by fh_fill_post_noop().
+ *
+ * Returns: error from vfs_getattr() which must be checked.
  */
 __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
-	struct kstat stat;
 	__be32 err;
 
 	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
 		return nfs_ok;
 
-	err = fh_getattr(fhp, &stat);
+	err = fh_getattr(fhp, &fhp->fh_post_attr);
 	if (err)
 		return err;
 
 	if (v4)
-		fhp->fh_pre_change = nfsd4_change_attribute(&stat);
+		fhp->fh_pre_change = fhp->fh_post_change =
+			nfsd4_change_attribute(&fhp->fh_post_attr);
 
-	fhp->fh_pre_mtime = stat.mtime;
-	fhp->fh_pre_ctime = stat.ctime;
-	fhp->fh_pre_size  = stat.size;
+	fhp->fh_pre_mtime = fhp->fh_post_attr.mtime;
+	fhp->fh_pre_ctime = fhp->fh_post_attr.ctime;
+	fhp->fh_pre_size  = fhp->fh_post_attr.size;
 	fhp->fh_pre_saved = true;
 	return nfs_ok;
 }
@@ -833,29 +838,6 @@ __be32 fh_fill_post_attrs(struct svc_fh *fhp)
 	return nfs_ok;
 }
 
-/**
- * fh_fill_both_attrs - Fill pre-op and post-op attributes
- * @fhp: file handle to be updated
- *
- * This is used when the directory wasn't changed, but wcc attributes
- * are needed anyway.
- */
-__be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp)
-{
-	__be32 err;
-
-	err = fh_fill_post_attrs(fhp);
-	if (err)
-		return err;
-
-	fhp->fh_pre_change = fhp->fh_post_change;
-	fhp->fh_pre_mtime = fhp->fh_post_attr.mtime;
-	fhp->fh_pre_ctime = fhp->fh_post_attr.ctime;
-	fhp->fh_pre_size = fhp->fh_post_attr.size;
-	fhp->fh_pre_saved = true;
-	return nfs_ok;
-}
-
 /*
  * Release a file handle.
  */
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5ef7191f8ad8..2af2fdc919d2 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -335,5 +335,16 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
 u64 nfsd4_change_attribute(const struct kstat *stat);
 __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp);
 __be32 fh_fill_post_attrs(struct svc_fh *fhp);
-__be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp);
+
+/**
+ * fh_fill_post_noop - Copy pre attrs to post attrs
+ * @fhp: file handle to be updated
+ *
+ * This is used when the directory wasn't changed, but wcc attributes
+ * are needed anyway.
+ */
+static inline void fh_fill_post_noop(struct svc_fh *fhp)
+{
+	fhp->fh_post_saved = true;
+}
 #endif /* _LINUX_NFSD_NFSFH_H */
-- 
2.50.0.107.gf914562f5916.dirty


