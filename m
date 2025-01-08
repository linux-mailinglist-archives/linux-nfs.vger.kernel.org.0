Return-Path: <linux-nfs+bounces-8986-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB044A0673F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB901165A85
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EDD2040B0;
	Wed,  8 Jan 2025 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1SvzkxB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395E204088
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372195; cv=none; b=LWF9pJY9PLCu3l350MyYeMws82eC/bIyT3xlBZfpR8evvBZF+ohhp13zxWARVZYnvmKQ64YX7IBqrMSAUWwCgeLMXn1lejkPKFwgZsRHNzEp8cytNN3fKNedchc8lWvwcXqvaZCj7ncgMZh1OinXQsguXbAiAYaz0z3+N2aN8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372195; c=relaxed/simple;
	bh=Bc+C/cM85B8utmREyttjysNOrZ9zz9NLXY3W5HC/6XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxtnLhNvqgzD0Rr4O8pZH9etJyMzd3/d+3pCJvOD5I/syDinukBBdk3zMzdtagasor9UL6IaSBaFN+ap6f6sw1QpGX1WDFwHULoqwyC0mAAAdFTRIb+RLM5O3k3RDL5UAw5PsLq3rPxy7lrTqibUzbcAgRpbCZJ2EfgF+3t4YuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1SvzkxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C63C4CEDF;
	Wed,  8 Jan 2025 21:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372194;
	bh=Bc+C/cM85B8utmREyttjysNOrZ9zz9NLXY3W5HC/6XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1SvzkxBVfGoddU/b2aCw0r+ygmhtdrCG/lM9+ib9r1Vk9nq9BjfuPX81XkFF3pZY
	 cNvWUfEhifGmYOpyJgLcH92U1vKvh8kVfHo1+sMYrpsQveRScorWNpfmQDjNXuT+M+
	 Z500tiLlSCzU5pomtiNdXoU+mEbngPhw90pRUf+ofn2v3iG63MERKpShh/nTtLtduQ
	 tJihGpz7A4gvmzawI6a2yHOb6zLMypa82dNwLkPXjSfY/9Cwh7P5J6LItPfwtoCWTN
	 8gKqrVbbq/jgEdfLNTyWTCLWFk9fHkviTNY4S1vzQCkpx5Qzl+VYrvwmeWDx5jf+we
	 atKBYocPfJkBQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 2/3] sunrpc: Add a sysfs attr for xprtsec
Date: Wed,  8 Jan 2025 16:36:31 -0500
Message-ID: <20250108213632.260498-3-anna@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108213632.260498-1-anna@kernel.org>
References: <20250108213632.260498-1-anna@kernel.org>
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
2.47.1


