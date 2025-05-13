Return-Path: <linux-nfs+bounces-11704-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD96AB5D68
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 21:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4B71B6155D
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFA52BFC9B;
	Tue, 13 May 2025 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSWXcUsz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494762BFC85
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165846; cv=none; b=nTcAGdDe3e8/rRsN7kpicuhgi85XSSNacCouh8J0JG0Xl58bmQhKqKtgM+iI3f1B9J/+z0JlreYPiKu5lyclzNKlMWzSVRwF/2BP1mGs0GmbGNVrtxk6a1kWBjTza4yWoJceLpFjXGjqtHgThZYmm1ZjK51US1zXGjcvl8GkXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165846; c=relaxed/simple;
	bh=HsIweHztQRDEL9Sr7WWzJ1t3nEITl1KJeFIW2eKRJmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgrF1updWIR1w8+ctM4OvcieeL53QWB+xO04nb98lMS2XAytzgNeOuqcejAn2ORBf4LgAXKDAwS7dlhLzPxi4UqxTfHQE+nvfIRGAdJPmZUb1614E6eauBlIyCwqTUuAKUoPeGtiWiOz3O4SAhnd1/+de2sz9/mRO9ho1bf+H/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSWXcUsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85224C4CEE4;
	Tue, 13 May 2025 19:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747165845;
	bh=HsIweHztQRDEL9Sr7WWzJ1t3nEITl1KJeFIW2eKRJmM=;
	h=From:To:Cc:Subject:Date:From;
	b=eSWXcUszDRE4xtNuKnIbzZLgppqSpwwZVnFKOLMKUcMT15OnFzz4mwr26WLe+wC6W
	 +Gs8g6JHinzqtAPCjQS5UHbe9cp3NgWJ1Shsgkpvqr9C1Uk0isckqML4ktned9zdCf
	 s5C8c/g3P+bCcl5L8aPDA3pEmpKcNr3OBsMBrV+7FZQ7peEhOpR60TSv6BjjSdn5Aq
	 Kd9hwLkQbJkwtxtWsFXdCKv7P1q5zRktFaJGpJ0t/Lgzqth6DDG3FtpbP6+7uBVhcU
	 JVcQPdtvwdMV4IGaIdh3WC6XufzSNuti69/NqMgb/6ZdXT33MRJgatz7J+aeYD9cfy
	 sE3tVA6wsdZtw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@hammerspace.com>,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: add localio to sysfs
Date: Tue, 13 May 2025 15:50:44 -0400
Message-ID: <20250513195044.29431-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux NFS client and server added support for LOCALIO in Linux
v6.12. It is useful to know if a client and server negotiated LOCALIO
be used, so expose it through the 'localio' attribute.

Suggested-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 37cb2b776435..545148d42dcc 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -387,6 +387,33 @@ static inline void nfs_sysfs_add_nfsv41_server(struct nfs_server *server)
 }
 #endif /* CONFIG_NFS_V4_1 */
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+
+static ssize_t
+localio_show(struct kobject *kobj, struct kobj_attribute *attr,
+				char *buf)
+{
+	struct nfs_server *server = container_of(kobj, struct nfs_server, kobj);
+	bool localio = nfs_server_is_local(server->nfs_client);
+	return sysfs_emit(buf, "%d\n", localio);
+}
+
+static struct kobj_attribute nfs_sysfs_attr_localio = __ATTR_RO(localio);
+
+static void nfs_sysfs_add_nfs_localio_server(struct nfs_server *server)
+{
+	int ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_localio.attr,
+				       nfs_netns_server_namespace(&server->kobj));
+	if (ret < 0)
+		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+			server->s_sysfs_id, ret);
+}
+#else
+static inline void nfs_sysfs_add_nfs_localio_server(struct nfs_server *server)
+{
+}
+#endif /* IS_ENABLED(CONFIG_NFS_LOCALIO) */
+
 void nfs_sysfs_add_server(struct nfs_server *server)
 {
 	int ret;
@@ -405,6 +432,7 @@ void nfs_sysfs_add_server(struct nfs_server *server)
 			server->s_sysfs_id, ret);
 
 	nfs_sysfs_add_nfsv41_server(server);
+	nfs_sysfs_add_nfs_localio_server(server);
 }
 EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
 
-- 
2.44.0


