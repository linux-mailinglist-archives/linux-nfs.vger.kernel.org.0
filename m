Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7577360BF6A
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 02:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiJYASU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 20:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiJYARx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 20:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3682E8C4B
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 15:38:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4FF615F0
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 22:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F145C433D7;
        Mon, 24 Oct 2022 22:38:09 +0000 (UTC)
Subject: [PATCH v5 12/13] NFSD: Allocate an rhashtable for nfs4_file objects
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 24 Oct 2022 18:38:08 -0400
Message-ID: <166665108857.50761.11874625810370383309.stgit@klimt.1015granger.net>
In-Reply-To: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>
References: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce the infrastructure for managing nfs4_file objects in an
rhashtable. This infrastructure will be used by the next patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   23 ++++++++++++++++++++++-
 fs/nfsd/state.h     |    1 +
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index abed795bb4ec..681cb2daa843 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -44,7 +44,9 @@
 #include <linux/jhash.h>
 #include <linux/string_helpers.h>
 #include <linux/fsnotify.h>
+#include <linux/rhashtable.h>
 #include <linux/nfs_ssc.h>
+
 #include "xdr4.h"
 #include "xdr4cb.h"
 #include "vfs.h"
@@ -721,6 +723,18 @@ static unsigned int file_hashval(const struct svc_fh *fh)
 
 static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
 
+static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
+
+static const struct rhashtable_params nfs4_file_rhash_params = {
+	.key_len		= sizeof_field(struct nfs4_file, fi_inode),
+	.key_offset		= offsetof(struct nfs4_file, fi_inode),
+	.head_offset		= offsetof(struct nfs4_file, fi_rlist),
+
+	/* Reduce resizing churn on light workloads */
+	.min_size		= 256,		/* buckets */
+	.automatic_shrinking	= true,
+};
+
 /*
  * Check if courtesy clients have conflicting access and resolve it if possible
  *
@@ -8023,10 +8037,16 @@ nfs4_state_start(void)
 {
 	int ret;
 
-	ret = nfsd4_create_callback_queue();
+	ret = rhltable_init(&nfs4_file_rhltable, &nfs4_file_rhash_params);
 	if (ret)
 		return ret;
 
+	ret = nfsd4_create_callback_queue();
+	if (ret) {
+		rhltable_destroy(&nfs4_file_rhltable);
+		return ret;
+	}
+
 	set_max_delegations();
 	return 0;
 }
@@ -8057,6 +8077,7 @@ nfs4_state_shutdown_net(struct net *net)
 
 	nfsd4_client_tracking_exit(net);
 	nfs4_state_destroy_net(net);
+	rhltable_destroy(&nfs4_file_rhltable);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_shutdown_umount(nn);
 #endif
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e2daef3cc003..190fc7e418a4 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -546,6 +546,7 @@ struct nfs4_file {
 	bool			fi_aliased;
 	spinlock_t		fi_lock;
 	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
+	struct rhlist_head	fi_rlist;
 	struct list_head        fi_stateids;
 	union {
 		struct list_head	fi_delegations;


