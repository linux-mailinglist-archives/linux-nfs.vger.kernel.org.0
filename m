Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF16780CE7
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 15:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377340AbjHRNtF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 09:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377438AbjHRNs6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 09:48:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FA346A8
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 06:48:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36C4067C1A
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 13:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DD9C433C9;
        Fri, 18 Aug 2023 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366501;
        bh=9F0mLVE6Px02gqZkud+RH0Oi+Kkcqan4L3icyQXLzm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hl1if1tS4NeEnXO9YDJ+7/huqV2xe9YOFFNIP4ztWsYUvMMFS52MXUE39JrraUJKG
         9pFYp5KeW6rYeTGJDz52100JGJ27mD3mU8pQQykCPBAdShwf/cGAdGkT2BQ+ra9Rmd
         i2p6WWUrohHtJJhGFSxslUyuzFAHq1l5dzS+GnUHOL3TOSdoC4DddPrb7YdFuY7fNm
         oqbqKtyaAjujboIehwkQDwRMT8kW4WOGvNndGkplA7ZT1ykwCXkSFA0ulGxbB8hbBr
         PERRScIFDQjg9Nmlmq8AJZtV6hiPw3ZUqHgSM7SDauzRqAmYYN3FzuUYpjfeZ6nwGU
         M1t7GSUsZB3Zw==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] NFS/pNFS: Set the connect timeout for the pNFS flexfiles driver
Date:   Fri, 18 Aug 2023 09:41:50 -0400
Message-ID: <20230818134150.23485-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818134150.23485-4-trondmy@kernel.org>
References: <20230818134150.23485-1-trondmy@kernel.org>
 <20230818134150.23485-2-trondmy@kernel.org>
 <20230818134150.23485-3-trondmy@kernel.org>
 <20230818134150.23485-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that the connect timeout for the pNFS flexfiles driver is of the
same order as the I/O timeout, so that we can fail over quickly when
trying to read from a data server that is down.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c     | 2 ++
 fs/nfs/internal.h   | 2 ++
 fs/nfs/nfs3client.c | 3 +++
 fs/nfs/pnfs_nfs.c   | 3 +++
 4 files changed, 10 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index e4c5f193ed5e..44eca51b2808 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -517,6 +517,8 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 		.authflavor	= flavor,
 		.cred		= cl_init->cred,
 		.xprtsec	= cl_init->xprtsec,
+		.connect_timeout = cl_init->connect_timeout,
+		.reconnect_timeout = cl_init->reconnect_timeout,
 	};
 
 	if (test_bit(NFS_CS_DISCRTRY, &clp->cl_flags))
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 0019c7578f9d..4d80925c94f7 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -82,6 +82,8 @@ struct nfs_client_initdata {
 	const struct rpc_timeout *timeparms;
 	const struct cred *cred;
 	struct xprtsec_parms xprtsec;
+	unsigned long connect_timeout;
+	unsigned long reconnect_timeout;
 };
 
 /*
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index eff3802c5e03..674c012868b1 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -86,6 +86,7 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 		int ds_proto, unsigned int ds_timeo, unsigned int ds_retrans)
 {
 	struct rpc_timeout ds_timeout;
+	unsigned long connect_timeout = ds_timeo * (ds_retrans + 1) * HZ / 10;
 	struct nfs_client *mds_clp = mds_srv->nfs_client;
 	struct nfs_client_initdata cl_init = {
 		.addr = ds_addr,
@@ -98,6 +99,8 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 		.timeparms = &ds_timeout,
 		.cred = mds_srv->cred,
 		.xprtsec = mds_clp->cl_xprtsec,
+		.connect_timeout = connect_timeout,
+		.reconnect_timeout = connect_timeout,
 	};
 	struct nfs_client *clp;
 	char buf[INET6_ADDRSTRLEN + 1];
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index a0112ad4937a..a08cfda6fff1 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -852,6 +852,7 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 {
 	struct nfs_client *clp = ERR_PTR(-EIO);
 	struct nfs4_pnfs_ds_addr *da;
+	unsigned long connect_timeout = timeo * (retrans + 1) * HZ / 10;
 	int status = 0;
 
 	dprintk("--> %s DS %s\n", __func__, ds->ds_remotestr);
@@ -870,6 +871,8 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 				.dstaddr = (struct sockaddr *)&da->da_addr,
 				.addrlen = da->da_addrlen,
 				.servername = clp->cl_hostname,
+				.connect_timeout = connect_timeout,
+				.reconnect_timeout = connect_timeout,
 			};
 
 			if (da->da_transport != clp->cl_proto)
-- 
2.41.0

