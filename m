Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA8A78A568
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Aug 2023 07:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjH1Fxp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Aug 2023 01:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjH1Fxc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Aug 2023 01:53:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477E3A9
        for <linux-nfs@vger.kernel.org>; Sun, 27 Aug 2023 22:53:28 -0700 (PDT)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AE0903F21F
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 05:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693202006;
        bh=XBlNT+SJA1xULw0LphVVt+nl/FhzT+DOY2urbcNDsHQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=BuDR1MbtD1pL7mtB/L6vmrN9FDa4IQZq5UgWxu6Ro0eyphQlfa2PhY00FTHdbBSD5
         Im16IncUHcF8m4XaXarnO/GKQcvo3tFIWEfD0ewyDyMapmjEv7Rh5guHMP4uNEWqq9
         7vUReb+OWUaxnt1z4qyYEZyp5AWN/Br6IEIgNr1fehp4QwmaXJcKkGtw1jOh65q0c+
         BgN7qz6D8VmTJUSRcUumUsKF/sJ64KzQgQ8kEXD06kMjrR06sgN/icThpU2974Y6nk
         6QvK5MniUq53VBrpXCBoWfR0J4t4344RSk+7l2zx0yMJ/hnrbWeeFzRArS8IAUR5xO
         fCkGgSXhTvVoA==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-68a2d9a6b5fso3554188b3a.0
        for <linux-nfs@vger.kernel.org>; Sun, 27 Aug 2023 22:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693202005; x=1693806805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBlNT+SJA1xULw0LphVVt+nl/FhzT+DOY2urbcNDsHQ=;
        b=VXL7nJy5tk0dOidYDvzAEwCDSlbtFRX7gxFX+6E2U63zB8uIE7XLxCKDIuOD3FuFAV
         f9zTkLbyfxKqfZmus2sfMhbsr05dlyghyQMCL07Hqnsfmmm2MASa/TXdSzWI7iVHRDji
         MZdoSxwWf3P1fG3ow3lrqlCJlH02sWf9l4kzQmLTl2VSQkgKyl4bvc0CZoMh+O5W7ZPy
         avcoeIfUt2urejRZrtj5KBWJ84NHNcenF7PZXPeOQNWqxev2v3iWKruzOlJBe2rp40Dl
         uipZ1ojkAMljMuTPLsVmEYOfagFK224kczCRrrknHPEIyNDH9Fv+RkQQ7jAxd5bfb+h0
         4BEA==
X-Gm-Message-State: AOJu0YycY4p9I/WqtGyVhSdHIINnjE8FnO0TVhVuOR/zMNxwQHGRGp5+
        HFO8vwxLIpZCjJPlubz4jcv4s5J2a+oTG+F45bCfqBhacs3uNA43kc46c+Rv1906FiQRdjoY81n
        wvU+7OgNATmD139Bh6JzDSe0Z9BwcHrSbjaufzA==
X-Received: by 2002:a05:6a00:1702:b0:68a:31b2:5219 with SMTP id h2-20020a056a00170200b0068a31b25219mr27171270pfc.22.1693202005333;
        Sun, 27 Aug 2023 22:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETOr5QON36PnUzijEjXWZZvvLEKX4zMQcUsq6iqBwE+qP9e8IOTfUvNUd2cjJ6MZMldHklNw==
X-Received: by 2002:a05:6a00:1702:b0:68a:31b2:5219 with SMTP id h2-20020a056a00170200b0068a31b25219mr27171261pfc.22.1693202005029;
        Sun, 27 Aug 2023 22:53:25 -0700 (PDT)
Received: from chengendu.. (111-248-129-25.dynamic-ip.hinet.net. [111.248.129.25])
        by smtp.gmail.com with ESMTPSA id e14-20020a63ae4e000000b0056946623d7esm6452028pgp.55.2023.08.27.22.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 22:53:24 -0700 (PDT)
From:   Chengen Du <chengen.du@canonical.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengen Du <chengen.du@canonical.com>
Subject: [PATCH v3 RESEND] NFS: Add mount option 'fasc'
Date:   Mon, 28 Aug 2023 13:53:10 +0800
Message-Id: <20230828055310.21391-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 853e8d609bb3..2fbc2d1bd775 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -92,6 +92,7 @@ enum nfs_param {
 	Opt_wsize,
 	Opt_write,
 	Opt_xprtsec,
+	Opt_fasc,
 };
 
 enum {
@@ -199,6 +200,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
 	fsparam_u32   ("wsize",		Opt_wsize),
 	fsparam_string("xprtsec",	Opt_xprtsec),
+	fsparam_flag  ("fasc",		Opt_fasc),
 	{}
 };
 
@@ -925,6 +927,9 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 	case Opt_sloppy:
 		ctx->sloppy = true;
 		break;
+	case Opt_fasc:
+		ctx->flags |= NFS_MOUNT_FASC;
+		break;
 	}
 
 	return 0;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 2284f749d892..7a0c5280e388 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -448,6 +448,7 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 		{ NFS_MOUNT_NORDIRPLUS, ",nordirplus", "" },
 		{ NFS_MOUNT_UNSHARED, ",nosharecache", "" },
 		{ NFS_MOUNT_NORESVPORT, ",noresvport", "" },
+		{ NFS_MOUNT_FASC, ",fasc", "" },
 		{ 0, NULL, NULL }
 	};
 	const struct proc_nfs_info *nfs_infop;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 20eeba8b009d..6a88ba36f7a8 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -155,6 +155,7 @@ struct nfs_server {
 #define NFS_MOUNT_WRITE_WAIT		0x02000000
 #define NFS_MOUNT_TRUNK_DISCOVERY	0x04000000
 #define NFS_MOUNT_SHUTDOWN			0x08000000
+#define NFS_MOUNT_FASC			0x10000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
-- 
2.39.2

