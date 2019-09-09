Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9D0ADAAE
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405130AbfIIODX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Sep 2019 10:03:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41129 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405126AbfIIODW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Sep 2019 10:03:22 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so28823330ioh.8
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2019 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wy1dUH5bibrhCk/Qm7oofyb/CYs8Ue5YUMfLEdziIqQ=;
        b=pJ2vfWYq8G4Yq+jADOt3h+BBGFjoXuIvkjwtshXMLhF0xMlme7qnQKgtbsfpruJMGU
         oOltRKf/njzqBaR3kSVQczDfPMDBGBcp4+kKl/UcSOT73eHqOvWQphRDchDiP6ZnzftW
         q07o7T+jY4HNayVuw0/5iCZVJ22ynWUBFk2o7xu+nDgYPbBuSMcsuxgv4dCGo+4sva+9
         vWWXCdGBHuMJja9UyZYh/16MUsBlUl8TMWhXo5TLG0ttIGt8FKMebcFXrpiGRLb1P5GY
         Bq/CNkOEAy4jn00jvrHoVarzCrpDbKqJnf44vVMn99kbEvTxumdkfnp3mDCUbT5Ei34H
         wGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wy1dUH5bibrhCk/Qm7oofyb/CYs8Ue5YUMfLEdziIqQ=;
        b=G7Twr7hJuE3xz2g6bO2hY1XneFwpXpBuxkujOBuhZ7ekQbiKIXa07WZENHWz52QQ8j
         HIoK43XK95s3o8MNKuzjCSNPCa0kgGq7ST/oxBpoeAag8WGGVkOM5T5qiY2NKSkhVMFj
         4yKqNaUfoxE4bvQEMNBA95KyswJUejiD04WiVP+heu8G0VYokClG0gokuH9NPNWmw/NY
         aPsUiB2/8o4VJH5ueYosEzJ2HEHyGtiqshKFvU5XT221HEI5fqBJ/ynE0nQ3lAt1NWZx
         EApGtqiLlHmFs8PLCAb+5fCrBVEajOZN/X5Qn3heFtrAu2Hw2wAtyVaZ7IkvSjzpSUGF
         Q1yA==
X-Gm-Message-State: APjAAAW+CFz8WlP/XU3j8NYHtT04A4v+/celrJU2CbRFJtuQyb4FsWX5
        fLW0FpgG7v2A/nvEGJY3s8aBxW/0Bg==
X-Google-Smtp-Source: APXvYqyJ/nOe3FqQ9QTdaIizc1k0XaBNEq1NnVSfPfV7zWPeg+YHjWkWrrqBQwbT6BOISCGu4Z17zA==
X-Received: by 2002:a6b:7a07:: with SMTP id h7mr26669923iom.57.1568037801790;
        Mon, 09 Sep 2019 07:03:21 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id h70sm33727176iof.48.2019.09.09.07.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:03:21 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 9/9] NFSv4: Handle NFS4ERR_OLD_STATEID in LOCKU
Date:   Mon,  9 Sep 2019 10:01:04 -0400
Message-Id: <20190909140104.78818-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909140104.78818-8-trond.myklebust@hammerspace.com>
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
 <20190909140104.78818-2-trond.myklebust@hammerspace.com>
 <20190909140104.78818-3-trond.myklebust@hammerspace.com>
 <20190909140104.78818-4-trond.myklebust@hammerspace.com>
 <20190909140104.78818-5-trond.myklebust@hammerspace.com>
 <20190909140104.78818-6-trond.myklebust@hammerspace.com>
 <20190909140104.78818-7-trond.myklebust@hammerspace.com>
 <20190909140104.78818-8-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a LOCKU request receives a NFS4ERR_OLD_STATEID, then bump the
seqid before resending. Ensure we only bump the seqid by 1.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 49f301198008..ecfaf4b1ba5d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6377,6 +6377,42 @@ static int nfs4_proc_getlk(struct nfs4_state *state, int cmd, struct file_lock *
 	return err;
 }
 
+/*
+ * Update the seqid of a lock stateid after receiving
+ * NFS4ERR_OLD_STATEID
+ */
+static bool nfs4_refresh_lock_old_stateid(nfs4_stateid *dst,
+		struct nfs4_lock_state *lsp)
+{
+	struct nfs4_state *state = lsp->ls_state;
+	bool ret = false;
+
+	spin_lock(&state->state_lock);
+	if (!nfs4_stateid_match_other(dst, &lsp->ls_stateid))
+		goto out;
+	if (!nfs4_stateid_is_newer(&lsp->ls_stateid, dst))
+		nfs4_stateid_seqid_inc(dst);
+	else
+		dst->seqid = lsp->ls_stateid.seqid;
+	ret = true;
+out:
+	spin_unlock(&state->state_lock);
+	return ret;
+}
+
+static bool nfs4_sync_lock_stateid(nfs4_stateid *dst,
+		struct nfs4_lock_state *lsp)
+{
+	struct nfs4_state *state = lsp->ls_state;
+	bool ret;
+
+	spin_lock(&state->state_lock);
+	ret = !nfs4_stateid_match_other(dst, &lsp->ls_stateid);
+	nfs4_stateid_copy(dst, &lsp->ls_stateid);
+	spin_unlock(&state->state_lock);
+	return ret;
+}
+
 struct nfs4_unlockdata {
 	struct nfs_locku_args arg;
 	struct nfs_locku_res res;
@@ -6448,10 +6484,14 @@ static void nfs4_locku_done(struct rpc_task *task, void *data)
 					task->tk_msg.rpc_cred);
 			/* Fall through */
 		case -NFS4ERR_BAD_STATEID:
-		case -NFS4ERR_OLD_STATEID:
 		case -NFS4ERR_STALE_STATEID:
-			if (!nfs4_stateid_match(&calldata->arg.stateid,
-						&calldata->lsp->ls_stateid))
+			if (nfs4_sync_lock_stateid(&calldata->arg.stateid,
+						calldata->lsp))
+				rpc_restart_call_prepare(task);
+			break;
+		case -NFS4ERR_OLD_STATEID:
+			if (nfs4_refresh_lock_old_stateid(&calldata->arg.stateid,
+						calldata->lsp))
 				rpc_restart_call_prepare(task);
 			break;
 		default:
@@ -6474,7 +6514,6 @@ static void nfs4_locku_prepare(struct rpc_task *task, void *data)
 
 	if (nfs_wait_on_sequence(calldata->arg.seqid, task) != 0)
 		goto out_wait;
-	nfs4_stateid_copy(&calldata->arg.stateid, &calldata->lsp->ls_stateid);
 	if (test_bit(NFS_LOCK_INITIALIZED, &calldata->lsp->ls_flags) == 0) {
 		/* Note: exit _without_ running nfs4_locku_done */
 		goto out_no_action;
-- 
2.21.0

