Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318082AE40F
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 00:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbgKJX3Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 18:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbgKJX3Y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 18:29:24 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C1520781
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 23:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605050963;
        bh=7ngd8Pccs51h78vSZOwcVyIh4qZHE9XTMMXXkvjhyEA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SvCr5riAL4i8xaTg7YzFWoR5ncXsqckWlD4g2/iCSqqlALza9a8rKXgkrizcvC+rz
         mZXZcPEYZ6pXESoe+jm8mkKtlG+9+l1XETNcwZf187i5AWlsnxnbTFswXLkRu5gxib
         TjWxjyUCDBfcgov423RGyhdyzwCw6rgvQi0eYFZI=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 07/11] pNFS: Add helpers for allocation/free of struct nfs4_pnfs_ds_addr
Date:   Tue, 10 Nov 2020 18:19:02 -0500
Message-Id: <20201110231906.863446-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110231906.863446-7-trondmy@kernel.org>
References: <20201110231906.863446-1-trondmy@kernel.org>
 <20201110231906.863446-2-trondmy@kernel.org>
 <20201110231906.863446-3-trondmy@kernel.org>
 <20201110231906.863446-4-trondmy@kernel.org>
 <20201110231906.863446-5-trondmy@kernel.org>
 <20201110231906.863446-6-trondmy@kernel.org>
 <20201110231906.863446-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 7027dac41cc7..8c5921be41f8 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -661,6 +661,20 @@ _data_server_lookup_locked(const struct list_head *dsaddrs)
 	return NULL;
 }
 
+static struct nfs4_pnfs_ds_addr *nfs4_pnfs_ds_addr_alloc(gfp_t gfp_flags)
+{
+	struct nfs4_pnfs_ds_addr *da = kzalloc(sizeof(*da), gfp_flags);
+	if (da)
+		INIT_LIST_HEAD(&da->da_node);
+	return da;
+}
+
+static void nfs4_pnfs_ds_addr_free(struct nfs4_pnfs_ds_addr *da)
+{
+	kfree(da->da_remotestr);
+	kfree(da);
+}
+
 static void destroy_ds(struct nfs4_pnfs_ds *ds)
 {
 	struct nfs4_pnfs_ds_addr *da;
@@ -676,8 +690,7 @@ static void destroy_ds(struct nfs4_pnfs_ds *ds)
 				      struct nfs4_pnfs_ds_addr,
 				      da_node);
 		list_del_init(&da->da_node);
-		kfree(da->da_remotestr);
-		kfree(da);
+		nfs4_pnfs_ds_addr_free(da);
 	}
 
 	kfree(ds->ds_remotestr);
@@ -1094,12 +1107,10 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 	}
 	*portstr = '\0';
 
-	da = kzalloc(sizeof(*da), gfp_flags);
+	da = nfs4_pnfs_ds_addr_alloc(gfp_flags);
 	if (unlikely(!da))
 		goto out_free_buf;
 
-	INIT_LIST_HEAD(&da->da_node);
-
 	if (!rpc_pton(net, buf, portstr-buf, (struct sockaddr *)&da->da_addr,
 		      sizeof(da->da_addr))) {
 		dprintk("%s: error parsing address %s\n", __func__, buf);
-- 
2.28.0

