Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E04A7B53
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Feb 2022 23:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiBBWzH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Feb 2022 17:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiBBWzH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Feb 2022 17:55:07 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74A4C061714
        for <linux-nfs@vger.kernel.org>; Wed,  2 Feb 2022 14:55:06 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id j12so672778qtr.2
        for <linux-nfs@vger.kernel.org>; Wed, 02 Feb 2022 14:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGy5f63JSap+Hv8MGQpGxRHCUDbBWTT3+CUps1rnT0w=;
        b=SOR4ZKF2dMeHjvUQ7V4cq2qv1SX8qexozZdaWHGsAuZQIFAvHZ6QqHtHNLYCLxiVTX
         s+gtGiKrU7CEZLn8KjMRxuRts6IrKv2Jch9JvOqrDaXsspzPmtdLzVHha6s3160H1e6k
         3GFX9iDmsxuJoM0O1RegJXeEQUIJgBcXiqvT0QnUHDarywFchi2vSGC/L7ZA3dVQbB1t
         RzjGht6HKRtrUNWEtO9HNC3CRt9+na3fuGx6XVxXJOXGCifbDMGdbQHyjj+eE99lPgg3
         hq5ENojhXSxnI1uT7Ph7CxUiAN5qjJioI0MmXf7K9FnFHHf8xicSLZPhrQmeARexGFWk
         ebRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGy5f63JSap+Hv8MGQpGxRHCUDbBWTT3+CUps1rnT0w=;
        b=EqS/c67BRbrfdC7t8ZvAdDt3XXva++CBOuxvxkhG2WW86ZcyG0ClMwAiKbFe5BzLMG
         mxSi9WWnevNklQ8qV7mvT3Q9nC9sDV2GR2cHTn1x6waU2zJM2LhJAMhMOuGpxgInri1w
         o59J8mhRmAEgZKYcC1BiMMEXSMYbZM59MymgSo2OezkOLCR4IXKNL0XpWcDsS5bSRlo6
         oK5WFReUjYzamI+DM0Qb31v9unzrxXL7tXCihpStFKcRBcidH9j2CYdxckWnE5yKenm5
         6DLlN2f2HBOetSW/A5Bzk1km3qfTbiczAe1K4OXWxpU0oMP4fHTilCSojQEGDw4FLlFa
         ysHw==
X-Gm-Message-State: AOAM532++xjk++6B/rHC/WpB0i+9tXSJZp383GzRRKSEBHgazm+o/zR4
        9jePtUcWB3PUZrAPAzaGH+M=
X-Google-Smtp-Source: ABdhPJxs7ldMlo7v/YnNkHanjSHN1CpytUKMbfsEdB+EhldPRMSrXRJde7JbCBHnDXrmtV9eLlzW3A==
X-Received: by 2002:ac8:5905:: with SMTP id 5mr25170201qty.28.1643842505842;
        Wed, 02 Feb 2022 14:55:05 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:1cbe:ff3b:3157:136c])
        by smtp.gmail.com with ESMTPSA id bm27sm10994808qkb.5.2022.02.02.14.55.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Feb 2022 14:55:05 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4.1 support for NFS4_RESULT_PRESERVER_UNLINKED
Date:   Wed,  2 Feb 2022 17:55:02 -0500
Message-Id: <20220202225502.2601-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In 4.1+, the server is allowed to set a flag
NFS4_RESULT_PRESERVE_UNLINKED in reply to the OPEN, that tells
the client that it does not need to do a silly rename of an
opened file when it's being removed.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/dir.c              | 10 ++++++++--
 fs/nfs/nfs4proc.c         |  2 ++
 include/linux/nfs_fs.h    |  1 +
 include/uapi/linux/nfs4.h |  1 +
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 00b222e48d6f..4225d9463ba6 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1404,7 +1404,12 @@ int nfs_lookup_verify_inode(struct inode *inode, unsigned int flags)
 	if (flags & LOOKUP_REVAL)
 		goto out_force;
 out:
-	return (inode->i_nlink == 0) ? -ESTALE : 0;
+	if (inode->i_nlink > 0 || (inode->i_nlink == 0 &&
+			test_bit(NFS_INO_PRESERVE_UNLINKED,
+				 &NFS_I(inode)->flags)))
+		return 0;
+	else
+		return -ESTALE;
 out_force:
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -2315,7 +2320,8 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
 
 	trace_nfs_unlink_enter(dir, dentry);
 	spin_lock(&dentry->d_lock);
-	if (d_count(dentry) > 1) {
+	if (d_count(dentry) > 1 && !test_bit(NFS_INO_PRESERVE_UNLINKED,
+			&NFS_I(d_inode(dentry))->flags)) {
 		spin_unlock(&dentry->d_lock);
 		/* Start asynchronous writeout of the inode */
 		write_inode_now(d_inode(dentry), 0);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2fbe04d12e44..2cbade53c8d3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3073,6 +3073,8 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 		set_bit(NFS_STATE_POSIX_LOCKS, &state->flags);
 	if (opendata->o_res.rflags & NFS4_OPEN_RESULT_MAY_NOTIFY_LOCK)
 		set_bit(NFS_STATE_MAY_NOTIFY_LOCK, &state->flags);
+	if (opendata->o_res.rflags & NFS4_OPEN_RESULT_PRESERVE_UNLINKED)
+		set_bit(NFS_INO_PRESERVE_UNLINKED, &NFS_I(state->inode)->flags);
 
 	dentry = opendata->dentry;
 	if (d_really_is_negative(dentry)) {
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 7a134e4c03e8..ea58d96354a9 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -290,6 +290,7 @@ struct nfs4_copy_state {
 #define NFS_INO_STALE		(1)		/* possible stale inode */
 #define NFS_INO_ACL_LRU_SET	(2)		/* Inode is on the LRU list */
 #define NFS_INO_INVALIDATING	(3)		/* inode is being invalidated */
+#define NFS_INO_PRESERVE_UNLINKED (4)		/* preserve file if removed while open */
 #define NFS_INO_FSCACHE		(5)		/* inode can be cached by FS-Cache */
 #define NFS_INO_FSCACHE_LOCK	(6)		/* FS-Cache cookie management lock */
 #define NFS_INO_FORCE_READDIR	(7)		/* force readdirplus */
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index 800bb0ffa6e6..14acfe5300b7 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -46,6 +46,7 @@
 #define NFS4_OPEN_RESULT_CONFIRM		0x0002
 #define NFS4_OPEN_RESULT_LOCKTYPE_POSIX		0x0004
 #define NFS4_OPEN_RESULT_MAY_NOTIFY_LOCK	0x0020
+#define NFS4_OPEN_RESULT_PRESERVE_UNLINKED	0x0008
 
 #define NFS4_SHARE_ACCESS_MASK	0x000F
 #define NFS4_SHARE_ACCESS_READ	0x0001
-- 
2.27.0

