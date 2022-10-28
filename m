Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A48611524
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiJ1OtL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 10:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiJ1Os7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 10:48:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F4E20272F
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 07:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 949CA628ED
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 14:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF08C433D6;
        Fri, 28 Oct 2022 14:47:54 +0000 (UTC)
Subject: [PATCH v7 13/14] NFSD: Allocate an rhashtable for nfs4_file objects
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de, jlayton@redhat.com
Date:   Fri, 28 Oct 2022 10:47:53 -0400
Message-ID: <166696847392.106044.9319954364556566370.stgit@klimt.1015granger.net>
In-Reply-To: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
References: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
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
Reviewed-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c |   26 +++++++++++++++++++++++++-
 fs/nfsd/state.h     |    1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2b694d693be5..c2ef2db9c84c 100644
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
@@ -721,6 +723,21 @@ static unsigned int file_hashval(const struct svc_fh *fh)
 
 static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
 
+static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
+
+static const struct rhashtable_params nfs4_file_rhash_params = {
+	.key_len		= sizeof_field(struct nfs4_file, fi_inode),
+	.key_offset		= offsetof(struct nfs4_file, fi_inode),
+	.head_offset		= offsetof(struct nfs4_file, fi_rlist),
+
+	/*
+	 * Start with a single page hash table to reduce resizing churn
+	 * on light workloads.
+	 */
+	.min_size		= 256,
+	.automatic_shrinking	= true,
+};
+
 /*
  * Check if courtesy clients have conflicting access and resolve it if possible
  *
@@ -8026,10 +8043,16 @@ nfs4_state_start(void)
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
@@ -8060,6 +8083,7 @@ nfs4_state_shutdown_net(struct net *net)
 
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


