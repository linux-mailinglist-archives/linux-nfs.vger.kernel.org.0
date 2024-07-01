Return-Path: <linux-nfs+bounces-4453-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C15F91D65A
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 04:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF4D1C20FDE
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 02:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388B2C13B;
	Mon,  1 Jul 2024 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qHG2AzRE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sOfrKwUc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qHG2AzRE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sOfrKwUc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847A73D62
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802720; cv=none; b=huoJ1sA9sH4yDvDcSxxN5EDohNS+GGpm30+Ej52PWP1GmTXWLB2DjU+bF+L3IzU9AS43jioYdO3eRT/ktZJW/feT0LdEqmGaMIQY6OAH3URUmaf70Rm5IBDzrmTshT9ku2xz0W5bPDm8G+uuKKRnZRKRW/WqUrxBJBLVc5gZA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802720; c=relaxed/simple;
	bh=Xigck+beaN2LxcN152rBeHGnVsPrm3z629foUUDx+TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aif1PFcGdZ25PeI7hX5h6dxz7x4n7Uw5MIoSd7IU7o6pv1FyWFTyP3d+/Uo7lIEMOQYPogJQhzDJ/d9FRw/fJDckPEGMPYERTLPLw91vihNXK/SbT6cbbNBPGA0UEGbjqSDfuJKfiUBwGIg0KX34oHPJUdXYEfSViX2m59dxdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qHG2AzRE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sOfrKwUc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qHG2AzRE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sOfrKwUc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A397A219EE;
	Mon,  1 Jul 2024 02:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r220mdYJD8If/YQdr3hK/O1Vx+zA62ZvysNxIUJT+lA=;
	b=qHG2AzREJwuMcLJzxOEcL/WJgskPhaeY4s5KcnyGCyO4A8iaCC+HRPJMEyI8Izgawvi1/v
	0hEOstZBd6/UHZK9HZohNhrCVkx0t2HPfksxCSLnhJPCOvS4XuwjkI7m9AUqD6tgmohN1A
	mJeGyp1gvEb/F+WnMB2xOfNI8LUq5B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r220mdYJD8If/YQdr3hK/O1Vx+zA62ZvysNxIUJT+lA=;
	b=sOfrKwUcPO6iagWRH+uScey9C1VvrlLn6gD5TV8xbzS/MWrF9HVSwvz4XGpmPbtHojgbKD
	gFp4Shy4YXpzKsCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qHG2AzRE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sOfrKwUc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r220mdYJD8If/YQdr3hK/O1Vx+zA62ZvysNxIUJT+lA=;
	b=qHG2AzREJwuMcLJzxOEcL/WJgskPhaeY4s5KcnyGCyO4A8iaCC+HRPJMEyI8Izgawvi1/v
	0hEOstZBd6/UHZK9HZohNhrCVkx0t2HPfksxCSLnhJPCOvS4XuwjkI7m9AUqD6tgmohN1A
	mJeGyp1gvEb/F+WnMB2xOfNI8LUq5B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r220mdYJD8If/YQdr3hK/O1Vx+zA62ZvysNxIUJT+lA=;
	b=sOfrKwUcPO6iagWRH+uScey9C1VvrlLn6gD5TV8xbzS/MWrF9HVSwvz4XGpmPbtHojgbKD
	gFp4Shy4YXpzKsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0EA41340C;
	Mon,  1 Jul 2024 02:58:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qI0HEVkbgmbULgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 01 Jul 2024 02:58:33 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 1/6] nfsd: introduce __fh_verify which takes explicit nfsd_net arg
Date: Mon,  1 Jul 2024 12:53:16 +1000
Message-ID: <20240701025802.22985-2-neilb@suse.de>
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
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A397A219EE
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Spam-Level: 

This is a step towards having an interface like fh_verify() which
doesn't require a struct svc_rqst *, but instead takes the specific
parts of that which are actually needed.

This first step allows the 'struct nfsd_net *' to be passed in
separately.  __fh_verify() does not use SVC_NET(), nor does its
callers.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/export.c   | 12 ++++++++----
 fs/nfsd/export.h   |  4 +++-
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfsfh.c    | 20 ++++++++++++++------
 4 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 50b3135d07ac..a35f06b610d0 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1165,11 +1165,15 @@ rqst_exp_get_by_name(struct svc_rqst *rqstp, struct path *path)
 }
 
 struct svc_export *
-rqst_exp_find(struct svc_rqst *rqstp, int fsid_type, u32 *fsidv)
+rqst_exp_find(struct svc_rqst *rqstp,  struct nfsd_net *nn,
+	      int fsid_type, u32 *fsidv)
 {
 	struct svc_export *gssexp, *exp = ERR_PTR(-ENOENT);
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	struct cache_detail *cd = nn->svc_export_cache;
+	struct cache_detail *cd;
+
+	if (!nn)
+		nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	cd = nn->svc_export_cache;
 
 	if (rqstp->rq_client == NULL)
 		goto gss;
@@ -1220,7 +1224,7 @@ struct svc_export *rqst_find_fsidzero_export(struct svc_rqst *rqstp)
 
 	mk_fsid(FSID_NUM, fsidv, 0, 0, 0, NULL);
 
-	return rqst_exp_find(rqstp, FSID_NUM, fsidv);
+	return rqst_exp_find(rqstp, NULL, FSID_NUM, fsidv);
 }
 
 /*
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index ca9dc230ae3d..1a54d388d58d 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -127,6 +127,8 @@ static inline struct svc_export *exp_get(struct svc_export *exp)
 	cache_get(&exp->h);
 	return exp;
 }
-struct svc_export * rqst_exp_find(struct svc_rqst *, int, u32 *);
+struct nfsd_net;
+struct svc_export * rqst_exp_find(struct svc_rqst *, struct nfsd_net *,
+				  int, u32 *);
 
 #endif /* NFSD_EXPORT_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2e39cf2e502a..30335cdf9e6c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2231,7 +2231,7 @@ nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
 		return nfserr_noent;
 	}
 
-	exp = rqst_exp_find(rqstp, map->fsid_type, map->fsid);
+	exp = rqst_exp_find(rqstp, NULL, map->fsid_type, map->fsid);
 	if (IS_ERR(exp)) {
 		dprintk("%s: could not find device id\n", __func__);
 		return nfserr_noent;
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 0b75305fb5f5..e27ed27054ab 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -151,7 +151,8 @@ static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
  * dentry.  On success, the results are used to set fh_export and
  * fh_dentry.
  */
-static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
+static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
+				 struct svc_fh *fhp)
 {
 	struct knfsd_fh	*fh = &fhp->fh_handle;
 	struct fid *fid = NULL;
@@ -195,7 +196,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	data_left -= len;
 	if (data_left < 0)
 		return error;
-	exp = rqst_exp_find(rqstp, fh->fh_fsid_type, fh->fh_fsid);
+	exp = rqst_exp_find(rqstp, nn, fh->fh_fsid_type, fh->fh_fsid);
 	fid = (struct fid *)(fh->fh_fsid + len);
 
 	error = nfserr_stale;
@@ -324,16 +325,16 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
  * @access is formed from the NFSD_MAY_* constants defined in
  * fs/nfsd/vfs.h.
  */
-__be32
-fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
+static __be32
+__fh_verify(struct svc_rqst *rqstp, struct nfsd_net *nn,
+	    struct svc_fh *fhp, umode_t type, int access)
 {
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct svc_export *exp = NULL;
 	struct dentry	*dentry;
 	__be32		error;
 
 	if (!fhp->fh_dentry) {
-		error = nfsd_set_fh_dentry(rqstp, fhp);
+		error = nfsd_set_fh_dentry(rqstp, nn, fhp);
 		if (error)
 			goto out;
 	}
@@ -400,6 +401,13 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	return error;
 }
 
+__be32
+fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
+{
+	return __fh_verify(rqstp, net_generic(SVC_NET(rqstp), nfsd_net_id),
+			   fhp, type, access);
+}
+
 
 /*
  * Compose a file handle for an NFS reply.
-- 
2.44.0


