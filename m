Return-Path: <linux-nfs+bounces-5122-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2D693EAC5
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 03:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968292817D8
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7084226AC3;
	Mon, 29 Jul 2024 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tx3kk0gn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="beIv36a7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tx3kk0gn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="beIv36a7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE832BD04
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217815; cv=none; b=RjpROTlkq2WzGkaERsFAGT/AO1upoCJWfldcNyQdBnzwkiioFyBphSoHiMZKxWYPicfjTnUD2Zk8lIZlQRvDm19GbMRW9YSes383q1GnEiKtyDNJv9osq8PfZtSdgwYmyfKZq+/uAt9yYImc2XUTFysZB6SiCtgvEiPrhSj14mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217815; c=relaxed/simple;
	bh=ieMIOIMZN4RfXjaRjxYufSc/e8GqehpVluUd8/9h9Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHTzdmmECgkTI26yeyWCAi99t46Twn6UBGtrlTdjgkhLovx3cXvPP1qs6RsccBfaL7vG8cK7LzAO2RS4JK01TLj42FR+HB6cNOcoWQHRPTOMR/hY2SALnsRLMP7exhDZxEbdWWb4poB39KvgqZyg/6RW2e/fOJAXv4010QvzOAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tx3kk0gn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=beIv36a7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tx3kk0gn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=beIv36a7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB30321BBD;
	Mon, 29 Jul 2024 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722217811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSXl1CCQjo7iQ6hAOwADz/NikvSCAPBWsjXk6iaNLTc=;
	b=tx3kk0gno1jITeCfRoaeNTm6gNt3wQ+BblA7MrkQ4eEf3xfPB6VB7VX3/DvXUlkkUTfJY3
	MZ3nW3VGOthWHMPZuWqnZSFb6h/7833nd+yg6fahbVXbELhSsNKG/9dPxlZqCyiMplzciO
	1PrRSt3Qpzv1qSxwaAzq25kjEsVrTgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722217811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSXl1CCQjo7iQ6hAOwADz/NikvSCAPBWsjXk6iaNLTc=;
	b=beIv36a7tKLACEkrkMI8fUIfuepMKlMDx6kgOhEPpAGVo3QfVU8mDXWdoZdtF8WNmNCh1P
	eD6FlNruEYd697Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tx3kk0gn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=beIv36a7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722217811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSXl1CCQjo7iQ6hAOwADz/NikvSCAPBWsjXk6iaNLTc=;
	b=tx3kk0gno1jITeCfRoaeNTm6gNt3wQ+BblA7MrkQ4eEf3xfPB6VB7VX3/DvXUlkkUTfJY3
	MZ3nW3VGOthWHMPZuWqnZSFb6h/7833nd+yg6fahbVXbELhSsNKG/9dPxlZqCyiMplzciO
	1PrRSt3Qpzv1qSxwaAzq25kjEsVrTgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722217811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSXl1CCQjo7iQ6hAOwADz/NikvSCAPBWsjXk6iaNLTc=;
	b=beIv36a7tKLACEkrkMI8fUIfuepMKlMDx6kgOhEPpAGVo3QfVU8mDXWdoZdtF8WNmNCh1P
	eD6FlNruEYd697Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D51013704;
	Mon, 29 Jul 2024 01:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bcedFFH1pmYRFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jul 2024 01:50:09 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/3] nfsd: move error choice for incorrect object types to version-specific code.
Date: Mon, 29 Jul 2024 11:47:24 +1000
Message-ID: <20240729014940.23053-4-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729014940.23053-1-neilb@suse.de>
References: <20240729014940.23053-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.81
X-Rspamd-Queue-Id: BB30321BBD

If an NFS operation expect a particular sort of object (file, dir, link,
etc) but gets a file handle for a different sort of object, it must
return an error.  The actual error varies among version in no-trivial
ways.

For v2 and v3 there are ISDIR and NOTDIR errors, and for any else, only
INVAL is suitable.

For v4.0 there is also NFS4ERR_SYMLINK which should be used if a SYMLINK
was found when not expected.  This take precedence over NOTDIR.

For v4.1+ there is also NFS4ERR_WRONG_TYPE which should be used in
preference to EINVAL when none of the specific error codes apply.

When nfsd_mode_check() finds a symlink where it expect a directory it
needs to return an error code that can be converted to NOTDIR for v2 or
v3 but will be SYMLINK for v4.  It must be different from the error
code returns when it finds a symlink but expects a regular file - that
must be converted to EINVAL or SYMLINK.

So we introduce an internal error code nfserr_symlink_not_dir which each
version converts as appropriate.

We also allow nfserr_wrong_type to be returned by
nfsd_check_obj_is_reg() in nfsv4 code) and nfsd_mode_check().  This a
behavioural change as nfsd_check_obj_is_reg() would previously return
nfserr_symiink for non-directory objects that aren't regular files.  Now
it will return nfserr_wrong_type for objects that aren't regular,
directory, symlink (so char-special, block-special, sockets), which is
mapped to nfserr_inval for NFSv4.0.  This should not be a problem as the
behaviour is supported by RFCs.

As a result of these changes, nfsd_mode_check() doesn't need an rqstp
arg any more.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3proc.c |  8 ++++++++
 fs/nfsd/nfs4proc.c | 24 ++++++++++++++++--------
 fs/nfsd/nfsd.h     |  5 +++++
 fs/nfsd/nfsfh.c    | 16 +++++++---------
 fs/nfsd/nfsproc.c  |  7 +++++++
 5 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 31bd9bcf8687..ac7ee24415a3 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -38,6 +38,14 @@ static __be32 map_status(__be32 status)
 	case nfserr_file_open:
 		status = nfserr_acces;
 		break;
+
+	case nfserr_symlink_not_dir:
+		status = nfserr_notdir;
+		break;
+	case nfserr_symlink:
+	case nfserr_wrong_type:
+		status = nfserr_inval;
+		break;
 	}
 	return status;
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 46bd20fe5c0f..cc715438e77a 100644
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
@@ -184,6 +179,17 @@ static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state *cstate
 			&resfh->fh_handle);
 }
 
+static __be32 map_status(__be32 status, int minor)
+{
+	if (status == nfserr_wrong_type &&
+	    minor == 0)
+		/* RFC5661 - 15.1.2.9 */
+		status = nfserr_inval;
+
+	if (status == nfserr_symlink_not_dir)
+		status = nfserr_symlink;
+	return status;
+}
 static inline bool nfsd4_create_is_exclusive(int createmode)
 {
 	return createmode == NFS4_CREATE_EXCLUSIVE ||
@@ -2798,6 +2804,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			nfsd4_encode_replay(resp->xdr, op);
 			status = op->status = op->replay->rp_status;
 		} else {
+			op->status = map_status(op->status,
+						cstate->minorversion);
 			nfsd4_encode_operation(resp, op);
 			status = op->status;
 		}
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 593c34fd325a..3c8c8da063b0 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -349,6 +349,11 @@ enum {
 	NFSERR_REPLAY_CACHE,
 #define	nfserr_replay_cache	cpu_to_be32(NFSERR_REPLAY_CACHE)
 
+/* symlink found where dir expected - handled differently to
+ * other symlink found errors by NFSv3.
+ */
+	NFSERR_SYMLINK_NOT_DIR,
+#define	nfserr_symlink_not_dir	cpu_to_be32(NFSERR_SYMLINK_NOT_DIR)
 };
 
 /* Check for dir entries '.' and '..' */
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 0130103833e5..8cd70f93827c 100644
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
@@ -362,7 +360,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	if (error)
 		goto out;
 
-	error = nfsd_mode_check(rqstp, dentry, type);
+	error = nfsd_mode_check(dentry, type);
 	if (error)
 		goto out;
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index cb7099c6dc78..3d65ab558091 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -25,6 +25,13 @@ static __be32 map_status(__be32 status)
 	case nfserr_file_open:
 		status = nfserr_acces;
 		break;
+	case nfserr_symlink_not_dir:
+		status = nfserr_notdir;
+		break;
+	case nfserr_symlink:
+	case nfserr_wrong_type:
+		status = nfserr_inval;
+		break;
 	}
 	return status;
 }
-- 
2.44.0


