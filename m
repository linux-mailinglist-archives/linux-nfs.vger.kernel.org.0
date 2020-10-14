Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5698328E738
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Oct 2020 21:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390303AbgJNTY2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Oct 2020 15:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389668AbgJNTY1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Oct 2020 15:24:27 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42728214D8;
        Wed, 14 Oct 2020 19:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602703466;
        bh=fkAGzfqumQbaABPfDkcxBrAT3qFv7+v0vQDUOLI3VwQ=;
        h=From:To:Cc:Subject:Date:From;
        b=T2a2MK49udy2DL3u8epoH4sO3p0huY6VkG82OPuxnD/gg1SW+BnQ7MnSiLOIfy3kK
         qepFwYFgRpnbpqgJ/9uJYlAk22YDNmTycoehRfzHsLhTroQPWzj5ZcDg3rTBg2jn4a
         hsckeA7t7ZOzKdf/dBIXxr9YeIw4kP09WtwGpYS4=
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Fix up RCU annotations for struct nfs_netns_client
Date:   Wed, 14 Oct 2020 15:22:11 -0400
Message-Id: <20201014192211.337564-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The identifier is read as an RCU protected string. Its value may
be changed during the lifetime of the network namespace by writing
a new string into the sysfs pseudofile (at which point, we free the
old string only after a call to synchronize_rcu()).

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/sysfs.c | 11 ++++++++---
 fs/nfs/sysfs.h |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index c489496b5659..8cb70755e3c9 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -79,7 +79,12 @@ static ssize_t nfs_netns_identifier_show(struct kobject *kobj,
 	struct nfs_netns_client *c = container_of(kobj,
 			struct nfs_netns_client,
 			kobject);
-	return scnprintf(buf, PAGE_SIZE, "%s\n", c->identifier);
+	ssize_t ret;
+
+	rcu_read_lock();
+	ret = scnprintf(buf, PAGE_SIZE, "%s\n", rcu_dereference(c->identifier));
+	rcu_read_unlock();
+	return ret;
 }
 
 /* Strip trailing '\n' */
@@ -107,7 +112,7 @@ static ssize_t nfs_netns_identifier_store(struct kobject *kobj,
 	p = kmemdup_nul(buf, len, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
-	old = xchg(&c->identifier, p);
+	old = rcu_dereference_protected(xchg(&c->identifier, (char __rcu *)p), 1);
 	if (old) {
 		synchronize_rcu();
 		kfree(old);
@@ -121,7 +126,7 @@ static void nfs_netns_client_release(struct kobject *kobj)
 			struct nfs_netns_client,
 			kobject);
 
-	kfree(c->identifier);
+	kfree(rcu_dereference_raw(c->identifier));
 	kfree(c);
 }
 
diff --git a/fs/nfs/sysfs.h b/fs/nfs/sysfs.h
index ebcbdc40483b..5501ef573c32 100644
--- a/fs/nfs/sysfs.h
+++ b/fs/nfs/sysfs.h
@@ -11,7 +11,7 @@
 struct nfs_netns_client {
 	struct kobject kobject;
 	struct net *net;
-	const char *identifier;
+	const char __rcu *identifier;
 };
 
 extern struct kobject *nfs_client_kobj;
-- 
2.26.2

