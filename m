Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC65832EB
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 21:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiG0THZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 15:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiG0TGy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 15:06:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B561D52FF5
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 11:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F3086197E
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C805C433C1
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:40:04 +0000 (UTC)
Subject: [PATCH v2 01/13] NFSD: Fix strncpy() fortify warning
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 27 Jul 2022 14:40:03 -0400
Message-ID: <165894720346.11193.73709024635235677.stgit@manet.1015granger.net>
In-Reply-To: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
References: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In function ‘strncpy’,
    inlined from ‘nfsd4_ssc_setup_dul’ at /home/cel/src/linux/manet/fs/nfsd/nfs4proc.c:1392:3,
    inlined from ‘nfsd4_interssc_connect’ at /home/cel/src/linux/manet/fs/nfsd/nfs4proc.c:1489:11:
/home/cel/src/linux/manet/include/linux/fortify-string.h:52:33: warning: ‘__builtin_strncpy’ specified bound 63 equals destination size [-Wstringop-truncation]
   52 | #define __underlying_strncpy    __builtin_strncpy
      |                                 ^
/home/cel/src/linux/manet/include/linux/fortify-string.h:89:16: note: in expansion of macro ‘__underlying_strncpy’
   89 |         return __underlying_strncpy(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~~

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c      |    2 +-
 include/linux/nfs_ssc.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3895eb52d2b1..4a09cb473378 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1389,7 +1389,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 		return 0;
 	}
 	if (work) {
-		strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
+		strlcpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr) - 1);
 		refcount_set(&work->nsui_refcnt, 2);
 		work->nsui_busy = true;
 		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
index 222ae8883e85..75843c00f326 100644
--- a/include/linux/nfs_ssc.h
+++ b/include/linux/nfs_ssc.h
@@ -64,7 +64,7 @@ struct nfsd4_ssc_umount_item {
 	refcount_t nsui_refcnt;
 	unsigned long nsui_expire;
 	struct vfsmount *nsui_vfsmount;
-	char nsui_ipaddr[RPC_MAX_ADDRBUFLEN];
+	char nsui_ipaddr[RPC_MAX_ADDRBUFLEN + 1];
 };
 #endif
 


