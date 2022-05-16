Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73724529243
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348693AbiEPVCK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349207AbiEPVBI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4C3B864
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 13:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37F18614B5
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 20:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9A4C36AE2;
        Mon, 16 May 2022 20:36:25 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 5/5] NFS: Remove the CONFIG_NFS_V4_2_READ_PLUS Kconfig option
Date:   Mon, 16 May 2022 16:36:22 -0400
Message-Id: <20220516203622.2605713-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516203622.2605713-1-Anna.Schumaker@Netapp.com>
References: <20220516203622.2605713-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This option was added due to a few failing xfstests and performance
issues that were found during testing. Both of these have now been
addressed, meaning it should be okay to remove the option.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/Kconfig    | 9 ---------
 fs/nfs/nfs4proc.c | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 14a72224b657..5dcd84ce1c0c 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -205,12 +205,3 @@ config NFS_DISABLE_UDP_SUPPORT
 	 Choose Y here to disable the use of NFS over UDP. NFS over UDP
 	 on modern networks (1Gb+) can lead to data corruption caused by
 	 fragmentation during high loads.
-
-config NFS_V4_2_READ_PLUS
-	bool "NFS: Enable support for the NFSv4.2 READ_PLUS operation"
-	depends on NFS_V4_2
-	default n
-	help
-	 This is intended for developers only. The READ_PLUS operation has
-	 been shown to have issues under specific conditions and should not
-	 be used in production.
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a79f66432bd3..114ae7673e9a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5436,7 +5436,7 @@ static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 				    nfs4_read_done_cb(task, hdr);
 }
 
-#if defined CONFIG_NFS_V4_2 && defined CONFIG_NFS_V4_2_READ_PLUS
+#if defined CONFIG_NFS_V4_2
 static void nfs42_read_plus_support(struct nfs_pgio_header *hdr,
 				    struct rpc_message *msg)
 {
-- 
2.36.1

