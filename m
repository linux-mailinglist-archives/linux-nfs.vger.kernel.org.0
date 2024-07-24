Return-Path: <linux-nfs+bounces-5036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A7F93B581
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 19:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10891283952
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC2215ECD2;
	Wed, 24 Jul 2024 17:01:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE115B10C
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840505; cv=none; b=eiKZ4fHdZbjRI4N8kEYbCclF2NIf2z7OEiqbEp1LZ4aPl+GCrBRTAnHI1uHLU0ea7HhnilokTiEAfjp0OBfmI1Xg4p9firhSp5Lmlt6gLfQ3rjqJWLxOidd7FsSKXzcgC/cUhH6TujDRKMBNXUdZX5aIi1eh0FC7XOkarILb430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840505; c=relaxed/simple;
	bh=koLE/1vEZsqttGK9DIPmb4gFMyEEQ/Gi5j1BBG2mjEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q92JP77fg3sDtH2EfwCdRYGxDwRZcNpTCHs4VK4YKPqp1pOO4nZ6XYrhrweUnlxsmmzxWKIfd6S/p1/oum4bDVcdp7s9yBJGZdGPowzH/lRZMxVSpJULQAtUm6lMzP924BBVWGT66NnHBtobof+IOd5vVQ0nBiEZIKWhi8luuds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5af48b48eso3176eaf.3
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 10:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721840502; x=1722445302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4K4rXAtWhch/PzhCzUBE7+zd8DWV37wuMuHWQ2NDccY=;
        b=g2CZM8JCGfCCvSYzoMzrimHKQFy8ydyGTkfEs2jZjUMwD1LsA4xZXnp0+qpGP5as82
         ZU7K3tdFmyDQfLO4Z8bNktu8iutm1BcWCw35lyDfD+JgeEAhzgwJRtJW9vPs1MBIuLHI
         Vaw6Gv55f4KgS/bGH7kaqmSCgohL9TpVKfSlMOK4guJj/r2gpFCSZWEmY5G4mJfNE6+C
         Lnbc6BWEaF48O02eGO77nIeyPSz8zxuLR2iakyiRQWaXHlECMS5fzffrqRhyMhELA6xp
         y1Q/h5eZn+Uh5/IQ3eGKyrMFPHGPNSJzKLkqIi/VIUccn+6xGYMd0puqrZjfA6rjoMPL
         L2/A==
X-Forwarded-Encrypted: i=1; AJvYcCV65OYb1lO55xOrg1W3WqbEkD9s+3f9laNnRA1f9pqGqCYGtlGeCkCXfYvjuDr6Hzr3ei6/LtvamLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/p5N6mj1ebef/8n4BoeLggA5rGTUw/6fG2u2R8ZsdwwFjzGd+
	ZbJDpPlKCCE7oFouhY7Jiq9yEXAQ9nud0jXkRPgBk5AtHcDU0+1o7ghpdQ==
X-Google-Smtp-Source: AGHT+IGGQ+LAbBUPy5rrV2cWjh1NS5n90lDZg8GB/4KFOU5WiE4leTrT6TuvRg7d2OBbXhjw11XKWg==
X-Received: by 2002:a4a:ca97:0:b0:5c6:e7c6:711 with SMTP id 006d021491bc7-5d5adaa28ddmr316613eaf.1.1721840502276;
        Wed, 24 Jul 2024 10:01:42 -0700 (PDT)
Received: from vastdata-ubuntu2.. ([12.220.158.163])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d59ee65be5sm368297eaf.24.2024.07.24.10.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:01:41 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH rfc 2/2] NFSD: allow client to use write delegation stateid for READ
Date: Wed, 24 Jul 2024 10:01:38 -0700
Message-ID: <20240724170138.1942307-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724170138.1942307-1-sagi@grimberg.me>
References: <20240724170138.1942307-1-sagi@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on a patch fom Dai Ngo, allow NFSv4 client to use write delegation
stateid for READ operation. Per RFC 8881 section 9.1.2. Use of the
Stateid and Locking.

In addition, for anonymous stateids, check for pending delegations by
the filehandle and client_id, and if a conflict found, recall the delegation
before allowing the read to take place.

Suggested-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fs/nfsd/nfs4proc.c  | 22 +++++++++++++++++++--
 fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c   |  9 +++++++++
 fs/nfsd/state.h     |  2 ++
 fs/nfsd/xdr4.h      |  2 ++
 5 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7b70309ad8fb..324984ec70c6 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					&read->rd_stateid, RD_STATE,
-					&read->rd_nf, NULL);
-
+					&read->rd_nf, &read->rd_wd_stid);
+	/*
+	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
+	 * delegation stateid used for read. Its refcount is decremented
+	 * by nfsd4_read_release when read is done.
+	 */
+	if (!status) {
+		if (!read->rd_wd_stid) {
+			/* special stateid? */
+			status = nfsd4_deleg_read_conflict(rqstp, cstate->clp,
+				&cstate->current_fh);
+		} else if (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
+			   delegstateid(read->rd_wd_stid)->dl_type !=
+						NFS4_OPEN_DELEGATE_WRITE) {
+			nfs4_put_stid(read->rd_wd_stid);
+			read->rd_wd_stid = NULL;
+		}
+	}
 	read->rd_rqstp = rqstp;
 	read->rd_fhp = &cstate->current_fh;
 	return status;
@@ -990,6 +1006,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static void
 nfsd4_read_release(union nfsd4_op_u *u)
 {
+	if (u->read.rd_wd_stid)
+		nfs4_put_stid(u->read.rd_wd_stid);
 	if (u->read.rd_nf)
 		nfsd_file_put(u->read.rd_nf);
 	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index dc61a8adfcd4..7e6b9fb31a4c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8805,6 +8805,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
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
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c7bfd2180e3f..f0fe526fac3c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4418,6 +4418,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	unsigned long maxcount;
 	struct file *file;
 	__be32 *p;
+	fmode_t o_fmode = 0;
 
 	if (nfserr)
 		return nfserr;
@@ -4437,10 +4438,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	maxcount = min_t(unsigned long, read->rd_length,
 			 (xdr->buf->buflen - xdr->buf->len));
 
+	if (read->rd_wd_stid) {
+		/* allow READ using write delegation stateid */
+		o_fmode = file->f_mode;
+		file->f_mode |= FMODE_READ;
+	}
 	if (file->f_op->splice_read && splice_ok)
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
 		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+	if (o_fmode)
+		file->f_mode = o_fmode;
+
 	if (nfserr) {
 		xdr_truncate_encode(xdr, starting_len);
 		return nfserr;
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


