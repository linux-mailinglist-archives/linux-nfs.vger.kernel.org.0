Return-Path: <linux-nfs+bounces-22750-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N+3LEi5ZOGpgbQcAu9opvQ
	(envelope-from <linux-nfs+bounces-22750-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 23:35:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D42746AB9B9
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 23:35:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HKWL2djo;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22750-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22750-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F3C430022ED
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 21:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017382836A0;
	Sun, 21 Jun 2026 21:35:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3833597B
	for <linux-nfs@vger.kernel.org>; Sun, 21 Jun 2026 21:35:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782077738; cv=none; b=Tdjch1yHBe08VrQrFFz5LYPljNN4dQplhG22KATCGOW0wNdlT6IKifNhsY+Go2mZXoF0TPAPjsJ3TnIgV8xSIzjznasmcs2v9+DcD0vySmGxG1NtxCvQ3KXAzpi7GDzgt3izRebQXgTzAPdL4O1FQWjB3f1tjaOl7z7knrccD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782077738; c=relaxed/simple;
	bh=RwlGMzMdnM7O94MzezUO/QwJUx/Q+TLSZA1jlmgTVnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDQvwHaTkjMWFZSvG0JRK5Dt3lwJ2LQHV/DYLe10H6dZR8UBqmTy2bMjrANT08EI5E5LuVfGUZpmUW2tt/fv1lHZNwQqFDLnlNSheqoZICG4DsFX/gSwDxzm+U5hN7CM7fGrYm0RdzmkHitE9VnqCPeECOHIei4/3C5VJtO/syI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKWL2djo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E571F000E9;
	Sun, 21 Jun 2026 21:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782077737;
	bh=qO39d/NGhJfs+nDphxcxALKfJwSbhRYXc2H073neJiE=;
	h=From:To:Cc:Subject:Date;
	b=HKWL2djoosdkeQhlHQ9SQL7dFKDNSflzb7oexb3aUEr/WKLQrBaZzPxMyXZ6saauJ
	 AvkRSpn9US7nL+QXEks98+Em/22GVzGRtq6OJN4DOjFBE1EP5+dJe8sv1awyhjLVoI
	 6w5pi7/UnHafKxw73eQsVKoyIfN7JGkhv19unITQwEiwkuAyyt20L2bXI4TlAFIfl4
	 cWEtuT5QSWq2RxeMzhU8tZukIVMwDtxLbrTcqc2LVs58gaTJG1ssf/ZIfKMbVIEqgR
	 RetTFr+9luCsyViq30OKzjR6ciLQrUIJeF0AljCOHVadgVXu1ka4+fkrmrvNthFgJ5
	 w2fhhnWQdceiw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFSD: Replace isdotent() macro
Date: Sun, 21 Jun 2026 17:35:35 -0400
Message-ID: <20260621213535.539450-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22750-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:jlayton@kernel.org,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D42746AB9B9

The VFS provides name_is_dot_dotdot() as the canonical helper for
recognizing the "." and ".." directory entries, and fs/ already uses
it widely. nfsd has instead carried its own open-coded isdotent()
macro that computes the same predicate for non-empty names, a needless
duplicate of shared functionality. The macro reads the first name byte
without first confirming the name is non-empty; name_is_dot_dotdot()
tests the length first, so it never touches a zero-length buffer.
Convert every isdotent() call site to the generic helper and remove the
macro.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs3proc.c |  2 +-
 fs/nfsd/nfs3xdr.c  |  2 +-
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfs4xdr.c  |  4 ++--
 fs/nfsd/nfsd.h     |  3 ---
 fs/nfsd/nfsproc.c  |  2 +-
 fs/nfsd/vfs.c      | 13 +++++++------
 7 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 42adc5461db0..a14827cfeeb8 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -265,7 +265,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_vfs_create(rqstp, fhp, S_IFREG, argp->name, argp->len);
 
-	if (isdotent(argp->name, argp->len))
+	if (name_is_dot_dotdot(argp->name, argp->len))
 		return nfserr_exist;
 	if (!(iap->ia_valid & ATTR_MODE))
 		iap->ia_mode = 0;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 2ff9a991a8fb..e481804bb120 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -987,7 +987,7 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
 	dparent = cd->fh.fh_dentry;
 	exp  = cd->fh.fh_export;
 
-	if (isdotent(name, namlen)) {
+	if (name_is_dot_dotdot(name, namlen)) {
 		if (namlen == 2) {
 			dchild = dget_parent(dparent);
 			/*
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 907b899a90da..654705d1dd37 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -259,7 +259,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 status;
 	int host_err;
 
-	if (isdotent(open->op_fname, open->op_fnamelen))
+	if (name_is_dot_dotdot(open->op_fname, open->op_fnamelen))
 		return nfserr_exist;
 	if (!(iap->ia_valid & ATTR_MODE))
 		iap->ia_mode = 0;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2a0946c630e1..8db16a30d971 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -98,7 +98,7 @@ check_filename(char *str, int len)
 		return nfserr_inval;
 	if (len > NFS4_MAXNAMLEN)
 		return nfserr_nametoolong;
-	if (isdotent(str, len))
+	if (name_is_dot_dotdot(str, len))
 		return nfserr_badname;
 	for (i = 0; i < len; i++)
 		if (str[i] == '/')
@@ -4241,7 +4241,7 @@ nfsd4_encode_entry4(void *ccdv, const char *name, int namlen,
 	__be32 nfserr = nfserr_toosmall;
 
 	/* In nfsv4, "." and ".." never make it onto the wire.. */
-	if (name && isdotent(name, namlen)) {
+	if (name && name_is_dot_dotdot(name, namlen)) {
 		cd->common.err = nfs_ok;
 		return 0;
 	}
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 7c009f07c90b..faf5c1dafa42 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -372,9 +372,6 @@ enum {
 #define	nfserr_symlink_not_dir	cpu_to_be32(NFSERR_SYMLINK_NOT_DIR)
 };
 
-/* Check for dir entries '.' and '..' */
-#define isdotent(n, l)	(l < 3 && n[0] == '.' && (l == 1 || n[1] == '.'))
-
 #ifdef CONFIG_NFSD_V4
 
 /* before processing a COMPOUND operation, we have to check that there
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 8873033d1e82..846506445ff9 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -298,7 +298,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	/* Check for NFSD_MAY_WRITE in nfsd_create if necessary */
 
 	resp->status = nfserr_exist;
-	if (isdotent(argp->name, argp->len))
+	if (name_is_dot_dotdot(argp->name, argp->len))
 		goto done;
 	hosterr = fh_want_write(dirfhp);
 	if (hosterr) {
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index eafdf7b7890f..73506e924dc3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -255,7 +255,7 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	exp = exp_get(fhp->fh_export);
 
 	/* Lookup the name, but don't follow links */
-	if (isdotent(name, len)) {
+	if (name_is_dot_dotdot(name, len)) {
 		if (len==1)
 			dentry = dget(dparent);
 		else if (dparent != exp->ex_path.dentry)
@@ -1867,7 +1867,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_vfs_create(rqstp, fhp, type, fname, flen);
 
-	if (isdotent(fname, flen))
+	if (name_is_dot_dotdot(fname, flen))
 		return nfserr_exist;
 
 	err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_NOP);
@@ -1969,7 +1969,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!flen || path[0] == '\0')
 		goto out;
 	err = nfserr_exist;
-	if (isdotent(fname, flen))
+	if (name_is_dot_dotdot(fname, flen))
 		goto out;
 
 	err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
@@ -2046,7 +2046,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	if (!len)
 		goto out;
 	err = nfserr_exist;
-	if (isdotent(name, len))
+	if (name_is_dot_dotdot(name, len))
 		goto out;
 
 	err = nfs_ok;
@@ -2157,7 +2157,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	tdentry = tfhp->fh_dentry;
 
 	err = nfserr_perm;
-	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
+	if (!flen || name_is_dot_dotdot(fname, flen) ||
+	    !tlen || name_is_dot_dotdot(tname, tlen))
 		goto out;
 
 	err = nfserr_xdev;
@@ -2279,7 +2280,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	trace_nfsd_vfs_unlink(rqstp, fhp, fname, flen);
 
 	err = nfserr_acces;
-	if (!flen || isdotent(fname, flen))
+	if (!flen || name_is_dot_dotdot(fname, flen))
 		goto out;
 	err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_REMOVE);
 	if (err)
-- 
2.54.0


