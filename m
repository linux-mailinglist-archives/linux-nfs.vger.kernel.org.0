Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3F9B8EFA
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438187AbfITL0M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 07:26:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42059 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438184AbfITL0M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 07:26:12 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so15269936iod.9
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKBtfXBDb2I4SIWkL8RbGSdtWIaBiUXWBZYasSgkTuM=;
        b=kX+PQVfzY3z1NkQMDKaRAAkI61WmJfj7k279HXOWC7fQE29f0g+aFogda1BU4xtcFN
         A/4zmqHZe14/PjellTKQT4fw1Hi/0emAWOgRDaOx3fC8WPfPMEUbmkMir9RewwqY2Ocx
         uv9rZyz86it2jnd3fAuXJm2LJiXSzdNSoI1mVCeoZimBLmU8aqwCXYl0epS1t6ZfG8MN
         Epui648jjUPOk+Zfx4Lp39y5Ym37LJOtjjn64YFF7MWGbkcweq9lwsyHNBFiDGM4FEoj
         rZYyMnkBQgwuagaQ6HNMi4B2YtDS5jk/5GD5tpjyxowgAJ8Lt8yEjAHXa1RkwrUv/vRE
         X+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKBtfXBDb2I4SIWkL8RbGSdtWIaBiUXWBZYasSgkTuM=;
        b=iW8Of2ZnklSVXbr0n9bNxp+yy9QfVcaoieFhW0TYhLXax1tWxwq+hva87V8Fs8Rcwa
         eCxCpWCVHO3RF1Q872WMIXHIdiByOpNnJvog+9lGmHRJHCV/7ma1CLWvejytZ567IPIh
         eqYf3v7xM9UzRoVummoMYKtjN838jnGUknJbhCBirV/+4QBlxnSx8iJYlKjD9yqxRJpY
         Q9dyx0sXswZ8PkeCpHBifvT84mV8Ew3ULLsyGfWtJXbDfecdHbUrPsjrdyb4pSsAjIIx
         aNfAevp5XeBgYAS6kDjL3r0f/C5Rx0p3PI/k+KZPKccIcXZLVDDTJMFqWg7RolJaEDJ4
         aJkw==
X-Gm-Message-State: APjAAAUB1auHYfxXT8h2VH12iDgj26sVQkkGGiJ3FKN/mHGIrOvjjfDE
        fWoH1tQhN94blR1RSmVUcw==
X-Google-Smtp-Source: APXvYqxeccqgqZbpN+cCz0VyKJ+wdf0kNJhx2/4y+uy2B19D82kvDlfkpRSYVVjQmkMMH6FK4l7/gg==
X-Received: by 2002:a6b:8d84:: with SMTP id p126mr18188497iod.111.1568978771137;
        Fri, 20 Sep 2019 04:26:11 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q74sm1308736iod.72.2019.09.20.04.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 04:26:10 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v3 8/9] NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
Date:   Fri, 20 Sep 2019 07:23:47 -0400
Message-Id: <20190920112348.69496-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920112348.69496-8-trond.myklebust@hammerspace.com>
References: <20190920112348.69496-1-trond.myklebust@hammerspace.com>
 <20190920112348.69496-2-trond.myklebust@hammerspace.com>
 <20190920112348.69496-3-trond.myklebust@hammerspace.com>
 <20190920112348.69496-4-trond.myklebust@hammerspace.com>
 <20190920112348.69496-5-trond.myklebust@hammerspace.com>
 <20190920112348.69496-6-trond.myklebust@hammerspace.com>
 <20190920112348.69496-7-trond.myklebust@hammerspace.com>
 <20190920112348.69496-8-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a CLOSE or OPEN_DOWNGRADE operation receives a NFS4ERR_OLD_STATEID
then bump the seqid before resending. Ensure we only bump the seqid
by 1.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4_fs.h   |  2 --
 fs/nfs/nfs4proc.c  | 75 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfs/nfs4state.c | 16 ----------
 3 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index e8f74ed98e42..16b2e5cc3e94 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -491,8 +491,6 @@ extern int nfs4_set_lock_state(struct nfs4_state *state, struct file_lock *fl);
 extern int nfs4_select_rw_stateid(struct nfs4_state *, fmode_t,
 		const struct nfs_lock_context *, nfs4_stateid *,
 		const struct cred **);
-extern bool nfs4_refresh_open_stateid(nfs4_stateid *dst,
-		struct nfs4_state *state);
 extern bool nfs4_copy_open_stateid(nfs4_stateid *dst,
 		struct nfs4_state *state);
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 025dd5efbf34..c14af2c1c6b6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3308,6 +3308,75 @@ nfs4_wait_on_layoutreturn(struct inode *inode, struct rpc_task *task)
 	return pnfs_wait_on_layoutreturn(inode, task);
 }
 
+/*
+ * Update the seqid of an open stateid
+ */
+static void nfs4_sync_open_stateid(nfs4_stateid *dst,
+		struct nfs4_state *state)
+{
+	__be32 seqid_open;
+	u32 dst_seqid;
+	int seq;
+
+	for (;;) {
+		if (!nfs4_valid_open_stateid(state))
+			break;
+		seq = read_seqbegin(&state->seqlock);
+		if (!nfs4_state_match_open_stateid_other(state, dst)) {
+			nfs4_stateid_copy(dst, &state->open_stateid);
+			if (read_seqretry(&state->seqlock, seq))
+				continue;
+			break;
+		}
+		seqid_open = state->open_stateid.seqid;
+		if (read_seqretry(&state->seqlock, seq))
+			continue;
+
+		dst_seqid = be32_to_cpu(dst->seqid);
+		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) < 0)
+			dst->seqid = seqid_open;
+		break;
+	}
+}
+
+/*
+ * Update the seqid of an open stateid after receiving
+ * NFS4ERR_OLD_STATEID
+ */
+static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
+		struct nfs4_state *state)
+{
+	__be32 seqid_open;
+	u32 dst_seqid;
+	bool ret;
+	int seq;
+
+	for (;;) {
+		ret = false;
+		if (!nfs4_valid_open_stateid(state))
+			break;
+		seq = read_seqbegin(&state->seqlock);
+		if (!nfs4_state_match_open_stateid_other(state, dst)) {
+			if (read_seqretry(&state->seqlock, seq))
+				continue;
+			break;
+		}
+		seqid_open = state->open_stateid.seqid;
+		if (read_seqretry(&state->seqlock, seq))
+			continue;
+
+		dst_seqid = be32_to_cpu(dst->seqid);
+		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) >= 0)
+			dst->seqid = cpu_to_be32(dst_seqid + 1);
+		else
+			dst->seqid = seqid_open;
+		ret = true;
+		break;
+	}
+
+	return ret;
+}
+
 struct nfs4_closedata {
 	struct inode *inode;
 	struct nfs4_state *state;
@@ -3382,7 +3451,7 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 			break;
 		case -NFS4ERR_OLD_STATEID:
 			/* Did we race with OPEN? */
-			if (nfs4_refresh_open_stateid(&calldata->arg.stateid,
+			if (nfs4_refresh_open_old_stateid(&calldata->arg.stateid,
 						state))
 				goto out_restart;
 			goto out_release;
@@ -3451,8 +3520,8 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
 	} else if (is_rdwr)
 		calldata->arg.fmode |= FMODE_READ|FMODE_WRITE;
 
-	if (!nfs4_valid_open_stateid(state) ||
-	    !nfs4_refresh_open_stateid(&calldata->arg.stateid, state))
+	nfs4_sync_open_stateid(&calldata->arg.stateid, state);
+	if (!nfs4_valid_open_stateid(state))
 		call_close = 0;
 	spin_unlock(&state->owner->so_lock);
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index cad4e064b328..e23945174da4 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1015,22 +1015,6 @@ static int nfs4_copy_lock_stateid(nfs4_stateid *dst,
 	return ret;
 }
 
-bool nfs4_refresh_open_stateid(nfs4_stateid *dst, struct nfs4_state *state)
-{
-	bool ret;
-	int seq;
-
-	do {
-		ret = false;
-		seq = read_seqbegin(&state->seqlock);
-		if (nfs4_state_match_open_stateid_other(state, dst)) {
-			dst->seqid = state->open_stateid.seqid;
-			ret = true;
-		}
-	} while (read_seqretry(&state->seqlock, seq));
-	return ret;
-}
-
 bool nfs4_copy_open_stateid(nfs4_stateid *dst, struct nfs4_state *state)
 {
 	bool ret;
-- 
2.21.0

