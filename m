Return-Path: <linux-nfs+bounces-4456-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F08D91D65D
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 04:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C21B2814A8
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 02:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF43D62;
	Mon,  1 Jul 2024 02:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UTen2UhB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hnndDoqr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UTen2UhB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hnndDoqr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37310C13B
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802741; cv=none; b=e/RTCE2kZKi6IHM7ugof7eoiSM2ALwFLrNzjJzsHCTjv8ugbKo0y69NQ/9rt3rGzoYb/O9ghjUuATlVBSch4iFtTqtFCR4Hkb38sV+mYjsmN+ZrpcDBHhTXdbWxmUvUXtUB1jtEoLpJeEKGOpJQIJ4GGTO9p0ebzeRMUPirxdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802741; c=relaxed/simple;
	bh=sVq+VmFQxz+wl6uieob5DFniD7GUvmIfkDDcFLptuSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YS3V5Q5TxU7ZwYu4w8ir1BH/X2T5UuHojgaLKVqgAnitfp4GBYtQTOOnoFB5xeroQNltW5OShUPws66pWCrgcEtKb17xHJDFE8TMsBM8nbbNHhB3B0OmJi9QJEVRENGbGcbDyXQTAicgqgTj6sWj4jRmVyXaotfziVOdXn1cGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UTen2UhB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hnndDoqr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UTen2UhB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hnndDoqr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B4231F8BA;
	Mon,  1 Jul 2024 02:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CiXyL0CKlv7FrBaaCpust98IKTOg02CARB2IBTCcVyw=;
	b=UTen2UhBSd+iZIhZOfB1cFMbHZ1yHvZ9jziUCvQMpqq3nBBIO9E6t4lhvgWjoBOl5qRO77
	tqrIM+Sv69AGOxKEEkfDwz7t2am0AXfX710DS6vKGhz532v0qtFVQM8ujBGhEpwSbQmQQI
	hCNN+p7f0YsMQVlcH9MB/sgOJAkEy68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CiXyL0CKlv7FrBaaCpust98IKTOg02CARB2IBTCcVyw=;
	b=hnndDoqryFsLx8Op4oUgHMtCMDDf3QJoViDcAiTEEd5Rpz2bbZ71eUiyecby74vQNfkhSo
	iAcmRQdkcLJVLuAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CiXyL0CKlv7FrBaaCpust98IKTOg02CARB2IBTCcVyw=;
	b=UTen2UhBSd+iZIhZOfB1cFMbHZ1yHvZ9jziUCvQMpqq3nBBIO9E6t4lhvgWjoBOl5qRO77
	tqrIM+Sv69AGOxKEEkfDwz7t2am0AXfX710DS6vKGhz532v0qtFVQM8ujBGhEpwSbQmQQI
	hCNN+p7f0YsMQVlcH9MB/sgOJAkEy68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CiXyL0CKlv7FrBaaCpust98IKTOg02CARB2IBTCcVyw=;
	b=hnndDoqryFsLx8Op4oUgHMtCMDDf3QJoViDcAiTEEd5Rpz2bbZ71eUiyecby74vQNfkhSo
	iAcmRQdkcLJVLuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ADDF1340C;
	Mon,  1 Jul 2024 02:58:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GPWWO24bgmYFLwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 01 Jul 2024 02:58:54 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 4/6] nfsd: pass client explicitly to __fh_verify()
Date: Mon,  1 Jul 2024 12:53:19 +1000
Message-ID: <20240701025802.22985-5-neilb@suse.de>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Rather than using rqstp->rq_client pass the client explicitly to
__fh_verify and thence to rqst_exp_find().  If rqst_exp_find is given an
explicit client it doesn't try ->rq_gssclient.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/export.c   | 15 ++++++++++-----
 fs/nfsd/export.h   |  2 +-
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfsfh.c    | 11 ++++++-----
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index a35f06b610d0..ccfe8c528bcb 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1165,21 +1165,26 @@ rqst_exp_get_by_name(struct svc_rqst *rqstp, struct path *path)
 }
 
 struct svc_export *
-rqst_exp_find(struct svc_rqst *rqstp,  struct nfsd_net *nn,
+rqst_exp_find(struct svc_rqst *rqstp, struct nfsd_net *nn,
+	      struct auth_domain *client,
 	      int fsid_type, u32 *fsidv)
 {
 	struct svc_export *gssexp, *exp = ERR_PTR(-ENOENT);
 	struct cache_detail *cd;
+	bool try_gss = rqstp && !client;
 
 	if (!nn)
 		nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	cd = nn->svc_export_cache;
 
-	if (rqstp->rq_client == NULL)
+	if (!client && rqstp)
+		client = rqstp->rq_client;
+
+	if (client == NULL)
 		goto gss;
 
 	/* First try the auth_unix client: */
-	exp = exp_find(cd, rqstp->rq_client, fsid_type,
+	exp = exp_find(cd, client, fsid_type,
 		       fsidv, &rqstp->rq_chandle);
 	if (PTR_ERR(exp) == -ENOENT)
 		goto gss;
@@ -1190,7 +1195,7 @@ rqst_exp_find(struct svc_rqst *rqstp,  struct nfsd_net *nn,
 		return exp;
 gss:
 	/* Otherwise, try falling back on gss client */
-	if (rqstp->rq_gssclient == NULL)
+	if (!try_gss || rqstp->rq_gssclient == NULL)
 		return exp;
 	gssexp = exp_find(cd, rqstp->rq_gssclient, fsid_type, fsidv,
 						&rqstp->rq_chandle);
@@ -1224,7 +1229,7 @@ struct svc_export *rqst_find_fsidzero_export(struct svc_rqst *rqstp)
 
 	mk_fsid(FSID_NUM, fsidv, 0, 0, 0, NULL);
 
-	return rqst_exp_find(rqstp, NULL, FSID_NUM, fsidv);
+	return rqst_exp_find(rqstp, NULL, NULL, FSID_NUM, fsidv);
 }
 
 /*
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index 2dbd15704a86..accad9d231fd 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -130,6 +130,6 @@ static inline struct svc_export *exp_get(struct svc_export *exp)
 }
 struct nfsd_net;
 struct svc_export * rqst_exp_find(struct svc_rqst *, struct nfsd_net *,
-				  int, u32 *);
+				  struct auth_domain *, int, u32 *);
 
 #endif /* NFSD_EXPORT_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 30335cdf9e6c..8430c197c900 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2231,7 +2231,7 @@ nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
 		return nfserr_noent;
 	}
 
-	exp = rqst_exp_find(rqstp, NULL, map->fsid_type, map->fsid);
+	exp = rqst_exp_find(rqstp, NULL, NULL, map->fsid_type, map->fsid);
 	if (IS_ERR(exp)) {
 		dprintk("%s: could not find device id\n", __func__);
 		return nfserr_noent;
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index adc731bb171e..ea3d98c43a9d 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -155,7 +155,7 @@ static inline __be32 check_pseudo_root(int nfs_vers,
  */
 static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
 				 struct svc_cred *cred, int nfs_vers,
-				 struct svc_fh *fhp)
+				 struct auth_domain *client, struct svc_fh *fhp)
 {
 	struct knfsd_fh	*fh = &fhp->fh_handle;
 	struct fid *fid = NULL;
@@ -199,7 +199,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
 	data_left -= len;
 	if (data_left < 0)
 		return error;
-	exp = rqst_exp_find(rqstp, nn, fh->fh_fsid_type, fh->fh_fsid);
+	exp = rqst_exp_find(rqstp, nn, client, fh->fh_fsid_type, fh->fh_fsid);
 	fid = (struct fid *)(fh->fh_fsid + len);
 
 	error = nfserr_stale;
@@ -331,7 +331,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
 static __be32
 __fh_verify(struct svc_rqst *rqstp,
 	    struct nfsd_net *nn, struct svc_cred *cred,
-	    int nfs_vers,
+	    int nfs_vers, struct auth_domain *client,
 	    struct svc_fh *fhp, umode_t type, int access)
 {
 	struct svc_export *exp = NULL;
@@ -339,7 +339,8 @@ __fh_verify(struct svc_rqst *rqstp,
 	__be32		error;
 
 	if (!fhp->fh_dentry) {
-		error = nfsd_set_fh_dentry(rqstp, nn, cred, nfs_vers, fhp);
+		error = nfsd_set_fh_dentry(rqstp, nn, cred, nfs_vers, client,
+					   fhp);
 		if (error)
 			goto out;
 	}
@@ -415,7 +416,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	else /* must be NLM */
 		nfs_vers = rqstp->rq_vers == 4 ? 3 : 2;
 	return __fh_verify(rqstp, net_generic(SVC_NET(rqstp), nfsd_net_id),
-			   &rqstp->rq_cred, nfs_vers,
+			   &rqstp->rq_cred, nfs_vers, rqstp->rq_client,
 			   fhp, type, access);
 }
 
-- 
2.44.0


