Return-Path: <linux-nfs+bounces-1615-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10660843B73
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 10:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9815E28D070
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D4069979;
	Wed, 31 Jan 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KAMxcjd1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D06994D
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694613; cv=none; b=QxXnXsNqtAkFoK9C3AYgiELP8lQmzKGVnqRWiyq4fvQq5jWzYLqbWVSIArQCKJtbq/mDVIn2IbAdJWDqwPKIGIn5anrkxo9x8SvlDt7bdJpnhvmG4jf1IC4Gj1gUxOb5H1TyXvILFFH/AH9SJotk4Jo4MWek5P0U536labrTX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694613; c=relaxed/simple;
	bh=BGS9skEt6y39ept4itZ7sKWyjGifeORqBgSwhkqBZdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V+TbQew/C8BNJvAmpbVeCew0gru3vsYmnW9hFghp72n0i1B3QX52o0ABuD5/dA3BPruQ+bxoht/A21P89XCx1taPl5nPK5I9qFr3jaDF0gCEAGqduDvdoBjzmPuxplpTz9Cn48WSxz+zdBkiwnxViNkmE5lIc5nddIdx49FlvSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KAMxcjd1; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706694610; x=1738230610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BGS9skEt6y39ept4itZ7sKWyjGifeORqBgSwhkqBZdo=;
  b=KAMxcjd16bc9T7doF6NL0xb/w0utYkFAwzsa8xlmTJpllCZRBAnIauNS
   40fpszHhzr3Gl85HyLWwtggio9e9m47JbvWGtfVXLToHnFYD+B83v/9Q6
   Dk60XcJXUN2eJtBDmWngwran3RDJ6b9/V2I2wMt1zg67c0CYJ3stK+H/6
   rXH5cmPmkF79oOB12o9R/b2hCRFSZrVG0aMlCR3VKDUdHUNMZZtqosTfI
   crdnUpa4WBaj1BzfuquKxcODC6Obw7vzfvqjKqMtVdbK6idSRTI+Lloal
   N44g82woW0m3LBDW9499M+YCW0hzR/pVlCG2J32Dqzom06taIxBU0q9lh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="149604613"
X-IronPort-AV: E=Sophos;i="6.05,231,1701097200"; 
   d="scan'208";a="149604613"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 18:50:01 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id EDA0C2CFFF
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 18:49:58 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3D827D9682
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 18:49:58 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B302B1EB1DD
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 18:49:57 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 03B141A006A;
	Wed, 31 Jan 2024 17:49:56 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Dave Wysochanski <dwysocha@redhat.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v3] nfs: fix regression in handling of fsc= option in NFSv4
Date: Wed, 31 Jan 2024 17:49:17 +0800
Message-Id: <20240131094917.850-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28152.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28152.006
X-TMASE-Result: 10--4.499100-10.000000
X-TMASE-MatchedRID: /2NGPvLZz+PkWQ892nFTzCrLqyE6Ur/jjlRp8uau9obAuQ0xDMaXkH4q
	tYI9sRE/BRj5e39v/eENXG08J6BRwqG3Y3gyPHARa87CDXaKRVIYH39vFLryE02SImGKAVGghg8
	F91XO0aLi8zVgXoAltvbGdFF9BGjiC24oEZ6SpSmcfuxsiY4QFEUjDbKh5t3/7QhquSa7obcntU
	6WedHk9NyzDBT9zzBvdm9TF8ARmCjWDz0ty/OZ5Ga+HLkmZAaEAfBGL8QWtAFspF+8SiJEGZsNE
	GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Setting the uniquifier for fscache via the fsc= mount
option is currently broken in NFSv4.

Fix this by passing fscache_uniq to root_fc if possible.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
v3:
    properly set param_fsc.size
v2:
    use kmemdup_nul instead of snprintf

 fs/nfs/nfs4super.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index d09bcfd7db89..8da5a9c000f4 100644
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
+		len = strlen(ctx->fscache_uniq);
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


