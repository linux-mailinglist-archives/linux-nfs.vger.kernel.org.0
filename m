Return-Path: <linux-nfs+bounces-12238-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F32AD3236
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 11:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175533B7024
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 09:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCED27932B;
	Tue, 10 Jun 2025 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="rfBwQ01p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B614E28B4FC
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548099; cv=none; b=hSiFDQsAlYBQYm2BTttF9Ej9Z9EtCg6C1IqNXuonoNgZpLSrvoKM75iOQN+N9Xmo+AZUihgLs4NKrvsplk26Yxb4inChXXkgvNktY9y0epse4B/Dgz75ReXslVEW4qsuCDV4wX1ZSDjI3qF02RaUcNoqy5oZedaXsKV4PhALrvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548099; c=relaxed/simple;
	bh=YqEbSB3E0Or6JVU50v8Be6SK5a9v3TScXn+6tSeCbpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTwPxdHVYKOqc1aaXzz/9c+zYgUqC54UDWHEWE6GyI6+9Up/Om0ZWVX4zqd1d/fnqx95te3/y1+Dmrwhu61ux526/LP9GIfrAcC91MtRQA25HtccSQZOuFiMBohJmEvonIzxjBvFRCvPjh6f6sYb74BsKVBR8oM4qDQPzopzlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=rfBwQ01p; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-2.desy.de (Postfix) with ESMTP id A1DD613F651
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 11:34:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de A1DD613F651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1749548094; bh=cOZHEHUAa5ADCwmqSCajaiHhbgp8wkDBpGFR+2m+Vx0=;
	h=From:To:Cc:Subject:Date:From;
	b=rfBwQ01pHRNEn5JxMvZ+sDZZQ7d+pqtL0rZmjbucbPgVzfRNtestUuRGE9QJSyqzA
	 Wgb0WGtXMMSvdA0YidCkI8KQEN91ScibKemxBzIwT0+I5HjILxRlWpp6cafTpjPBDH
	 7XM83s+88wOOE32wMZazsXrjYmhlEki/0oaXOUsk=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 95686120043;
	Tue, 10 Jun 2025 11:34:54 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [194.95.239.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 88C0240044;
	Tue, 10 Jun 2025 11:34:54 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id C91AF10A3CD;
	Tue, 10 Jun 2025 11:34:53 +0200 (CEST)
Received: from nairi.desy.de (zitpcx23514.desy.de [131.169.214.185])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id A69DB80046;
	Tue, 10 Jun 2025 11:34:53 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] pnfs: add pnfs_ds_connect trace point
Date: Tue, 10 Jun 2025 11:34:51 +0200
Message-ID: <20250610093451.835089-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

this trace point aims expose pnfs ds connect status

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 fs/nfs/nfs4trace.c |  1 +
 fs/nfs/nfs4trace.h | 26 ++++++++++++++++++++++++++
 fs/nfs/pnfs_nfs.c  | 14 +++++++++-----
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4trace.c b/fs/nfs/nfs4trace.c
index 389941ccc9c9..436763a559cd 100644
--- a/fs/nfs/nfs4trace.c
+++ b/fs/nfs/nfs4trace.c
@@ -26,6 +26,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_read_done);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_write_done);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_read_pagelist);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_write_pagelist);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_ds_connect);
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_read_error);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_write_error);
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index deab4c0e21a0..f6fc38bce9d0 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -273,6 +273,32 @@ TRACE_EVENT(nfs4_cb_offload,
 			show_nfs_stable_how(__entry->cb_how)
 		)
 );
+
+TRACE_EVENT(pnfs_ds_connect,
+		TP_PROTO(
+			char *ds_remotestr,
+			int status
+		),
+
+		TP_ARGS(ds_remotestr, status),
+
+		TP_STRUCT__entry(
+			__string(ds_ips, ds_remotestr)
+			__field(int, status)
+		),
+
+		TP_fast_assign(
+			__assign_str(ds_ips);
+			__entry->status = status;
+		),
+
+		TP_printk(
+			"ds_ips=%s, status=%d",
+			__get_str(ds_ips),
+			__entry->status
+                )
+);
+
 #endif /* CONFIG_NFS_V4_1 */
 
 TRACE_EVENT(nfs4_setup_sequence,
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 91ef486f40b9..4e25753945f6 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -17,6 +17,7 @@
 #include "internal.h"
 #include "pnfs.h"
 #include "netns.h"
+#include "nfs4trace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PNFS
 
@@ -998,8 +999,10 @@ int nfs4_pnfs_ds_connect(struct nfs_server *mds_srv, struct nfs4_pnfs_ds *ds,
 		err = nfs4_wait_ds_connect(ds);
 		if (err || ds->ds_clp)
 			goto out;
-		if (nfs4_test_deviceid_unavailable(devid))
-			return -ENODEV;
+		if (nfs4_test_deviceid_unavailable(devid)) {
+			err = -ENODEV;
+			goto out;
+		}
 	} while (test_and_set_bit(NFS4DS_CONNECTING, &ds->ds_state) != 0);
 
 	if (ds->ds_clp)
@@ -1029,11 +1032,12 @@ int nfs4_pnfs_ds_connect(struct nfs_server *mds_srv, struct nfs4_pnfs_ds *ds,
 		if (!ds->ds_clp || !nfs_client_init_is_complete(ds->ds_clp)) {
 			WARN_ON_ONCE(ds->ds_clp ||
 				!nfs4_test_deviceid_unavailable(devid));
-			return -EINVAL;
-		}
-		err = nfs_client_init_status(ds->ds_clp);
+			err = -EINVAL;
+		} else
+			err = nfs_client_init_status(ds->ds_clp);
 	}
 
+	trace_pnfs_ds_connect(ds->ds_remotestr, err);
 	return err;
 }
 EXPORT_SYMBOL_GPL(nfs4_pnfs_ds_connect);
-- 
2.47.1


