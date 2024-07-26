Return-Path: <linux-nfs+bounces-5057-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DB593CCB5
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 04:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386B828124B
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 02:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E637318E11;
	Fri, 26 Jul 2024 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QU4afctr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QintuUqb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QU4afctr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QintuUqb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBAC320B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721960774; cv=none; b=SX/IOGD/6iCgdeyAk41Jm0LU8KfoC+fsMiyWHYTNUoq7ym1rpiiF4fXvaEXnsJk6cciTWhwHCOQXaJaNkNiUO6mSNy5Vl5pYkc3a33OE1DuuAPq7AHX8/7rumQSGiRmymidxdRRebRALdiXAV8ThfOcnzhV024HN3t6h43SksC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721960774; c=relaxed/simple;
	bh=H+Mb84lISPPcLCSKrCa+3G1tqKmhfQ2U0vfew5wwU7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtQfMg4SSoqNJoXi2mIQwsnH1D+OT3GcGyUCgXg1vefYyKD55HPC3RNFWy//WaVZc5om+NyLJwlC8r9zb6t+H3qArjyuTHZXi/6F48mtUzswwu4qZVj6jY1TJtRHXKlh+Yb4dHzm2SmTC4iyfT96nj9NfHHI5uXZ4Xd1Tna5lds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QU4afctr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QintuUqb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QU4afctr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QintuUqb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05D30218BB;
	Fri, 26 Jul 2024 02:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721960771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoFISfuP5t+G0rWFwVY1UulJot7cJ6ChkZ8KaEYuIAc=;
	b=QU4afctrVDsH7ZR4oFXizctSKQaRhx2EnDRihwDwlvrjumgQ2Aho+5SdvNMIYUInMAdaxK
	xN5RUn0oCdqy3encGGoq8Z5u5/e+AuEinfMHWgB3bQorjms+jBLOVJyg78Kn/LYyd5uMTr
	6Xq+VH2npXUeB0zoZUYQNx6YrBBtEgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721960771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoFISfuP5t+G0rWFwVY1UulJot7cJ6ChkZ8KaEYuIAc=;
	b=QintuUqbl6SzlJyftPqh0E+jE3JkGhwCJmOj79SHGP1XJlTGllWpOuzwzbOYU3KGpD1Mb1
	m6fabDrUcQqrEUDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QU4afctr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QintuUqb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721960771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoFISfuP5t+G0rWFwVY1UulJot7cJ6ChkZ8KaEYuIAc=;
	b=QU4afctrVDsH7ZR4oFXizctSKQaRhx2EnDRihwDwlvrjumgQ2Aho+5SdvNMIYUInMAdaxK
	xN5RUn0oCdqy3encGGoq8Z5u5/e+AuEinfMHWgB3bQorjms+jBLOVJyg78Kn/LYyd5uMTr
	6Xq+VH2npXUeB0zoZUYQNx6YrBBtEgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721960771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoFISfuP5t+G0rWFwVY1UulJot7cJ6ChkZ8KaEYuIAc=;
	b=QintuUqbl6SzlJyftPqh0E+jE3JkGhwCJmOj79SHGP1XJlTGllWpOuzwzbOYU3KGpD1Mb1
	m6fabDrUcQqrEUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E27AE138A7;
	Fri, 26 Jul 2024 02:26:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B+ewJUAJo2awWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 26 Jul 2024 02:26:08 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/6] nfsd: Move error code mapping to per-version xdr code.
Date: Fri, 26 Jul 2024 12:21:32 +1000
Message-ID: <20240726022538.32076-4-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240726022538.32076-1-neilb@suse.de>
References: <20240726022538.32076-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 05D30218BB
X-Spam-Score: -4.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]

There is code scatter around nfsd which chooses an error status based on
the particular version of nfs being used.  It is cleaner to have the
version specific choices in version specific code.

With this patch common code returns the most specific error code
possible and the version specific code maps that if necessary.

One complication is that the NFSv4 code NFS4ERR_SYMLINK might be used
where v3 expects NFSERR_NOTDIR of NFSERR_INVAL.  To handle this we
introduce an internal error code NFSERR_SYMLINK_NOT_DIR and convert that
as appropriate for all versions.

The selection of numbers for internal error codes was previously ad hoc.
Now it uses an enum which starts at the first unused error code.

NFSv4.1+ now returns NFS4ERR_WRONG_TYPE when that is appropriate.  It
previously returned NFS4ERR_SYMLINK as that seemed best for NFSv4.0.
According to RFC5661 15.1.2.9 NFSv4.0 was expected to return
NFSERR_INVAL in these cases, so that is how the code now behaves.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/export.c     |  2 +-
 fs/nfsd/nfs3xdr.c    | 17 +++++++++++++++++
 fs/nfsd/nfs4proc.c   | 11 +++--------
 fs/nfsd/nfs4xdr.c    | 15 +++++++++++++++
 fs/nfsd/nfsd.h       | 23 +++++++++++++++++++----
 fs/nfsd/nfsfh.c      | 26 ++++++++++----------------
 fs/nfsd/nfsxdr.c     | 19 +++++++++++++++++++
 fs/nfsd/vfs.c        | 14 ++++----------
 include/linux/nfs4.h |  3 +++
 9 files changed, 91 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 9aa5f95f18a8..7bb4f2075ac5 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1121,7 +1121,7 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 		return 0;
 
 denied:
-	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
+	return nfserr_wrongsec;
 }
 
 /*
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index a7a07470c1f8..8d75759c600d 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -111,6 +111,23 @@ svcxdr_encode_nfsstat3(struct xdr_stream *xdr, __be32 status)
 {
 	__be32 *p;
 
+	switch (status) {
+	case nfserr_symlink_not_dir:
+		status = nfserr_notdir;
+		break;
+	case nfserr_symlink:
+	case nfserr_wrong_type:
+		status = nfserr_inval;
+		break;
+	case nfserr_nofilehandle:
+		status = nfserr_badhandle;
+		break;
+	case nfserr_wrongsec:
+	case nfserr_file_open:
+		status = nfserr_acces;
+		break;
+	}
+
 	p = xdr_reserve_space(xdr, sizeof(status));
 	if (!p)
 		return false;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d5ed01c72910..c4b65f747d8b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -166,14 +166,9 @@ static __be32 nfsd_check_obj_isreg(struct svc_fh *fh)
 		return nfs_ok;
 	if (S_ISDIR(mode))
 		return nfserr_isdir;
-	/*
-	 * Using err_symlink as our catch-all case may look odd; but
-	 * there's no other obvious error for this case in 4.0, and we
-	 * happen to know that it will cause the linux v4 client to do
-	 * the right thing on attempts to open something other than a
-	 * regular file.
-	 */
-	return nfserr_symlink;
+	if (S_ISLNK(mode))
+		return nfserr_symlink;
+	return nfserr_wrong_type;
 }
 
 static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state *cstate, struct nfsd4_open *open, struct svc_fh *resfh)
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c7bfd2180e3f..117dea18cbc8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5748,6 +5748,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 
 	if (op->opnum == OP_ILLEGAL)
 		goto status;
+
+	if (op->status == nfserr_wrong_type &&
+	    resp->cstate.minorversion == 0)
+		/* RFC5661 - 15.1.2.9 */
+		op->status = nfserr_inval;
+	if (op->status == nfserr_symlink_not_dir)
+		op->status = nfserr_symlink;
+
 	if (op->status && opdesc &&
 			!(opdesc->op_flags & OP_NONTRIVIAL_ERROR_ENCODE))
 		goto status;
@@ -5870,6 +5878,13 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	 */
 	p = resp->statusp;
 
+	if (resp->cstate.status == nfserr_wrong_type &&
+	    resp->cstate.minorversion == 0)
+		/* RFC5661 - 15.1.2.9 */
+		resp->cstate.status = nfserr_inval;
+	if (resp->cstate.status == nfserr_symlink_not_dir)
+		resp->cstate.status = nfserr_symlink;
+
 	*p++ = resp->cstate.status;
 	*p++ = htonl(resp->taglen);
 	memcpy(p, resp->tag, resp->taglen);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 8f4f239d9f8a..0f499066aa72 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -327,16 +327,31 @@ void		nfsd_lockd_shutdown(void);
 #define nfserr_noxattr			cpu_to_be32(NFS4ERR_NOXATTR)
 
 /* error codes for internal use */
+enum {
+	NFSERR_DROPIT = NFS4ERR_FIRST_FREE,
 /* if a request fails due to kmalloc failure, it gets dropped.
  *  Client should resend eventually
  */
-#define	nfserr_dropit		cpu_to_be32(30000)
+#define	nfserr_dropit		cpu_to_be32(NFSERR_DROPIT)
+
 /* end-of-file indicator in readdir */
-#define	nfserr_eof		cpu_to_be32(30001)
+	NFSERR_EOF,
+#define	nfserr_eof		cpu_to_be32(NFSERR_EOF)
+
 /* replay detected */
-#define	nfserr_replay_me	cpu_to_be32(11001)
+	NFSERR_REPLAY_ME,
+#define	nfserr_replay_me	cpu_to_be32(NFSERR_REPLAY_ME)
+
 /* nfs41 replay detected */
-#define	nfserr_replay_cache	cpu_to_be32(11002)
+	NFSERR_REPLAY_CACHE,
+#define	nfserr_replay_cache	cpu_to_be32(NFSERR_REPLAY_CACHE)
+
+/* symlink found where dir expected - handled differently to
+ * other symlink found errors by NSv3.
+ */
+	NFSERR_SYMLINK_NOT_DIR,
+#define	nfserr_symlink_not_dir	cpu_to_be32(NFSERR_SYMLINK_NOT_DIR)
+};
 
 /* Check for dir entries '.' and '..' */
 #define isdotent(n, l)	(l < 3 && n[0] == '.' && (l == 1 || n[1] == '.'))
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index a485d630d10e..8fb56e2f896c 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -62,8 +62,7 @@ static int nfsd_acceptable(void *expv, struct dentry *dentry)
  * the write call).
  */
 static inline __be32
-nfsd_mode_check(struct svc_rqst *rqstp, struct dentry *dentry,
-		umode_t requested)
+nfsd_mode_check(struct dentry *dentry, umode_t requested)
 {
 	umode_t mode = d_inode(dentry)->i_mode & S_IFMT;
 
@@ -76,17 +75,16 @@ nfsd_mode_check(struct svc_rqst *rqstp, struct dentry *dentry,
 		}
 		return nfs_ok;
 	}
-	/*
-	 * v4 has an error more specific than err_notdir which we should
-	 * return in preference to err_notdir:
-	 */
-	if (rqstp->rq_vers == 4 && mode == S_IFLNK)
+	if (mode == S_IFLNK) {
+		if (requested == S_IFDIR)
+			return nfserr_symlink_not_dir;
 		return nfserr_symlink;
+	}
 	if (requested == S_IFDIR)
 		return nfserr_notdir;
 	if (mode == S_IFDIR)
 		return nfserr_isdir;
-	return nfserr_inval;
+	return nfserr_wrong_type;
 }
 
 static bool nfsd_originating_port_ok(struct svc_rqst *rqstp, int flags)
@@ -162,10 +160,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	int len;
 	__be32 error;
 
-	error = nfserr_stale;
-	if (rqstp->rq_vers > 2)
-		error = nfserr_badhandle;
-	if (rqstp->rq_vers == 4 && fh->fh_size == 0)
+	error = nfserr_badhandle;
+	if (fh->fh_size == 0)
 		return nfserr_nofilehandle;
 
 	if (fh->fh_version != 1)
@@ -239,9 +235,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	/*
 	 * Look up the dentry using the NFS file handle.
 	 */
-	error = nfserr_stale;
-	if (rqstp->rq_vers > 2)
-		error = nfserr_badhandle;
+	error = nfserr_badhandle;
 
 	fileid_type = fh->fh_fileid_type;
 
@@ -368,7 +362,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	if (error)
 		goto out;
 
-	error = nfsd_mode_check(rqstp, dentry, type);
+	error = nfsd_mode_check(dentry, type);
 	if (error)
 		goto out;
 
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 5777f40c7353..9bb306bdc225 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -38,6 +38,25 @@ svcxdr_encode_stat(struct xdr_stream *xdr, __be32 status)
 {
 	__be32 *p;
 
+	switch (status) {
+	case nfserr_symlink_not_dir:
+		status = nfserr_notdir;
+		break;
+	case nfserr_symlink:
+	case nfserr_wrong_type:
+		status = nfserr_inval;
+		break;
+	case nfserr_nofilehandle:
+	case nfserr_badhandle:
+		status = nfserr_stale;
+		break;
+	case nfserr_wrongsec:
+	case nfserr_xdev:
+	case nfserr_file_open:
+		status = nfserr_acces;
+		break;
+	}
+
 	p = xdr_reserve_space(xdr, sizeof(status));
 	if (!p)
 		return false;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0862f6ae86a9..cf96a2ef6533 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1770,10 +1770,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 		if (!err)
 			err = nfserrno(commit_metadata(tfhp));
 	} else {
-		if (host_err == -EXDEV && rqstp->rq_vers == 2)
-			err = nfserr_acces;
-		else
-			err = nfserrno(host_err);
+		err = nfserrno(host_err);
 	}
 	dput(dnew);
 out_drop_write:
@@ -1839,7 +1836,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
-	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+	err = nfserr_xdev;
 	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
 		goto out;
 	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
@@ -1854,7 +1851,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 
 	trap = lock_rename(tdentry, fdentry);
 	if (IS_ERR(trap)) {
-		err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+		err = nfserr_xdev;
 		goto out_want_write;
 	}
 	err = fh_fill_pre_attrs(ffhp);
@@ -2023,10 +2020,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		/* name is mounted-on. There is no perfect
 		 * error status.
 		 */
-		if (nfsd_v4client(rqstp))
-			err = nfserr_file_open;
-		else
-			err = nfserr_acces;
+		err = nfserr_file_open;
 	} else {
 		err = nfserrno(host_err);
 	}
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 0d896ce296ce..04dad965fa66 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -290,6 +290,9 @@ enum nfsstat4 {
 	/* xattr (RFC8276) */
 	NFS4ERR_NOXATTR        = 10095,
 	NFS4ERR_XATTR2BIG      = 10096,
+
+	/* can be used for internal errors */
+	NFS4ERR_FIRST_FREE
 };
 
 /* error codes for internal client use */
-- 
2.44.0


