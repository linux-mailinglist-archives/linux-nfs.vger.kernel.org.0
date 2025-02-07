Return-Path: <linux-nfs+bounces-9948-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC53A2CE60
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BC73AB06B
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 20:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30A21B4151;
	Fri,  7 Feb 2025 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCaYI+XC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0661A8F97
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960948; cv=none; b=PiVeacKs5iu/BUGYlYF2WeGxrAHG+VelnPbe8o/0bigBKqtpxuklFpc3dQQywJWpjU3XBy4U5ZyvB3RHEzTR6zK3h474rn7P5Q9muNgpq2dcXX1nRxdfnsbzfoB76DWGBfqIHqzpVyBR4GC02qRpBP39ndKEXWm5F12Wz2XZjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960948; c=relaxed/simple;
	bh=fknGuYnQ1cgfKxMOrI2w1RekboN7nJqSd/hZ3o5Cqrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpHSUynQkMPVxpI04XgUyjxTAW6MrydASi2TOj+eGZMgKbqwaUdF5MNwyJNXU+ZF8Ye4qIRKgHZkHKIvc53e/nWkXGjVY1uiBwO1P/W2f8ERWgPV12hg3ZhH8+wf8CcbBEEnkRYG3Sw7VkKjE0OAR13qaBq0kT31DjaKn0+OtPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCaYI+XC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD27C4CEE2;
	Fri,  7 Feb 2025 20:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738960948;
	bh=fknGuYnQ1cgfKxMOrI2w1RekboN7nJqSd/hZ3o5Cqrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UCaYI+XC9V5bh7OwgFRg9S59gmXwBv6l/e2dINmLxyEhRIqQN7SjUFR7bPUfBBAE0
	 NNn8G+mCpmruwZoZQk0YBV7kO1SFljVWeS0r6eLxNJo0GrrPbfybgWBKFqSlGpgeC0
	 3/g5rRbFnKS2ziwDM8xHOHczOgBOQYnhaHGzpqOgrUNLmu0gMv/jitZxie+OKna4dj
	 CQeUAv9HPfOosR1sOCphVBuAf6MXZ6/sm+vUWQIphmjC/go42oPi7B6I0pTafznaZJ
	 yxL3xIczY4pIa5SeBeEX1AquCI8wY2ncSGlYF3IaLLTFVRR+vWhKWlGPFbB3Rt8gTm
	 JZnvLTlyxm/RA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v3 3/5] sunrpc: Add a sysfs files for rpc_clnt information
Date: Fri,  7 Feb 2025 15:42:23 -0500
Message-ID: <20250207204225.594002-4-anna@kernel.org>
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

These files display useful information about the RPC client, such as the
rpc version number, program name, and maximum number of connections
allowed.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
v3: Fix the mode bits for the max_connect file
---
 net/sunrpc/sysfs.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index dc3b7cd70000..dcd579eab50a 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -59,6 +59,16 @@ static struct kobject *rpc_sysfs_object_alloc(const char *name,
 	return NULL;
 }
 
+static inline struct rpc_clnt *
+rpc_sysfs_client_kobj_get_clnt(struct kobject *kobj)
+{
+	struct rpc_sysfs_client *c = container_of(kobj,
+		struct rpc_sysfs_client, kobject);
+	struct rpc_clnt *ret = c->clnt;
+
+	return refcount_inc_not_zero(&ret->cl_count) ? ret : NULL;
+}
+
 static inline struct rpc_xprt *
 rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
 {
@@ -86,6 +96,51 @@ rpc_sysfs_xprt_switch_kobj_get_xprt(struct kobject *kobj)
 	return xprt_switch_get(x->xprt_switch);
 }
 
+static ssize_t rpc_sysfs_clnt_version_show(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   char *buf)
+{
+	struct rpc_clnt *clnt = rpc_sysfs_client_kobj_get_clnt(kobj);
+	ssize_t ret;
+
+	if (!clnt)
+		return sprintf(buf, "<closed>\n");
+
+	ret = sprintf(buf, "%u", clnt->cl_vers);
+	refcount_dec(&clnt->cl_count);
+	return ret;
+}
+
+static ssize_t rpc_sysfs_clnt_program_show(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   char *buf)
+{
+	struct rpc_clnt *clnt = rpc_sysfs_client_kobj_get_clnt(kobj);
+	ssize_t ret;
+
+	if (!clnt)
+		return sprintf(buf, "<closed>\n");
+
+	ret = sprintf(buf, "%s", clnt->cl_program->name);
+	refcount_dec(&clnt->cl_count);
+	return ret;
+}
+
+static ssize_t rpc_sysfs_clnt_max_connect_show(struct kobject *kobj,
+					       struct kobj_attribute *attr,
+					       char *buf)
+{
+	struct rpc_clnt *clnt = rpc_sysfs_client_kobj_get_clnt(kobj);
+	ssize_t ret;
+
+	if (!clnt)
+		return sprintf(buf, "<closed>\n");
+
+	ret = sprintf(buf, "%u\n", clnt->cl_max_connect);
+	refcount_dec(&clnt->cl_count);
+	return ret;
+}
+
 static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
 					   struct kobj_attribute *attr,
 					   char *buf)
@@ -423,6 +478,23 @@ static const void *rpc_sysfs_xprt_namespace(const struct kobject *kobj)
 			    kobject)->xprt->xprt_net;
 }
 
+static struct kobj_attribute rpc_sysfs_clnt_version = __ATTR(rpc_version,
+	0444, rpc_sysfs_clnt_version_show, NULL);
+
+static struct kobj_attribute rpc_sysfs_clnt_program = __ATTR(program,
+	0444, rpc_sysfs_clnt_program_show, NULL);
+
+static struct kobj_attribute rpc_sysfs_clnt_max_connect = __ATTR(max_connect,
+	0444, rpc_sysfs_clnt_max_connect_show, NULL);
+
+static struct attribute *rpc_sysfs_rpc_clnt_attrs[] = {
+	&rpc_sysfs_clnt_version.attr,
+	&rpc_sysfs_clnt_program.attr,
+	&rpc_sysfs_clnt_max_connect.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(rpc_sysfs_rpc_clnt);
+
 static struct kobj_attribute rpc_sysfs_xprt_dstaddr = __ATTR(dstaddr,
 	0644, rpc_sysfs_xprt_dstaddr_show, rpc_sysfs_xprt_dstaddr_store);
 
@@ -459,6 +531,7 @@ ATTRIBUTE_GROUPS(rpc_sysfs_xprt_switch);
 
 static const struct kobj_type rpc_sysfs_client_type = {
 	.release = rpc_sysfs_client_release,
+	.default_groups = rpc_sysfs_rpc_clnt_groups,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_client_namespace,
 };
-- 
2.48.1


