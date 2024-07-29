Return-Path: <linux-nfs+bounces-5120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F5593EAC3
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 03:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B842816F2
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 01:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6AB18C36;
	Mon, 29 Jul 2024 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fYaX0w5p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ukW0xLzM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fYaX0w5p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ukW0xLzM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D226AC3
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217811; cv=none; b=tIZQxcKJpPmcVvyfu8kcYGFo4l56ucz6miHnUIBJYo1R0yTCC5pFGWOp47pQa8u4GoEkVvmAIbuvD2aeIYH/4qcxjQ1i8rDTI1IR0YrHB+eUJZrIp9t9vZjTnzKMFf2hFGgNLfOgQhJe0xeGBOAz1GN3q/5PIHGfZfqOHSXsa2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217811; c=relaxed/simple;
	bh=e4vTQs1xzqR8Q5MH38LMl1pT5wrlF3LmT0nmjOn8DeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwDGPi7yJJ5Vxkm3tM1vPSflMVZ9POznkIVhdRJ+7CEjh04XG2/uM8Krvld8vwQE3O6XRbDmtEWrUDVd//VYaq7PG/SAdmnPhm8IkduUBrxC0EwIYmP6QuMkr6h6ZoTzFWRH/+aPv30cZ119b3PGDs3jNeoOOxafQiTfDde+0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fYaX0w5p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ukW0xLzM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fYaX0w5p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ukW0xLzM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B7A021BBD;
	Mon, 29 Jul 2024 01:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722217800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P51x/qorReur0cBzK6aCOAHYoIEO7uUdlL0hSO/EYEY=;
	b=fYaX0w5p7kArrYNEAMRbqDs+CN7RYrgzJQ4/epve3z69pHNDalAig7BovkomNORC0vEScd
	iJvOzaJFS/h2RQTzlrX9S3poMGoFdphAovCm5w42UNPb+S+6PhX1s2hZFT4wHIQIhc/170
	EL5Hg+GyNAUFoivD3yq8yMEzxoPbEMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722217800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P51x/qorReur0cBzK6aCOAHYoIEO7uUdlL0hSO/EYEY=;
	b=ukW0xLzMct5qM+gIU1TOMViQCx+SAtwLHLPB+o5kcIP83xqCteILsOa0UQu+MFPt5gk/Uo
	X+OhtISr2XGIlZDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fYaX0w5p;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ukW0xLzM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722217800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P51x/qorReur0cBzK6aCOAHYoIEO7uUdlL0hSO/EYEY=;
	b=fYaX0w5p7kArrYNEAMRbqDs+CN7RYrgzJQ4/epve3z69pHNDalAig7BovkomNORC0vEScd
	iJvOzaJFS/h2RQTzlrX9S3poMGoFdphAovCm5w42UNPb+S+6PhX1s2hZFT4wHIQIhc/170
	EL5Hg+GyNAUFoivD3yq8yMEzxoPbEMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722217800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P51x/qorReur0cBzK6aCOAHYoIEO7uUdlL0hSO/EYEY=;
	b=ukW0xLzMct5qM+gIU1TOMViQCx+SAtwLHLPB+o5kcIP83xqCteILsOa0UQu+MFPt5gk/Uo
	X+OhtISr2XGIlZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D48713704;
	Mon, 29 Jul 2024 01:49:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PDjFDEb1pmb+FgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jul 2024 01:49:58 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/3] nfsd: Move error code mapping to per-version proc code.
Date: Mon, 29 Jul 2024 11:47:22 +1000
Message-ID: <20240729014940.23053-2-neilb@suse.de>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9B7A021BBD
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]

There is code scattered around nfsd which chooses an error status based
on the particular version of nfs being used.  It is cleaner to have the
version specific choices in version specific code.

With this patch common code returns the most specific error code
possible and the version specific code maps that if necessary.

Both v2 (nfsproc.c) and v3 (nfs3proc.c) now have a "map_status()"
function which is called to map the resp->status before each non-trivial
nfsd_proc_* or nfsd3_proc_* function returns.

NFS4ERR_SYMLINK and NFS4ERR_WRONG_TYPE introduce extra complications and
are left for a later patch.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/export.c   |  2 +-
 fs/nfsd/nfs3proc.c | 35 +++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsfh.c    | 10 +++-------
 fs/nfsd/nfsproc.c  | 31 +++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c      | 14 ++++----------
 5 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 50b3135d07ac..08e3527062e8 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1121,7 +1121,7 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 		return 0;
 
 denied:
-	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
+	return nfserr_wrongsec;
 }
 
 /*
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index dfcc957e460d..31bd9bcf8687 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -28,6 +28,20 @@ static int	nfs3_ftypes[] = {
 	S_IFIFO,		/* NF3FIFO */
 };
 
+static __be32 map_status(__be32 status)
+{
+	switch (status) {
+	case nfserr_nofilehandle:
+		status = nfserr_badhandle;
+		break;
+	case nfserr_wrongsec:
+	case nfserr_file_open:
+		status = nfserr_acces;
+		break;
+	}
+	return status;
+}
+
 /*
  * NULL call.
  */
@@ -57,6 +71,7 @@ nfsd3_proc_getattr(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -80,6 +95,7 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 	if (argp->check_guard)
 		guardtime = &argp->guardtime;
 	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs, guardtime);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -103,6 +119,7 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
 	resp->status = nfsd_lookup(rqstp, &resp->dirfh,
 				   argp->name, argp->len,
 				   &resp->fh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -122,6 +139,7 @@ nfsd3_proc_access(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->access = argp->access;
 	resp->status = nfsd_access(rqstp, &resp->fh, &resp->access, NULL);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -142,6 +160,7 @@ nfsd3_proc_readlink(struct svc_rqst *rqstp)
 	resp->pages = rqstp->rq_next_page++;
 	resp->status = nfsd_readlink(rqstp, &resp->fh,
 				     page_address(*resp->pages), &resp->len);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -179,6 +198,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
 				 &resp->count, &resp->eof);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -212,6 +232,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 				  rqstp->rq_vec, nvecs, &cnt,
 				  resp->committed, resp->verf);
 	resp->count = cnt;
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -359,6 +380,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
 
 	resp->status = nfsd3_create_file(rqstp, dirfhp, newfhp, argp);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -384,6 +406,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 	fh_init(&resp->fh, NFS3_FHSIZE);
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, S_IFDIR, 0, &resp->fh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -424,6 +447,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 				    argp->flen, argp->tname, &attrs, &resp->fh);
 	kfree(argp->tname);
 out:
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -465,6 +489,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, type, rdev, &resp->fh);
 out:
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -486,6 +511,7 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
 				   argp->name, argp->len);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -506,6 +532,7 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
 				   argp->name, argp->len);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -528,6 +555,7 @@ nfsd3_proc_rename(struct svc_rqst *rqstp)
 	fh_copy(&resp->tfh, &argp->tfh);
 	resp->status = nfsd_rename(rqstp, &resp->ffh, argp->fname, argp->flen,
 				   &resp->tfh, argp->tname, argp->tlen);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -548,6 +576,7 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 	fh_copy(&resp->tfh, &argp->tfh);
 	resp->status = nfsd_link(rqstp, &resp->tfh, argp->tname, argp->tlen,
 				 &resp->fh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -600,6 +629,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	/* Recycle only pages that were part of the reply */
 	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
 
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -644,6 +674,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
 
 out:
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -661,6 +692,7 @@ nfsd3_proc_fsstat(struct svc_rqst *rqstp)
 
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats, 0);
 	fh_put(&argp->fh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -704,6 +736,7 @@ nfsd3_proc_fsinfo(struct svc_rqst *rqstp)
 	}
 
 	fh_put(&argp->fh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -746,6 +779,7 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 	}
 
 	fh_put(&argp->fh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -773,6 +807,7 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 				   argp->count, resp->verf);
 	nfsd_file_put(nf);
 out:
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 0b75305fb5f5..0130103833e5 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -162,10 +162,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
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
@@ -237,9 +235,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	/*
 	 * Look up the dentry using the NFS file handle.
 	 */
-	error = nfserr_stale;
-	if (rqstp->rq_vers > 2)
-		error = nfserr_badhandle;
+	error = nfserr_badhandle;
 
 	fileid_type = fh->fh_fileid_type;
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 36370b957b63..cb7099c6dc78 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -13,6 +13,22 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
+static __be32 map_status(__be32 status)
+{
+	switch (status) {
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
+	return status;
+}
+
 static __be32
 nfsd_proc_null(struct svc_rqst *rqstp)
 {
@@ -38,6 +54,7 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -109,6 +126,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -143,6 +161,7 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -164,6 +183,7 @@ nfsd_proc_readlink(struct svc_rqst *rqstp)
 				     page_address(resp->page), &resp->len);
 
 	fh_put(&argp->fh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -200,6 +220,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
 		set_bit(RQ_DROPME, &rqstp->rq_flags);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -235,6 +256,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
 		set_bit(RQ_DROPME, &rqstp->rq_flags);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -403,6 +425,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -419,6 +442,7 @@ nfsd_proc_remove(struct svc_rqst *rqstp)
 	resp->status = nfsd_unlink(rqstp, &argp->fh, -S_IFDIR,
 				   argp->name, argp->len);
 	fh_put(&argp->fh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -437,6 +461,7 @@ nfsd_proc_rename(struct svc_rqst *rqstp)
 				   &argp->tfh, argp->tname, argp->tlen);
 	fh_put(&argp->ffh);
 	fh_put(&argp->tfh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -457,6 +482,7 @@ nfsd_proc_link(struct svc_rqst *rqstp)
 				 &argp->ffh);
 	fh_put(&argp->ffh);
 	fh_put(&argp->tfh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -495,6 +521,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 	fh_put(&argp->ffh);
 	fh_put(&newfh);
 out:
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -528,6 +555,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -545,6 +573,7 @@ nfsd_proc_rmdir(struct svc_rqst *rqstp)
 	resp->status = nfsd_unlink(rqstp, &argp->fh, S_IFDIR,
 				   argp->name, argp->len);
 	fh_put(&argp->fh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -590,6 +619,7 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	nfssvc_encode_nfscookie(resp, offset);
 
 	fh_put(&argp->fh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
@@ -607,6 +637,7 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats,
 				   NFSD_MAY_BYPASS_GSS_ON_ROOT);
 	fh_put(&argp->fh);
+	resp->status = map_status(resp->status);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29b1f3613800..b4f7b35cf0c0 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1767,10 +1767,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
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
@@ -1836,7 +1833,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
-	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+	err = nfserr_xdev;
 	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
 		goto out;
 	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
@@ -1851,7 +1848,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 
 	trap = lock_rename(tdentry, fdentry);
 	if (IS_ERR(trap)) {
-		err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+		err = nfserr_xdev;
 		goto out_want_write;
 	}
 	err = fh_fill_pre_attrs(ffhp);
@@ -2020,10 +2017,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
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
-- 
2.44.0


