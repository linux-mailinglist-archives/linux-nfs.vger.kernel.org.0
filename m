Return-Path: <linux-nfs+bounces-1504-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244F783E104
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 19:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE13B280DA5
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F246B208A3;
	Fri, 26 Jan 2024 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSDv3n8D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3B1EB5E
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292260; cv=none; b=Yj3MNHK/HT5fjv82ZW7+fxCYhMGIWbV9vzXv25jGkgxke671pk15zmJ88nbxQhaMpRANc7HPe0wzSyptyQhHw+hErWZ82Dk4jAJvBIPNECD0Gtz0+9rgYQrOFyQWoYuySZr1kr/Zks3vvgaHSzcjoO9TJifKHjFbSR1MdbgRJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292260; c=relaxed/simple;
	bh=PzL+wDEvshK7wwdCMRBKwwb7lS+JvKhLg5YYjRrwt9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SnLBfh4zy9fyNHeROUgmJZEaFffyRNYJvXVBfx4Mxa8j8aTGTtpJ8wnOYkPYGbiyX7OTxpyefCsXP0B/ryDrJdCH7Vz8VJt45qr74qs0ft06AA1ESw+LQFP913u45TbQSdW7UhUMM4HDIM/fwyhpxXP+MBmxZ4/37xVnE87nQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSDv3n8D; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso10149539f.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 10:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706292258; x=1706897058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpNeJtocKK5LpdONOyZF/R9A9PS3L+2YY1FnYEHvSKI=;
        b=gSDv3n8DajPAf2HbbDg1pn71NxPMqhzoZlHbWk52w0F19Nq9BBpHqD8/36hnaQBYR9
         mYEKD+4id4Q6yfxWy5yWgB6VkbA5XTDQuPxGzYamMP3dsB3LhzS3Em8ooo5eVwDg1x1S
         bbKvoVq827IQtX1v7D/v8hzzji3P4G0S6n7TT2wSyBF5FFdd98LQa3LkWiAD4kfSG2lX
         H1mqdeMRt4n8l70u1n9fKC8L41AZ6ZJ9pQ0xXxWBhiQDH7sEy4ggR4LmWB7nIutoKO8a
         jBdLpxkk2oYrFZT98AKy6valnDDH00Mw1bmqIHIa6yDrwoRMGiogMYX7SPWgMSN+H9uK
         zwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706292258; x=1706897058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpNeJtocKK5LpdONOyZF/R9A9PS3L+2YY1FnYEHvSKI=;
        b=JrUTuP1PTlLNZfkhAr4d4oX1Tfe63QrjKztNYQqVBCYWNYWithiaH50Y4Ozsc/yYjM
         qp8bmS5+PNh4B5j3lidxlF2dWdwizWEqarHa+NopkTZbQVY3U4ZsNlVebKxnZQ6SV6Wf
         T9xyJI2dRDzs8lrz+EGmHFL6I5r9iLUgenEV9kXZJnyRbZpJfxAv0c6p7iouB8A+hi0T
         00n/WEi7vJIF62196L8CpooBpWmR/CuOAz8FtCZf4GnWrxg3KmtZr5reaVOqxpV62k42
         3YHgXxoM5FFN2uGbK+VftxgCVTp0KNz4M9p7yn9qhF92/Rx3wxwsMgcbUmWGlF/jUeOD
         3fjw==
X-Gm-Message-State: AOJu0YxvvblBv9DcXkbhvo8BxyT0d0Y1p7PN/KcSgRc+7eHXmXFSfb7J
	IMZtTzmbdiXLEoz9/Ig13ue1hFz1cSnoGLJTZ2lGf2q9V9yVnMgy
X-Google-Smtp-Source: AGHT+IGG4/TkF5A+FnjCD/+pv1fGUjxvs1a3FGnji7Ye6QNileSpDZwRkYMzfe7ajM00NcXSeh0bug==
X-Received: by 2002:a6b:c8d0:0:b0:7bc:207d:5178 with SMTP id y199-20020a6bc8d0000000b007bc207d5178mr334115iof.2.1706292258475;
        Fri, 26 Jan 2024 10:04:18 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:db7:3f83:f7f0:ed9a])
        by smtp.gmail.com with ESMTPSA id cc10-20020a056602424a00b007bf2c9bbdd6sm484780iob.50.2024.01.26.10.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 10:04:17 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] pnfs/filelayout: add tracepoint to getdeviceinfo
Date: Fri, 26 Jan 2024 13:04:16 -0500
Message-Id: <20240126180416.8949-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

While decoding filelayout getdeviceinfo received, print out the
information about the location of data servers (IPs).

Generic getdeviceinfo tracepoints prints the MDS's ip for the
dstaddr. In this patch, separate the MDS's address from the
DS's addresses.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/filelayout/filelayoutdev.c |  2 ++
 fs/nfs/nfs4trace.c                |  2 ++
 fs/nfs/nfs4trace.h                | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index acf4b88889dc..4fa304fa5bc4 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -35,6 +35,7 @@
 #include "../internal.h"
 #include "../nfs4session.h"
 #include "filelayout.h"
+#include "../nfs4trace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PNFS_LD
 
@@ -172,6 +173,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		dsaddr->ds_list[i] = nfs4_pnfs_ds_add(&dsaddrs, gfp_flags);
 		if (!dsaddr->ds_list[i])
 			goto out_err_drain_dsaddrs;
+		trace_fl_getdevinfo(server, &pdev->dev_id, dsaddr->ds_list[i]->ds_remotestr);
 
 		/* If DS was already in cache, free ds addrs */
 		while (!list_empty(&dsaddrs)) {
diff --git a/fs/nfs/nfs4trace.c b/fs/nfs/nfs4trace.c
index d9ac556bebcf..d22c6670f770 100644
--- a/fs/nfs/nfs4trace.c
+++ b/fs/nfs/nfs4trace.c
@@ -28,4 +28,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_write_pagelist);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_read_error);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_write_error);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_commit_error);
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(fl_getdevinfo);
 #endif
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index d27919d7241d..713d080fd268 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1991,6 +1991,34 @@ DECLARE_EVENT_CLASS(nfs4_deviceid_status,
 DEFINE_PNFS_DEVICEID_STATUS(nfs4_getdeviceinfo);
 DEFINE_PNFS_DEVICEID_STATUS(nfs4_find_deviceid);
 
+TRACE_EVENT(fl_getdevinfo,
+		TP_PROTO(
+			const struct nfs_server *server,
+			const struct nfs4_deviceid *deviceid,
+			char *ds_remotestr
+		),
+		TP_ARGS(server, deviceid, ds_remotestr),
+
+		TP_STRUCT__entry(
+			__string(mds_addr, server->nfs_client->cl_hostname)
+			__array(unsigned char, deviceid, NFS4_DEVICEID4_SIZE)
+			__string(ds_ips, ds_remotestr)
+		),
+
+		TP_fast_assign(
+			__assign_str(mds_addr, server->nfs_client->cl_hostname);
+			__assign_str(ds_ips, ds_remotestr);
+			memcpy(__entry->deviceid, deviceid->data,
+			       NFS4_DEVICEID4_SIZE);
+		),
+		TP_printk(
+			"deviceid=%s, mds_addr=%s, ds_ips=%s",
+			__print_hex(__entry->deviceid, NFS4_DEVICEID4_SIZE),
+			__get_str(mds_addr),
+			__get_str(ds_ips)
+		)
+);
+
 DECLARE_EVENT_CLASS(nfs4_flexfiles_io_event,
 		TP_PROTO(
 			const struct nfs_pgio_header *hdr
-- 
2.39.1


