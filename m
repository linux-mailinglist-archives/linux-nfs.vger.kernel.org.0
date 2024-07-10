Return-Path: <linux-nfs+bounces-4763-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA3392CFAF
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 12:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3403C1F22AF3
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B418FDCF;
	Wed, 10 Jul 2024 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="j6W+IKCc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546418FC99
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608020; cv=none; b=DHuca/ulY4sw3yG++D4iFb//YjrxZ5DP5i6K2WJohuzRgdPKOeLMeRwYAGyRpux5rAxCG7xuUEV05YHla6BLG6WMEw6qfioAe6AMyX5JHjcet10wsL7Uvjau8oq/Us2+8Ia5SNZF9rx5JPQDOcwPcXjZAigpzMw0OrzRORUfzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608020; c=relaxed/simple;
	bh=Xx/77QXmQOzbWW+RKoawBCq44/4/6sBILOL7vzUmlW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKnZ5RcGL3Z6kd0Vso3OpRwAI6jNaPZAR/uV7fk0pHvTR7WprALGKxIjvg05RsbgCIROpU2ViNpgnhQwW33EHcGJ5bBe1iTmerphOpL9UYV9tC8XTE+UFi5GBgzPuQokojsspQecxa4MFivWSCGz75gJLafcRKxaTTCvi7y9jq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=j6W+IKCc; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1720608017; x=1752144017;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xx/77QXmQOzbWW+RKoawBCq44/4/6sBILOL7vzUmlW0=;
  b=j6W+IKCcFU5BGW5zVsCW1CwDNZ/+Nm5YE5+RtIkydxYgsE3hl/Ydwpn7
   Ia8KVcXGW/SvQ3jt575eqCjCytr8bUydacIuoQ2twUAt3IcOjGqjqXhTD
   Q0cKspDkI8CPrC5brWfDMPHR4ueTl5CHaX8s0vNqxGaHooHTOwJdIrxXn
   +MbDnHEE4dyXQHXToUJssw3FxWrKloo9WbHuSb0WCIUo+iGpn/MKhq6YO
   8l1pWqf/38h0SSkgbiXIbhI9FOnuhEIcB23Sf/8VrFz4mOKanSRB5fBF9
   GD+evcqPkotsnoQVKVTWz142KafAPPJvgmjywjYbZUobjmdALzpsqQJLv
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="165756246"
X-IronPort-AV: E=Sophos;i="6.09,197,1716217200"; 
   d="scan'208";a="165756246"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 19:39:05 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 840C3D6EF1
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 19:39:03 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D2FFCD3F2D
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 19:39:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6314A20086EB9
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 19:39:02 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C86721A0002;
	Wed, 10 Jul 2024 18:39:01 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3] NFSv4: add tracepoint to referral events
Date: Wed, 10 Jul 2024 18:38:30 +0800
Message-ID: <20240710103854.1387-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28520.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28520.007
X-TMASE-Result: 10-2.585900-10.000000
X-TMASE-MatchedRID: Dkfyeyxtv0b/R1NSMc2qCR1kSRHxj+Z5G3SoAWcU42VL/3rQmWrTBugo
	SvaKsl/kIvrftAIhWmLy9zcRSkKatYrOQQ708E7z0wmR34xRQc8JHI5dPooIdZsoi2XrUn/J8m+
	hzBStansfRoCwBzgRYidET58jp62S5PD2NeNcxCxxXYgfayWQBSLVwocV5DmjG7OgHVO6QHHc2X
	bP1mOqXndVOi67bPLqk8kCvv06YY5JvVA3dgEBC3agksmjhmHVwGC8e6520fKw0PJt06oJaHpaQ
	l5xviY7wxgWdRvK9Un9g+oMf9KM6Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Trace new locations when hitting a referral:

  nfs4_referral_location: referral_host=192.168.122.210 referral_path=/share12

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
v3:
    fit one parameter style of __assign_str

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
index 4de8780a7c48..ad0af7addcb0 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2600,6 +2600,31 @@ DEFINE_NFS4_XATTR_EVENT(nfs4_setxattr);
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
+			__assign_str(referral_hostname);
+			__assign_str(referral_path);
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


