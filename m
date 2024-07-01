Return-Path: <linux-nfs+bounces-4454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904891D65B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 04:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13D028194A
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 02:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DF53D62;
	Mon,  1 Jul 2024 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pRUj1yS4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JpOV4DW5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RqENmGv6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HM2idDG1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7716C13B
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802728; cv=none; b=Cp1loOkrft3OAieILrXqvM1no3tdJ7jpqD6KULIvKO2TKGs3IKzt9dNKdJtd/XH3KdnvJDa0Y4Uvr+B4ENor/8fPhy+vBsGxW/yiqcJIDnocLP4HL00IfiNAbefWSGc1oeCe5AikIZxUknPD35eyoXMWjP6VrkaIHcw2nF5ilAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802728; c=relaxed/simple;
	bh=Iq29TcalvSOPzqEMMRg8m0Xr7tmY2JCADQp8y/uhISg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWbAogM8p44wOZmyyWp1KTfX4wYJgysEt4gsmy2Dd9Be0UNdLrW7QwCoZ8x/ztHRqKajQsQ4zwWymd/mFSdNfid6+RWPhkTrfhnukBVOP8QAnq6HssU+bx5LzcNuoX0aRm1KMTcOUAFJBk9PmWBDZpNCogGrySitVsilXZubWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pRUj1yS4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JpOV4DW5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RqENmGv6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HM2idDG1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4B4E219EE;
	Mon,  1 Jul 2024 02:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAszePV7xAY9I57K+3A+VwhNSFS3DRP62W975wixz+Y=;
	b=pRUj1yS4H3R0pWcBo8Npp6Ca7PCtDVQGj3Jo23HbVD8XrwPriNATydFKDiAysTU88nPUVZ
	PPGfBlCu4vtT4gNW1PjM4rfdzarymCE0EwcFsc4IuX91bHEfHe+FLRTNKIrHJvbKaC7sVP
	kiHRnQOwlGBJ+nMzaDaYOkhr/ouSW+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAszePV7xAY9I57K+3A+VwhNSFS3DRP62W975wixz+Y=;
	b=JpOV4DW5OgFUPr/92dxwHyUkbXwSmr0QI/wiiDDMsTWck6D8U3unHcfpdlXAeEfb0ZWO9r
	iSGbCEyR4X6EWHDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RqENmGv6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HM2idDG1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAszePV7xAY9I57K+3A+VwhNSFS3DRP62W975wixz+Y=;
	b=RqENmGv6/SQITUoIlB+H5wG0MOilz1rp09OlWBvNHT/vv1iscjBDQaEQplAD9nN5K+6fAP
	zh+DU5dyzNeBA9TEsWXegqfCxsL6XD6dXImq+gm/vQ82TKMeX4K8ophx3S6QqUNsjHwGoN
	GcVQ9lrI0JR4wVqrsz3WqgNO4uSQjEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAszePV7xAY9I57K+3A+VwhNSFS3DRP62W975wixz+Y=;
	b=HM2idDG16WGIRotNicOZ5MUDcmWZk/6QFuZ1HYsALXVt6zCax00o4DZVljBkey8mbHJMZQ
	sYK97wa3weRwpWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3DF21340C;
	Mon,  1 Jul 2024 02:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i0d/IWAbgmboLgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 01 Jul 2024 02:58:40 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 2/6] nfsd: add cred parameter to __fh_verify()
Date: Mon,  1 Jul 2024 12:53:17 +1000
Message-ID: <20240701025802.22985-3-neilb@suse.de>
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
X-Rspamd-Queue-Id: E4B4E219EE
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

__fh_verify() now takes a 'cred' parameter and never dereferences
rqstp->rq_cred.

nfsd_permission(), nfsd_setuser() and nfsexp_flags() only never needed
the cred out of rqstp, so we now pass in the cred explicitly and not the
rqstp.

nfsd_originating_port_ok() is NOT passed a cred despite that it uses
one.  This function is not useful when rqstp is NULL and a future patch
will address that.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/auth.c      | 14 +++++++-------
 fs/nfsd/auth.h      |  2 +-
 fs/nfsd/export.h    |  3 ++-
 fs/nfsd/nfs4state.c |  3 ++-
 fs/nfsd/nfsfh.c     | 18 +++++++++++-------
 fs/nfsd/nfsproc.c   |  9 +++++----
 fs/nfsd/vfs.c       | 21 ++++++++++++---------
 fs/nfsd/vfs.h       |  2 +-
 8 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/auth.c b/fs/nfsd/auth.c
index e6beaaf4f170..93e33d1ee891 100644
--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -5,26 +5,26 @@
 #include "nfsd.h"
 #include "auth.h"
 
-int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp)
+int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp)
 {
 	struct exp_flavor_info *f;
 	struct exp_flavor_info *end = exp->ex_flavors + exp->ex_nflavors;
 
 	for (f = exp->ex_flavors; f < end; f++) {
-		if (f->pseudoflavor == rqstp->rq_cred.cr_flavor)
+		if (f->pseudoflavor == cred->cr_flavor)
 			return f->flags;
 	}
 	return exp->ex_flags;
 
 }
 
-int nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
+int nfsd_setuser(struct svc_cred *cred, struct svc_export *exp)
 {
 	struct group_info *rqgi;
 	struct group_info *gi;
 	struct cred *new;
 	int i;
-	int flags = nfsexp_flags(rqstp, exp);
+	int flags = nfsexp_flags(cred, exp);
 
 	/* discard any old override before preparing the new set */
 	revert_creds(get_cred(current_real_cred()));
@@ -32,10 +32,10 @@ int nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
 	if (!new)
 		return -ENOMEM;
 
-	new->fsuid = rqstp->rq_cred.cr_uid;
-	new->fsgid = rqstp->rq_cred.cr_gid;
+	new->fsuid = cred->cr_uid;
+	new->fsgid = cred->cr_gid;
 
-	rqgi = rqstp->rq_cred.cr_group_info;
+	rqgi = cred->cr_group_info;
 
 	if (flags & NFSEXP_ALLSQUASH) {
 		new->fsuid = exp->ex_anon_uid;
diff --git a/fs/nfsd/auth.h b/fs/nfsd/auth.h
index dbd66424f600..fc75c5d90be4 100644
--- a/fs/nfsd/auth.h
+++ b/fs/nfsd/auth.h
@@ -12,6 +12,6 @@
  * Set the current process's fsuid/fsgid etc to those of the NFS
  * client user
  */
-int nfsd_setuser(struct svc_rqst *, struct svc_export *);
+int nfsd_setuser(struct svc_cred *, struct svc_export *);
 
 #endif /* LINUX_NFSD_AUTH_H */
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index 1a54d388d58d..2dbd15704a86 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -99,7 +99,8 @@ struct svc_expkey {
 #define EX_NOHIDE(exp)		((exp)->ex_flags & NFSEXP_NOHIDE)
 #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
 
-int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
+struct svc_cred;
+int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp);
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
 
 /*
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..eadb7d1a7f13 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6889,7 +6889,8 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 
 	nf = nfs4_find_file(s, flags);
 	if (nf) {
-		status = nfsd_permission(rqstp, fhp->fh_export, fhp->fh_dentry,
+		status = nfsd_permission(&rqstp->rq_cred,
+					 fhp->fh_export, fhp->fh_dentry,
 				acc | NFSD_MAY_OWNER_OVERRIDE);
 		if (status) {
 			nfsd_file_put(nf);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index e27ed27054ab..760684fa4b50 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -100,9 +100,10 @@ static bool nfsd_originating_port_ok(struct svc_rqst *rqstp, int flags)
 }
 
 static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
+					  struct svc_cred *cred,
 					  struct svc_export *exp)
 {
-	int flags = nfsexp_flags(rqstp, exp);
+	int flags = nfsexp_flags(cred, exp);
 
 	/* Check if the request originated from a secure port. */
 	if (!nfsd_originating_port_ok(rqstp, flags)) {
@@ -113,7 +114,7 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 	}
 
 	/* Set user creds for this exportpoint */
-	return nfserrno(nfsd_setuser(rqstp, exp));
+	return nfserrno(nfsd_setuser(cred, exp));
 }
 
 static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
@@ -152,6 +153,7 @@ static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
  * fh_dentry.
  */
 static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
+				 struct svc_cred *cred,
 				 struct svc_fh *fhp)
 {
 	struct knfsd_fh	*fh = &fhp->fh_handle;
@@ -230,7 +232,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
 		put_cred(override_creds(new));
 		put_cred(new);
 	} else {
-		error = nfsd_setuser_and_check_port(rqstp, exp);
+		error = nfsd_setuser_and_check_port(rqstp, cred, exp);
 		if (error)
 			goto out;
 	}
@@ -326,7 +328,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
  * fs/nfsd/vfs.h.
  */
 static __be32
-__fh_verify(struct svc_rqst *rqstp, struct nfsd_net *nn,
+__fh_verify(struct svc_rqst *rqstp,
+	    struct nfsd_net *nn, struct svc_cred *cred,
 	    struct svc_fh *fhp, umode_t type, int access)
 {
 	struct svc_export *exp = NULL;
@@ -334,7 +337,7 @@ __fh_verify(struct svc_rqst *rqstp, struct nfsd_net *nn,
 	__be32		error;
 
 	if (!fhp->fh_dentry) {
-		error = nfsd_set_fh_dentry(rqstp, nn, fhp);
+		error = nfsd_set_fh_dentry(rqstp, nn, cred, fhp);
 		if (error)
 			goto out;
 	}
@@ -363,7 +366,7 @@ __fh_verify(struct svc_rqst *rqstp, struct nfsd_net *nn,
 	if (error)
 		goto out;
 
-	error = nfsd_setuser_and_check_port(rqstp, exp);
+	error = nfsd_setuser_and_check_port(rqstp, cred, exp);
 	if (error)
 		goto out;
 
@@ -393,7 +396,7 @@ __fh_verify(struct svc_rqst *rqstp, struct nfsd_net *nn,
 
 skip_pseudoflavor_check:
 	/* Finally, check access permissions. */
-	error = nfsd_permission(rqstp, exp, dentry, access);
+	error = nfsd_permission(cred, exp, dentry, access);
 out:
 	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
 	if (error == nfserr_stale)
@@ -405,6 +408,7 @@ __be32
 fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 {
 	return __fh_verify(rqstp, net_generic(SVC_NET(rqstp), nfsd_net_id),
+			   &rqstp->rq_cred,
 			   fhp, type, access);
 }
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 36370b957b63..97aab34593ef 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -331,10 +331,11 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 					 *   echo thing > device-special-file-or-pipe
 					 * by doing a CREATE with type==0
 					 */
-					resp->status = nfsd_permission(rqstp,
-								 newfhp->fh_export,
-								 newfhp->fh_dentry,
-								 NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS);
+					resp->status = nfsd_permission(
+						&rqstp->rq_cred,
+						newfhp->fh_export,
+						newfhp->fh_dentry,
+						NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS);
 					if (resp->status && resp->status != nfserr_rofs)
 						goto out_unlock;
 				}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29b1f3613800..0862f6ae86a9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -421,8 +421,9 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (iap->ia_size < inode->i_size) {
 		__be32 err;
 
-		err = nfsd_permission(rqstp, fhp->fh_export, fhp->fh_dentry,
-				NFSD_MAY_TRUNC | NFSD_MAY_OWNER_OVERRIDE);
+		err = nfsd_permission(&rqstp->rq_cred,
+				      fhp->fh_export, fhp->fh_dentry,
+				      NFSD_MAY_TRUNC | NFSD_MAY_OWNER_OVERRIDE);
 		if (err)
 			return err;
 	}
@@ -814,7 +815,8 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *suppor
 
 			sresult |= map->access;
 
-			err2 = nfsd_permission(rqstp, export, dentry, map->how);
+			err2 = nfsd_permission(&rqstp->rq_cred, export,
+					       dentry, map->how);
 			switch (err2) {
 			case nfs_ok:
 				result |= map->access;
@@ -1475,7 +1477,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dirp = d_inode(dentry);
 
 	dchild = dget(resfhp->fh_dentry);
-	err = nfsd_permission(rqstp, fhp->fh_export, dentry, NFSD_MAY_CREATE);
+	err = nfsd_permission(&rqstp->rq_cred, fhp->fh_export, dentry,
+			      NFSD_MAY_CREATE);
 	if (err)
 		goto out;
 
@@ -2255,9 +2258,9 @@ nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat, in
 	return err;
 }
 
-static int exp_rdonly(struct svc_rqst *rqstp, struct svc_export *exp)
+static int exp_rdonly(struct svc_cred *cred, struct svc_export *exp)
 {
-	return nfsexp_flags(rqstp, exp) & NFSEXP_READONLY;
+	return nfsexp_flags(cred, exp) & NFSEXP_READONLY;
 }
 
 #ifdef CONFIG_NFSD_V4
@@ -2501,8 +2504,8 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
  * Check for a user's access permissions to this inode.
  */
 __be32
-nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
-					struct dentry *dentry, int acc)
+nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
+		struct dentry *dentry, int acc)
 {
 	struct inode	*inode = d_inode(dentry);
 	int		err;
@@ -2533,7 +2536,7 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
 	 */
 	if (!(acc & NFSD_MAY_LOCAL_ACCESS))
 		if (acc & (NFSD_MAY_WRITE | NFSD_MAY_SATTR | NFSD_MAY_TRUNC)) {
-			if (exp_rdonly(rqstp, exp) ||
+			if (exp_rdonly(cred, exp) ||
 			    __mnt_is_readonly(exp->ex_path.mnt))
 				return nfserr_rofs;
 			if (/* (acc & NFSD_MAY_WRITE) && */ IS_IMMUTABLE(inode))
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 57cd70062048..1565c1dc28b6 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -153,7 +153,7 @@ __be32		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 				struct kstatfs *, int access);
 
-__be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
+__be32		nfsd_permission(struct svc_cred *, struct svc_export *,
 				struct dentry *, int);
 
 void		nfsd_filp_close(struct file *fp);
-- 
2.44.0


