Return-Path: <linux-nfs+bounces-12224-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 960F7AD28F7
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 23:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670481892461
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 21:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E2C21D587;
	Mon,  9 Jun 2025 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="ceXU4eZ1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A7721CC41
	for <linux-nfs@vger.kernel.org>; Mon,  9 Jun 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505972; cv=none; b=hNWMqA2JqyiJ8J+kiid1RMd5kCKV+PTjnd5Yf6AzBsX1S1HamrUvaSHDu/WBWYsB1K3VObNuP7d1qHqqlfnkrTXzwr97WAWJBqVleGxAHDoHyJ0kwvXA5f14KvQN5hiD1dZhELhz/JsrxqGRCXTD7jA3N3anNEXl/O6n0SGN6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505972; c=relaxed/simple;
	bh=peipfacVK6MGlu1yTqE/yzzizEC5OQ9ryXNN0n2o0Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjvRKdSgHz9ti61cFepq8ibifmkDBH4lm9y1EYEPHTzUA+jKG+wm7sf5Cw3iOeVHGIVCthqY1GEH3ueYGuAZYlkvRcUU1sKKMkRpHBFSYAGPSMB31Hi1/WRL0OWAnVXrh56oyN6hiBIgAoN6xNBzqTpwH6zrYM5nJwN+EsP1Sss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=ceXU4eZ1; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	by smtp-o-3.desy.de (Postfix) with ESMTP id CF95211F889
	for <linux-nfs@vger.kernel.org>; Mon,  9 Jun 2025 23:43:20 +0200 (CEST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-1.desy.de (Postfix) with ESMTP id E867311F749
	for <linux-nfs@vger.kernel.org>; Mon,  9 Jun 2025 23:43:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de E867311F749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1749505392; bh=1p98zIO6Cm5I1bZug1tu6mVg5Qjp5dPIv+hyYe0Hjt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceXU4eZ1hCzSAMApCi5QH/Xl/CaETHjIL0o1FRGER1ryuDPCII8P1KF8E4Dmr0nU4
	 uxoTa53TkqQDWJpog9WWFAg52hbJDIkUMjeyYVvtW4vHq3EepIS5SrV4ecfMPvExYq
	 XuXmK97kM8qdyR9MmzuMUcOkJbk7AmwNFHfs1xFk=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id D769C20040;
	Mon,  9 Jun 2025 23:43:12 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id C029A16003F;
	Mon,  9 Jun 2025 23:43:12 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [131.169.56.83])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 51B6D320093;
	Mon,  9 Jun 2025 23:43:12 +0200 (CEST)
Received: from nairi.desy.de (VPN0424.desy.de [131.169.254.169])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 16C4F20044;
	Mon,  9 Jun 2025 23:43:12 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH 1/1] pNFS/flexfiles: mark device unavailable on fatal connection error
Date: Mon,  9 Jun 2025 23:43:03 +0200
Message-ID: <20250609214303.816241-2-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609214303.816241-1-tigran.mkrtchyan@desy.de>
References: <20250609214303.816241-1-tigran.mkrtchyan@desy.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 260f32adb88 ("pNFS/flexfiles: Check the result of nfs4_pnfs_ds_connect")

When an applications get killed (SIGTERM/SIGINT) while pNFS client performs a connection
to DS, client ends in an infinite loop of connect-disconnect. This
source of the issue, it that flexfilelayoutdev#nfs4_ff_layout_prepare_ds gets an error
on nfs4_pnfs_ds_connect with status ERESTARTSYS, which is set by rpc_signal_task, but
the error is treated as transient, thus retried.

The issue is reproducible with script as (there should be ~1000 files in
a directory, client should must not have any connections to DSes):

```
echo 3 > /proc/sys/vm/drop_caches

for i in *
do
        head -1 $i &
        PP=$!
        sleep 10e-03
        kill -TERM $PP
done
```

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 4a304cf17c4b..0008a8180c9b 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -410,6 +410,10 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 			mirror->mirror_ds->ds_versions[0].wsize = max_payload;
 		goto out;
 	}
+	/* There is a fatal error to connect to DS. Mark it unavailable to avoid infinite retry loop. */
+	if (nfs_error_is_fatal(status))
+		nfs4_mark_deviceid_unavailable(&mirror->mirror_ds->id_node);
+
 noconnect:
 	ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg->pls_layout),
 				 mirror, lseg->pls_range.offset,
-- 
2.49.0


