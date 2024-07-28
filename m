Return-Path: <linux-nfs+bounces-5116-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB3293E970
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 22:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1DE1F21A1E
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 20:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58AE76C76;
	Sun, 28 Jul 2024 20:41:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8BA75808
	for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722199272; cv=none; b=rTEO+oKy/5Qiofu6dw4Ecj8faWtR0S2yfNaBlV6NWjZmCAWTOOSHDTzWbMnKQDlsUgiHJvZaVBWOMHu8EotG1832E5sKvxs7PEgBH2wrhoSX9WvBylcQhcguclGwQfcQ+H+BJbTSpy5n4YE1jhYk7w5+ochjXJS5sqHBbn1lJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722199272; c=relaxed/simple;
	bh=GJTaV/mWwpAV6MmhuQFRBhAL4U0GmiGeeBq5DulHVyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AobQltd5KC1yyhsnt0rgfsS9/g6WGJihmYRTL/Ekw1iyTBiHIJWSFpi1xmiOwmxg5Bpoaf6yxyeeFUXGZMNTq7KzYngGwNMvaeVp7ySiQ0BcIiI7ASdGJ7W0h9g7tcx4hIg4odjr0gyiDM3lysO/k5UmfM8Suy6/SAxbnYjtx6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36830a54b34so201344f8f.0
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 13:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722199269; x=1722804069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txBjn/1fH3AQubL9MsRoFT8Ypx4NNGLxqt9t2ggiyqU=;
        b=MPgQY2CDTTpW2gi3ILuebd4qWUhul98/Y0XeLodYQRiyn//QOlADSjzxfgkU5TBUos
         ah+yNweUe9MVCf1aP9MGzu+GsMGni2WKmkAcT94HXzJbkmIACo+w5r3fhSPdi1i9p9Z/
         C8cdcKmr8HRarQtObEEqxyVjLG+zSISkqM0WWrYioTHFN2k6dmfh9nCrqI9+8xMqy5P5
         UVB2Vfn7TMavPGLfWcqS9LluDqLR0uyROtN5ZiYbZVN1Kw5ZX0HX4HzYVBqZ5eDBJqaW
         yohNLx/R5lKeij6nettmk56aHzHfbDZdeVr4Grj3TT63MPPaR/kmGi840fwiu58IisVb
         gosA==
X-Forwarded-Encrypted: i=1; AJvYcCW4lBptIpDXCKDbEpoPtNtAZ9WdkcbgKMv1QqjN5TIGYq+nxSquDxOFTtlDuAFgkcTbkrSgROSbXikJzDRF7KvmB/A8jCuJadzS
X-Gm-Message-State: AOJu0YwXIBCI6xjTZZ5YE8zdggT7D/ocZtyk4IKtARYEiuDPjTRFG20P
	yImYevWi232NbmC/dTnx3s7fRzs1oKvw4/YcXbAZaKkQHs4wUbDF
X-Google-Smtp-Source: AGHT+IF8SynIirq/G5aO2nERVrGNhToETtevt4cScmqywMrVkVJkOK6MJLK10M5i/Y6IkpYru3GOaQ==
X-Received: by 2002:a05:600c:3b87:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-428053c9c55mr56508145e9.0.1722199268592;
        Sun, 28 Jul 2024 13:41:08 -0700 (PDT)
Received: from localhost.localdomain (89-138-69-172.bb.netvision.net.il. [89.138.69.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280d13570bsm98701395e9.7.2024.07.28.13.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 13:41:08 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>,
	Olga Kornievskaia <aglo@umich.edu>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/3] nfsd: Offer write delegations for o_wronly opens
Date: Sun, 28 Jul 2024 23:41:03 +0300
Message-ID: <20240728204104.519041-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728204104.519041-1-sagi@grimberg.me>
References: <20240728204104.519041-1-sagi@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support write delegations with O_WRONLY opens, we need to
allow the clients to read using the write delegation stateid (Per RFC
8881 section 9.1.2. Use of the Stateid and Locking).

Hence, we check for NFS4_SHARE_ACCESS_WRITE set in open request, and
in case the share access flag does not set NFS4_SHARE_ACCESS_READ as
well, we'll open the file locally with O_RDWR in order to allow the
client to use the write delegation stateid when issuing a read in case
it may choose to.

Plus, find_rw_file singular call-site is now removed, remove it altogether.

Note: reads using special stateids that conflict with pending write
delegations are undetected, and will be covered in a follow on patch.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fs/nfsd/nfs4proc.c  | 18 +++++++++++++++++-
 fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++----------------------
 fs/nfsd/xdr4.h      |  2 ++
 3 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7b70309ad8fb..041bcc3ab5d7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -979,8 +979,22 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					&read->rd_stateid, RD_STATE,
-					&read->rd_nf, NULL);
+					&read->rd_nf, &read->rd_wd_stid);
 
+	/*
+	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
+	 * delegation stateid used for read. Its refcount is decremented
+	 * by nfsd4_read_release when read is done.
+	 */
+	if (!status) {
+		if (read->rd_wd_stid &&
+		    (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
+		     delegstateid(read->rd_wd_stid)->dl_type !=
+					NFS4_OPEN_DELEGATE_WRITE)) {
+			nfs4_put_stid(read->rd_wd_stid);
+			read->rd_wd_stid = NULL;
+		}
+	}
 	read->rd_rqstp = rqstp;
 	read->rd_fhp = &cstate->current_fh;
 	return status;
@@ -990,6 +1004,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static void
 nfsd4_read_release(union nfsd4_op_u *u)
 {
+	if (u->read.rd_wd_stid)
+		nfs4_put_stid(u->read.rd_wd_stid);
 	if (u->read.rd_nf)
 		nfsd_file_put(u->read.rd_nf);
 	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0645fccbf122..538b6e1127a2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -639,18 +639,6 @@ find_readable_file(struct nfs4_file *f)
 	return ret;
 }
 
-static struct nfsd_file *
-find_rw_file(struct nfs4_file *f)
-{
-	struct nfsd_file *ret;
-
-	spin_lock(&f->fi_lock);
-	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
-	spin_unlock(&f->fi_lock);
-
-	return ret;
-}
-
 struct nfsd_file *
 find_any_file(struct nfs4_file *f)
 {
@@ -5784,15 +5772,11 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
 	 *   on its own, all opens."
 	 *
-	 * Furthermore the client can use a write delegation for most READ
-	 * operations as well, so we require a O_RDWR file here.
-	 *
-	 * Offer a write delegation in the case of a BOTH open, and ensure
-	 * we get the O_RDWR descriptor.
+	 * Offer a write delegation for WRITE or BOTH access
 	 */
-	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
-		nf = find_rw_file(fp);
+	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
 		dl_type = NFS4_OPEN_DELEGATE_WRITE;
+		nf = find_writeable_file(fp);
 	}
 
 	/*
@@ -5934,8 +5918,8 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
  * open or lock state.
  */
 static void
-nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
-		     struct svc_fh *currentfh)
+nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
+		struct nfs4_ol_stateid *stp, struct svc_fh *currentfh)
 {
 	struct nfs4_delegation *dp;
 	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
@@ -5994,6 +5978,20 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
 		dp->dl_cb_fattr.ncf_initial_cinfo =
 			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
+		if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) != NFS4_SHARE_ACCESS_BOTH) {
+			struct nfsd_file *nf = NULL;
+
+			/* make sure the file is opened locally for O_RDWR */
+			status = nfsd_file_acquire_opened(rqstp, currentfh,
+				nfs4_access_to_access(NFS4_SHARE_ACCESS_BOTH),
+				open->op_filp, &nf);
+			if (status) {
+				nfs4_put_stid(&dp->dl_stid);
+				destroy_delegation(dp);
+				goto out_no_deleg;
+			}
+			stp->st_stid.sc_file->fi_fds[O_RDWR] = nf;
+		}
 	} else {
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
 		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
@@ -6123,7 +6121,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* Attempt to hand out a delegation. No error return, because the
 	* OPEN succeeds even if we fail.
 	*/
-	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
+	nfs4_open_delegation(rqstp, open, stp, &resp->cstate.current_fh);
 nodeleg:
 	status = nfs_ok;
 	trace_nfsd_open(&stp->st_stid.sc_stateid);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index fbdd42cde1fa..434973a6a8b1 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -426,6 +426,8 @@ struct nfsd4_read {
 	struct svc_rqst		*rd_rqstp;          /* response */
 	struct svc_fh		*rd_fhp;            /* response */
 	u32			rd_eof;             /* response */
+
+	struct nfs4_stid	*rd_wd_stid;		/* internal */
 };
 
 struct nfsd4_readdir {
-- 
2.43.0


