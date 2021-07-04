Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0D3BAADF
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jul 2021 04:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhGDCHt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Jul 2021 22:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhGDCHs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 3 Jul 2021 22:07:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C0BE615FF
        for <linux-nfs@vger.kernel.org>; Sun,  4 Jul 2021 02:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625364313;
        bh=EJ8S6SyURr4ivvRdfn5eT0vHlVmMQK0osPw/VS7jLyQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vHhsDRE0CuxLZU39VFDxFCEbRgUyyGenzgj7yM9ZnIK62tZ3SMDU/REa1wgeBNKc9
         ZqUKxq+wvJbY3PkLhi+el6QORdbrzpDu8Ce/7MuuZKkP+n31lhKVSzcvp4P1/fP81x
         7AZYkbgitW+W6yzy79T8+mu6TrMyIl1jKIJXCbnXBaOIUG1LhwYtTw+Gyr/NoshGZ7
         LKvBRlsHF7SbaO/F5R3VtB7mTCu7AWyhBj7piGV8QQz3TvrG/HhvjNJWAdEqKsg7lR
         FRcnVcXxFTv28Vfh0Qece24VTYcerUdFX8BfYVeqh7fJLOop1zi1jU0zPFBe8EYAxd
         VgdGL+vg7i+fw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] NFSv4/pNFS: Don't call _nfs4_pnfs_v3_ds_connect multiple times
Date:   Sat,  3 Jul 2021 22:05:09 -0400
Message-Id: <20210704020510.4898-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210704020510.4898-3-trondmy@kernel.org>
References: <20210704020510.4898-1-trondmy@kernel.org>
 <20210704020510.4898-2-trondmy@kernel.org>
 <20210704020510.4898-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

After we grab the lock in nfs4_pnfs_ds_connect(), there is no check for
whether or not ds->ds_clp has already been initialised, so we can end up
adding the same transports multiple times.

Fixes: fc821d59209d ("pnfs/NFSv4.1: Add multipath capabilities to pNFS flexfiles servers over NFSv3")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 52 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 49d3389bd813..1c2c0d08614e 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -805,19 +805,16 @@ nfs4_pnfs_ds_add(struct list_head *dsaddrs, gfp_t gfp_flags)
 }
 EXPORT_SYMBOL_GPL(nfs4_pnfs_ds_add);
 
-static void nfs4_wait_ds_connect(struct nfs4_pnfs_ds *ds)
+static int nfs4_wait_ds_connect(struct nfs4_pnfs_ds *ds)
 {
 	might_sleep();
-	wait_on_bit(&ds->ds_state, NFS4DS_CONNECTING,
-			TASK_KILLABLE);
+	return wait_on_bit(&ds->ds_state, NFS4DS_CONNECTING, TASK_KILLABLE);
 }
 
 static void nfs4_clear_ds_conn_bit(struct nfs4_pnfs_ds *ds)
 {
 	smp_mb__before_atomic();
-	clear_bit(NFS4DS_CONNECTING, &ds->ds_state);
-	smp_mb__after_atomic();
-	wake_up_bit(&ds->ds_state, NFS4DS_CONNECTING);
+	clear_and_wake_up_bit(NFS4DS_CONNECTING, &ds->ds_state);
 }
 
 static struct nfs_client *(*get_v3_ds_connect)(
@@ -993,30 +990,33 @@ int nfs4_pnfs_ds_connect(struct nfs_server *mds_srv, struct nfs4_pnfs_ds *ds,
 {
 	int err;
 
-again:
-	err = 0;
-	if (test_and_set_bit(NFS4DS_CONNECTING, &ds->ds_state) == 0) {
-		if (version == 3) {
-			err = _nfs4_pnfs_v3_ds_connect(mds_srv, ds, timeo,
-						       retrans);
-		} else if (version == 4) {
-			err = _nfs4_pnfs_v4_ds_connect(mds_srv, ds, timeo,
-						       retrans, minor_version);
-		} else {
-			dprintk("%s: unsupported DS version %d\n", __func__,
-				version);
-			err = -EPROTONOSUPPORT;
-		}
+	do {
+		err = nfs4_wait_ds_connect(ds);
+		if (err || ds->ds_clp)
+			goto out;
+		if (nfs4_test_deviceid_unavailable(devid))
+			return -ENODEV;
+	} while (test_and_set_bit(NFS4DS_CONNECTING, &ds->ds_state) != 0);
 
-		nfs4_clear_ds_conn_bit(ds);
-	} else {
-		nfs4_wait_ds_connect(ds);
+	if (ds->ds_clp)
+		goto connect_done;
 
-		/* what was waited on didn't connect AND didn't mark unavail */
-		if (!ds->ds_clp && !nfs4_test_deviceid_unavailable(devid))
-			goto again;
+	switch (version) {
+	case 3:
+		err = _nfs4_pnfs_v3_ds_connect(mds_srv, ds, timeo, retrans);
+		break;
+	case 4:
+		err = _nfs4_pnfs_v4_ds_connect(mds_srv, ds, timeo, retrans,
+					       minor_version);
+		break;
+	default:
+		dprintk("%s: unsupported DS version %d\n", __func__, version);
+		err = -EPROTONOSUPPORT;
 	}
 
+connect_done:
+	nfs4_clear_ds_conn_bit(ds);
+out:
 	/*
 	 * At this point the ds->ds_clp should be ready, but it might have
 	 * hit an error.
-- 
2.31.1

