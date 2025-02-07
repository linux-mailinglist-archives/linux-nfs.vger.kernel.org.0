Return-Path: <linux-nfs+bounces-9947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359C9A2CE5E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3387F3AAC14
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 20:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406A21B395F;
	Fri,  7 Feb 2025 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7GST+YW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5DD1A8F97
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960948; cv=none; b=JQOj1iOs7jjXtavGl1PZo428f0eNSH29C8wpt1jCbW2HcDYUvcsTj67UrskbhRw/5Ymqlg5KshRSu8LRh37b5PwXuNpPmpJ5RracrQkpcKppuJ3fusPrrTTprmH5AsEVUz7BLsu3I/e3oVWD/c3Z8k5wWtBBS+Ae3lXBpa5hhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960948; c=relaxed/simple;
	bh=U53nYvSfgTlzIynS/URfRQmCYprbBDXVgBSqyV5tYvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+6oB9PNmubVIx3xJWzdlUcWQbvDUxFvccHuKNvX6TWSjyIycY5+0cK59mLIEih7PUexDzloHSpTBXRcvkklwXTcPRZdvJedBFs8DuhPw8Mtv5KJrbHGpspHbJNIv6VULj5gl6IubDTFjjFrUHK0ySNP41lGUesbQp6XumEjMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7GST+YW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43979C4CED1;
	Fri,  7 Feb 2025 20:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738960947;
	bh=U53nYvSfgTlzIynS/URfRQmCYprbBDXVgBSqyV5tYvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7GST+YWxRnN56sbRwCd1ak/EJDg8mXRxQX0At2qOKFsJn0rlNufT0HivVfl4Y2wf
	 XsGtlvU4Koma0w6wm8EY30MGOCFUJM/eI1p+pWP0ce1cbGHGWAWOWcMsgFFB6yRpzr
	 I5zvyDrVpP+1gUwjRpH6l5q/tu9X7IuEisSi7Pk1lurHgBOtMdi+Kk5fi9KvRzdxWp
	 MpcSMQOjh5PBpxnpWNTw/zi0WYUEE4anLr6eQO4BuVTrOhwbl+BnIpcUITCJzASyBs
	 Q3qKZ3I/hu6iYwUCGzCJevRvHUpgFk+VpM4SjtMmF+ztMViJoCkCO99wHiIAhlfw9M
	 MLFlfKAdLhEyw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v3 2/5] sunrpc: Add a sysfs attr for xprtsec
Date: Fri,  7 Feb 2025 15:42:22 -0500
Message-ID: <20250207204225.594002-3-anna@kernel.org>
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

This allows the admin to check the TLS configuration for each xprt.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 net/sunrpc/sysfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 5c8ecdaaa985..dc3b7cd70000 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -129,6 +129,31 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
 	return ret;
 }
 
+static const char *xprtsec_strings[] = {
+	[RPC_XPRTSEC_NONE] = "none",
+	[RPC_XPRTSEC_TLS_ANON] = "tls-anon",
+	[RPC_XPRTSEC_TLS_X509] = "tls-x509",
+};
+
+static ssize_t rpc_sysfs_xprt_xprtsec_show(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   char *buf)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	ssize_t ret;
+
+	if (!xprt) {
+		ret = sprintf(buf, "<closed>\n");
+		goto out;
+	}
+
+	ret = sprintf(buf, "%s\n", xprtsec_strings[xprt->xprtsec.policy]);
+	xprt_put(xprt);
+out:
+	return ret;
+
+}
+
 static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 					struct kobj_attribute *attr, char *buf)
 {
@@ -404,6 +429,9 @@ static struct kobj_attribute rpc_sysfs_xprt_dstaddr = __ATTR(dstaddr,
 static struct kobj_attribute rpc_sysfs_xprt_srcaddr = __ATTR(srcaddr,
 	0644, rpc_sysfs_xprt_srcaddr_show, NULL);
 
+static struct kobj_attribute rpc_sysfs_xprt_xprtsec = __ATTR(xprtsec,
+	0644, rpc_sysfs_xprt_xprtsec_show, NULL);
+
 static struct kobj_attribute rpc_sysfs_xprt_info = __ATTR(xprt_info,
 	0444, rpc_sysfs_xprt_info_show, NULL);
 
@@ -413,6 +441,7 @@ static struct kobj_attribute rpc_sysfs_xprt_change_state = __ATTR(xprt_state,
 static struct attribute *rpc_sysfs_xprt_attrs[] = {
 	&rpc_sysfs_xprt_dstaddr.attr,
 	&rpc_sysfs_xprt_srcaddr.attr,
+	&rpc_sysfs_xprt_xprtsec.attr,
 	&rpc_sysfs_xprt_info.attr,
 	&rpc_sysfs_xprt_change_state.attr,
 	NULL,
-- 
2.48.1


