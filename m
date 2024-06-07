Return-Path: <linux-nfs+bounces-3578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563B98FFE5D
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 10:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB771C209BB
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D2E405F8;
	Fri,  7 Jun 2024 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kKeXkgyA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA615B122
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750205; cv=none; b=RGn0LtEHHbK+WUgFctKKJ39qo9NJGRNJHHKE9xiFAtypYnaLNaanXzZ2tmBqqIZsMjSoYHCD0yD0eTwO1uqTNgi7tHaPRl4PJpcmqj0sfzop8THPWhQu5nL0vlf3c/u6xiPsLuvsUBC0bpjqJtNvObZpLcyI/AVS3Epib/p4CNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750205; c=relaxed/simple;
	bh=9PTCDMaqFCUKaQnfC5Jb6CwM3fxs8VWiIBKXxxHg4xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gUW6pJJ+tyGWHJOprNK8dgoR2ipsM5RR09umIhHMI5zAWkHsOMENEX6lw33ShpWGfucp96omIMBY7ZqrUsCQZ9wI49948tNldAt5TRfQkZuJ80stwQMvCFg1fVrWkfc59FCN1s8qEivjH7TXipjdq+D/LNfpzIo+xIAAFdKylSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kKeXkgyA; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717750203; x=1749286203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9PTCDMaqFCUKaQnfC5Jb6CwM3fxs8VWiIBKXxxHg4xQ=;
  b=kKeXkgyAFOrgKbVwHNLl7Fh5sZy/JGrRZP0tQrvivlL0ZT1hEp4Z7KXq
   6KtvoW3VkkMUC40r+NffK3BK/7uDSss5mYEz7/bpXG0jNXKecfxvSeM5B
   MfNZDDWk+SEil2a7zaYoaUInrtwic78ogpMG4jHIfcl98zMp4v6GKlW4+
   RqOITOZIMJ+U0vCavC36cvMuCssVzZH5hkkmjTWtM8uv9Z3e0qw3ogjKa
   SROsnHomMySoKIDrqJTiOOGgF4EBI/sSF639WAeGTbz1XCDxK3Sx7JlgI
   ZkIv2AU7pXMg8ewYoiKsTKmXMif0rqBdiN03q4vjlAmSvb+dKgrsu0SdY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="141165594"
X-IronPort-AV: E=Sophos;i="6.08,220,1712588400"; 
   d="scan'208";a="141165594"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 17:48:51 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0075BCD6DE
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 17:48:49 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3397CD50BE
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 17:48:48 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id BB1EC2008389C
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 17:48:47 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 46F9D1A000A;
	Fri,  7 Jun 2024 16:48:47 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: add new nfs3 acl tracepoint events
Date: Fri,  7 Jun 2024 16:48:40 +0800
Message-Id: <20240607084840.1890-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28436.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28436.006
X-TMASE-Result: 10-4.865300-10.000000
X-TMASE-MatchedRID: SzbEz7SZt2tSuJfEWZSQfBqkhv3OdF4DKQNhMboqZlo6FHRWx2FGsL8F
	Hrw7frluf146W0iUu2tdGdXpDccA9LqIXLlnBtioI0cHLI6lhgJhv+ctX+VuT8SiwizsgluQADP
	a8EfcrDMG2glyrVARq8DGpkv2rssQEEBjOlnEA/yzRPQ8T4oe5VK6+0HOVoSo//6LNRWr/saWao
	DgyV83tb/GXUjOHS9G7Gwv1cOg4ZMfE8yM4pjsDwtuKBGekqUpnH7sbImOEBTfCtYBHXfk6fSXj
	GCvqMXR/FNSE0kur3criNHOiluwT2D6UXCckFs8RlcppTO0MrDnbq2/czlD9u0o0CQI3p6Gcj80
	3EtJ02abDRBqS2n66yzP5xAyz9Oenvkw4sh/+PcMX5CwH5DTUmgGZNLBHGNe
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Add some new tracepoints to the NFSv3 acl events

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 fs/nfs/nfs3acl.c  |  3 +++
 fs/nfs/nfstrace.c |  2 ++
 fs/nfs/nfstrace.h | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index 18d8f6529f61..5c5c1e1c07f8 100644
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
+	trace_nfs3_get_acl(inode, status);
 	dprintk("NFS reply getacl: %d\n", status);
 
 	/* pages may have been allocated at the xdr layer. */
@@ -287,6 +289,7 @@ int nfs3_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		acl = alloc;
 	}
 	status = __nfs3_proc_setacls(inode, acl, dfacl);
+	trace_nfs3_set_acl(inode, status);
 out:
 	if (acl != orig)
 		posix_acl_release(acl);
diff --git a/fs/nfs/nfstrace.c b/fs/nfs/nfstrace.c
index 5d1bfccbb4da..c6cf133b8853 100644
--- a/fs/nfs/nfstrace.c
+++ b/fs/nfs/nfstrace.c
@@ -13,3 +13,5 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_fsync_enter);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_fsync_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_xdr_status);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_xdr_bad_filehandle);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nfs3_get_acl);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nfs3_set_acl);
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 1e710654af11..d0d8b83c665a 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -161,6 +161,45 @@ DEFINE_NFS_INODE_EVENT(nfs_readdir_force_readdirplus);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_readdir_cache_fill_done);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_readdir_uncached_done);
 
+DECLARE_EVENT_CLASS(nfs3_acl_template,
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
+			show_nfs4_status(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle
+		)
+);
+
+DEFINE_EVENT(nfs3_acl_template, nfs3_get_acl,
+		TP_PROTO(const struct inode *inode, int error),
+		TP_ARGS(inode, error));
+DEFINE_EVENT(nfs3_acl_template, nfs3_set_acl,
+		TP_PROTO(const struct inode *inode, int error),
+		TP_ARGS(inode, error));
+
 TRACE_EVENT(nfs_access_exit,
 		TP_PROTO(
 			const struct inode *inode,
-- 
2.39.1


