Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659545EB04F
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Sep 2022 20:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiIZSmr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Sep 2022 14:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiIZSlv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Sep 2022 14:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0C017E1F
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 11:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 974BA61132
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 18:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C76C43150;
        Mon, 26 Sep 2022 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664217664;
        bh=Zcjvh+pca4laB4jRvvwNRyy6FVS05eQSPP4HekWceA8=;
        h=From:To:Cc:Subject:Date:From;
        b=tQV1FgwEArVMsRNgIAZgendSN32FuUi71OmKCzRkReING2BIbbLzO0qh7QhlV/705
         us+e8P1KbEgYW0VLXtQsjsY319zjFcGTPPNFeWnBnOO3iRqkFF2174W6kxM5VT/kAV
         wy/nscT00LRLRat2JR2/PXK8gXhRnfaKlykdiw1/BRuez1NMbDSbgpbWbx7cRjp8Kh
         tRPw402CZ73ha4xNJ5YmTkt6xxU2e08LvAaKOuRKQBPaXCg6zk+bAI9aCXWF2bGYjY
         7+ZlBbxLCsyQuzUro3p0kV+CB+85LA6xdYrafnExM9XldOht81m02MRObC/7Z2JMGx
         Y88+N0i3fcebw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] nfsd: make nfsd4_run_cb a bool return function
Date:   Mon, 26 Sep 2022 14:41:01 -0400
Message-Id: <20220926184102.57254-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

queue_work can return false and not queue anything, if the work is
already queued. If that happens in the case of a CB_RECALL, we'll have
taken an extra reference to the stid that will never be put. Ensure we
throw a warning in that case.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 14 ++++++++++++--
 fs/nfsd/nfs4state.c    |  5 ++---
 fs/nfsd/state.h        |  2 +-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 4ce328209f61..c4ee4a820a62 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1371,11 +1371,21 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_holds_slot = false;
 }
 
-void nfsd4_run_cb(struct nfsd4_callback *cb)
+/**
+ * nfsd4_run_cb - queue up a callback job to run
+ * @cb: callback to queue
+ *
+ * Kick off a callback to do its thing. Returns false if it was already
+ * on a queue, true otherwise.
+ */
+bool nfsd4_run_cb(struct nfsd4_callback *cb)
 {
+	bool queued;
 	struct nfs4_client *clp = cb->cb_clp;
 
 	nfsd41_cb_inflight_begin(clp);
-	if (!nfsd4_queue_cb(cb))
+	queued = nfsd4_queue_cb(cb);
+	if (!queued)
 		nfsd41_cb_inflight_end(clp);
+	return queued;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e116f50afcf2..c78c3223161e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4859,14 +4859,13 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 	 * we know it's safe to take a reference.
 	 */
 	refcount_inc(&dp->dl_stid.sc_count);
-	nfsd4_run_cb(&dp->dl_recall);
+	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
 }
 
 /* Called from break_lease() with flc_lock held. */
 static bool
 nfsd_break_deleg_cb(struct file_lock *fl)
 {
-	bool ret = false;
 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
@@ -4892,7 +4891,7 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	fp->fi_had_conflict = true;
 	nfsd_break_one_deleg(dp);
 	spin_unlock(&fp->fi_lock);
-	return ret;
+	return false;
 }
 
 /**
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index b3477087a9fc..e2daef3cc003 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -692,7 +692,7 @@ extern void nfsd4_probe_callback_sync(struct nfs4_client *clp);
 extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *);
 extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
-extern void nfsd4_run_cb(struct nfsd4_callback *cb);
+extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
 extern int nfsd4_create_callback_queue(void);
 extern void nfsd4_destroy_callback_queue(void);
 extern void nfsd4_shutdown_callback(struct nfs4_client *);
-- 
2.37.3

