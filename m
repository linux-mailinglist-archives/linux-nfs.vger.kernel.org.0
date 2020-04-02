Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307EE19CD52
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 01:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgDBXHR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 19:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389574AbgDBXHQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 Apr 2020 19:07:16 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8A62077D
        for <linux-nfs@vger.kernel.org>; Thu,  2 Apr 2020 23:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585868836;
        bh=XSSnQqfMAG1I1XCBYJghlJwzUaAFiIgrld1QasmZnNk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZePkJCs1Kn6Ir09JQUcsYrsmjTaoO9m2AiydRBloONg8Lk5jBAxDxYpxv7E67qcjY
         xw+MKQDm31fKAz2mWIuo9OMEimQogja9Q/tzQJbhmRfnsNJ5neCoxuQNZfAQiETX2x
         Az74f+5+67KC7NXEzjHX9946F8eGFGnlgm1jgP4A=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFS: Add a module parameter to set nfs_mountpoint_expiry_timeout
Date:   Thu,  2 Apr 2020 19:05:07 -0400
Message-Id: <20200402230507.795151-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402230507.795151-1-trondmy@kernel.org>
References: <20200402230507.795151-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Setting nfs_mountpoint_expiry_timeout() to a negative value stops
mountpoint expiration, while setting it to a positive value restarts
the scheduler.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/namespace.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index fe19ae280262..6b063227e34e 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -311,3 +311,53 @@ int nfs_submount(struct fs_context *fc, struct nfs_server *server)
 	return nfs_do_submount(fc);
 }
 EXPORT_SYMBOL_GPL(nfs_submount);
+
+static int param_set_nfs_timeout(const char *val, const struct kernel_param *kp)
+{
+	long num;
+	int ret;
+
+	if (!val)
+		return -EINVAL;
+	ret = kstrtol(val, 0, &num);
+	if (ret)
+		return -EINVAL;
+	if (num > 0) {
+		if (num >= INT_MAX / HZ)
+			num = INT_MAX;
+		else
+			num *= HZ;
+		*((int *)kp->arg) = num;
+		if (!list_empty(&nfs_automount_list))
+			mod_delayed_work(system_wq, &nfs_automount_task, num);
+	} else {
+		*((int *)kp->arg) = -1*HZ;
+		cancel_delayed_work(&nfs_automount_task);
+	}
+	return 0;
+}
+
+static int param_get_nfs_timeout(char *buffer, const struct kernel_param *kp)
+{
+	long num = *((int *)kp->arg);
+
+	if (num > 0) {
+		if (num >= INT_MAX - (HZ - 1))
+			num = INT_MAX / HZ;
+		else
+			num = (num + (HZ - 1)) / HZ;
+	} else
+		num = -1;
+	return scnprintf(buffer, PAGE_SIZE, "%li\n", num);
+}
+
+static const struct kernel_param_ops param_ops_nfs_timeout = {
+	.set = param_set_nfs_timeout,
+	.get = param_get_nfs_timeout,
+};
+#define param_check_nfs_timeout(name, p) __param_check(name, p, int);
+
+module_param(nfs_mountpoint_expiry_timeout, nfs_timeout, 0644);
+MODULE_PARM_DESC(nfs_mountpoint_expiry_timeout,
+		"Set the NFS automounted mountpoint timeout value (seconds)."
+		"Values <= 0 turn expiration off.");
-- 
2.25.1

