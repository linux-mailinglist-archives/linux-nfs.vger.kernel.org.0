Return-Path: <linux-nfs+bounces-15382-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68366BEDD3F
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 02:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1525C3B8FCE
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 00:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B3F1D6BB;
	Sun, 19 Oct 2025 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ6Tl+AS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6220F282F5
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760832640; cv=none; b=WsXg9UxUhoDJAd9ltSEQqUEb+mK84N8NQTBn+n2pVCkEXeRxw0YfZovOTdJ0rWdEPCvr4cm5/NpNZDussNNwptw1Q8+fJDhlczCIDfce5QzaWTi2mlg1IvyXx4hxtv38FNpYPlzximNzKxos4ifUws69to+mDRMOHdbPC23DwLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760832640; c=relaxed/simple;
	bh=Lruf5InEObxFQPGUsCZTrWArjGJtXzm0b082PO09GCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ng2Gx4JXC9MW3gXjTxQQeWXzhW9D20lQ9l4fFGysAoYQkgH94a6ImqlEJTfw2O3zqgtUd/cub/rBbw3uBrGeXTDVfqVt0J9IgmImmBXaIYVM0BPcDo3Y3N7GTrV6QrqY1+jerK9YYuSCU7UEmxBekZoyPw0LwkziuuHNFRaEumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQ6Tl+AS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8421DC4CEF8;
	Sun, 19 Oct 2025 00:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760832639;
	bh=Lruf5InEObxFQPGUsCZTrWArjGJtXzm0b082PO09GCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQ6Tl+AS53ErODI6bBODxFRqviu+Oj1MC2jbAsk9bxN162xBSnVDTA0tkurI1d3v9
	 sPFrLUhjkT4lRNF32hfSxEazhdzeUnCAwGp/RBveoAFjs/HyECKPmhuFuhcKMwArqS
	 3z7rasg27WmXvF/cpPG7GTEDZXZ/OWHNlCbSvZVJY6HFz8QG0YLFEx6woBDvlVPZaf
	 iAMMcHrpIGRYgknQiq/X5s7JAFrp4UgXds6u60w8hcMPZ5Pm6ioddgJt9TUaHw5gQn
	 lGYjFki86kGuzCM3XfUg2LY6GMpjBiP9vw4GI37Esj3tJ4WeTbAi+InKUnMsLHmXhT
	 B+VtBPdrHBi/g==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 3/4] pnfs: Set transport security policy to RPC_XPRTSEC_NONE unless using TLS
Date: Sat, 18 Oct 2025 20:10:35 -0400
Message-ID: <816ed47531df15f4e64c54df181ffc59827d18fe.1760831906.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760831906.git.trond.myklebust@hammerspace.com>
References: <cover.1760831906.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The default setting for the transport security policy must be
RPC_XPRTSEC_NONE, when using a TCP or RDMA connection without TLS.
Conversely, when using TLS, the security policy needs to be set.

Fixes: 6c0a8c5fcf71 ("NFS: Have struct nfs_client carry a TLS policy field")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs3client.c | 14 ++++++++++++--
 fs/nfs/nfs4client.c | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 0d7310c1ee0c..5d97c1d38bb6 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -2,6 +2,7 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/sunrpc/addr.h>
+#include <net/handshake.h>
 #include "internal.h"
 #include "nfs3_fs.h"
 #include "netns.h"
@@ -98,7 +99,11 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 		.net = mds_clp->cl_net,
 		.timeparms = &ds_timeout,
 		.cred = mds_srv->cred,
-		.xprtsec = mds_clp->cl_xprtsec,
+		.xprtsec = {
+			.policy = RPC_XPRTSEC_NONE,
+			.cert_serial = TLS_NO_CERT,
+			.privkey_serial = TLS_NO_PRIVKEY,
+		},
 		.connect_timeout = connect_timeout,
 		.reconnect_timeout = connect_timeout,
 	};
@@ -111,9 +116,14 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 	cl_init.hostname = buf;
 
 	switch (ds_proto) {
+	case XPRT_TRANSPORT_TCP_TLS:
+		if (mds_clp->cl_xprtsec.policy != RPC_XPRTSEC_NONE)
+			cl_init.xprtsec = mds_clp->cl_xprtsec;
+		else
+			ds_proto = XPRT_TRANSPORT_TCP;
+		fallthrough;
 	case XPRT_TRANSPORT_RDMA:
 	case XPRT_TRANSPORT_TCP:
-	case XPRT_TRANSPORT_TCP_TLS:
 		if (mds_clp->cl_nconnect > 1)
 			cl_init.nconnect = mds_clp->cl_nconnect;
 	}
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 6fddf43d729c..bb4c41ad7134 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -11,6 +11,7 @@
 #include <linux/sunrpc/xprt.h>
 #include <linux/sunrpc/bc_xprt.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
+#include <net/handshake.h>
 #include "internal.h"
 #include "callback.h"
 #include "delegation.h"
@@ -982,7 +983,11 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 		.net = mds_clp->cl_net,
 		.timeparms = &ds_timeout,
 		.cred = mds_srv->cred,
-		.xprtsec = mds_srv->nfs_client->cl_xprtsec,
+		.xprtsec = {
+			.policy = RPC_XPRTSEC_NONE,
+			.cert_serial = TLS_NO_CERT,
+			.privkey_serial = TLS_NO_PRIVKEY,
+		},
 	};
 	char buf[INET6_ADDRSTRLEN + 1];
 
@@ -991,9 +996,14 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 	cl_init.hostname = buf;
 
 	switch (ds_proto) {
+	case XPRT_TRANSPORT_TCP_TLS:
+		if (mds_srv->nfs_client->cl_xprtsec.policy != RPC_XPRTSEC_NONE)
+			cl_init.xprtsec = mds_srv->nfs_client->cl_xprtsec;
+		else
+			ds_proto = XPRT_TRANSPORT_TCP;
+		fallthrough;
 	case XPRT_TRANSPORT_RDMA:
 	case XPRT_TRANSPORT_TCP:
-	case XPRT_TRANSPORT_TCP_TLS:
 		if (mds_clp->cl_nconnect > 1) {
 			cl_init.nconnect = mds_clp->cl_nconnect;
 			cl_init.max_connect = NFS_MAX_TRANSPORTS;
-- 
2.51.0


