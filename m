Return-Path: <linux-nfs+bounces-15380-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6449CBEDD3D
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 02:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AB904E2D96
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 00:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7FAC2EA;
	Sun, 19 Oct 2025 00:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWphCtTa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA114286
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760832639; cv=none; b=GDbYPV11WzVxCov9okzvt9LW9k7PDXjviC3G5lnqB+wpIFU/zQgOl33h9hHjTQgOSSiIGAXUMnYheBEUWHkTQpcaviXLMU//53Y1ctNEk1oz6BvQQKg944km0NLasEn+r+qa+dIefeug+xjZotEEffQ8KnvXFUjSyOr41WYDfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760832639; c=relaxed/simple;
	bh=QFC1DYSdxkSBghVlBE1m/5DpKoyFyu+H+RUdtvu2RcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsK10bWkigOzK9krJGspIJ1KAWG3WsEs6TkUz6c2HB0Hfq6Z4JBBzxre6Xhg/ctok0NGc/FDK6XB1UiLJvY97tznA77sUciP5buuzKxiWKhuFcqEF7ydhu35FSO0SoFlXISnUsUkIJtN5VHLeaNDLPs6EECydzpu1A5kpd1cPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWphCtTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59379C4CEFB;
	Sun, 19 Oct 2025 00:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760832638;
	bh=QFC1DYSdxkSBghVlBE1m/5DpKoyFyu+H+RUdtvu2RcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWphCtTay/0J+wpwLwW9sFyZYyCOKJPHeiabEkMNIx4brXkRQhq5+Al1VQyxeL4/5
	 biPiqHpuQDDJLy99lDKKjtpJd/0BH7TkZYfGwmF40E5o+30nBNKV3pYX1qFvJOw8cg
	 n7QH7BJx1D9QCnKeaSo3FQXchgW5i8JF5O/rIgPdAbDyj2qU8jrqsajhQr2b2w8aW4
	 SKEYuyltJ+szOygIqC9PxDtJRwYB0NS4GgOCFKA8A8WAmiTysVgTAUB8AAyXHgOn+K
	 d2p6kQLu5jgpl18yb/eq5yEthtfQRbxXU2c80JTCllREbwQSVsH4LfNn9wcSwGwxRD
	 iSxjL9PlCZMFg==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 1/4] pnfs: Fix TLS logic in _nfs4_pnfs_v3_ds_connect()
Date: Sat, 18 Oct 2025 20:10:33 -0400
Message-ID: <4cd2dafb71ce3b70b14b3a0eebf996db681827dc.1760831906.git.trond.myklebust@hammerspace.com>
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

Don't try to add an RDMA transport to a client that is already marked as
being a TCP/TLS transport.

Fixes: 04a15263662a ("pnfs/flexfiles: connect to NFSv3 DS using TLS if MDS connection uses TLS")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 7b32afb29782..ff48056bf750 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -809,8 +809,11 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 				 unsigned int retrans)
 {
 	struct nfs_client *clp = ERR_PTR(-EIO);
+	struct nfs_client *mds_clp = mds_srv->nfs_client;
+	enum xprtsec_policies xprtsec_policy = mds_clp->cl_xprtsec.policy;
 	struct nfs4_pnfs_ds_addr *da;
 	unsigned long connect_timeout = timeo * (retrans + 1) * HZ / 10;
+	int ds_proto;
 	int status = 0;
 
 	dprintk("--> %s DS %s\n", __func__, ds->ds_remotestr);
@@ -834,27 +837,28 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 				.xprtsec = clp->cl_xprtsec,
 			};
 
-			if (da->da_transport != clp->cl_proto &&
-			    clp->cl_proto != XPRT_TRANSPORT_TCP_TLS)
-				continue;
-			if (da->da_transport == XPRT_TRANSPORT_TCP &&
-			    mds_srv->nfs_client->cl_proto == XPRT_TRANSPORT_TCP_TLS)
+			if (xprt_args.ident == XPRT_TRANSPORT_TCP &&
+			    clp->cl_proto == XPRT_TRANSPORT_TCP_TLS)
 				xprt_args.ident = XPRT_TRANSPORT_TCP_TLS;
 
-			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
+			if (xprt_args.ident != clp->cl_proto)
+				continue;
+			if (xprt_args.dstaddr->sa_family !=
+			    clp->cl_addr.ss_family)
 				continue;
 			/* Add this address as an alias */
 			rpc_clnt_add_xprt(clp->cl_rpcclient, &xprt_args,
-					rpc_clnt_test_and_add_xprt, NULL);
+					  rpc_clnt_test_and_add_xprt, NULL);
 			continue;
 		}
-		if (da->da_transport == XPRT_TRANSPORT_TCP &&
-		    mds_srv->nfs_client->cl_proto == XPRT_TRANSPORT_TCP_TLS)
-			da->da_transport = XPRT_TRANSPORT_TCP_TLS;
-		clp = get_v3_ds_connect(mds_srv,
-				&da->da_addr,
-				da->da_addrlen, da->da_transport,
-				timeo, retrans);
+
+		ds_proto = da->da_transport;
+		if (ds_proto == XPRT_TRANSPORT_TCP &&
+		    xprtsec_policy != RPC_XPRTSEC_NONE)
+			ds_proto = XPRT_TRANSPORT_TCP_TLS;
+
+		clp = get_v3_ds_connect(mds_srv, &da->da_addr, da->da_addrlen,
+					ds_proto, timeo, retrans);
 		if (IS_ERR(clp))
 			continue;
 		clp->cl_rpcclient->cl_softerr = 0;
-- 
2.51.0


