Return-Path: <linux-nfs+bounces-2598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FCA895033
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 12:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43C11C22919
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F9F5F873;
	Tue,  2 Apr 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="r2Evgy0j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ACD657AD
	for <linux-nfs@vger.kernel.org>; Tue,  2 Apr 2024 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054059; cv=none; b=P37U9K0GF/Sukm6FfnP6U0aKYotTg60p0JNAzETMUAmggda3iYvz0bfQXyaKXJK3fx5AjA7l2yme7fou1Mnbj4f1+Qjj5b6ZqOA9vMYZoQLbTXhwZQJQ8yH/+Asf89lHaLNZ59gpYEQTK6NU6b4nR5I4k82JdB/GfXT1to1NH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054059; c=relaxed/simple;
	bh=zhT7ol6vQlFSj8JM5F0Vhpoqv4g+uMUONk4hQwFJGFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cvclqX9uCApq3vy6a5+40cX74NCZToaDA8brYO1M+VNPIpSxJF/A17uu06csZtJXSO9hlmwG8mm4+zlh7obdox6tRqkRzn9OlWt0AwZiZJGN29+NTvSMXcNiUTMEv8snAxUDDP7/QvIuENdvpF+f205AmH1qN0xUsxF+sEiF8V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=r2Evgy0j; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712054057; x=1743590057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zhT7ol6vQlFSj8JM5F0Vhpoqv4g+uMUONk4hQwFJGFo=;
  b=r2Evgy0jYrkkHvGkXPrA2PTyMAM+tNNUQXPkP8UbZZZz8zK2GrtabW/o
   zyQSJnOVvKwlI+LIraZLVAbWahUKqXD4/KsU98I8mwcX8CTw1ns8uCdCq
   nbasFoIJ5VwjRm+IGcYiw6y1zzL4/R8qGngSZ0M1IaZCkfkApN2hCYRQm
   KsqJ48ukQzVH2H+dZ/LeY5FPGkNDhc5/0+k/P7oyAo5v15EXDytBgjNsn
   WJlmtOOAQqxzkg7JcfiCWnfOk+DDIwLP1DckYK6UEPrKS5l1/gG3cDJLi
   H1CknS7gs9RHpy7fd58NgaHib3532wBJxweq39OhAyc9cp/oAQ+Sdvd81
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="154356995"
X-IronPort-AV: E=Sophos;i="6.07,174,1708354800"; 
   d="scan'208";a="154356995"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 19:34:09 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A8B65EB427
	for <linux-nfs@vger.kernel.org>; Tue,  2 Apr 2024 19:34:06 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id DA6FBD52BF
	for <linux-nfs@vger.kernel.org>; Tue,  2 Apr 2024 19:34:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 76B4A2007473F
	for <linux-nfs@vger.kernel.org>; Tue,  2 Apr 2024 19:34:05 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D89BB1A000B;
	Tue,  2 Apr 2024 18:34:04 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: make sure lock/nolock overriding local_lock mount option
Date: Tue,  2 Apr 2024 18:33:55 +0800
Message-Id: <20240402103355.256-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28292.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28292.007
X-TMASE-Result: 10--6.228900-10.000000
X-TMASE-MatchedRID: qs/7TikDQGZDfKpRuRX+oB1kSRHxj+Z51QQ6Jx/fflY6FHRWx2FGsL8F
	Hrw7frluf146W0iUu2tU3a+owMO/aoSasxSwyoX84kw0h+3MIJO/XAJUFuWKazKIerHAhfYx/vI
	5ah38pDW90igsQ32uTT6eOS91uJ8FlwV2iaAfSWcURSScn+QSXt0H8LFZNFG7bkV4e2xSge5/on
	MEssYEmKTiJD8nLFhUnTo+nT0zsUQPm6771I51gByFdNnda6Rv
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Currently, mount option lock/nolock and local_lock option
may override NFS_MOUNT_LOCAL_FLOCK NFS_MOUNT_LOCAL_FCNTL flags
when passing in different order:

mount -o vers=3,local_lock=all,lock: 
	local_lock=none

mount -o vers=3,lock,local_lock=all:
	local_lock=all

This patch will let lock/nolock override local_lock option
as nfs(5) suggested.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 fs/nfs/fs_context.c |  2 ++
 fs/nfs/internal.h   |  7 +++++++
 fs/nfs/super.c      | 10 ++++++++++
 3 files changed, 19 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index d0a0956f8a13..ec93306b7e79 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -600,9 +600,11 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		break;
 	case Opt_lock:
 		if (result.negated) {
+			ctx->lock_status = NFS_LOCK_NOLOCK;
 			ctx->flags |= NFS_MOUNT_NONLM;
 			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
 		} else {
+			ctx->lock_status = NFS_LOCK_LOCK;
 			ctx->flags &= ~NFS_MOUNT_NONLM;
 			ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
 		}
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 06253695fe53..dc0693b3d214 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -112,6 +112,7 @@ struct nfs_fs_context {
 	unsigned short		protofamily;
 	unsigned short		mountfamily;
 	bool			has_sec_mnt_opts;
+	int			lock_status;
 
 	struct {
 		union {
@@ -153,6 +154,12 @@ struct nfs_fs_context {
 	} clone_data;
 };
 
+enum nfs_lock_status {
+	NFS_LOCK_NOT_SET	= 0,
+	NFS_LOCK_LOCK		= 1,
+	NFS_LOCK_NOLOCK		= 2,
+};
+
 #define nfs_errorf(fc, fmt, ...) ((fc)->log.log ?		\
 	errorf(fc, fmt, ## __VA_ARGS__) :			\
 	({ dprintk(fmt "\n", ## __VA_ARGS__); }))
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index dc03f98f7616..cbbd4866b0b7 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -901,6 +901,16 @@ static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
 	rpc_authflavor_t authlist[NFS_MAX_SECFLAVORS];
 	unsigned int authlist_len = ARRAY_SIZE(authlist);
 
+	/* make sure 'nolock'/'lock' override the 'local_lock' mount option */
+	if (ctx->lock_status) {
+		if (ctx->lock_status == NFS_LOCK_NOLOCK) {
+			ctx->flags |= NFS_MOUNT_NONLM;
+			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
+		} else {
+			ctx->flags &= ~NFS_MOUNT_NONLM;
+			ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
+		}
+	}
 	status = nfs_request_mount(fc, ctx->mntfh, authlist, &authlist_len);
 	if (status)
 		return ERR_PTR(status);
-- 
2.39.1


