Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C350F65EA7E
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 13:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjAEMPV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 07:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjAEMPR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 07:15:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D745844C7B
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 04:15:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 730A5619BA
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 12:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921D8C433F0;
        Thu,  5 Jan 2023 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672920915;
        bh=3p+ngESF8KDQYHCVlyR+gbXAMRqoiukwDM35jBjQZnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fe1qmwYAP1hdESRBr8dQ29fOd+YtMH84NmLg9yst0FgZfZGXpLOBmaIRI4kEaHOa+
         41734WtCToaXafQuTGrSZfYml8yuWE6MtJUAvpeZ4RlKqJ2uQ14IvU5bNaPvbsuEIr
         BLhfWASGKoxWfzK0vwW1IZDix3/WuSPlW/NACNgrBzdG9So65yEz2mVXCx02TKAABV
         qvR3V/9otyljh5Qm4FkXVUVmZWDRk9TLuhjbyE0/yU49raI0sYj1JcTP57vNl5i25H
         97wuXwZRiu/k5PG2cyClEy7kdqDav/eyMLjIlLCNxFXOPLC2eN2/vHuhBNshpO1WKZ
         PJweVsMP+LJvw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed entries
Date:   Thu,  5 Jan 2023 07:15:10 -0500
Message-Id: <20230105121512.21484-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105121512.21484-1-jlayton@kernel.org>
References: <20230105121512.21484-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since v4 files are expected to be long-lived, there's little value in
closing them out of the cache when there is conflicting access.

Rename NFSD_FILE_KEY_INODE to NFSD_FILE_KEY_INODE_GC, and change the
comparator to also match the gc value in the key. Change both of the
current users of that key to set the gc value in the key to "true".

Also, test_bit returns bool, AFAICT, so I think we're ok to drop the
!! from the condition later in the comparator.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9fff1fa09d08..a67b22579c6e 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -78,7 +78,7 @@ static struct rhashtable		nfsd_file_rhash_tbl
 						____cacheline_aligned_in_smp;
 
 enum nfsd_file_lookup_type {
-	NFSD_FILE_KEY_INODE,
+	NFSD_FILE_KEY_INODE_GC,
 	NFSD_FILE_KEY_FULL,
 };
 
@@ -174,7 +174,9 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
 	const struct nfsd_file *nf = ptr;
 
 	switch (key->type) {
-	case NFSD_FILE_KEY_INODE:
+	case NFSD_FILE_KEY_INODE_GC:
+		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
+			return 1;
 		if (nf->nf_inode != key->inode)
 			return 1;
 		break;
@@ -187,7 +189,7 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
 			return 1;
 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
 			return 1;
-		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
+		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
 			return 1;
 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0)
 			return 1;
@@ -681,8 +683,9 @@ static void
 nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
 {
 	struct nfsd_file_lookup_key key = {
-		.type	= NFSD_FILE_KEY_INODE,
+		.type	= NFSD_FILE_KEY_INODE_GC,
 		.inode	= inode,
+		.gc	= true,
 	};
 	struct nfsd_file *nf;
 
@@ -1057,8 +1060,9 @@ bool
 nfsd_file_is_cached(struct inode *inode)
 {
 	struct nfsd_file_lookup_key key = {
-		.type	= NFSD_FILE_KEY_INODE,
+		.type	= NFSD_FILE_KEY_INODE_GC,
 		.inode	= inode,
+		.gc	= true,
 	};
 	bool ret = false;
 
-- 
2.39.0

