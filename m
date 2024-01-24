Return-Path: <linux-nfs+bounces-1309-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAA983AC6F
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 15:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAE51C222E3
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FCC15B1;
	Wed, 24 Jan 2024 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Ql93fbT3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB932F26
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107098; cv=none; b=ANEVjwgSuIQXJc5xl+84XZcvQUxJMiVNkdwSwms5hsUgT0RY9EVYB5/CxQoAcLnw2I0e0QSHBSivPTzwZXeyfb2ic/uwekI/bMf7hdSdFrJ/yFEPzRZxuNRei2xVqUN7feTQ7ujHWrrSWuL4Ua7bAxOK52b8d4J9Ul9/Jb/Zobs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107098; c=relaxed/simple;
	bh=IQ/FqyCbPKxo/AgaIhIpn2ZB53TEaDquUaXJQQDvtdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gu+t54QIUK5/MyCqCSmTfyMUhCQ7lA737/8EsB//QCdoEE/biubW/izQgpYFC5FoZSrcMsNBlsUBh/KAF9ZUvSBThFsLvd+ChspYLaZhtb0KkyR69kd0JZKioU57z+N91akguHagX2C6X6t1tIxXIFSc5PWPZOl5r6q0W7JtQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Ql93fbT3; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706107096; x=1737643096;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IQ/FqyCbPKxo/AgaIhIpn2ZB53TEaDquUaXJQQDvtdA=;
  b=Ql93fbT35Fy7SPm081dKo6BsghBIG0jgeHKA22jEgVnE6q08WqbYqQN1
   +QzISZwK4uGjb9pJnjDvYURZPALAFx5Keuy5n+nK+wAfNKZGNFz/AL2Sv
   TPzvQ2ctzdwUd98FJRh7lpaM0VTA5zzdymHEVF1OtiiczWuW0S9e5/FOw
   rnRV4eeMrFgsU5D9J+PPasbnH6AkUD0Xl3Ldcv1dGqDMY7KKO/PYiu9X1
   xsf9ip2YFJvjUCet631lUMg/gPfT5zR4vvJpyN/PWr83dCkDmct6aC9c1
   o6vGU/id+7CVl2M6g70U/X9wit1IsGMcEaYJO8oV1bChiyKJroU/Gszo9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="146986110"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; 
   d="scan'208";a="146986110"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:38:13 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8465F7FB35
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 23:38:10 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id BE766D947F
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 23:38:09 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 50D4F220E6C
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 23:38:09 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 9AF9B1A006C;
	Wed, 24 Jan 2024 22:38:08 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: fix regression in handling of fsc= option in NFSv4
Date: Wed, 24 Jan 2024 22:37:55 +0800
Message-Id: <20240124143755.2184-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28140.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28140.000
X-TMASE-Result: 10--4.499100-10.000000
X-TMASE-MatchedRID: /2NGPvLZz+PkWQ892nFTzCrLqyE6Ur/jwTlc9CcHMZerwqxtE531VIpb
	wG9fIuITw5o0gj8M3b37fVAndB8aViwZCE2dUtlYSs47mbT7SAT0swHSFcVJ6GxllyQzRX3Qhg8
	F91XO0aLi8zVgXoAltvbGdFF9BGjiC24oEZ6SpSmcfuxsiY4QFHIJlqcLJLHCSS2UtW1r90oqJh
	PzjON6t5LRtUqkApsbS35y6bF9n2q0aUmgb12DMsn5WA5NiYCp2ZpbPDL+2yh7x/Gn9ycbupsNE
	GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Setting the uniquifier for fscache via the fsc= mount
option is currently broken in NFSv4.

Fix this by passing fscache_uniq to root_fc if possible.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 fs/nfs/nfs4super.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index d09bcfd7db89..669d7f65ef9c 100644
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
+		param_fsc.string = kmalloc(len, GFP_KERNEL);
+		if (param_fsc.string == NULL) {
+			put_fs_context(root_fc);
+			return -ENOMEM;
+		}
+		param_fsc.size = snprintf(param_fsc.string, len, "%s", ctx->fscache_uniq);
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


