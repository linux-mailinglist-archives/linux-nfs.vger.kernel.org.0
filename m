Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CF06DCFEB
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Apr 2023 05:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjDKDDC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Apr 2023 23:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjDKDC7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Apr 2023 23:02:59 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FE2100
        for <linux-nfs@vger.kernel.org>; Mon, 10 Apr 2023 20:02:57 -0700 (PDT)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3C7883F237
        for <linux-nfs@vger.kernel.org>; Tue, 11 Apr 2023 03:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681182175;
        bh=+f+3R8L5DqH9o0mr7+f8a0zBE1AVEE+v5ZfMF+VWjEU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=waJRPtc21BO9kuINz/eyRHOR78a98iFxnkkkB3CpOOIwdzQUxkui2sb3Xa7oYVU2q
         OujPISuygO7FX64LJQr02MpOjB0/qbMhdj9hoxuNT5TnoATJpU4GSd4D8VkWOn0hWi
         rRe2vCBH9tr4O20nT5ho7Ee4DllqZc5+NhzxOOXF0MHHrBL2zQDLsnZhEt7QddE5GU
         x6v8Oe1N8NZ0m+dzda484GJuye/6sWuhmWPcnfv0aZBU54HcLQ5PBvjyCCJPyzlJr/
         9C11CjUkjJkNeSZ+kurwD5ZX7h9ejVs+xYrDnqM2SCuyM72R2rN84+B2R0Wc/pclCa
         XkcKcAZGhg/cQ==
Received: by mail-pl1-f197.google.com with SMTP id m13-20020a170902db0d00b001a63c5ce31cso2559935plx.3
        for <linux-nfs@vger.kernel.org>; Mon, 10 Apr 2023 20:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681182174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+f+3R8L5DqH9o0mr7+f8a0zBE1AVEE+v5ZfMF+VWjEU=;
        b=o7O5+GiajcSfVQsgmoqK8KPelGWPAJ/vdD23WgXi/cDXe9X5ztXDivgvBZ28tm7td9
         rbINzmvI6ReB5g21wlzhR1ANtFZBdTwwbbtcJaejwc9jgQxT/LMQcuGzyAIpf5phAlkN
         6TT6FbxhAmpTbddc4opbUvE7p44RRtqGV+nuoQFOA41UvsvHxmjq8g8fyKfJqpTPvuLZ
         B7gLoFK2y+mLyGTsaEcklY+fyTrh6Q2eUichAnae5qGU6dCIf+Be4XoTKZ07BplQvTf5
         oYZwkw1HKSyijAi7FEQNx4u/mnwO+ywWovM3Xfuz1Cen3n4LKUyp4xWWlcT24WNOBl27
         rcBg==
X-Gm-Message-State: AAQBX9cbdUNK7h2UV05A4gZLwLPTrT9dIbIMSdOpM5eugZZKACev7rin
        RStzCu748LP9fWNzt625V7yZ8CocRuqTkm+5xUJqI+lpQ57bWxokqwUGRA/qcNvln4vbcAuZRvt
        AKscS7z/HnPxb2eKP/x9vNDX0rgMlgSU9vnGi7w==
X-Received: by 2002:a17:902:db10:b0:19c:b11b:ffca with SMTP id m16-20020a170902db1000b0019cb11bffcamr19408898plx.23.1681182173646;
        Mon, 10 Apr 2023 20:02:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZceQgJx2rJsXAD3c1fpVQv7KIn9b2BoAIyeL73z0rNd/4WDPVcWn4ViDrjSO6zAPnNabTpwA==
X-Received: by 2002:a17:902:db10:b0:19c:b11b:ffca with SMTP id m16-20020a170902db1000b0019cb11bffcamr19408873plx.23.1681182173315;
        Mon, 10 Apr 2023 20:02:53 -0700 (PDT)
Received: from chengendu.. (111-248-110-103.dynamic-ip.hinet.net. [111.248.110.103])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902b70d00b001a1d553de0fsm8482356pls.271.2023.04.10.20.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 20:02:53 -0700 (PDT)
From:   Chengen Du <chengen.du@canonical.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengen Du <chengen.du@canonical.com>
Subject: [PATCH] NFS: Add mount option 'nofasc'
Date:   Tue, 11 Apr 2023 11:02:48 +0800
Message-Id: <20230411030248.53356-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This mount option is used to skip clearing the file access cache
upon login. Some users or applications switch to other privileged
users via commands such as 'su' to operate on NFS-mounted folders.
In such cases, the privileged user's login time will be renewed,
and NFS ACCESS operations will need to be re-sent, potentially
leading to performance degradation.
In some production environments where the access cache can be
trusted due to stable group membership, this option could be
particularly useful.

Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 fs/nfs/dir.c              | 21 ++++++++++++---------
 fs/nfs/fs_context.c       |  8 ++++++++
 fs/nfs/super.c            |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 6fbcbb8d6587..9a6d86e2044e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2953,12 +2953,14 @@ static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, co
 	return NULL;
 }
 
-static u64 nfs_access_login_time(const struct task_struct *task,
-				 const struct cred *cred)
+static inline
+bool nfs_check_access_stale(const struct task_struct *task,
+			    const struct cred *cred,
+			    const struct nfs_access_entry *cache)
 {
 	const struct task_struct *parent;
 	const struct cred *pcred;
-	u64 ret;
+	u64 login_time;
 
 	rcu_read_lock();
 	for (;;) {
@@ -2968,15 +2970,15 @@ static u64 nfs_access_login_time(const struct task_struct *task,
 			break;
 		task = parent;
 	}
-	ret = task->start_time;
+	login_time = task->start_time;
 	rcu_read_unlock();
-	return ret;
+
+	return ((s64)(login_time - cache->timestamp) > 0);
 }
 
 static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *cred, u32 *mask, bool may_block)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
-	u64 login_time = nfs_access_login_time(current, cred);
 	struct nfs_access_entry *cache;
 	bool retry = true;
 	int err;
@@ -3005,7 +3007,8 @@ static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *
 		retry = false;
 	}
 	err = -ENOENT;
-	if ((s64)(login_time - cache->timestamp) > 0)
+	if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_NOFASC) &&
+	    nfs_check_access_stale(current, cred, cache))
 		goto out;
 	*mask = cache->mask;
 	list_move_tail(&cache->lru, &nfsi->access_cache_entry_lru);
@@ -3025,7 +3028,6 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	 * but do it without locking.
 	 */
 	struct nfs_inode *nfsi = NFS_I(inode);
-	u64 login_time = nfs_access_login_time(current, cred);
 	struct nfs_access_entry *cache;
 	int err = -ECHILD;
 	struct list_head *lh;
@@ -3040,7 +3042,8 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 		cache = NULL;
 	if (cache == NULL)
 		goto out;
-	if ((s64)(login_time - cache->timestamp) > 0)
+	if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_NOFASC) &&
+	    nfs_check_access_stale(current, cred, cache))
 		goto out;
 	if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
 		goto out;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 9bcd53d5c7d4..5cd9b2882c79 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -88,6 +88,7 @@ enum nfs_param {
 	Opt_vers,
 	Opt_wsize,
 	Opt_write,
+	Opt_fasc,
 };
 
 enum {
@@ -194,6 +195,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_string("vers",		Opt_vers),
 	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
 	fsparam_u32   ("wsize",		Opt_wsize),
+	fsparam_flag_no("fasc",         Opt_fasc),
 	{}
 };
 
@@ -861,6 +863,12 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 	case Opt_sloppy:
 		ctx->sloppy = true;
 		break;
+	case Opt_fasc:
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NOFASC;
+		else
+			ctx->flags &= ~NFS_MOUNT_NOFASC;
+		break;
 	}
 
 	return 0;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 05ae23657527..059513d403f8 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -444,6 +444,7 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 		{ NFS_MOUNT_NORDIRPLUS, ",nordirplus", "" },
 		{ NFS_MOUNT_UNSHARED, ",nosharecache", "" },
 		{ NFS_MOUNT_NORESVPORT, ",noresvport", "" },
+		{ NFS_MOUNT_NOFASC, ",nofasc", "" },
 		{ 0, NULL, NULL }
 	};
 	const struct proc_nfs_info *nfs_infop;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ea2f7e6b1b0b..a39ae1bd2217 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -153,6 +153,7 @@ struct nfs_server {
 #define NFS_MOUNT_WRITE_EAGER		0x01000000
 #define NFS_MOUNT_WRITE_WAIT		0x02000000
 #define NFS_MOUNT_TRUNK_DISCOVERY	0x04000000
+#define NFS_MOUNT_NOFASC		0x08000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
-- 
2.37.2

