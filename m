Return-Path: <linux-nfs+bounces-11754-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD48AB8B2E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 17:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6229D1635D6
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E9E33DF;
	Thu, 15 May 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="UGXVVxSX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B6E218858
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747323899; cv=none; b=NIK5omku0Fu/cLV842FMaNFVGun8AzB2oPrtqZQuQO6MBpr46Evb8MyuCDzIkQmfjpzAUmlc8b1xTqdWEmPctPLmyAI9KDoqVenr0vN242asceF2jjZ9Kh3DEIDPi+gqyRWd+QKGQWmyO3mvLk174OERiJkzz59hrwNFxNZApII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747323899; c=relaxed/simple;
	bh=zzUE4rHPrtCXmcsOEl4Bdtyyv2iqFb/U9vHODCehI1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rf9DffipxamNy0zHM0O7qpX8QjovlMvYNYHBmc4oTR+8G471w1ZWitCxddvAq/aT8q+Q7rfMOGHOK+Dq+I2/naXWPiARvwtNEX+OPx1ybZblDua8rYXJBRzztMk4ZIo5j9j1/3/PjROoW0VIZ1VOFvwzP4q+sht8buEKlu91SLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=UGXVVxSX; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 74BEC11F744
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 17:44:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 74BEC11F744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1747323893; bh=VNsriJ/GL9Eny0DBXRyQ5NfMIs5v58aqwlTeqRSe5I0=;
	h=From:To:Cc:Subject:Date:From;
	b=UGXVVxSXAWD5EPZWNke5okFxc6aGneGHAMYfyQ1LqpJTx8Cs3zF0X8W+9kaBg5hG7
	 8hUU+X8CYszpEBzAZRUBf1uL3xKK++XW1oeaVK9HC8oh1JK/fiTHeTbDpCu7YYsDVC
	 S4DKggoEUT147mdFytpPA+aL6PvaUJ8js8amp9P8=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 6B60420040;
	Thu, 15 May 2025 17:44:53 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [194.95.239.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 5DE1640044;
	Thu, 15 May 2025 17:44:53 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id B80EA10A3CC;
	Thu, 15 May 2025 17:44:52 +0200 (CEST)
Received: from nairi.desy.de (zitpcx23514.desy.de [131.169.214.185])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 925A220044;
	Thu, 15 May 2025 17:44:52 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] RFC flexfiles/pNFS: delete v4.1 device in case of any connection errors
Date: Thu, 15 May 2025 17:44:29 +0200
Message-ID: <20250515154429.104887-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rpc layer might return a large range of network errors. In all
cases, the DS should be marked unavailable. Currently, the error
handling of nfs4.1-based DSes does so only for a selected set of errors.

Update the ff_layout_async_handle_error_v4 to mark device bad on all
network errors (mimic v3 behaviour)

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 61ad269c825f..8ff4e9e761bd 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1159,21 +1159,12 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		if (test_bit(NFS_CS_NETUNREACH_FATAL, &clp->cl_flags))
 			return -NFS4ERR_FATAL_IOERROR;
 		fallthrough;
-	case -ECONNREFUSED:
-	case -EHOSTDOWN:
-	case -EHOSTUNREACH:
-	case -EIO:
-	case -ETIMEDOUT:
-	case -EPIPE:
-	case -EPROTO:
-	case -ENODEV:
+	default:
 		dprintk("%s DS connection error %d\n", __func__,
 			task->tk_status);
 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
 				&devid->deviceid);
 		rpc_wake_up(&tbl->slot_tbl_waitq);
-		fallthrough;
-	default:
 		if (ff_layout_avoid_mds_available_ds(lseg))
 			return -NFS4ERR_RESET_TO_PNFS;
 reset:
-- 
2.49.0


