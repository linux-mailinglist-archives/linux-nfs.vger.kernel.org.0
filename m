Return-Path: <linux-nfs+bounces-9950-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13056A2CE5D
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941721886325
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 20:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC3E1B4153;
	Fri,  7 Feb 2025 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CseMRWOO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8611B040B
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960949; cv=none; b=QGuV5rLv66KHcaJhkIhgQlbCH9QQTrDuF9Qc78dpdzeFWm0wPBVcBDNoAQPmLD9fJustETmMYYHX7qUEt1sFjNaRWiJ8gDqXkRmJMBy0IfJb0O1S1o7BN8hFjy+e8s1G5H6ENzr+eGpAL83nb8okCsYzua6ivJAI4B76zwFlaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960949; c=relaxed/simple;
	bh=oyXMgYzZBtuVNTlQFq8kagATWP0+OtkEAOtOAtjAe6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwQFJtA7AqXLS+NNL+sYd1s93YS+EF/dfzp+ryuXh5JjfI34zTZklF/8wNWJdk4nE4e0M5eQMzIb/jr+MRmr2kdT/IsGpI1gCVkKmCnaTyWTUIMF6SLOJ7F16sqHa/hEj/QRJXTK5Xkwb0P4IzMXWidUYkReeiLalkIk0H796dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CseMRWOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5C9C4CED1;
	Fri,  7 Feb 2025 20:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738960949;
	bh=oyXMgYzZBtuVNTlQFq8kagATWP0+OtkEAOtOAtjAe6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CseMRWOOCIWXSZ+tc+8lTfLuyqQOgN409fuIaYCUUDG2U5LQL6sk4VKai0Ts/a+ro
	 YtspERYCyZdKcaEIVc7fWnoymS2+SfMe9ha3WmZNesLdmFCAi887rhPpcjSDpxl4/D
	 POGjIOYLKxEzCn/VifH/LlpZkc2B9TI51r3jSSFapj1+HXKGJqgKhrkn0pSYqxC6eL
	 Myn5rZvoDM63TsS7HCgKjV946W3U3zDirPFtmJcQ4plNMBhXH8VRkNJOkKlV2rwfU7
	 0imZxjiY330TTJnHhyfc4D8WfPhJ5WkdJqI16uuKYpfMzqMCHd0GFuiuqab/XUNjch
	 FRDVttpOlBT5Q==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v3 5/5] sunrpc: Add a sysfs file for one-step xprt deletion
Date: Fri,  7 Feb 2025 15:42:25 -0500
Message-ID: <20250207204225.594002-6-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207204225.594002-1-anna@kernel.org>
References: <20250207204225.594002-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Previously, the admin would need to set the xprt state to "offline"
before attempting to remove. This patch adds a new sysfs attr that does
both these steps in a single call.

Suggested-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 net/sunrpc/sysfs.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 8fd1975f2fe8..09434e1143c5 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -286,6 +286,14 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 	return ret;
 }
 
+static ssize_t rpc_sysfs_xprt_del_xprt_show(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    char *buf)
+{
+	return sprintf(buf, "# delete this xprt\n");
+}
+
+
 static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
 					       struct kobj_attribute *attr,
 					       char *buf)
@@ -464,6 +472,40 @@ static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t rpc_sysfs_xprt_del_xprt(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	struct rpc_xprt_switch *xps = rpc_sysfs_xprt_kobj_get_xprt_switch(kobj);
+
+	if (!xprt || !xps) {
+		count = 0;
+		goto out;
+	}
+
+	if (xprt->main) {
+		count = -EINVAL;
+		goto release_tasks;
+	}
+
+	if (wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE)) {
+		count = -EINTR;
+		goto out_put;
+	}
+
+	xprt_set_offline_locked(xprt, xps);
+	xprt_delete_locked(xprt, xps);
+
+release_tasks:
+	xprt_release_write(xprt, NULL);
+out_put:
+	xprt_put(xprt);
+	xprt_switch_put(xps);
+out:
+	return count;
+}
+
 int rpc_sysfs_init(void)
 {
 	rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
@@ -559,12 +601,16 @@ static struct kobj_attribute rpc_sysfs_xprt_info = __ATTR(xprt_info,
 static struct kobj_attribute rpc_sysfs_xprt_change_state = __ATTR(xprt_state,
 	0644, rpc_sysfs_xprt_state_show, rpc_sysfs_xprt_state_change);
 
+static struct kobj_attribute rpc_sysfs_xprt_del = __ATTR(del_xprt,
+	0644, rpc_sysfs_xprt_del_xprt_show, rpc_sysfs_xprt_del_xprt);
+
 static struct attribute *rpc_sysfs_xprt_attrs[] = {
 	&rpc_sysfs_xprt_dstaddr.attr,
 	&rpc_sysfs_xprt_srcaddr.attr,
 	&rpc_sysfs_xprt_xprtsec.attr,
 	&rpc_sysfs_xprt_info.attr,
 	&rpc_sysfs_xprt_change_state.attr,
+	&rpc_sysfs_xprt_del.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(rpc_sysfs_xprt);
-- 
2.48.1


