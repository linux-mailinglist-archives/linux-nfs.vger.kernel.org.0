Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCFB6FF22E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 15:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbjEKNJ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 May 2023 09:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbjEKNJz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 May 2023 09:09:55 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C0A65AD
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 06:09:54 -0700 (PDT)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 24AEB3F4A5
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 13:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683810593;
        bh=ADYcWIpSoyGUYLtHFTKfWIEkvPV48HcjMTgglFlUFik=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=l77FwxE0s1AxMU7r7KdGOC7bclQenNcPQ8230Vjn4aN1J2w4paPqoQ00KGuRLdV47
         GPFvu0vPf0AnpwMppbWdM9KSXJqvFHRUsZTmvydMI2fKjUHKwq+y03bIx2sI2wJEM+
         G/tZEPlysxNSCUr7Z1zf+6kGEX7IAY8ohvA2MME4oVF27qoXI50eJQRMYniTUD0uuS
         OtAF6sEbQAN5JFPkzLFgc9tsZfQEKTAUZ8OCAuHzz9GTpwHapkyTWk9cr3CeyuloIS
         6BF2EWQzuBxHiZtex4ylZvS2J9TO8w+jUH6eJH4bxGSBFfIDlMWQh7byJGF4Zy58La
         aajZhM4XeHNYg==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-643bb9cdd3cso6346329b3a.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 06:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683810588; x=1686402588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADYcWIpSoyGUYLtHFTKfWIEkvPV48HcjMTgglFlUFik=;
        b=UFrwY26UkPyjqX1y2CAe4zMIVWdmayCZumH0eMOX/n40o3Y4OCsYAaH03J5B1UIpgh
         BI5N0PVGAKDqf1O5ehkm9BdZkh5i+qGFP1bLSNHklwb66NXlNFhVxTxgXn0FGMaAKNO6
         RFh57qCazwLS4QeTK3ENqfTlcqqI6qYQ+qSf/k67ICOj6N2iIgnXggNKykuY2mdSYw/d
         8NxZ2B+Joxii+vMT58QuCta9GnWZoSlFLh89Alw7f0BwjWcsaJchIl9C0KX2KxO7Ee89
         jGFa+7871AQx6Q8AOfoi3wpZLGFyWRm/MU2GhspzU9U838GydcMNTqGBOqD7yxuzdS+G
         mknw==
X-Gm-Message-State: AC+VfDyPskBpmSNlamfddlP2FruAMHhLpEcmN5wtwqZL/u5+DDusqohi
        3DQNjXMQMsKSbsowxyoOB8KAGz7cbOWlHVrzFrNOnBg3Z7gSB1fya2ViIWpm4a7TjkWMkaPHNjT
        VuJIqQ4+hvhZ3zHt5/MyYbCUb0VpSadsFG4URfw==
X-Received: by 2002:a05:6a20:54a2:b0:100:85e2:26c9 with SMTP id i34-20020a056a2054a200b0010085e226c9mr18732289pzk.13.1683810588471;
        Thu, 11 May 2023 06:09:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4QkeXgJ2W1+Cg7cx3adaGgbhwuu5BVRTluw7MIh6UfC7A6H7SDZo8pVHrltncAnPYNdejO5Q==
X-Received: by 2002:a05:6a20:54a2:b0:100:85e2:26c9 with SMTP id i34-20020a056a2054a200b0010085e226c9mr18732254pzk.13.1683810588170;
        Thu, 11 May 2023 06:09:48 -0700 (PDT)
Received: from chengendu.. (111-248-154-232.dynamic-ip.hinet.net. [111.248.154.232])
        by smtp.gmail.com with ESMTPSA id q12-20020a63cc4c000000b0051eff0a70d7sm4892669pgi.94.2023.05.11.06.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 06:09:47 -0700 (PDT)
From:   Chengen Du <chengen.du@canonical.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengen Du <chengen.du@canonical.com>
Subject: [PATCH v2] NFS: Add mount option 'fasc'
Date:   Thu, 11 May 2023 21:09:42 +0800
Message-Id: <20230511130942.61099-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In certain instances, users or applications switch to other privileged
users by executing commands like 'su' to carry out operations on NFS-
mounted folders. However, when this happens, the login time for the
privileged user is reset, and any NFS ACCESS operations must be resent,
which can result in a decrease in performance. In specific production
environments where the access cache can be trusted due to stable group
membership, there's no need to verify the cache stall situation.
To maintain the initial behavior and performance, a new mount option
called 'fasc' has been introduced. This option triggers the mechanism
of clearing the file access cache upon login.

Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 fs/nfs/dir.c              | 21 ++++++++++++---------
 fs/nfs/fs_context.c       |  5 +++++
 fs/nfs/super.c            |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index bacad0c57810..f66656185940 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2951,12 +2951,14 @@ static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, co
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
@@ -2966,15 +2968,15 @@ static u64 nfs_access_login_time(const struct task_struct *task,
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
@@ -3003,7 +3005,8 @@ static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *
 		retry = false;
 	}
 	err = -ENOENT;
-	if ((s64)(login_time - cache->timestamp) > 0)
+	if ((NFS_SERVER(inode)->flags & NFS_MOUNT_FASC) &&
+	    nfs_check_access_stale(current, cred, cache))
 		goto out;
 	*mask = cache->mask;
 	list_move_tail(&cache->lru, &nfsi->access_cache_entry_lru);
@@ -3023,7 +3026,6 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	 * but do it without locking.
 	 */
 	struct nfs_inode *nfsi = NFS_I(inode);
-	u64 login_time = nfs_access_login_time(current, cred);
 	struct nfs_access_entry *cache;
 	int err = -ECHILD;
 	struct list_head *lh;
@@ -3038,7 +3040,8 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 		cache = NULL;
 	if (cache == NULL)
 		goto out;
-	if ((s64)(login_time - cache->timestamp) > 0)
+	if ((NFS_SERVER(inode)->flags & NFS_MOUNT_FASC) &&
+	    nfs_check_access_stale(current, cred, cache))
 		goto out;
 	if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
 		goto out;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 9bcd53d5c7d4..0a14bd67efc1 100644
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
+	fsparam_flag  ("fasc",		Opt_fasc),
 	{}
 };
 
@@ -861,6 +863,9 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 	case Opt_sloppy:
 		ctx->sloppy = true;
 		break;
+	case Opt_fasc:
+		ctx->flags |= NFS_MOUNT_FASC;
+		break;
 	}
 
 	return 0;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 30e53e93049e..e8d0ffd04b16 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -444,6 +444,7 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 		{ NFS_MOUNT_NORDIRPLUS, ",nordirplus", "" },
 		{ NFS_MOUNT_UNSHARED, ",nosharecache", "" },
 		{ NFS_MOUNT_NORESVPORT, ",noresvport", "" },
+		{ NFS_MOUNT_FASC, ",fasc", "" },
 		{ 0, NULL, NULL }
 	};
 	const struct proc_nfs_info *nfs_infop;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ea2f7e6b1b0b..332ceb11be6c 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -153,6 +153,7 @@ struct nfs_server {
 #define NFS_MOUNT_WRITE_EAGER		0x01000000
 #define NFS_MOUNT_WRITE_WAIT		0x02000000
 #define NFS_MOUNT_TRUNK_DISCOVERY	0x04000000
+#define NFS_MOUNT_FASC			0x08000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
-- 
2.39.2

