Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D336A9717
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Mar 2023 13:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCCMQO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Mar 2023 07:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjCCMQN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Mar 2023 07:16:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21A45F500
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 04:16:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BB0FB8169D
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 12:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C251C433A1;
        Fri,  3 Mar 2023 12:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677845769;
        bh=Z2wKJmm9+tf41X155xT/ylLDEMm8XxmCC0KU15YLcN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkfVPXdWRqH+PC786qCnCzgXr8GsA0cq22r5230gSlqh9cHuwzDHFYmzhIbuZ/QBV
         Y2rEbWYx5bWbdNTbEseL8nVIk6KN6l0QW/okcrIEsRvTfsgUoEnTWbaKP+8Ess/ROY
         J1ElpzOQCGRRhJbSyl32NzxDkWUcuv3bli8yapZLwQSfMv/ZDf+Iis5aDmBqJvh/i7
         L9gPpR7mKffpaxSWT3UbK2zClgn0nWvG/XAFxXGsyxxJ5e3+QRcpkvC4Of3DFEPr8E
         tqzBZl0nKkXQ7RN4+UEz+DxS0R88qXohSnnn+UYy1I39WyeEX+kBR5moDZj9tLjIOP
         pSjf/mRjaQitw==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, yoyang@redhat.com
Subject: [PATCH 6/7] nfs: move nfs_fhandle_hash to common include file
Date:   Fri,  3 Mar 2023 07:16:02 -0500
Message-Id: <20230303121603.132103-7-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303121603.132103-1-jlayton@kernel.org>
References: <20230303121603.132103-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

lockd needs to be able to hash filehandles for tracepoints. Move
nfs_fhandle_hash to a common nfs include file.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/internal.h   | 15 ---------------
 include/linux/nfs.h | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 2a65fe2a63ab..10fb5e7573eb 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -846,27 +846,12 @@ u64 nfs_timespec_to_change_attr(const struct timespec64 *ts)
 }
 
 #ifdef CONFIG_CRC32
-/**
- * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
- * @fh - pointer to filehandle
- *
- * returns a crc32 hash for the filehandle that is compatible with
- * the one displayed by "wireshark".
- */
-static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
-{
-	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
-}
 static inline u32 nfs_stateid_hash(const nfs4_stateid *stateid)
 {
 	return ~crc32_le(0xFFFFFFFF, &stateid->other[0],
 				NFS4_STATEID_OTHER_SIZE);
 }
 #else
-static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
-{
-	return 0;
-}
 static inline u32 nfs_stateid_hash(nfs4_stateid *stateid)
 {
 	return 0;
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index b06375e88e58..ceb70a926b95 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -10,6 +10,7 @@
 
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/string.h>
+#include <linux/crc32.h>
 #include <uapi/linux/nfs.h>
 
 /*
@@ -44,4 +45,23 @@ enum nfs3_stable_how {
 	/* used by direct.c to mark verf as invalid */
 	NFS_INVALID_STABLE_HOW = -1
 };
+
+#ifdef CONFIG_CRC32
+/**
+ * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
+ * @fh - pointer to filehandle
+ *
+ * returns a crc32 hash for the filehandle that is compatible with
+ * the one displayed by "wireshark".
+ */
+static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
+{
+	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
+}
+#else /* CONFIG_CRC32 */
+static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
+{
+	return 0;
+}
+#endif /* CONFIG_CRC32 */
 #endif /* _LINUX_NFS_H */
-- 
2.39.2

