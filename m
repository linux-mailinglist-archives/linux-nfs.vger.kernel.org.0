Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CA432C696
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355536AbhCDA3Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383754AbhCCPep (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 10:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614785593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GyWRKLVucVyW/0Jo4xUcQLBrgZiINDhy5XfjWJ+w02Q=;
        b=SJ3qE7ADIHn5MuN8GMdP97popLyMczmkAmfw+vnuCbLw/+qCi/5uXEYDqyzjdxaG5qePWC
        ffptOPOPs2vcKlecBzqODu4PPiewBJpWjvHXHaOgpxgkb3G+43k+Ko7J4/SRtRnagETkEM
        gJIr/1y74gzv51fXqrNBXy6i17+yA/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-q_5CdsvkNDyEmLP-B51dqQ-1; Wed, 03 Mar 2021 10:33:11 -0500
X-MC-Unique: q_5CdsvkNDyEmLP-B51dqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93C83100728F;
        Wed,  3 Mar 2021 15:33:10 +0000 (UTC)
Received: from idlethread.redhat.com (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2C3150DE6;
        Wed,  3 Mar 2021 15:33:08 +0000 (UTC)
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: [PATCH] pNFS: make DS availability problems visible in log
Date:   Wed,  3 Mar 2021 16:33:07 +0100
Message-Id: <20210303153307.3147-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Would be interesting to promote DS availability logging outside debug
so that we are more aware that I/O is diverted to MDS and some part
of the infraestructure failed.

Also added logging for failed DS connection attempts.

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 fs/nfs/filelayout/filelayout.c         | 4 ++--
 fs/nfs/flexfilelayout/flexfilelayout.c | 6 +++---
 fs/nfs/pnfs_nfs.c                      | 6 +++++-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 7f5aa0403e16..fef2d31a501a 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -181,7 +181,7 @@ static int filelayout_async_handle_error(struct rpc_task *task,
 	case -EIO:
 	case -ETIMEDOUT:
 	case -EPIPE:
-		dprintk("%s DS connection error %d\n", __func__,
+		pr_warn("%s DS connection error %d\n", __func__,
 			task->tk_status);
 		nfs4_mark_deviceid_unavailable(devid);
 		pnfs_error_mark_layout_for_return(inode, lseg);
@@ -190,7 +190,7 @@ static int filelayout_async_handle_error(struct rpc_task *task,
 		fallthrough;
 	default:
 reset:
-		dprintk("%s Retry through MDS. Error %d\n", __func__,
+		pr_warn("%s Retry through MDS. Error %d\n", __func__,
 			task->tk_status);
 		return -NFS4ERR_RESET_TO_MDS;
 	}
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a163533446fa..7150d94e80e6 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1129,7 +1129,7 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 	case -EIO:
 	case -ETIMEDOUT:
 	case -EPIPE:
-		dprintk("%s DS connection error %d\n", __func__,
+		pr_warn("%s DS connection error %d\n", __func__,
 			task->tk_status);
 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
 				&devid->deviceid);
@@ -1139,7 +1139,7 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		if (ff_layout_avoid_mds_available_ds(lseg))
 			return -NFS4ERR_RESET_TO_PNFS;
 reset:
-		dprintk("%s Retry through MDS. Error %d\n", __func__,
+		pr_warn("%s Retry through MDS. Error %d\n", __func__,
 			task->tk_status);
 		return -NFS4ERR_RESET_TO_MDS;
 	}
@@ -1167,7 +1167,7 @@ static int ff_layout_async_handle_error_v3(struct rpc_task *task,
 		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
 		goto out_retry;
 	default:
-		dprintk("%s DS connection error %d\n", __func__,
+		pr_warn("%s DS connection error %d\n", __func__,
 			task->tk_status);
 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
 				&devid->deviceid);
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 679767ac258d..322661a48348 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -934,8 +934,11 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 						(struct sockaddr *)&da->da_addr,
 						da->da_addrlen, IPPROTO_TCP,
 						timeo, retrans, minor_version);
-			if (IS_ERR(clp))
+			if (IS_ERR(clp)) {
+				pr_warn("%s: DS: %s unable to connect with address %s, error: %ld\n",
+					__func__, ds->ds_remotestr, da->da_remotestr, PTR_ERR(clp));
 				continue;
+			}
 
 			status = nfs4_init_ds_session(clp,
 					mds_srv->nfs_client->cl_lease_time);
@@ -949,6 +952,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 	}
 
 	if (IS_ERR(clp)) {
+		pr_warn("%s: no DS available\n", __func__);
 		status = PTR_ERR(clp);
 		goto out;
 	}
-- 
2.21.0

