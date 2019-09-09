Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA682ADAAD
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 16:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405129AbfIIODW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Sep 2019 10:03:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35945 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405126AbfIIODW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Sep 2019 10:03:22 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so28947816iof.3
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2019 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RzLZLmp3WvFdfyW0ZePHs1vz3bQF80svtna2LHv1A6I=;
        b=I+GkS99Xf//pFDDBp3I0Nvh9kK5DvXPJrsHDt0LTqWIC/ajsFahssyyQMXH6Dj+7/9
         Iy1OAkFQyQiwP5TlvkT3nVIeEdweXKxOs45VogWfDtkUhoWj1j/Z1NsBxjZjqRfTbo4g
         eh7jErdM1zSC//qndGpa5136F46NmBFS8GuOw5vYjVf3g3ZeRVAqAs6HDQlP2blYWBWo
         vGFmFNCaI+M3UcuSOq0VTGDec3sZLmLGyQZdiAaZ1JI4llrOeet6QFg7/1WQ9OG69/IK
         x0j8ecVIsWVcGAxogKEIwFvuU60sGq2NFZM900Yhb6/LTAXdzqti+ud8zuqDvv8oU2kT
         25hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RzLZLmp3WvFdfyW0ZePHs1vz3bQF80svtna2LHv1A6I=;
        b=sHpuCbfErQMPVRkAQ1NC5c0Up9J5874fQplLfyqzDTx5iuH9iZTG5fOFlGzUOF5cy/
         GpTbn50h54FiS7AP6coLqTrNfxfJIa0oGCOz1j6a3KoG8adlfbL4xGRZus/6x99K13av
         ybw203vQsG7nT2UzTYm1q8rueUlOSUhb7T+cJhycTo54nmNRK5gaUUNMGcBqhDG4Ee4F
         F/sT08yX9Bs3IaV8etyQxpHDWA28pFWsYv/geNBTAQ9ryzOtxuIBhvhwKnyOm/1vbVFa
         MxovXoaoHXFEzUfkUYD/Ns6l6Jr30q48F9O0aVLGMy+D+gYZpy4ZwTtNUd3iWg+sD0xc
         cZAw==
X-Gm-Message-State: APjAAAV9B3XOufrkPB6E5gY0cB9UU0/Drc0lnkfCVO2Tr5mROZFsYVz1
        UOxPXsXhlExP05caXWQrmA==
X-Google-Smtp-Source: APXvYqyodsVEN1Ki+M6pFFMzX4HQQmtA4Vm4b4k8yOCZC8K87z7ef8SI+Z4Q1qDm3u8axIE0FoO0SA==
X-Received: by 2002:a5d:89c1:: with SMTP id a1mr26209316iot.306.1568037800572;
        Mon, 09 Sep 2019 07:03:20 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id h70sm33727176iof.48.2019.09.09.07.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:03:19 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 8/9] NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
Date:   Mon,  9 Sep 2019 10:01:03 -0400
Message-Id: <20190909140104.78818-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909140104.78818-7-trond.myklebust@hammerspace.com>
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
 <20190909140104.78818-2-trond.myklebust@hammerspace.com>
 <20190909140104.78818-3-trond.myklebust@hammerspace.com>
 <20190909140104.78818-4-trond.myklebust@hammerspace.com>
 <20190909140104.78818-5-trond.myklebust@hammerspace.com>
 <20190909140104.78818-6-trond.myklebust@hammerspace.com>
 <20190909140104.78818-7-trond.myklebust@hammerspace.com>
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
 fs/nfs/nfs4proc.c  | 41 ++++++++++++++++++++++++++++++++++++++---
 fs/nfs/nfs4state.c | 16 ----------------
 3 files changed, 38 insertions(+), 21 deletions(-)

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
index 025dd5efbf34..49f301198008 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3308,6 +3308,42 @@ nfs4_wait_on_layoutreturn(struct inode *inode, struct rpc_task *task)
 	return pnfs_wait_on_layoutreturn(inode, task);
 }
 
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
+		seq = read_seqbegin(&state->seqlock);
+		if (!nfs4_state_match_open_stateid_other(state, dst)) {
+			if (read_seqretry(&state->seqlock, seq))
+				continue;
+			break;
+		}
+		seqid_open = state->open_stateid.seqid;
+		dst_seqid = be32_to_cpu(dst->seqid);
+
+		if (read_seqretry(&state->seqlock, seq))
+			continue;
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
@@ -3382,7 +3418,7 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 			break;
 		case -NFS4ERR_OLD_STATEID:
 			/* Did we race with OPEN? */
-			if (nfs4_refresh_open_stateid(&calldata->arg.stateid,
+			if (nfs4_refresh_open_old_stateid(&calldata->arg.stateid,
 						state))
 				goto out_restart;
 			goto out_release;
@@ -3451,8 +3487,7 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
 	} else if (is_rdwr)
 		calldata->arg.fmode |= FMODE_READ|FMODE_WRITE;
 
-	if (!nfs4_valid_open_stateid(state) ||
-	    !nfs4_refresh_open_stateid(&calldata->arg.stateid, state))
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

