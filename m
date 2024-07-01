Return-Path: <linux-nfs+bounces-4458-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCD091D65F
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 04:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B23B1F211D8
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 02:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C73D62;
	Mon,  1 Jul 2024 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yoMpiS+y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VwxAmUGm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wwbK1edn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7k7Uwh8M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305D8D535
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802761; cv=none; b=iqSa0wTFSEkv0zSuDmx7xdlr1N/4ASIn6yFrUsIT/3Zk+p+uM7mzol6ZyZkngBar2gS0dyXlMoEWAfQlQ/RuRy2Mfh1FI/LlqBk+4cqEnzMJ+5J5Mlpm1rnMcPWzhsIzlKHMa8plbRU357qyB89N9aZgqOaqAm6Xfj/m+zz9PI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802761; c=relaxed/simple;
	bh=zxTbQ783C55lnQxkbVp/MJLGQV4nYg4ZzrOeqiknQdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fp7bTrSjRfmTeGtmU4FHSv8Ay5389Hc2SkQkdKmDWZ+YAI+bRULd8BCFcPFiUQoIaemaXNofQjFZgofGf6WiXx3NWTHm2QLEz5F04h9/pDcs68KfrkrlPJq7kg87k3Foat10UX9abqlJKtQiv3bW9Npb5ZGKH1am6Tfes7swYAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yoMpiS+y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VwxAmUGm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wwbK1edn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7k7Uwh8M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A11A1F8BB;
	Mon,  1 Jul 2024 02:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtKMJ2rEN8YMYT7xxEmsChXBdk4MeiUyLR7ELvMMJl0=;
	b=yoMpiS+yaQkVzLUV/G+KCWkm+3hO2p5igUcSzcS9STb7mcec+np3yWv/WYhpbaOVbz4C0a
	r4e79Ak0xN/p40hoxBOQ73Tj5/liYJ17Y0EgC71hpQYStnO21ZoMx5yjONs956Dxqv0WVA
	x0W//uaRa+S14Fr3zE0nZRh3lib2+OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtKMJ2rEN8YMYT7xxEmsChXBdk4MeiUyLR7ELvMMJl0=;
	b=VwxAmUGmGFT1yMDav+9Y/n4tIuc/BEA1jbwXlrpyyVh9HCv16/pMvTFLfElITY6/3vnM/y
	/Hpj6qU6m+AGv3Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtKMJ2rEN8YMYT7xxEmsChXBdk4MeiUyLR7ELvMMJl0=;
	b=wwbK1ednm1avc5xC1X7/+JPYE6sUgQwh9kH0nzrTx0wIE5a1Ji5fIFaVK6krrkO+OtOgrC
	4gzCjUdad9OLH/2SSQJ1ATpT2Q5X04B0XzAE47AE4hTrRm6nsMwOwBFb+lHS/W0LRDst1k
	RpEmhgzwTWy/vmjOHMDQPgwWhVAPFgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtKMJ2rEN8YMYT7xxEmsChXBdk4MeiUyLR7ELvMMJl0=;
	b=7k7Uwh8MBFQOoZ7/pVkV4esTTi7bn/EPN9zIz4xF04cvux7TTTDflFerEaj4NKTX0oozM/
	cB50+MM0cBAqEmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A304F1340C;
	Mon,  1 Jul 2024 02:59:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /HDlEYEbgmYgLwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 01 Jul 2024 02:59:13 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 6/6] nfsd: add nfsd_file_acquire_local().
Date: Mon,  1 Jul 2024 12:53:21 +1000
Message-ID: <20240701025802.22985-7-neilb@suse.de>
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

nfsd_file_acquire_local() can be used to look up a file by filehandle
without having a struct rqst.  This can be used by NFS LOCALIO to allow
the NFS client to by the NFS protocol to directly access a file provided
by the NFS server which is running in the same kernel.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 54 ++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/filecache.h |  4 ++++
 fs/nfsd/nfsfh.c     |  2 +-
 fs/nfsd/nfsfh.h     |  5 +++++
 4 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ad9083ca144b..87f965d2574b 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -977,7 +977,10 @@ nfsd_file_is_cached(struct inode *inode)
 }
 
 static __be32
-nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
+nfsd_file_do_acquire(struct svc_rqst *rqstp, struct nfsd_net *nn,
+		     struct svc_cred *cred, int nfs_vers,
+		     struct auth_domain *client,
+		     struct svc_fh *fhp,
 		     unsigned int may_flags, struct file *file,
 		     struct nfsd_file **pnf, bool want_gc)
 {
@@ -991,7 +994,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int ret;
 
 retry:
-	status = fh_verify(rqstp, fhp, S_IFREG,
+	status = __fh_verify(rqstp, nn, cred, nfs_vers, client, fhp, S_IFREG,
 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
 	if (status != nfs_ok)
 		return status;
@@ -1139,7 +1142,8 @@ __be32
 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
+	return nfsd_file_do_acquire(rqstp, NULL, NULL, 0, NULL,
+				    fhp, may_flags, NULL, pnf, true);
 }
 
 /**
@@ -1163,7 +1167,46 @@ __be32
 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, false);
+	return nfsd_file_do_acquire(rqstp, NULL, NULL, 0, NULL, fhp,
+				    may_flags, NULL, pnf, false);
+}
+
+/**
+ * nfsd_file_acquire_local - Get a struct nfsd_file with an open file for localio
+ * @nn: The nfsd network namespace in which to perform a lookup
+ * @cred: the user credential with which to validate access
+ * @nfs_vers: NFS version number to assume for request
+ * @client: the auth_domain for LOCALIO lookup
+ * @fhp: the NFS filehandle of the file to be opened
+ * @may_flags: NFSD_MAY_ settings for the file
+ * @pnf: OUT: new or found "struct nfsd_file" object
+ *
+ * This file lookup interface provide access to a file given the
+ * filehandle and credential.  No connection-based authorisation
+ * is performed and in that way it is quite different to other
+ * file access mediated by nfsd.  It allows a kernel module such as the NFS
+ * client to reach across network and filesystem namespaces to access
+ * a file.  The security implications of this should be carefully
+ * considered before use.
+ *
+ * The nfsd_file_object returned by this API is reference-counted
+ * but not garbage-collected. The object is unhashed after the
+ * final nfsd_file_put().
+ *
+ * Return values:
+ *   %nfs_ok - @pnf points to an nfsd_file with its reference
+ *   count boosted.
+ *
+ * On error, an nfsstat value in network byte order is returned.
+ */
+__be32
+nfsd_file_acquire_local(struct nfsd_net *nn, struct svc_cred *cred,
+			int nfs_vers, struct auth_domain *client,
+			struct svc_fh *fhp,
+			unsigned int may_flags, struct nfsd_file **pnf)
+{
+	return nfsd_file_do_acquire(NULL, nn, cred, nfs_vers, client,
+				    fhp, may_flags, NULL, pnf, false);
 }
 
 /**
@@ -1189,7 +1232,8 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			 unsigned int may_flags, struct file *file,
 			 struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
+	return nfsd_file_do_acquire(rqstp, NULL, NULL, 0, NULL,
+				    fhp, may_flags, file, pnf, false);
 }
 
 /*
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index c61884def906..d179dbae98e3 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -65,5 +65,9 @@ __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 __be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct file *file,
 		  struct nfsd_file **nfp);
+__be32 nfsd_file_acquire_local(struct nfsd_net *nn, struct svc_cred *cred,
+			       int nfs_vers, struct auth_domain *client,
+			       struct svc_fh *fhp,
+			       unsigned int may_flags, struct nfsd_file **pnf);
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index fb5a23060a4c..fa7e358d91ab 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -328,7 +328,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
  * @access is formed from the NFSD_MAY_* constants defined in
  * fs/nfsd/vfs.h.
  */
-static __be32
+__be32
 __fh_verify(struct svc_rqst *rqstp,
 	    struct nfsd_net *nn, struct svc_cred *cred,
 	    int nfs_vers, struct auth_domain *client,
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 6ebdf7ea27bf..a2d9962f1bf8 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -214,7 +214,12 @@ extern char * SVCFH_fmt(struct svc_fh *fhp);
 /*
  * Function prototypes
  */
+struct nfsd_net;
 __be32	fh_verify(struct svc_rqst *, struct svc_fh *, umode_t, int);
+__be32	__fh_verify(struct svc_rqst *rqstp,
+		    struct nfsd_net *nn, struct svc_cred *cred,
+		    int nfs_vers, struct auth_domain *client,
+		    struct svc_fh *fhp, umode_t type, int access);
 __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
 __be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
-- 
2.44.0


