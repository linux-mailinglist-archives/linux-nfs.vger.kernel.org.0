Return-Path: <linux-nfs+bounces-4789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8F92E0F1
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 09:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3562B230C7
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A0084DFF;
	Thu, 11 Jul 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JIzon87R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7614885D
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683228; cv=none; b=ujNWI9KoYnyvNMDEPYhheo+xST0H3ZdV9YSnKm2SRmCrokGHHSmehb+vZnTUv0NeX+sohCxIkgndl90YpwToCb6dQnrgk4O/UR/9+hncaDmYkzdtvm5mlTe7+s1fpfrEL2MgbXzS2dOIZE197NqDALGmUFuYmUbxRxsgJMP2LRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683228; c=relaxed/simple;
	bh=ivaashZ1fMidgl506PSuSJZ3Iz/d9wDQQb+FpQhDIis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhdZ09O7BDxJgwMGblv+fVi4ZDewcxg/muTF+0IkP3WZaNRXJDA5zNuTz9/MUodTEpHkfP/NCHOEGDHnOx54GhWtzMzaD+p+/ohw+/V3bPqnwcD3mU8YGKQqPsGlH6KT3ADGfko9QKRg6rF5LYU6QEM5MaS5x0srw451PKFXqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JIzon87R; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1720683226; x=1752219226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ivaashZ1fMidgl506PSuSJZ3Iz/d9wDQQb+FpQhDIis=;
  b=JIzon87RCkPj+7/fyLy547/4OsfsuSM/iDiBpOhNu7rKuOwLHfAiFT52
   0DhYxlm/3Zvh2rCn4yhooad5irb8Qz/+1zvdv4Aww9OyQQI8wpibGIduY
   RtZQkvjOTbeDa9mb28Wck5LDIvpE9vtYaFOGtu68+/8JxDUDV6lcDGABH
   NFr70477Hf9WNd349ptnavs5K4gZMiNMWdt2Z17CmgHFzianjsJ2M0FQj
   keA5BJ+Mru0AKpWnq07KFWAIb77Y2kWhsIzoTq9GYtOTjQLI+9OjO20I/
   EnTIguCDr+ibxnK4Qy2NYF/YxhbvHvBcUetBwZcCCgBgfQmix4uu4Rp+O
   A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="166655629"
X-IronPort-AV: E=Sophos;i="6.09,199,1716217200"; 
   d="scan'208";a="166655629"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 16:32:33 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id D116CD6EEE
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 16:32:30 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2281E103FB
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 16:32:30 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9F2CF20088EAB
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 16:32:29 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1D6391A000A;
	Thu, 11 Jul 2024 15:32:29 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFS: add new nfs3 acl tracepoint events
Date: Thu, 11 Jul 2024 15:32:04 +0800
Message-ID: <20240711073219.1700-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28522.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28522.005
X-TMASE-Result: 10-4.825800-10.000000
X-TMASE-MatchedRID: GQw6Xh/XS6VSuJfEWZSQfBqkhv3OdF4DRealVAhocE8H8UzOewTxw+go
	SvaKsl/kIvrftAIhWmLy9zcRSkKatbhPu4tF1R7BxDiakrJ+SpmIrmqDVyayvzRMpxC5/1NGKlY
	wxaYDzXfwBEJy3W9mKc5YfYf/8jQKqJ6c6lqtTQq6kMgL3jbYOiUnLzk1+IxzuBsk5njfgGxSOn
	NCwes0U1eXFQs0t/lwbbGQkBXBwiIYB2fOueQzjxRFJJyf5BJew5ug89ZVKMv6C0ePs7A07Z5Vb
	9l0vnaPD/2sHMrIIKXf6qT6GIAXHnsx04bO7xBTKo8wIRWEGYCh66Izx60/YTTxnZ1qEzJM5kNj
	fmFp023xFlPsT4ksNaNbce9ePV0lhpPsVGqnTA8BxCsB8GHr28FEsV4fo4lIJMMP4MGO4TA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Add some new tracepoints to the NFSv3 acl events

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
v2:
  rename trace_nfs3_[sg]et_acl to trace_nfs_[sg]et_acl
  use show_nfs_status instead of show_nfs4_status

 fs/nfs/nfs3acl.c         |  3 +++
 fs/nfs/nfstrace.c        |  2 ++
 fs/nfs/nfstrace.h        | 39 +++++++++++++++++++++++++++++++++++++++
 include/trace/misc/nfs.h |  3 +++
 4 files changed, 47 insertions(+)

diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index 18d8f6529f61..96fb0c8f9d7a 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -9,6 +9,7 @@
 
 #include "internal.h"
 #include "nfs3_fs.h"
+#include "nfstrace.h"
 
 #define NFSDBG_FACILITY	NFSDBG_PROC
 
@@ -96,6 +97,7 @@ struct posix_acl *nfs3_get_acl(struct inode *inode, int type, bool rcu)
 		nfs3_prepare_get_acl(&inode->i_default_acl);
 
 	status = rpc_call_sync(server->client_acl, &msg, 0);
+	trace_nfs_get_acl(inode, status);
 	dprintk("NFS reply getacl: %d\n", status);
 
 	/* pages may have been allocated at the xdr layer. */
@@ -287,6 +289,7 @@ int nfs3_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		acl = alloc;
 	}
 	status = __nfs3_proc_setacls(inode, acl, dfacl);
+	trace_nfs_set_acl(inode, status);
 out:
 	if (acl != orig)
 		posix_acl_release(acl);
diff --git a/fs/nfs/nfstrace.c b/fs/nfs/nfstrace.c
index 5d1bfccbb4da..c3d882769ef2 100644
--- a/fs/nfs/nfstrace.c
+++ b/fs/nfs/nfstrace.c
@@ -13,3 +13,5 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_fsync_enter);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_fsync_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_xdr_status);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_xdr_bad_filehandle);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_get_acl);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_set_acl);
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 1e710654af11..92fa46a9b780 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -161,6 +161,45 @@ DEFINE_NFS_INODE_EVENT(nfs_readdir_force_readdirplus);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_readdir_cache_fill_done);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_readdir_uncached_done);
 
+DECLARE_EVENT_CLASS(nfs_acl_template,
+		TP_PROTO(
+			const struct inode *inode,
+			int error
+		),
+
+		TP_ARGS(inode, error),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(unsigned long, error)
+		),
+
+		TP_fast_assign(
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->error = error < 0 ? -error : 0;
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x",
+			-__entry->error,
+			show_nfs_status(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle
+		)
+);
+
+DEFINE_EVENT(nfs_acl_template, nfs_get_acl,
+		TP_PROTO(const struct inode *inode, int error),
+		TP_ARGS(inode, error));
+DEFINE_EVENT(nfs_acl_template, nfs_set_acl,
+		TP_PROTO(const struct inode *inode, int error),
+		TP_ARGS(inode, error));
+
 TRACE_EVENT(nfs_access_exit,
 		TP_PROTO(
 			const struct inode *inode,
diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
index 7b221d51133a..5ed59c871147 100644
--- a/include/trace/misc/nfs.h
+++ b/include/trace/misc/nfs.h
@@ -51,6 +51,9 @@ TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
 		{ NFSERR_IO,			"IO" }, \
 		{ NFSERR_NXIO,			"NXIO" }, \
 		{ ECHILD,			"CHILD" }, \
+		{ ENOTSUPP,			"ENOTSUPP" }, \
+		{ EPFNOSUPPORT,			"EPFNOSUPPORT" }, \
+		{ EPROTONOSUPPORT,		"EPROTONOSUPPORT" }, \
 		{ NFSERR_EAGAIN,		"AGAIN" }, \
 		{ NFSERR_ACCES,			"ACCES" }, \
 		{ NFSERR_EXIST,			"EXIST" }, \
-- 
2.39.1


