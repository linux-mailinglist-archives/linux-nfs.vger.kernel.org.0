Return-Path: <linux-nfs+bounces-1604-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 224D8842853
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 16:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78F0B284BB
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 15:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB42F605A6;
	Tue, 30 Jan 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="DApbzLQL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE985C67
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629630; cv=none; b=c2XxZ8GbCK7eV5gAZuDkIITozXNhHxemN0qgLKGeWAhcasZhb6fmShh+f6LrFOXX4fKF/oW2GCud1yYkcf+glDGaiO+S1Zg2eZJYl6Jm+vu6fR0Aa9QmX6cXiEhUJH+wlN3cCZqHGLwLJKs0MS1rkSO4tk7AdGa5C4StfeZ8vqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629630; c=relaxed/simple;
	bh=B0h/jOtutN2itpyB8pn0D0FTvUWgZxMB23QZNJN5zts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+/EI6KH1b2mfL79Z5qT2X2CLQ07hdZEEvNHEnds1UB/tZLRURwOvUqh7Mcg9UA2X8R4/6h7zL5Q2TT0Tpcpg4C3oLZn7b678iwu21ucA92nvxSF3r5Feqcoph0+AfeLNvPrDsMVLO/M4Mwsj4WSzl5vY3uVUGyOevXgCFeF4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=DApbzLQL; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706629628; x=1738165628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B0h/jOtutN2itpyB8pn0D0FTvUWgZxMB23QZNJN5zts=;
  b=DApbzLQLax7KpieydhPszS1C26hXOdYH3Vky562o/qpbPWgKIXHZYRG8
   YFYsVk9LvkgocrjZinfbAeFhMJjbJCglFWRtqBuF7NN5jZr7hA8cWZpoQ
   tj5Jpc7K1sfiJI1CZMIiSK+q3fOF0VKwOmv/AUlsB9ZAEsoX/6o3jDtEz
   JBCMZt7efKeueWy9F+88HMRsdo9Ge1fECZFWiErE14/iNZ6ysrxJ66/HI
   KzMbynwZPncD+M2KV8SMRNVcl6wdRQZ58WoXVvw9GI6r80XrBUcRDjS1i
   uEALNT8VqLMHRrwezdd9s7/metg4FSnDR7Imsn6Ak1kTfc8/UCHE4XHqY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="135801515"
X-IronPort-AV: E=Sophos;i="6.05,230,1701097200"; 
   d="scan'208";a="135801515"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:46:59 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 96A28224284
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 00:46:57 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D339D4BF0B
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 00:46:56 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 51B7020099572
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 00:46:56 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 988E31A006B;
	Tue, 30 Jan 2024 23:46:55 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	Dave Wysochanski <dwysocha@redhat.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v2] nfs: fix regression in handling of fsc= option in NFSv4
Date: Tue, 30 Jan 2024 23:46:26 +0800
Message-Id: <20240130154626.741-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28152.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28152.000
X-TMASE-Result: 10--4.499100-10.000000
X-TMASE-MatchedRID: /2NGPvLZz+PkWQ892nFTzCrLqyE6Ur/jwTlc9CcHMZerwqxtE531VIpb
	wG9fIuITw5o0gj8M3b37fVAndB8aViwZCE2dUtlYSs47mbT7SASOVGny5q72hk2SImGKAVGghg8
	F91XO0aLi8zVgXoAltvbGdFF9BGjiC24oEZ6SpSmcfuxsiY4QFCmNzrZdt3ZB+5un2kBt8QlKlO
	WvDaeyj2kHkZ2FTgfkbYF5Cf6QAVAxsBB+jxHytEhTjQKuzHkS1tc8hfQyF27NGlI4NH0wr5sNE
	GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Setting the uniquifier for fscache via the fsc= mount
option is currently broken in NFSv4.

Fix this by passing fscache_uniq to root_fc if possible.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
v2:
    use kmemdup_nul instead of snprintf

 fs/nfs/nfs4super.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index d09bcfd7db89..4a23d9143d5a 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -145,6 +145,7 @@ static int do_nfs4_mount(struct nfs_server *server,
 			 const char *export_path)
 {
 	struct nfs_fs_context *root_ctx;
+	struct nfs_fs_context *ctx;
 	struct fs_context *root_fc;
 	struct vfsmount *root_mnt;
 	struct dentry *dentry;
@@ -157,6 +158,12 @@ static int do_nfs4_mount(struct nfs_server *server,
 		.dirfd	= -1,
 	};
 
+	struct fs_parameter param_fsc = {
+		.key	= "fsc",
+		.type	= fs_value_is_string,
+		.dirfd	= -1,
+	};
+
 	if (IS_ERR(server))
 		return PTR_ERR(server);
 
@@ -168,9 +175,26 @@ static int do_nfs4_mount(struct nfs_server *server,
 	kfree(root_fc->source);
 	root_fc->source = NULL;
 
+	ctx = nfs_fc2context(fc);
 	root_ctx = nfs_fc2context(root_fc);
 	root_ctx->internal = true;
 	root_ctx->server = server;
+
+	if (ctx->fscache_uniq) {
+		len = strlen(ctx->fscache_uniq) + 1;
+		param_fsc.size = len;
+		param_fsc.string = kmemdup_nul(ctx->fscache_uniq, len, GFP_KERNEL);
+		if (param_fsc.string == NULL) {
+			put_fs_context(root_fc);
+			return -ENOMEM;
+		}
+		ret = vfs_parse_fs_param(root_fc, &param_fsc);
+		kfree(param_fsc.string);
+		if (ret < 0) {
+			put_fs_context(root_fc);
+			return ret;
+		}
+	}
 	/* We leave export_path unset as it's not used to find the root. */
 
 	len = strlen(hostname) + 5;
-- 
2.39.1


