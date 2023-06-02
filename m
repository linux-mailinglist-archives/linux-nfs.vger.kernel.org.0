Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ED271F84D
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jun 2023 04:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjFBCJt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Jun 2023 22:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjFBCJs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Jun 2023 22:09:48 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88D7180
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 19:09:45 -0700 (PDT)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D34D13F1E9
        for <linux-nfs@vger.kernel.org>; Fri,  2 Jun 2023 02:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685671783;
        bh=HGFWY1748xWHBeuQ3h2WYaCQqPEsRJy9T6c8zRERFxM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=phEWswAl0wWSkyaj3oMRZhO53CNioAiy/CBfpIkavZbKunUkvStRzNYwWh+8hvm4S
         pfxId/+pkgmbYxUeNCWMC1G2FSPuW9pIGx1fXW3RRfqlLDYMcaJCc4wTrS0BrgdQt9
         mgLzaamBGMf25lcqjzlFyqEO/WeloMxmIDjcq35calekE8Lfd+YAm6ldXV6lAHBuZK
         uRIWWlDYQaIiSgmwsopR9/DkniZiDMqdmDqONkyyEp2LQJ7FIQOaS1L291DHk3ubyW
         Bkgqrn8n/anrNW4mjDaIdtkn0XyMV/kaNrD3u1bm29dsENyxVzbA+qFI1Ka5HbXdg1
         R50jF7/S1aHzg==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b034ca114cso7190655ad.1
        for <linux-nfs@vger.kernel.org>; Thu, 01 Jun 2023 19:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685671781; x=1688263781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGFWY1748xWHBeuQ3h2WYaCQqPEsRJy9T6c8zRERFxM=;
        b=O7eJFFPo2KDecNidGIdLQpIJ/A4CBCbwYAlXTscOgexeKEYnThDBgaHOzbmzUWeMJZ
         TAowONGsleFhqlZWXmjRjTFJtL2a3qeny0CBIjCCjtZbCaQY+fo3F7dqkruPzvHuOeWK
         yutFn8EHhbroWQvTzCaKUGOGUp5aibNrwBi6eqtNeMxwjQFE30UShuJVoJsd3wIDadMO
         OGlbiiEVNpsHa3eAN66vSuLasKE+SI7SP2EprF9wCDuQhZ3/r73XdEsgGCP7TgfZXqWp
         3mjCELaFYtoLFuZlyEGvfjc3egOstgSQd6gMXFytZShpm48CAYCPQFhk6FZHZW9OTwJ8
         wrpQ==
X-Gm-Message-State: AC+VfDxQNFLwxQHwUtzvJ5V2zOehXv697NOP1uWk2UpO2n8tTtufgcAB
        ABAWTWq3tyMtEgYtcjXUoRUi4Q3zxpCSTUEptYS4fDLogZoSTDEyA1E2npdQrfPLC+NJX9Sg7Vm
        Nxf6F1Jwj/W7Fa71UvNy7/bVWHT/gb8mQZpJwFA==
X-Received: by 2002:a17:902:d503:b0:1b1:a2c3:29c0 with SMTP id b3-20020a170902d50300b001b1a2c329c0mr882202plg.24.1685671781282;
        Thu, 01 Jun 2023 19:09:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ714BmOv9fruEm5Qgzxep6fJULya1ekyW4/JETSKvADOJrqtiqDHlU+NnOPyVOY75zkhlAelA==
X-Received: by 2002:a17:902:d503:b0:1b1:a2c3:29c0 with SMTP id b3-20020a170902d50300b001b1a2c329c0mr882194plg.24.1685671780984;
        Thu, 01 Jun 2023 19:09:40 -0700 (PDT)
Received: from chengendu.. (111-248-148-133.dynamic-ip.hinet.net. [111.248.148.133])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001acacff3a70sm64391plg.125.2023.06.01.19.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 19:09:40 -0700 (PDT)
From:   Chengen Du <chengen.du@canonical.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengen Du <chengen.du@canonical.com>
Subject: [PATCH v2 RESEND] NFS: Add mount option 'fasc'
Date:   Fri,  2 Jun 2023 10:09:35 +0800
Message-Id: <20230602020935.43367-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 8f3112e71a6a..cefdb23d4cd7 100644
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

