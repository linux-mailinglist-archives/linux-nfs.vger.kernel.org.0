Return-Path: <linux-nfs+bounces-2733-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC089DE11
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 17:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603FB1F2AEF6
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 15:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5B012FF80;
	Tue,  9 Apr 2024 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Orqin6a1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5D13AA45
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675087; cv=none; b=m2Q+IQpvsr194tNpPcQDtYGIUoEv08HEaAZkFQ0YS+Fpbch+viTxlomFcH/s/kCefAOibyLZK1RKYcs6bLisWBjsUXwfyB8vAgGlf/nOuDJH5Uni0aJmT2NBC3EfgA6NUZqMNf3I1C2xyUuF2x1d1Po0N8707XrbC3Yp+P/IG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675087; c=relaxed/simple;
	bh=IgSWaltl2r18/a5Lkw2jaYq65Cde60fIBWmAgRiy11s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p+WzTo3wQaIslDSrbhp8NM1L8/phqa/TdP2CVAW7yRINq8Q18HkX3s4GwhBNW3hw5CKYyQi3b/vjXCM9fasLv1QWx/9/5eW/hAr9yU2sMzt60n3ZUTU+jlCl91GkBSrgPI7caJCwLanXdUZLNyE4oHi6nQ638LmTIqyYaCmdtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Orqin6a1; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712675084; x=1744211084;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IgSWaltl2r18/a5Lkw2jaYq65Cde60fIBWmAgRiy11s=;
  b=Orqin6a1jf02NvtqCDN6SLXGZUcoN8IEK1ylW9uUbDjnmfO4SKwLV6DG
   nlHW03XWXTZMSfYsgaoD8Xmr2zmjSS7J8BWRDs+oQUQkywqflRKfrZe09
   NFxm93mvOGfFboKM0WwmRgxH8pZkkO8nHYbpc67Mty9aD6+IVAJg0ugFJ
   jUGPXXgvePcKeLrAaAI/ybHgBuMMKN5oOhzsngvj5qAMIhmaIckuZ66Ol
   xEbCGhyMPr9vfboYq+J5Qt1/lGbgXsBPaZzped78a2Kuuv/2uzwVdb3Ug
   8TloDIMXLEjaE9u8K84UYGtZ7WY7UVxu4I/zBd1zGO/vO2CkGZq3JRixe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="155334004"
X-IronPort-AV: E=Sophos;i="6.07,189,1708354800"; 
   d="scan'208";a="155334004"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 00:04:36 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 39B1DEB4DE
	for <linux-nfs@vger.kernel.org>; Wed, 10 Apr 2024 00:04:34 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6DDBA31AE4
	for <linux-nfs@vger.kernel.org>; Wed, 10 Apr 2024 00:04:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 035871EB429
	for <linux-nfs@vger.kernel.org>; Wed, 10 Apr 2024 00:04:33 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 54C671A0002;
	Tue,  9 Apr 2024 23:04:32 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv4: add tracepoint to referral events
Date: Tue,  9 Apr 2024 23:04:27 +0800
Message-Id: <20240409150427.463-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28308.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28308.000
X-TMASE-Result: 10-2.564800-10.000000
X-TMASE-MatchedRID: a4Q7dosAlP7/R1NSMc2qCR1kSRHxj+Z5TfK5j0EZbytWV9kWJGISDugo
	SvaKsl/kIvrftAIhWmLy9zcRSkKatYrOQQ708E7z0wmR34xRQc8JHI5dPooIdZsoi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNaHyYZQs3SFqRiOEZqLwepvyiipPbUQwzzaR1mrkCr5l4sqGrcM5uA0toC
	Wfz7hxHL3BGRiTEl9VHLH1RtzG1aN2G8uYdF1HEFg5TGo5k/wfFcUQf3Yp/ridO0/GUi4gFb0fO
	PzpgdcEKeJ/HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Trace new locations when hitting a referral.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
v2:
	fix a fat-finger typo

 fs/nfs/nfs4namespace.c |  3 +++
 fs/nfs/nfs4trace.h     | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index 9a98595bb160..fca9fb801bc2 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -24,6 +24,7 @@
 #include "nfs4_fs.h"
 #include "nfs.h"
 #include "dns_resolve.h"
+#include "nfs4trace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
@@ -351,6 +352,8 @@ static int try_location(struct fs_context *fc,
 		p += ctx->nfs_server.export_path_len;
 		*p = 0;
 
+		trace_nfs4_referral_location(ctx->nfs_server.hostname,
+			ctx->nfs_server.export_path);
 		ret = nfs4_get_referral_tree(fc);
 		if (ret == 0)
 			return 0;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 10985a4b8259..d9e3e6560cb9 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2604,6 +2604,31 @@ DEFINE_NFS4_XATTR_EVENT(nfs4_setxattr);
 DEFINE_NFS4_XATTR_EVENT(nfs4_removexattr);
 
 DEFINE_NFS4_INODE_EVENT(nfs4_listxattr);
+
+TRACE_EVENT(nfs4_referral_location,
+		TP_PROTO(
+			const char *hostname,
+			const char *path
+		),
+
+		TP_ARGS(hostname, path),
+
+		TP_STRUCT__entry(
+			__string(referral_hostname, hostname)
+			__string(referral_path, path)
+		),
+
+		TP_fast_assign(
+			__assign_str(referral_hostname, hostname);
+			__assign_str(referral_path, path);
+		),
+
+		TP_printk(
+			"referral_host=%s referral_path=%s",
+			__get_str(referral_hostname),
+			__get_str(referral_path)
+		)
+);
 #endif /* CONFIG_NFS_V4_2 */
 
 #endif /* CONFIG_NFS_V4_1 */
-- 
2.39.1


