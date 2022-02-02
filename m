Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0B94A7C18
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Feb 2022 00:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiBBX6w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Feb 2022 18:58:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33794 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348206AbiBBX6u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Feb 2022 18:58:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89B71B832C9
        for <linux-nfs@vger.kernel.org>; Wed,  2 Feb 2022 23:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025BDC004E1;
        Wed,  2 Feb 2022 23:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643846328;
        bh=X8FMOpmBYr/QXfLDFtS4AoDs44akqsCryjRb/jafDPM=;
        h=From:To:Cc:Subject:Date:From;
        b=T6xgMxhqT2kbnEltaZey82Rcdq+Oae9I7NqGbn4YRCbTB9Pd7nGTE64nfhmCweRRK
         sRGWdvv+3dbC7X/ROGpXsZHMoD8JgZEFNaytIQjJKPPTpFEiZlR/qKLVYSQYNfqlhh
         26mQR3COSi8IrirSVFCGaaeCL9yLsZrJskj9xCq/RljmxAX2Z9zTfQ7kIj6ioS4HKs
         9O1dtIOiM6Nv2UiFOviFGIC58iyu6l9yvH/Olna1/nal+awV/lC1/kKlw0MKZLg6WO
         IDZYdDdCnTzdc3e0msbKE6kPgqpJtRq3TAdN4G7kHauMCeGrlqsNJoh5RePoCxD5zX
         jdO9GW+TC8sCQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix initialisation of nfs_client cl_flags field
Date:   Wed,  2 Feb 2022 18:52:01 -0500
Message-Id: <20220202235201.7912-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

For some long forgotten reason, the nfs_client cl_flags field is
initialised in nfs_get_client() instead of being initialised at
allocation time. This quirk was harmless until we moved the call to
nfs_create_rpc_client().

Fixes: 87871d990a2c ("NFSv4: Initialise connection to the server in nfs4_alloc_client()")
Cc: stable@vger.kernel.org # 4.8.x
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index f18e80fda9bf..d1f34229e11a 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -177,6 +177,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	INIT_LIST_HEAD(&clp->cl_superblocks);
 	clp->cl_rpcclient = ERR_PTR(-EINVAL);
 
+	clp->cl_flags = cl_init->init_flags;
 	clp->cl_proto = cl_init->proto;
 	clp->cl_nconnect = cl_init->nconnect;
 	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
@@ -423,7 +424,6 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
 			list_add_tail(&new->cl_share_link,
 					&nn->nfs_client_list);
 			spin_unlock(&nn->nfs_client_lock);
-			new->cl_flags = cl_init->init_flags;
 			return rpc_ops->init_client(new, cl_init);
 		}
 
-- 
2.34.1

