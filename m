Return-Path: <linux-nfs+bounces-5117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C393E971
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 22:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF3E1C2132D
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 20:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DD9770EF;
	Sun, 28 Jul 2024 20:41:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26196F2F7
	for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722199273; cv=none; b=SR4LeFoCDIaT5g020yIq0cIGM2G1b8JqK2H+1keplx24mZLxck+gnUUq0IFxf+p5NLzNfBaZI1OASzVx3exe/wqBwFiJKSzqNHHkktgH/tO5Y3tyBz7CjDn60CESLjM+KaXiern+QK5SsAR//rQd02mZ5g+Cwk0o2R2OQwKiYlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722199273; c=relaxed/simple;
	bh=SWFp4adxcnYATOBc6ElcuQ2pV9NiD7053Zi/uzhTVUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKBikJawVW4YDyHsX1v2+YP9o34mGTfcJRc4yoMfgTCX4yy0tBADk1DckbMYEZbAj+Ho+3RvBblfYtZ+jJUMVUTUeGUUKcl014y3u5QsffuO4WXNu4wTVNPk4kdCHpT/OQ3J2PePolvut9DvDXnneKBrqfqixYDo5g9f/imHm5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280ef642fbso2244395e9.1
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 13:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722199270; x=1722804070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szo805fxHdddtXZQo66WsK4pJwLFljNG8awu3F91cTk=;
        b=fDR7jug2snskblg2VDtSUepKzumlEbcusd2pI5PuP3ZuorFd4YeVxKg6yhzoUqmW3L
         qhOR7YtSJkqm57IWmYDGuGvJo6Kba4lr2n2rMyE9yBbLqWtYvqJVcsQTZgWukdRyE9Ft
         DJ9L+GbWagUWShybHPqSnqK7ZZQ6IMJbkbwIwi4M6ok3O+WEyekjtRjjas8+fQXL2piw
         4zOEfdD7pJlspaA2GwPiFeHZwlwN+hatoptqTYPdQ0TSa13WsA8Z7kp7U+TM2jNDcwx1
         ibBjfkhCqfPEbs7eRrb1ZdY6hffPVEx5PmQCLbm+NsVfyVFx9b5oxJxTkREXxQo3flyP
         2e0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNJ6yK57qA9I1K7kVIMGgeVnZkKTqbGGYuuglUro45LsFAxmvHZnBNaKeeUfMaOfjIDVX2JDEHA27IMXhiqfgtHAenZuWp589l
X-Gm-Message-State: AOJu0YwGTY+LZmEecWoEIhCDynrJdbsbPXzWJDPREhjLBjZPKvf5NWKO
	//urh9p5o2B2Ji8DUrYxOxMSJ61Oztw+uvQlS75OAvIgim3Omejx6ve+aw==
X-Google-Smtp-Source: AGHT+IG7B7MYxTyX6KP6QLMHZA1/VBKABweT3OyMiDPS4UZaLSOELizGz+2uVsXaYB7F/tGzGjCmVQ==
X-Received: by 2002:a05:600c:4511:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-428053beee0mr52831785e9.0.1722199269790;
        Sun, 28 Jul 2024 13:41:09 -0700 (PDT)
Received: from localhost.localdomain (89-138-69-172.bb.netvision.net.il. [89.138.69.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280d13570bsm98701395e9.7.2024.07.28.13.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 13:41:09 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>,
	Olga Kornievskaia <aglo@umich.edu>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/3] nfsd: resolve possible conflicts of reads using special stateids and write delegations
Date: Sun, 28 Jul 2024 23:41:04 +0300
Message-ID: <20240728204104.519041-4-sagi@grimberg.me>
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

In case a client issues a read using a special (anonymous) stateid, we need
to check if there is a conflicting write delegation already given to a different
client. If it is, recall the delegation before processing the read.

If the client holding the write delegation sends this read, it probably needs
to be fixed, but nonetheless, as the spec allows it, we accept the read, and
don't recall the client delegation.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fs/nfsd/nfs4proc.c  | 11 +++++++----
 fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h     |  2 ++
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 041bcc3ab5d7..8a61c3bb2289 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -987,10 +987,13 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * by nfsd4_read_release when read is done.
 	 */
 	if (!status) {
-		if (read->rd_wd_stid &&
-		    (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
-		     delegstateid(read->rd_wd_stid)->dl_type !=
-					NFS4_OPEN_DELEGATE_WRITE)) {
+		if (!read->rd_wd_stid) {
+			/* special stateid? */
+			status = nfsd4_deleg_read_conflict(rqstp, cstate->clp,
+				&cstate->current_fh);
+		} else if (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
+			   delegstateid(read->rd_wd_stid)->dl_type !=
+						NFS4_OPEN_DELEGATE_WRITE) {
 			nfs4_put_stid(read->rd_wd_stid);
 			read->rd_wd_stid = NULL;
 		}
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 538b6e1127a2..a6c6d813c59c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8803,6 +8803,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
 	get_stateid(cstate, &u->write.wr_stateid);
 }
 
+/**
+ * nfsd4_deleg_read_conflict - Recall if read causes conflict
+ * @rqstp: RPC transaction context
+ * @clp: nfs client
+ * @fhp: nfs file handle
+ * @inode: file to be checked for a conflict
+ * @modified: return true if file was modified
+ * @size: new size of file if modified is true
+ *
+ * This function is called when there is a conflict between a write
+ * delegation and a read that is using a special stateid where the
+ * we cannot derive the client stateid exsistence. The server
+ * must recall a conflicting delegation before allowing the read
+ * to continue.
+ *
+ * Returns 0 if there is no conflict; otherwise an nfs_stat
+ * code is returned.
+ */
+__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
+		struct nfs4_client *clp, struct svc_fh *fhp)
+{
+	struct nfs4_file *fp;
+	__be32 status = 0;
+
+	fp = nfsd4_file_hash_lookup(fhp);
+	if (!fp)
+		return nfs_ok;
+
+	spin_lock(&state_lock);
+	spin_lock(&fp->fi_lock);
+	if (!list_empty(&fp->fi_delegations) &&
+	    !nfs4_delegation_exists(clp, fp)) {
+		/* conflict, recall deleg */
+		status = nfserrno(nfsd_open_break_lease(fp->fi_inode,
+					NFSD_MAY_READ));
+		if (status)
+			goto out;
+		if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
+			status = nfserr_jukebox;
+	}
+out:
+	spin_unlock(&fp->fi_lock);
+	spin_unlock(&state_lock);
+	return status;
+}
+
+
 /**
  * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
  * @rqstp: RPC transaction context
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ffc217099d19..c1f13b5877c6 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -780,6 +780,8 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 	return clp->cl_state == NFSD4_EXPIRABLE;
 }
 
+extern __be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
+		struct nfs4_client *clp, struct svc_fh *fhp);
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
 		struct inode *inode, bool *file_modified, u64 *size);
 #endif   /* NFSD4_STATE_H */
-- 
2.43.0


