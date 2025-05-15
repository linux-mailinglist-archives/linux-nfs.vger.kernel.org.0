Return-Path: <linux-nfs+bounces-11757-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57997AB8FA1
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 21:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C0C4E0D05
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 19:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15671296731;
	Thu, 15 May 2025 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="cah7Fq6D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730B225B675
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335876; cv=none; b=iRKNO2TPbSbN0pHseU3DoqtzFg0ryGoilqJk37THEUFuN9WFCrmfMKM4hH0cQV2JJH/PfkoJuEk9X/h6mX0GJOEIJcCSwVnsb+MKL1UkfX5SZxg/9ZR6UNBS80lIOsIJaj1UKAQrPeezSWiSPSQJTiIDS6SxTu0y2rS15Q55VMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335876; c=relaxed/simple;
	bh=5HP9uvzWdbEkd9ZCT5yQnn5ahMzNpLJ/3dNpEo4NBec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZastNPq7SnX4koQ+XIgHszSfeczcmst1s0s/qfu5n5UN8amdYsV5meIWoS654MwgqG8I6hq0/ieiJFP945T716sqBpZlJurI1A/Cvg9WGxQ0ZBoA5JR8ClKXS2I1vV8bIglMqxApm795HiXQehL2IT7T37KWMRdfcACOu2rPnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=cah7Fq6D; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-1.desy.de (Postfix) with ESMTP id E71F611F746
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 21:04:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de E71F611F746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1747335869; bh=qgBGNtXYE4dst/U7ahAkXFx0vKwBDRNTLEvVbdb7l+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=cah7Fq6DvmCTjwmGBnWktA41/OVT8bSTjqzPNZhUEHQEQJsfML4Z7fbazm1dXHDXr
	 R8CFAQij3BgY8+BgDFIm63plQek+TYxcebxqXw15E30gJYs3kZnuDISN8y2mQ3bAON
	 TuUvN5BLTnAR8j9LisElaGKbAQSvyGrI6EGr7N0U=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id DB3A220040;
	Thu, 15 May 2025 21:04:29 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id CF5E116003F;
	Thu, 15 May 2025 21:04:29 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id ED829160058;
	Thu, 15 May 2025 21:04:28 +0200 (CEST)
Received: from nairi.fritz.box (VPN0200.desy.de [131.169.253.199])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id A169480046;
	Thu, 15 May 2025 21:04:28 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] flexfiles/pNFS: update stats on NFS4ERR_DELAY for v4.1 DSes
Date: Thu, 15 May 2025 21:04:15 +0200
Message-ID: <20250515190415.117310-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On NFS4ERR_DELAY nfs slient updates its stats, but misses for
flexfiles v4.1 DSes.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 8ff4e9e761bd..4a4fd2bfc88c 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1129,6 +1129,8 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		nfs4_schedule_session_recovery(clp->cl_session, task->tk_status);
 		break;
 	case -NFS4ERR_DELAY:
+		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
+		fallthrough;
 	case -NFS4ERR_GRACE:
 		rpc_delay(task, FF_LAYOUT_POLL_RETRY_MAX);
 		break;
-- 
2.49.0


