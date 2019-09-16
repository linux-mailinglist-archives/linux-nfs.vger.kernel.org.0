Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 510D2B4246
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 22:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733255AbfIPUqf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 16:46:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39192 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733156AbfIPUqf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 16:46:35 -0400
Received: by mail-io1-f65.google.com with SMTP id a1so2297240ioc.6
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKBtfXBDb2I4SIWkL8RbGSdtWIaBiUXWBZYasSgkTuM=;
        b=iT0Qif5jqj6WB6v4kVzkV10QlNu/4nPhtNaNv+5zjs9KTSDpIs3HLj0F8ZvnFP7FeE
         CYhzF3OIv3+nCd78Y0VtMGVKX5L4If3zf9oH8z/cGCGLErcNllwQ8qbVngdU0WiJvOaF
         v3Vm7uSX4iP3w8C9/FybbZDL2EPqVySl2QYfEf4xyElD+hIalefszfLVx8/P6HRmmH5C
         b2TKPR9N/zPh7uQN35PX4FBMWbhcLk8PnMXk9D+c+fNi1I6yQvuBSepGEJUjhQlth5jN
         VHr+KNW4N7byDPKzrGvw3wFX6mSzLETnSfU0Jlba5g69tm2fpZrGyKE0Sc0xCr5DBQGT
         Az6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKBtfXBDb2I4SIWkL8RbGSdtWIaBiUXWBZYasSgkTuM=;
        b=I9ATI2nZGZ5QBFdDWkLwxyIS6Lt1ojBKEys1nVmsvzdcbCgOEefK3Ccd5+Nm7/yf+e
         NZ4gI0V3E0J6zlqMDM2hihdyhQoKo0rdji4nqBOwQesSKNZiXAK5bRjzdstSD8WSLAfx
         FGgiHTmTqPlUCwrnDyevbg3kjYCR88w6M4pdY6FOccj9wUGwUoiNN29uMkrcacxykosg
         Nm7K7u8WadM6wXetyOCeWMO0lowuOqXYip3NcYV8no0hTI2bed7+b2zh9NaxPbUpP+9+
         bb7Yo/7r2sgZXsNhHODdZ5ELDAWan09ld1BFY+SNyuF60DuZw/aJpFB/bYi2+628C9Sf
         E37Q==
X-Gm-Message-State: APjAAAVJFmCjnuXLei3KnqqV987s/PAb0o/8l8V3pcQRALMlmYow1UqL
        MQk2KzdkAJ40ImtA/fADBSe3Z1dIWw==
X-Google-Smtp-Source: APXvYqyMsqKS7rzsM4AiyhEuYt4OSmZS4bohObkQSHIXVg87uzkzGOEEivrcc9TMvuQz+jTngONaQw==
X-Received: by 2002:a5e:8b43:: with SMTP id z3mr276306iom.114.1568666793990;
        Mon, 16 Sep 2019 13:46:33 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c6sm3528iom.34.2019.09.16.13.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:46:33 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 8/9] NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
Date:   Mon, 16 Sep 2019 16:44:18 -0400
Message-Id: <20190916204419.21717-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204419.21717-8-trond.myklebust@hammerspace.com>
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
 <20190916204419.21717-2-trond.myklebust@hammerspace.com>
 <20190916204419.21717-3-trond.myklebust@hammerspace.com>
 <20190916204419.21717-4-trond.myklebust@hammerspace.com>
 <20190916204419.21717-5-trond.myklebust@hammerspace.com>
 <20190916204419.21717-6-trond.myklebust@hammerspace.com>
 <20190916204419.21717-7-trond.myklebust@hammerspace.com>
 <20190916204419.21717-8-trond.myklebust@hammerspace.com>
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

