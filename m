Return-Path: <linux-nfs+bounces-12271-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA32AD3C82
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 17:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BD4166982
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F87238C39;
	Tue, 10 Jun 2025 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="pBAVp1L7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA2238C1B
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568374; cv=none; b=Io0okAHYnt3/rl7s8gGHnsBNgHsK1SQBxlcjDQ23tSWB/P+t5N+n6JefT35Ygd2XQsC3UOg3aCvFru6ALd1ERlv5yfMFBu8c3OlqmDADk6X6Z6StanY8IsnxJhJWEoNP2emPx1f0bW314C4QXUx8cJ8gk5ZEMsaW3mjM/POFyjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568374; c=relaxed/simple;
	bh=5kwiWHCRMyIpYDZyEOHmdrRLVly3i6is70XP6rcpEFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyIQwfAWt2UTUZDBUvTtoSJdc6fTJxKXrHJ6CwzP/PPH5zPjuDk5aREwY5VdyKI++XNihZIYNRgCVsDARcWDO8fLwRKzUrlxyTtb3vXU9P1gBLXIN3nhs7c4d/3OIgKR4bkCpmtUEMkKFl6/Chb5Z5QYTCarwHlS/tmvfA2RviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=pBAVp1L7; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-1.desy.de (Postfix) with ESMTP id B7BAC11F74B
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 17:12:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de B7BAC11F74B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1749568369; bh=dRhTO3MCFyfome5cxsHbNUdgavSXquKhXkHhLKrDY60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pBAVp1L7jtAEGNZFCnO3wZnu/jnoNTu+vd4qBQCf+JDYWhCfC10L4Wxo9yi6RZWlY
	 yF0dl9Wyz6at/tkaqhgrS//3I61IDamjbpG3vO650cJ1sdJUGZiZm1FAp4QaxEfLP3
	 iX1+R+sDMbeXs3NycXJmV7kJYCE/DvfPpqQg51ag=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id AA2AA120043;
	Tue, 10 Jun 2025 17:12:49 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 9CE5716003F;
	Tue, 10 Jun 2025 17:12:49 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id B6BD23200A9;
	Tue, 10 Jun 2025 17:12:48 +0200 (CEST)
Received: from nairi.fritz.box (VPN0353.desy.de [131.169.254.98])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 63AFB20044;
	Tue, 10 Jun 2025 17:12:48 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v2] pnfs: add pnfs_ds_connect trace point
Date: Tue, 10 Jun 2025 17:12:46 +0200
Message-ID: <20250610151246.9147-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610093451.835089-1-tigran.mkrtchyan@desy.de>
References: <20250610093451.835089-1-tigran.mkrtchyan@desy.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tracepoint aims to expose pnfs DS connect status

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
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
2.49.0


