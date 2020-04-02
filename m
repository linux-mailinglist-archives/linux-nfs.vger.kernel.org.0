Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4542819CB3C
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2020 22:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389086AbgDBUcd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 16:32:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgDBUcd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 Apr 2020 16:32:33 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91D48206E9
        for <linux-nfs@vger.kernel.org>; Thu,  2 Apr 2020 20:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585859552;
        bh=utEhknUPbEj8txUV1e2LOOnRDtYnuux0v6wBCh5T3rc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qrj/T8426gGP0168Bvhkz790d+CvYW+QAR5N8+9QH5/y4Pb5D3/CiuH6eX8FGUqO2
         CNFqOG9ncnQzdMdZ8M2FiGmaZOCPIertY4F8FNPwHN5OVBMKfyeR+vG3rgADsvc6WJ
         p9wMG4id93s5+WTX5B1IQI34CdsLUE8mGaMgBul8=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Add a module parameter to set nfs_mountpoint_expiry_timeout
Date:   Thu,  2 Apr 2020 16:30:18 -0400
Message-Id: <20200402203018.385154-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402203018.385154-1-trondmy@kernel.org>
References: <20200402203018.385154-1-trondmy@kernel.org>
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
 fs/nfs/namespace.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 50b162dd88f5..4c02f0e00620 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -311,3 +311,38 @@ int nfs_submount(struct fs_context *fc, struct nfs_server *server)
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
+	if (num >= 0) {
+		num *= HZ;
+		if (num > INT_MAX)
+			num = INT_MAX;
+		*((int *)kp->arg) = num;
+		if (!list_empty(&nfs_automount_list))
+			mod_delayed_work(system_wq, &nfs_automount_task, num);
+	} else {
+		*((int *)kp->arg) = -1;
+		cancel_delayed_work(&nfs_automount_task);
+	}
+	return 0;
+}
+
+static const struct kernel_param_ops param_ops_nfs_timeout = {
+	.set = param_set_nfs_timeout,
+	.get = param_get_uint,
+};
+#define param_check_nfs_timeout(name, p) __param_check(name, p, int);
+
+module_param(nfs_mountpoint_expiry_timeout, nfs_timeout, 0644);
+MODULE_PARM_DESC(nfs_mountpoint_expiry_timeout,
+		"Set the NFS automounted mountpoint timeout value."
+		"Negative values turn expiration off.");
-- 
2.25.1

