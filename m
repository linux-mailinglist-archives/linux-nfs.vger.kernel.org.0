Return-Path: <linux-nfs+bounces-9701-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA76A2001D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0B71884DE9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB951D9329;
	Mon, 27 Jan 2025 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhUr79/k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB71DA617
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014624; cv=none; b=ToD8tYaMmBtEFFe8pR/vvo6zXlA4l8qgk+t40PbUrbrqNK+gavyTCX19ItFfFrL2LHsP/L+oAvDlnR5alAkrA31iOYyx2bC/NEL6HFCGfeB4y9g4qQezNw2UXWzocbZOrUD5JUG9u6PhmAsqZuEiucpEXePMxGFB3QFa2q6OeQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014624; c=relaxed/simple;
	bh=YPLOQszizsGFDDLzcx2A+ERk187aWgDFqdDxBnlzllI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jphJXZsYFPuN5eq6HlesuCxeq3HuMJf9GSKb3G0IQBidQhqKv819RtK1+J4TQGM3bgzjhHHTfv/+1jU/uSgBjW1hzLnbv1db1rKhxIwmWMIOE5Zt//yJhNZHbNn0wuyUZ7VFQkbTx2sy8p7JhAwJDhwosGWr0n3rQ9UwQ4/stHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhUr79/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39247C4CEE0;
	Mon, 27 Jan 2025 21:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738014623;
	bh=YPLOQszizsGFDDLzcx2A+ERk187aWgDFqdDxBnlzllI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LhUr79/kOgrSdk58vocdmoXHfjF+bAOOD7ztDWYw6c1nqTSpve+DcyN8z/mBNVbEw
	 81ZyTck4aijcObjKm/6GXSuQKro6+MDwvVgJGsUFbXsowmmy/ZofNRmMQfupV1xrRG
	 xYSaYk2fUqATB5iGL8mnZAh6DKItdjSsZtJh5XUXI0LCv53Z/spl4fgwXNfKJg0xhz
	 opi0EuObNZl9RlPhYeFyTYXvQTCGEUp00ZG1YVS3T15EpJqIvBxWBLYPSN+w5WpHXo
	 MdGN/6C5FZpIbjuCdoq0yVa6+aw1+F/htMUbSf+9tyO4AKLfr5IlFHddnCBJOJvuZr
	 VnT2W1t7q7HGw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 5/5] sunrpc: Add a sysfs file for one-step xprt deletion
Date: Mon, 27 Jan 2025 16:50:19 -0500
Message-ID: <20250127215019.352509-6-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127215019.352509-1-anna@kernel.org>
References: <20250127215019.352509-1-anna@kernel.org>
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
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 net/sunrpc/sysfs.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index a9d155a2b0ea..1e1cb2b3c51a 100644
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


