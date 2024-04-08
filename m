Return-Path: <linux-nfs+bounces-2713-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C1789BC53
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 11:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0869F1C214AF
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD4C4C600;
	Mon,  8 Apr 2024 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Ms3bJDWg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C0481DF
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569937; cv=none; b=Q0H+y3VDUPz5yEsP0R31rqrgNFtrVGw+wBkomVg/Vqfr9qm97ZUq1GCABwTT4Vcp0JacnDJ2xY7qcbwiIpMCQn98rcypWV4mIrpKeuFmEQqIpESbs2P+TSWJ+eMpUeRSjv0ncs71GMKdXEuMN+ZDck9OMnZ8jwzU8ZPgZQ0fhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569937; c=relaxed/simple;
	bh=0K1sVZqkNG5KfeQKSfWlJkbz5GY99ktd/Y2YWdRL7qU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ocl/rQnsF7jnQwhfC48aukeSVq+Fi4cvKTR7k0rxoBRpDtUCI6+1+UqDqudiF7F5dkk4glhyY6o665HgjWCCZV78ZoP594aNkXqmR/Mrq43sdqhaXduDPv5ZY/W3AC4PrJKj8j26LVBBujz87sRIOScLkJ55K1t/u1o6TxPlglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Ms3bJDWg; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712569934; x=1744105934;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0K1sVZqkNG5KfeQKSfWlJkbz5GY99ktd/Y2YWdRL7qU=;
  b=Ms3bJDWgF7ikVZTfsdrWjIfmNy+/AiTufwoONsbHZtQk1zoa4sYprRUC
   Qi12N/pGRggZLRV/YMJCuZdU5rWWIMgmXBPLcNnCcUcJfNqiUKNmTy9rC
   xlYmX5s4LqcRq2EmKBrbVYTmNFccOgYlhP0SS/t6FnB7i0jkSdVwDN5eY
   U614DGgogGhIfwJbK/ojcwEXEaAYZ1G+rZpLKjAFJJF2MsvBEccKDGAbH
   S60ix3Us6zVlv8IsKcvKiYA+ScBgOUUG99RfdaXAxVsqosaiIGGYOKDbR
   RD7xWtjEWWFgvQ3Zf5CFZmf0Limn16acV+CZCaXZrc3LDgYx6QWL4rC3V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="154807439"
X-IronPort-AV: E=Sophos;i="6.07,186,1708354800"; 
   d="scan'208";a="154807439"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 18:51:03 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7C2F0D3EAC
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 18:51:00 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id B6EF7E615E
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 18:50:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 48A806BEFD
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 18:50:59 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id AE2141A0002;
	Mon,  8 Apr 2024 17:50:58 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: add tracepoint to referral events
Date: Mon,  8 Apr 2024 17:50:52 +0800
Message-Id: <20240408095052.367-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28304.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28304.006
X-TMASE-Result: 10-1.953800-10.000000
X-TMASE-MatchedRID: BrKfIHwbYjX/R1NSMc2qCR1kSRHxj+Z5CZa9cSpBObnAuQ0xDMaXkH4q
	tYI9sRE/DNbgKEt9XPNiGZRBxfTmk2XCD9DZzMgRngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIcSq
	bxBgG0w4pr5H/EtyHO9teO1ApRBQQR5rzQkkyuzxDQbS48nfx6oZUwBcOvlGVG6OqA9Pr9t2hx5
	5pwnP3VY7MlCyFh+/O1/5CsusGKIFbjBuldNvkMkoq97WSHdFjfupJaud1uZCfRs6uIbkFVw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Trace new locations when hitting a referral.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
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
index 10985a4b8259..165c4dc7b5c7 100644
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
+			__assign_str(referral_hostname, hostname)e
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


