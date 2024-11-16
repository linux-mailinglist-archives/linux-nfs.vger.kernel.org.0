Return-Path: <linux-nfs+bounces-8028-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5C79CFC45
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 02:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4091F24D2B
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 01:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D22AEE9;
	Sat, 16 Nov 2024 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2wUIkW9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E64190662
	for <linux-nfs@vger.kernel.org>; Sat, 16 Nov 2024 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721283; cv=none; b=h7zfzGz1fIHdHB+vighO5eryWjUMNDqpbXcDShAyFifrnm1XzmVbTGFBKHEUvUcyCCU08Q9abjFibrRi0sFUg3JGNHqmmdETnnUbVsdRnKnpTg9xWhuHRha9pSUrq77Ff4bU0785c3MVstV/kIUzYmDB7uHNbH+MF5AjyKA8XqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721283; c=relaxed/simple;
	bh=AacpAPmBr5sqXM+0ofSneW3SXh3g2K8/DieatZa8mr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tm0oZNMSF2Je8/bHfQDelw6Maif+q8SgJN4kbuLd1LTnbebslCQ7lv4AukGZ+7pkDdWx9hWXKmntmDZ/9X1K9d9ydbCOYI8OenYTEiJ5mu2ij7E6llCpiYh1dhYpCZ6UPFXTNGS33DNEX2X0R+gN6mg/HTm6FiPB5PCGEwbDcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2wUIkW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09951C4CECF;
	Sat, 16 Nov 2024 01:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731721283;
	bh=AacpAPmBr5sqXM+0ofSneW3SXh3g2K8/DieatZa8mr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e2wUIkW99EwxW/kHPTylc8UGm20WuAqW9nDOfzBY+/0yw1Mqy+HfHGXMYZ+QIqzo8
	 3uHydEKJkzimpodQ1g+hOG/mV6Mss6HRFjsV8tS5y4a03BgmoK7g40ilRfKxdO0+cZ
	 GvgUn+774URV8Qnu/VLOZxd6bdFqGJED/9B2nkMedbpNIaEidTGUGXMsUiXoR9hsiN
	 txj4Ih6vBYkTPlD3UDlat4ldQNUKHojiRSpI/VdN9lpFqx0Lk8RNbwYkLdKB1J008B
	 ZOEGBe9WcgDTFAd0fO1IzwhAWxMdVfpu/x2J9N2eiqLozro4beGE8Yy9WcHnWqCd9z
	 yCVFK70kM24pA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v3 11/14] nfs_common: add nfs_localio trace events
Date: Fri, 15 Nov 2024 20:41:03 -0500
Message-ID: <20241116014106.25456-12-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241116014106.25456-1-snitzer@kernel.org>
References: <20241116014106.25456-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nfs_localio.ko now exposes /sys/kernel/tracing/events/nfs_localio
with nfs_localio_enable_client and nfs_localio_disable_client events.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs_common/Makefile        |  3 +-
 fs/nfs_common/localio_trace.c | 10 +++++++
 fs/nfs_common/localio_trace.h | 56 +++++++++++++++++++++++++++++++++++
 fs/nfs_common/nfslocalio.c    |  4 +++
 4 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 fs/nfs_common/localio_trace.c
 create mode 100644 fs/nfs_common/localio_trace.h

diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
index a5e54809701e3..c10ead273ff2c 100644
--- a/fs/nfs_common/Makefile
+++ b/fs/nfs_common/Makefile
@@ -6,8 +6,9 @@
 obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
 nfs_acl-objs := nfsacl.o
 
+CFLAGS_localio_trace.o += -I$(src)
 obj-$(CONFIG_NFS_COMMON_LOCALIO_SUPPORT) += nfs_localio.o
-nfs_localio-objs := nfslocalio.o
+nfs_localio-objs := nfslocalio.o localio_trace.o
 
 obj-$(CONFIG_GRACE_PERIOD) += grace.o
 obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
diff --git a/fs/nfs_common/localio_trace.c b/fs/nfs_common/localio_trace.c
new file mode 100644
index 0000000000000..7decfe57abebb
--- /dev/null
+++ b/fs/nfs_common/localio_trace.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Trond Myklebust <trond.myklebust@hammerspace.com>
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+#include <linux/nfs_fs.h>
+#include <linux/namei.h>
+
+#define CREATE_TRACE_POINTS
+#include "localio_trace.h"
diff --git a/fs/nfs_common/localio_trace.h b/fs/nfs_common/localio_trace.h
new file mode 100644
index 0000000000000..4055aec9ff8dc
--- /dev/null
+++ b/fs/nfs_common/localio_trace.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Trond Myklebust <trond.myklebust@hammerspace.com>
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM nfs_localio
+
+#if !defined(_TRACE_NFS_COMMON_LOCALIO_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NFS_COMMON_LOCALIO_H
+
+#include <linux/tracepoint.h>
+
+#include <trace/misc/fs.h>
+#include <trace/misc/nfs.h>
+#include <trace/misc/sunrpc.h>
+
+DECLARE_EVENT_CLASS(nfs_local_client_event,
+		TP_PROTO(
+			const struct nfs_client *clp
+		),
+
+		TP_ARGS(clp),
+
+		TP_STRUCT__entry(
+			__field(unsigned int, protocol)
+			__string(server, clp->cl_hostname)
+		),
+
+		TP_fast_assign(
+			__entry->protocol = clp->rpc_ops->version;
+			__assign_str(server);
+		),
+
+		TP_printk(
+			"server=%s NFSv%u", __get_str(server), __entry->protocol
+		)
+);
+
+#define DEFINE_NFS_LOCAL_CLIENT_EVENT(name) \
+	DEFINE_EVENT(nfs_local_client_event, name, \
+			TP_PROTO( \
+				const struct nfs_client *clp \
+			), \
+			TP_ARGS(clp))
+
+DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_localio_enable_client);
+DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_localio_disable_client);
+
+#endif /* _TRACE_NFS_COMMON_LOCALIO_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE localio_trace
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index cfb61871fb1e0..0decc2fe154c8 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -12,6 +12,8 @@
 #include <linux/nfs_fs.h>
 #include <net/netns/generic.h>
 
+#include "localio_trace.h"
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("NFS localio protocol bypass support");
 
@@ -141,6 +143,7 @@ void nfs_localio_enable_client(struct nfs_client *clp)
 
 	spin_lock(&nfs_uuid->lock);
 	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+	trace_nfs_localio_enable_client(clp);
 	spin_unlock(&nfs_uuid->lock);
 }
 EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
@@ -199,6 +202,7 @@ void nfs_localio_disable_client(struct nfs_client *clp)
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
 		/* &clp->cl_uuid is always not NULL, using as bool here */
 		nfs_uuid = &clp->cl_uuid;
+		trace_nfs_localio_disable_client(clp);
 	}
 	spin_unlock(&clp->cl_uuid.lock);
 
-- 
2.44.0


