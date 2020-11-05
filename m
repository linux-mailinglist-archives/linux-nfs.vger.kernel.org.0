Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E91A2A84F0
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 18:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgKERdd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 12:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKERdd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 12:33:33 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89B7C0613CF;
        Thu,  5 Nov 2020 09:33:31 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id u21so2592713iol.12;
        Thu, 05 Nov 2020 09:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XOyznZTEsXdH/0R24390C+1ujg7ZJGqVqGTwGLt4RDg=;
        b=jz4PrMo5rH3esQZ2RZqtP0qBLkPQ+53YYYQB9cQsm1c4YPxBmNzOS4YM0pFwrjz+KO
         +Lie/PHY0SMU/qtHl2UpAUq7UbhjHeGQ7yECd8zOopABh8W/zSqDnZilR2feKoBUlJ/t
         iXwL/JHqoKKShpqYlQHlK/I5SLnHXGYcfzMXyv72CaUiEP2SAiI5bbFDJBRH9Cr4bce5
         48vs56mGJ9sug5msRMNvaFxB+auBDRhcQkuhcpaJjGqvP7Ys9XH482qXLM9Mmodr6woR
         GreogOdKlZd2R7XZ5t0XkcIKVWy1qIyk6bJ1VOy1I9jAU7fYeuataV3YUy7uMhoPoN4A
         T3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XOyznZTEsXdH/0R24390C+1ujg7ZJGqVqGTwGLt4RDg=;
        b=d5qf1D01s4oXpNmxIBG29zQrqCh8xqgYRsPUsyzl6r3Ugykfcgfs4KkSuDMBGzcBLh
         UOOzaOGRoh1MVOCZgCSutxtFDTF2K3ueHxGh1lVBU2QLu2V90lB0aNBiQAE1ym202g4V
         IFQOQU1+vKwvzO51hrGKmdjrh+QcwI80AbiveE31wBVlyT2TTjXchDDlrnTr/kALWJz+
         w4plxj2/eVe0VjqjwRNFTGcQMekPxjbsAxouNUC4xQ7llhlTAn6od1qSaIqInTtNokem
         9nOHQBoRzjmj97BBmTfRsBn348jPpke6azsKKJhDB5Mr8puxGZEOcBrhSU4O6+5OAXqV
         bCWg==
X-Gm-Message-State: AOAM533dYTOD38NYyY3kmFY5IRftI3fWwn+Js+8kIh4k0IDoJonXseMA
        Nh1L23FLsGlHwLRuRJ34wSY=
X-Google-Smtp-Source: ABdhPJy9C1m7FXB2RvyTBYBW5bQAsEKNGlNIDhVy8U4SDVe/PtGtYlXYWgSbchAV3DXhFz42dRTv4w==
X-Received: by 2002:a05:6638:124d:: with SMTP id o13mr2878069jas.98.1604597611139;
        Thu, 05 Nov 2020 09:33:31 -0800 (PST)
Received: from Olgas-MBP-377.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x20sm1413888ioh.17.2020.11.05.09.33.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 05 Nov 2020 09:33:30 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH 1/2] [lsm] introduce a new hook to query LSM for functionality
Date:   Thu,  5 Nov 2020 12:33:27 -0500
Message-Id: <20201105173328.2539-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a new hook func_query_vfs to query an LSM module (such as
SELinux) with the intention of finding whether or not it is enabled
or perhaps supports some functionality.

NFS stores security labels for file system objects and SElinux
or any other LSM module can query those objects. But it's
wasteful to do so when no security enforcement is taking place.
Using a new API call of security_func_query_vfs() and asking if

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/security.h      | 4 ++++
 security/security.c           | 6 ++++++
 security/selinux/hooks.c      | 7 +++++++
 4 files changed, 18 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 32a940117e7a..df3454a1fcac 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -257,6 +257,7 @@ LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
 	 u32 *ctxlen)
+LSM_HOOK(int, 0, func_query_vfs, unsigned int)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
 LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
diff --git a/include/linux/security.h b/include/linux/security.h
index bc2725491560..e15964059fa4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -456,6 +456,10 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+#define LSM_FQUERY_VFS_NONE     0x00000000
+#define LSM_FQUERY_VFS_XATTRS   0x00000001
+int security_func_query_vfs(unsigned int flags);
+
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
diff --git a/security/security.c b/security/security.c
index a28045dc9e7f..502b33865238 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2067,6 +2067,12 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
+int security_func_query_vfs(unsigned int flags)
+{
+	return call_int_hook(func_query_vfs, 0, flags);
+}
+EXPORT_SYMBOL(security_func_query_vfs);
+
 #ifdef CONFIG_WATCH_QUEUE
 int security_post_notification(const struct cred *w_cred,
 			       const struct cred *cred,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6b1826fc3658..38f47570e214 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,7 @@
 #include <uapi/linux/mount.h>
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
+#include <linux/security.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -6502,6 +6503,11 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
 	spin_unlock(&isec->lock);
 }
 
+static int selinux_func_query_vfs(unsigned int flags)
+{
+	return !!(flags & LSM_FQUERY_VFS_XATTRS);
+}
+
 /*
  *	called with inode->i_mutex locked
  */
@@ -7085,6 +7091,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
+	LSM_HOOK_INIT(func_query_vfs, selinux_func_query_vfs),
 
 	LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
 	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
-- 
2.18.2

