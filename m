Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B9B57E652
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 20:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiGVSM2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 14:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiGVSM1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 14:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281F197A2F
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 11:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E5C622DB
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 18:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8D6C341C6;
        Fri, 22 Jul 2022 18:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658513545;
        bh=vlTMoCE6tYvp/S9rbUc5lDc5FJNn+2wuZg9qtn35Wnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brNTVq3RTSH32Jgz/Fq+WjwTJK+OQYequ5tPVnx9v/bKUzUWUicFmnVrN6Zq+Egit
         suxJxpmtpHiobkSCVpQw3tvbS/p9eo2OA+JLBm1ZaCA8HIl41OLvvmxVtUYRnGV1Rl
         Z+zIqRwXs350QUVW5M1gZDKGeQxuzUN7Erta/i6ExunmWJQiBScxWNQ5msWn3nDakI
         kwBB0LoFJDkeHi0zGmM62cfUABpOrAA/Ijk8nEA2dNAMEmSXU9HFCenrr9s0mZ75SF
         gmlMB71yhTl3Kvaouqb9/IEQT+r3KXbzgibVdV5VpGZdai/dyfSMKN1STy6JqdCRbi
         xu9w84lHXBdgQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com, bxue@redhat.com
Subject: [PATCH 3/3] nfs: only issue commit in DIO codepath if we have uncommitted data
Date:   Fri, 22 Jul 2022 14:12:20 -0400
Message-Id: <20220722181220.81636-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220722181220.81636-1-jlayton@kernel.org>
References: <20220722181220.81636-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, we try to determine whether to issue a commit based on
nfs_write_need_commit which looks at the current verifier. In the case
where we got a short write and then tried to follow it up with one that
failed, the verifier can't be trusted.

What we really want to know is whether the pgio request had any
successful writes that came back as UNSTABLE. Add a new flag to the pgio
request, and use that to indicate that we've had a successful unstable
write. Only issue a commit if that flag is set.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/direct.c         |  2 +-
 fs/nfs/write.c          | 48 +++++++++++++++++++++++++----------------
 include/linux/nfs_xdr.h |  1 +
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index a47d13296194..86df66bb14c5 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -690,7 +690,7 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 	}
 
 	nfs_direct_count_bytes(dreq, hdr);
-	if (hdr->good_bytes != 0 && nfs_write_need_commit(hdr)) {
+	if (test_bit(NFS_IOHDR_UNSTABLE_WRITES, &hdr->flags)) {
 		if (!dreq->flags)
 			dreq->flags = NFS_ODIRECT_DO_COMMIT;
 		flags = dreq->flags;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 1c706465d090..16d166bc4099 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1576,25 +1576,37 @@ static int nfs_writeback_done(struct rpc_task *task,
 	nfs_add_stats(inode, NFSIOS_SERVERWRITTENBYTES, hdr->res.count);
 	trace_nfs_writeback_done(task, hdr);
 
-	if (hdr->res.verf->committed < hdr->args.stable &&
-	    task->tk_status >= 0) {
-		/* We tried a write call, but the server did not
-		 * commit data to stable storage even though we
-		 * requested it.
-		 * Note: There is a known bug in Tru64 < 5.0 in which
-		 *	 the server reports NFS_DATA_SYNC, but performs
-		 *	 NFS_FILE_SYNC. We therefore implement this checking
-		 *	 as a dprintk() in order to avoid filling syslog.
-		 */
-		static unsigned long    complain;
+	if (task->tk_status >= 0) {
+		enum nfs3_stable_how committed = hdr->res.verf->committed;
+
+		if (committed == NFS_UNSTABLE) {
+			/*
+			 * We have some uncommitted data on the server at
+			 * this point, so ensure that we keep track of that
+			 * fact irrespective of what later writes do.
+			 */
+			set_bit(NFS_IOHDR_UNSTABLE_WRITES, &hdr->flags);
+		}
 
-		/* Note this will print the MDS for a DS write */
-		if (time_before(complain, jiffies)) {
-			dprintk("NFS:       faulty NFS server %s:"
-				" (committed = %d) != (stable = %d)\n",
-				NFS_SERVER(inode)->nfs_client->cl_hostname,
-				hdr->res.verf->committed, hdr->args.stable);
-			complain = jiffies + 300 * HZ;
+		if (committed < hdr->args.stable) {
+			/* We tried a write call, but the server did not
+			 * commit data to stable storage even though we
+			 * requested it.
+			 * Note: There is a known bug in Tru64 < 5.0 in which
+			 *	 the server reports NFS_DATA_SYNC, but performs
+			 *	 NFS_FILE_SYNC. We therefore implement this checking
+			 *	 as a dprintk() in order to avoid filling syslog.
+			 */
+			static unsigned long    complain;
+
+			/* Note this will print the MDS for a DS write */
+			if (time_before(complain, jiffies)) {
+				dprintk("NFS:       faulty NFS server %s:"
+					" (committed = %d) != (stable = %d)\n",
+					NFS_SERVER(inode)->nfs_client->cl_hostname,
+					committed, hdr->args.stable);
+				complain = jiffies + 300 * HZ;
+			}
 		}
 	}
 
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 0e3aa0f5f324..e86cf6642d21 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1600,6 +1600,7 @@ enum {
 	NFS_IOHDR_STAT,
 	NFS_IOHDR_RESEND_PNFS,
 	NFS_IOHDR_RESEND_MDS,
+	NFS_IOHDR_UNSTABLE_WRITES,
 };
 
 struct nfs_io_completion;
-- 
2.36.1

