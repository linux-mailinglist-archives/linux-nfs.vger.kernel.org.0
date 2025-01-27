Return-Path: <linux-nfs+bounces-9698-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E1BA2001A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFB33A3878
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151D1D932F;
	Mon, 27 Jan 2025 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx7E6hyg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0791C5F13
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014622; cv=none; b=o+OuELiYblCsgB3IoBIWPXPXQGEK6FYdJ7KtERilbQAwcFQuSDaHXio20KzolLal1Sj8iznxNi81rtffEtZwBRLbI23XlOJwCBrSrdivaHQj0oJyqXNf2X3qFBDh2lWZekGYsVW64gfh+JmhGxxERcnjOR75kRWgprbtGb4U96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014622; c=relaxed/simple;
	bh=LW++IZXmbaSsERqMxIOWwEVGWj0Uk6rC4ec5eXtd/k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go3yiLkVrubSAJ3gfXwnBu9Xx+VCsMn7Hr9YGBXvdKsjnkokyorQVSx0WFYPuLTaotRIy8dmKb1C/jKodk14QuIC6N7ddjo4gzDGs1Uf2By9hhOc4H00qHum9O5UsdSo+6wPbCeDIJFIZXFBW00uyq0E6H1CR0CWShAsICzJH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx7E6hyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848C6C4CED2;
	Mon, 27 Jan 2025 21:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738014621;
	bh=LW++IZXmbaSsERqMxIOWwEVGWj0Uk6rC4ec5eXtd/k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gx7E6hygCKad368/1SRsizo3Uivmt3SJfVLs9OdEP9covaz6IdsyUka7o0QzRq57b
	 N8YG6Wyk7eqIiVhCoUk0qZBuZPB3t0vuQlgP13bcgv1Td+XEgHxBpSGxYfQKAW8y2L
	 zVmJxZXrTWyeUJAeiAJCEBVD1d7cCnkXjDx4J6ukPSea8iQLRiDl2BeMzFATbJhuZ2
	 A2Eq7P8QjrYLqYoSh06zZjn2MI2Q7HTHnQCZxgyXU58NtvF7aEkMLcLt/7osmsolVa
	 xcFoU76DhGJgLOte92WsPZ7SCHabDmJkuc+s/hWXX2nt6SxaBmCPPRtF/GoJtOzY1F
	 6fxxLlr6PfZSw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 2/5] sunrpc: Add a sysfs attr for xprtsec
Date: Mon, 27 Jan 2025 16:50:16 -0500
Message-ID: <20250127215019.352509-3-anna@kernel.org>
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

This allows the admin to check the TLS configuration for each xprt.

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


