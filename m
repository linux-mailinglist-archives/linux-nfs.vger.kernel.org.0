Return-Path: <linux-nfs+bounces-4455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBAD91D65C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 04:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F941C2109D
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 02:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EC73D62;
	Mon,  1 Jul 2024 02:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KqAZxQSI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WBUNPxp5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KqAZxQSI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WBUNPxp5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0CFC13B
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 02:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802734; cv=none; b=KOdCqnywgBod4nAMg5PZt4PTkm1ErZE/6OMI6eL/B0ODYUxuP8IWwf9GObH+9b3y4oZwGHWDPvKUdn9yrfiZUIPLjKKQEWeRqEdliKup8rWdOmsErm8sEE458fqZe7VO1SypIqxuZLgtIIJoi7bCFcdbRPvMsqkMIvS/HyGelI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802734; c=relaxed/simple;
	bh=gC3cEJbR3+CerSgvfDtoUUTR+WrMC1PS/yhihNsVsAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+hCZXJiM+yNd/23wM0rZWiNmh3miF1TxCWS3HHhtZqrlKOWRL1+gZvcXt6OdpScsiEd0Kx5STUuhsZKHl5yEuWTps5skG1vki+9U8YLHET/ywcTS69Tlh2jsfc1RVEsg1eELUAic0SdrIUKeUVQNiIr8yP3df6CibIbpb9AkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KqAZxQSI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WBUNPxp5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KqAZxQSI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WBUNPxp5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31CB2219EE;
	Mon,  1 Jul 2024 02:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB3EqLxC2JRGmIuSY/xwOsawUdTSonpcPqDuEwd0UKA=;
	b=KqAZxQSIq598QrQDFxr6LfZgFgXg81Nyo61urgx8igZ3cBUUFTnpD8ODI7wW/yRQkJDeTX
	VkW8XxZGMhyft4UlTXCxqc1ZpLB1CJvfUek8QcOHL+1xYA7FKtc8LF1F+Mnjt/+Y3I4oa1
	rtnQVNkvqpfh6CGB13ZKVo5lHiZ4PmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB3EqLxC2JRGmIuSY/xwOsawUdTSonpcPqDuEwd0UKA=;
	b=WBUNPxp5v4PUlV7nX8VutLG9Nvy0MNfzium/Xi7ljKTFrRIhb3OkPeNEPQMzi6hO83exUU
	FudfyxxIqGgDOYDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KqAZxQSI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WBUNPxp5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB3EqLxC2JRGmIuSY/xwOsawUdTSonpcPqDuEwd0UKA=;
	b=KqAZxQSIq598QrQDFxr6LfZgFgXg81Nyo61urgx8igZ3cBUUFTnpD8ODI7wW/yRQkJDeTX
	VkW8XxZGMhyft4UlTXCxqc1ZpLB1CJvfUek8QcOHL+1xYA7FKtc8LF1F+Mnjt/+Y3I4oa1
	rtnQVNkvqpfh6CGB13ZKVo5lHiZ4PmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB3EqLxC2JRGmIuSY/xwOsawUdTSonpcPqDuEwd0UKA=;
	b=WBUNPxp5v4PUlV7nX8VutLG9Nvy0MNfzium/Xi7ljKTFrRIhb3OkPeNEPQMzi6hO83exUU
	FudfyxxIqGgDOYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DECB1340C;
	Mon,  1 Jul 2024 02:58:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xXuPMGcbgmb2LgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 01 Jul 2024 02:58:47 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 3/6] nfsd: pass nfs_vers explicitly to __fh_verify()
Date: Mon,  1 Jul 2024 12:53:18 +1000
Message-ID: <20240701025802.22985-4-neilb@suse.de>
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
X-Rspamd-Queue-Id: 31CB2219EE
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Rather then depending on rqstp->rq_vers to determine nfs version, pass
it in explicitly.  This removes another dependency on rqstp and ensures
the correct version is checked.  The rqstp can be for an NLM request and
while some code tests that, other code does not.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsfh.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 760684fa4b50..adc731bb171e 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -62,7 +62,7 @@ static int nfsd_acceptable(void *expv, struct dentry *dentry)
  * the write call).
  */
 static inline __be32
-nfsd_mode_check(struct svc_rqst *rqstp, struct dentry *dentry,
+nfsd_mode_check(int nfs_vers, struct dentry *dentry,
 		umode_t requested)
 {
 	umode_t mode = d_inode(dentry)->i_mode & S_IFMT;
@@ -80,7 +80,7 @@ nfsd_mode_check(struct svc_rqst *rqstp, struct dentry *dentry,
 	 * v4 has an error more specific than err_notdir which we should
 	 * return in preference to err_notdir:
 	 */
-	if (rqstp->rq_vers == 4 && mode == S_IFLNK)
+	if (nfs_vers == 4 && mode == S_IFLNK)
 		return nfserr_symlink;
 	if (requested == S_IFDIR)
 		return nfserr_notdir;
@@ -117,8 +117,9 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 	return nfserrno(nfsd_setuser(cred, exp));
 }
 
-static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
-	struct dentry *dentry, struct svc_export *exp)
+static inline __be32 check_pseudo_root(int nfs_vers,
+				       struct dentry *dentry,
+				       struct svc_export *exp)
 {
 	if (!(exp->ex_flags & NFSEXP_V4ROOT))
 		return nfs_ok;
@@ -128,7 +129,7 @@ static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
 	 * in v4-specific code, in which case v2/v3 clients could bypass
 	 * them.
 	 */
-	if (!nfsd_v4client(rqstp))
+	if (nfs_vers != 4)
 		return nfserr_stale;
 	/*
 	 * We're exposing only the directories and symlinks that have to be
@@ -153,7 +154,7 @@ static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
  * fh_dentry.
  */
 static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
-				 struct svc_cred *cred,
+				 struct svc_cred *cred, int nfs_vers,
 				 struct svc_fh *fhp)
 {
 	struct knfsd_fh	*fh = &fhp->fh_handle;
@@ -166,9 +167,9 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
 	__be32 error;
 
 	error = nfserr_stale;
-	if (rqstp->rq_vers > 2)
+	if (nfs_vers > 2)
 		error = nfserr_badhandle;
-	if (rqstp->rq_vers == 4 && fh->fh_size == 0)
+	if (nfs_vers == 4 && fh->fh_size == 0)
 		return nfserr_nofilehandle;
 
 	if (fh->fh_version != 1)
@@ -241,7 +242,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
 	 * Look up the dentry using the NFS file handle.
 	 */
 	error = nfserr_stale;
-	if (rqstp->rq_vers > 2)
+	if (nfs_vers > 2)
 		error = nfserr_badhandle;
 
 	fileid_type = fh->fh_fileid_type;
@@ -281,7 +282,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
 	fhp->fh_dentry = dentry;
 	fhp->fh_export = exp;
 
-	switch (rqstp->rq_vers) {
+	switch (nfs_vers) {
 	case 4:
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
 			fhp->fh_no_atomic_attr = true;
@@ -330,6 +331,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
 static __be32
 __fh_verify(struct svc_rqst *rqstp,
 	    struct nfsd_net *nn, struct svc_cred *cred,
+	    int nfs_vers,
 	    struct svc_fh *fhp, umode_t type, int access)
 {
 	struct svc_export *exp = NULL;
@@ -337,7 +339,7 @@ __fh_verify(struct svc_rqst *rqstp,
 	__be32		error;
 
 	if (!fhp->fh_dentry) {
-		error = nfsd_set_fh_dentry(rqstp, nn, cred, fhp);
+		error = nfsd_set_fh_dentry(rqstp, nn, cred, nfs_vers, fhp);
 		if (error)
 			goto out;
 	}
@@ -362,7 +364,7 @@ __fh_verify(struct svc_rqst *rqstp,
 	 *	  (for example, if different id-squashing options are in
 	 *	  effect on the new filesystem).
 	 */
-	error = check_pseudo_root(rqstp, dentry, exp);
+	error = check_pseudo_root(nfs_vers, dentry, exp);
 	if (error)
 		goto out;
 
@@ -370,7 +372,7 @@ __fh_verify(struct svc_rqst *rqstp,
 	if (error)
 		goto out;
 
-	error = nfsd_mode_check(rqstp, dentry, type);
+	error = nfsd_mode_check(nfs_vers, dentry, type);
 	if (error)
 		goto out;
 
@@ -407,12 +409,16 @@ __fh_verify(struct svc_rqst *rqstp,
 __be32
 fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 {
+	int nfs_vers;
+	if (rqstp->rq_prog == NFS_PROGRAM)
+		nfs_vers = rqstp->rq_vers;
+	else /* must be NLM */
+		nfs_vers = rqstp->rq_vers == 4 ? 3 : 2;
 	return __fh_verify(rqstp, net_generic(SVC_NET(rqstp), nfsd_net_id),
-			   &rqstp->rq_cred,
+			   &rqstp->rq_cred, nfs_vers,
 			   fhp, type, access);
 }
 
-
 /*
  * Compose a file handle for an NFS reply.
  *
-- 
2.44.0


