Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA918B4247
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 22:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbfIPUqg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 16:46:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45469 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733128AbfIPUqg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 16:46:36 -0400
Received: by mail-io1-f66.google.com with SMTP id f12so2198281iog.12
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 13:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=426706+FlYC3v0VZqCIDoAzzSSKZhgN5MXl6xlGWijs=;
        b=bANDj+BbdbZWv/66Ppod+FT6LjyN9dWPwLG1lruyg/yhrJps3kuXAo47fF832iAJgP
         lAcvbhH6Xtx+W/eP+i1/FfpXVdXpA7lce8Y71URjU5y6qsNnmTOyooIhOlzO0GwVzQsI
         uS8dqyq7EU0J/RL8AVVrDLj19Gz38/CacgdVhKUb+auj75FOTa27abVFNqWdS/pff+H8
         FW8AXEtQmbH4BTBnIRZKxZSeopH6cqLCfvIA5nN+SdOEwRJmEWGEF7GEEal09SvYsxAZ
         OaaILzWrU2EavcUPx1SX5H1X+PHhghblcvHSAslJ7KD/1kifBeiQZtuqipJqcRCI4DxM
         ocJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=426706+FlYC3v0VZqCIDoAzzSSKZhgN5MXl6xlGWijs=;
        b=nT/UevhbjnVopml9JyTd39DFIx+1O/qP9p+HcVvrVlNnbleHdGk4pyjb6JaIpZpvzh
         YoOLDXjGaPHqRY3Lq14tET0ALipk99I5B9wli9cBZdoVxUkR9Nv94RCmfAfvm7MR9TTB
         gcdWGLlNNqKPFnxayInSNBiY/ytxJpRU0rGSkphVlkPxBqDLQg/MQ6huvc06C7A+PyyC
         Hb2a8preh2Q+hhM63R54g/tvUOjUf75mRpCbeu4W/uvgSXYyPjHUvvhVazsVypi1TsvQ
         1ivtlkjpnmYAcXsC4bsekQ7H650EGp86aywNfa6cxVS0/jz6EQGtyI/4dnWo9mRLduhz
         Z6rA==
X-Gm-Message-State: APjAAAWaNGPqMDrHjwVjk1OQQJLBcT9sny0twl/RxXGj7UROgoIZgX5T
        qYQ/2B7jUjWe6hqqaMnbPg==
X-Google-Smtp-Source: APXvYqy8Z/MY9HZgv5A+iibQxWapEKnJcYE3LosYUvp8RvqDpH7QFY+ud3lgQ1COtHFAyM9u93OeDQ==
X-Received: by 2002:a6b:3c0a:: with SMTP id k10mr242248iob.282.1568666794710;
        Mon, 16 Sep 2019 13:46:34 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c6sm3528iom.34.2019.09.16.13.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:46:34 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 9/9] NFSv4: Handle NFS4ERR_OLD_STATEID in LOCKU
Date:   Mon, 16 Sep 2019 16:44:19 -0400
Message-Id: <20190916204419.21717-10-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204419.21717-9-trond.myklebust@hammerspace.com>
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
 <20190916204419.21717-2-trond.myklebust@hammerspace.com>
 <20190916204419.21717-3-trond.myklebust@hammerspace.com>
 <20190916204419.21717-4-trond.myklebust@hammerspace.com>
 <20190916204419.21717-5-trond.myklebust@hammerspace.com>
 <20190916204419.21717-6-trond.myklebust@hammerspace.com>
 <20190916204419.21717-7-trond.myklebust@hammerspace.com>
 <20190916204419.21717-8-trond.myklebust@hammerspace.com>
 <20190916204419.21717-9-trond.myklebust@hammerspace.com>
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
 fs/nfs/nfs4proc.c | 48 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c14af2c1c6b6..2fe6f8737023 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6411,6 +6411,42 @@ static int nfs4_proc_getlk(struct nfs4_state *state, int cmd, struct file_lock *
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
@@ -6444,6 +6480,7 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	locks_init_lock(&p->fl);
 	locks_copy_lock(&p->fl, fl);
 	p->server = NFS_SERVER(inode);
+	nfs4_stateid_copy(&p->arg.stateid, &lsp->ls_stateid);
 	return p;
 }
 
@@ -6482,10 +6519,14 @@ static void nfs4_locku_done(struct rpc_task *task, void *data)
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
@@ -6508,7 +6549,6 @@ static void nfs4_locku_prepare(struct rpc_task *task, void *data)
 
 	if (nfs_wait_on_sequence(calldata->arg.seqid, task) != 0)
 		goto out_wait;
-	nfs4_stateid_copy(&calldata->arg.stateid, &calldata->lsp->ls_stateid);
 	if (test_bit(NFS_LOCK_INITIALIZED, &calldata->lsp->ls_flags) == 0) {
 		/* Note: exit _without_ running nfs4_locku_done */
 		goto out_no_action;
-- 
2.21.0

