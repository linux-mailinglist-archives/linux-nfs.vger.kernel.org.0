Return-Path: <linux-nfs+bounces-9699-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F751A2001B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E85B16599D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 21:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E691D9587;
	Mon, 27 Jan 2025 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwvuRTx5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9751D9329
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014622; cv=none; b=G81oVL76K3N6AGOvoNdMGgJ63Y1SD3+9YWJ3KhomCc4zke4Ro98t3qxIINsNR9IiPRvW9B068zJTVp82mpx3oeY4lU/scegG4Pzcwd9tOLQHTK25RumqnUlpzg8bJND3d0aYdU0IDIZ8ZhTWTQdDNo1mk+E3XHCUVRZoSqemV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014622; c=relaxed/simple;
	bh=dBJ63pYa3Itg2TxqewLKklUTbSNfWuJZ0jQYbo2KwKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulmsKd/UF8tbaqPjxn/VhqiV1Noa+w42q2kWvf4ArIJ3E+lU9Y6QS2Kn+/G0UpYcSpL5Jscnpq2PiP6O699I6Kx8h/PYnLUuwzrx0gMowASKykM7lnuisXKPTaa0wcePtgwAwDt/fUHwGCA7JLJX1n1i/dl/bRkgAG86ciaK3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwvuRTx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A186C4CEE0;
	Mon, 27 Jan 2025 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738014622;
	bh=dBJ63pYa3Itg2TxqewLKklUTbSNfWuJZ0jQYbo2KwKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwvuRTx5AhMEASq23Ks/mnLbaTbdKpLLSu5vty24sxmZutrwhmES0IqHJ5Zd/ZOdw
	 NYdgd0TdbfUbsdS31Dy+8qmUS+avRvV5fQi64NYVBY5k4Ea8vEqOKBnXgcvkBXdygc
	 ViwtGr8zk2TX9oSIJxNlGyJTF1fmi0srI/xNzWZ39SlH1/CnVvyyH33YPMijGSDgOb
	 d0ol6TySI/3KDLqvaLrwin8fAqOcREdDGA8oda0/95y/YfgTVPD/siZkwKkPQPD25z
	 lhBZDKpgrEqV57coTuMuAvlKsuHFcA5NrsBSS3fscRlxkBV1uxleHBo5yu0IZO6rIA
	 lJKMNCciCJU4A==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 3/5] sunrpc: Add a sysfs files for rpc_clnt information
Date: Mon, 27 Jan 2025 16:50:17 -0500
Message-ID: <20250127215019.352509-4-anna@kernel.org>
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

These files display useful information about the RPC client, such as the
rpc version number, program name, and maximum number of connections
allowed.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 net/sunrpc/sysfs.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index dc3b7cd70000..0d382ab24f1f 100644
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
+	0644, rpc_sysfs_clnt_max_connect_show, NULL);
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


