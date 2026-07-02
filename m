Return-Path: <linux-nfs+bounces-22927-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OvyXBIXBRWr2EgsAu9opvQ
	(envelope-from <linux-nfs+bounces-22927-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:40:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E266F2CED
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:40:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=Qs7Az1nT;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="O/8p6CzK";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22927-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22927-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAAF4301FF13
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 01:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E50282F1C;
	Thu,  2 Jul 2026 01:40:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB512BDC23
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 01:40:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956418; cv=none; b=jltry5XYgnBaj9nWVrpjQ9MCL5eIdIn2+tspZhLXt+/LZ7wAmlxlUFDzVO2AGjodEt1GhsnTGEVpn12mZqXVw6ECWv2wpvy/LGP9Fl4kJx3UcDiSUmlW8e0a9G8/nSu8PkiXFi+ZPj+7HuwJ2D3zQzQcSYELNagyAnM4NfE5Nt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956418; c=relaxed/simple;
	bh=9dv34E/WkL1tZEhv2xiFIrUgD/MRjHXAndbjWw1s3eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWweQN54cyNmeYzqYEzcEDkESGQxx8Tq1x70bPJU5eqrqBd8FzHJPxHy/2jNnuYNl5RHhAkN39VsO4DSZK5HY+0OcTPwgg/ozKwN84AP+KypsbM1dBhRSBG1orc7bMK8VAfB02DezfFIhwCddBxKP9L4jITPrKLpfFU2D6lv2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Qs7Az1nT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O/8p6CzK; arc=none smtp.client-ip=103.168.172.155
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07A5D140013F;
	Wed,  1 Jul 2026 21:40:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 21:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782956416;
	 x=1783042816; bh=nUMpaUzan/C+J2Z1mnwCWKNIg8uNyTBZIgvRfyAjkvs=; b=
	Qs7Az1nTm2m+B6nttZ6sbwfIO8yBgSEwgRz4R5WVZbIlaajXpDF/QR9XF5S8rsF3
	Iu6xUkp6yRzeTriTqQr6WfEWhUGzLsZpN4Tkdp/RfGA15L+dqs/+KkZbWxC38Dib
	jTwJQEWWd91DKLFVxfGPvfcKsKQTXpbrPYf0/PBl/q/HgSKXmMGHdrpF2mCjCJj4
	iHlFHBYW8uufIDyQYAxQq/c4VhL4mxyYgttwKA0caJFaqU0KMfJB7NCeC+YDISqP
	bFQOeakjQbDlil6rLlIaZx7eb5u8MAe4SfyZmQSDIcppb0iBy8zDh0jh+C0OLLbY
	RpAWAu3LpCXjuirD5Rag9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782956416; x=1783042816; bh=n
	UMpaUzan/C+J2Z1mnwCWKNIg8uNyTBZIgvRfyAjkvs=; b=O/8p6CzK7g35GtA0c
	Od3pal9gftgwaJwMtNnlg5+gXVk053DOwvnjaG2Itusv9mNpPBSr4zqi6AVpj0oc
	3xcWfSLCE24JR0e1NhhhYi2r2YQV9WidNJG1URNKH3R/BXtchtg05ZsD7jtzbLGS
	UbtwI6KG6GNd3kDcjx0+bAJPeY6BdRqzNazboKdA/5IhDMOESHr1P1KAwUnME/hR
	wxvc8LgvKrnxFKGA0S9x2uC0W1ramEV4VwjFUztgLxhrlxyHw90X6A7l2mFAACNs
	HGU7McsmOvm1KYhQIDr4RLHMhhvbsQnXaXo9rX5cRyK6Wop2DB013z9S6LS5k5RI
	FYmfg==
X-ME-Sender: <xms:f8FFah4TusIBwNchFABzzVARlkkjJa22DVEg-4ihvp2WwAF_AKgcjQ>
    <xme:f8FFailZgLFF4kSsa7Mr5LbcgoqXdWM5jGJqd-yJJvECcahFlqVYEkmR3wWdShtD3
    j1dH6LwmiLVe0ZgsKadVidJO1SAYRRfb_IGevD0iJgiQYQBTaA>
X-ME-Received: <xmr:f8FFaiQnUOzl6AHxxfvIZAPn9qaymwGPhDEloxAmf4g5IY8ioFyppwuhpNFKenTvchF8dv4rE0sEDtCI_UcWmZIMrlnoDkk>
X-ME-Proxy-Cause: dmFkZTGxxG3WYOxUHoAfQ/lPCCBtpuI/S7RhXZdDZo5R/zg8oB5VVkJeqNXv4+5JHOpq5a
    +KGMHLUceWZQbXPkcZMChswAkz7oDBNzn2AAW712K9zA+2pVUC0R25sTJVNA5GxxGZFPf1
    pbUOYpi4dQLmAi8WqifnbcWGv9caFABP7KC0vD8MdlGlpjn5roAZxmnOAYWdGQbArFc5Hb
    UEMPfmUhw7JKuGB/UeLW6QzhMn9rUFgblOXzq7GYDHlxGkjfNMCQ4PJDU4+12b6NAKgXbl
    Rg1mGujmSEJHxyDH3iqFB1G6ofNBMwYgggnhxc3EKZatNVAxTrXJlSKPeBcpJnvqZuoCPj
    M7Z9vUT3SLA0hOmK2C+k4Ehhh060dIuFLN1lQvVffaqb9nbwMnCLd55qS9BiydQvauvv8N
    PyNT/QW91R3iRjj1e31DBnw9mzOQjkCoI7dQdKTyaiqhRPEVBesmTwOYpexkJutOBbMl7b
    Y5h18F/FnI7knk7pzNnx8rTJINgkfFs0kCtEwsSlLGW+TD6BwJjqrL4AoWZfuc7BBtrEt4
    PSYeGRuivSor8HZLNIQWFnlfVR9kdaYu3GDCA6vlX4IntwJZxNXxWJNs0yjO/Ju1oePpyt
    O6Cdsj/YNGHyA1K0JCR9nHJraQ9cuTg4H0JHS7SxyATFrzfeqz+GMLsWrFyQ
X-ME-Proxy: <xmx:f8FFahFyaNIrZ-fiB300c7dtVDQGyOtvqljOPwvo_2KdhzkPYM_MHg>
    <xmx:f8FFanGmFbkUKOM2YbOCPDB3sW0SLBXhPjpAOcvWXQQ9XlOixiYqpA>
    <xmx:f8FFavSCHT8UffA9OlYs_Vt-pwcMITkh7iR734DuUhrz7SvUktID0A>
    <xmx:f8FFaoJwMMKqUJVabQEWt2KSK5UV9MMuhPzGPA4LVlhTer3uA3FWeg>
    <xmx:gMFFara1b6Z658DvDMxzc4bUnUi-hYNqG0TZ7O0j2UMRQIkXJ6KpUdta>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 21:40:13 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 01/10] nfsd: replace fh_fill_both_attrs() with fh_fill_post_noop()
Date: Thu,  2 Jul 2026 11:34:20 +1000
Message-ID: <20260702014000.3397240-2-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22927-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ownmail.net:dkim,ownmail.net:mid,ownmail.net:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53E266F2CED

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
 fs/nfsd/nfs4proc.c | 20 +++++++++-----------
 fs/nfsd/nfsfh.c    | 40 +++++++++++-----------------------------
 fs/nfsd/nfsfh.h    | 13 ++++++++++++-
 3 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 669896be08b6..06de0cfd8e90 100644
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
@@ -495,11 +493,11 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	} else {
 		status = nfsd_lookup(rqstp, current_fh,
 				     open->op_fname, open->op_fnamelen, *resfh);
-		if (status == nfs_ok)
-			/* NFSv4 protocol requires change attributes even though
-			 * no change happened.
-			 */
-			status = fh_fill_both_attrs(current_fh);
+		/*
+		 * NFSv4 protocol requires change attributes even though
+		 * no change happened.
+		 */
+		fh_fill_post_noop(current_fh);
 	}
 	if (status)
 		goto out;
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 8b1a95e1d058..58de7b7c4238 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -784,26 +784,31 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
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
@@ -835,29 +840,6 @@ __be32 fh_fill_post_attrs(struct svc_fh *fhp)
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
index cdeb5eea65a8..e8b271a92024 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -338,5 +338,16 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
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


