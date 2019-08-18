Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8F918BF
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfHRSVY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39673 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfHRSVX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:23 -0400
Received: by mail-io1-f65.google.com with SMTP id l7so16099395ioj.6
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUqysWbKvPFNlaLXerEM8LOnAFiFnFfEtzysZY3wVnY=;
        b=RDNfhR5S3JUZDBPor9Wn53mGn4CXcVTZSYiNfhSBWOlzx5QCGIB1luUsRByRQ3fBEN
         2Kxvvyb/11veC8Kxwb4zJ9XMkn1NYsxonWumwb3O0RTUHxlbbpU0IDG48lMDAB0fZG/8
         7JRbZHeiJQ+JlWhMkP3g140Qn10SoJwugxCbDcaqvCMWtI6lwH8/wIKFn/6Z3kHXsLMw
         AQhPp0P34sU0J3Zb27uCQhSNLrE1BESF8zmqEosavFCfR8drHWaw7JZ+5EWSfnjW9iak
         SZAcRzkUDzdXXw5mIg3v9qOsE7dyuFa7WieAOgupmoJAMaC8Uly/asNdQeEJpm7yUbJj
         PTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUqysWbKvPFNlaLXerEM8LOnAFiFnFfEtzysZY3wVnY=;
        b=nVJOqANT4JRgERXlWF3LRxMU0RwubbkPDROG2y/uwReAyarXuqebDGfmvJmsgzSRj7
         g1klBAJX/ih3BexCwgpfR2koa3Y9VtQeay3YxFXnP6r7OaI+QhwF+/wdv5mv7djXTymd
         DExBCAQA0Pr7FRpkvb9AY9mpZUAVssunlPtB7V+8C1HZ8jJoOUfVcc1lSj9o0TsplXI9
         BXgYX8kduL0pTaZpsRYMpQc2eR8UCYjDJgHDSDiuKBfXbbpSgQw841xo52OFnUZsdihP
         HuaiAKd/NDf58zR8I7biAa3gSU79R2KlX6OVCRtEEhULQzyR7M4ogRpF8X8KaI6g5GqJ
         77dQ==
X-Gm-Message-State: APjAAAXiDqqyLw/IKXCrhdRSKUyj3hAHqWsYl+RKTHipaKioh0Zam3m1
        IxKlWbdzZrtq+TBWoYWX4guncRs=
X-Google-Smtp-Source: APXvYqwd/dMYSxREXjRrbLkLMB7MMzpsKD0Kf1vZ4qIouNj6CEK37XzvOeyHBbXmbqf+rlqKUCgJFA==
X-Received: by 2002:a6b:f119:: with SMTP id e25mr4698135iog.22.1566152469190;
        Sun, 18 Aug 2019 11:21:09 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:07 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 02/16] locks: create a new notifier chain for lease attempts
Date:   Sun, 18 Aug 2019 14:18:45 -0400
Message-Id: <20190818181859.8458-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-2-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

With the new file caching infrastructure in nfsd, we can end up holding
files open for an indefinite period of time, even when they are still
idle. This may prevent the kernel from handing out leases on the file,
which is something we don't want to block.

Fix this by running a SRCU notifier call chain whenever on any
lease attempt. nfsd can then purge the cache for that inode before
returning.

Since SRCU is only conditionally compiled in, we must only define the
new chain if it's enabled, and users of the chain must ensure that
SRCU is enabled.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/locks.c         | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  5 ++++
 2 files changed, 66 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 686eae21daf6..1913481bfbf7 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1990,6 +1990,64 @@ int generic_setlease(struct file *filp, long arg, struct file_lock **flp,
 }
 EXPORT_SYMBOL(generic_setlease);
 
+#if IS_ENABLED(CONFIG_SRCU)
+/*
+ * Kernel subsystems can register to be notified on any attempt to set
+ * a new lease with the lease_notifier_chain. This is used by (e.g.) nfsd
+ * to close files that it may have cached when there is an attempt to set a
+ * conflicting lease.
+ */
+static struct srcu_notifier_head lease_notifier_chain;
+
+static inline void
+lease_notifier_chain_init(void)
+{
+	srcu_init_notifier_head(&lease_notifier_chain);
+}
+
+static inline void
+setlease_notifier(long arg, struct file_lock *lease)
+{
+	if (arg != F_UNLCK)
+		srcu_notifier_call_chain(&lease_notifier_chain, arg, lease);
+}
+
+int lease_register_notifier(struct notifier_block *nb)
+{
+	return srcu_notifier_chain_register(&lease_notifier_chain, nb);
+}
+EXPORT_SYMBOL_GPL(lease_register_notifier);
+
+void lease_unregister_notifier(struct notifier_block *nb)
+{
+	srcu_notifier_chain_unregister(&lease_notifier_chain, nb);
+}
+EXPORT_SYMBOL_GPL(lease_unregister_notifier);
+
+#else /* !IS_ENABLED(CONFIG_SRCU) */
+static inline void
+lease_notifier_chain_init(void)
+{
+}
+
+static inline void
+setlease_notifier(long arg, struct file_lock *lease)
+{
+}
+
+int lease_register_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lease_register_notifier);
+
+void lease_unregister_notifier(struct notifier_block *nb)
+{
+}
+EXPORT_SYMBOL_GPL(lease_unregister_notifier);
+
+#endif /* IS_ENABLED(CONFIG_SRCU) */
+
 /**
  * vfs_setlease        -       sets a lease on an open file
  * @filp:	file pointer
@@ -2010,6 +2068,8 @@ EXPORT_SYMBOL(generic_setlease);
 int
 vfs_setlease(struct file *filp, long arg, struct file_lock **lease, void **priv)
 {
+	if (lease)
+		setlease_notifier(arg, *lease);
 	if (filp->f_op->setlease)
 		return filp->f_op->setlease(filp, arg, lease, priv);
 	else
@@ -2923,6 +2983,7 @@ static int __init filelock_init(void)
 		INIT_HLIST_HEAD(&fll->hlist);
 	}
 
+	lease_notifier_chain_init();
 	return 0;
 }
 core_initcall(filelock_init);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 997a530ff4e9..7ca1148778e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1155,6 +1155,11 @@ extern void lease_get_mtime(struct inode *, struct timespec64 *time);
 extern int generic_setlease(struct file *, long, struct file_lock **, void **priv);
 extern int vfs_setlease(struct file *, long, struct file_lock **, void **);
 extern int lease_modify(struct file_lock *, int, struct list_head *);
+
+struct notifier_block;
+extern int lease_register_notifier(struct notifier_block *);
+extern void lease_unregister_notifier(struct notifier_block *);
+
 struct files_struct;
 extern void show_fd_locks(struct seq_file *f,
 			 struct file *filp, struct files_struct *files);
-- 
2.21.0

