Return-Path: <linux-nfs+bounces-15381-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6290FBEDD3B
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 02:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEB434E3511
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 00:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A0614286;
	Sun, 19 Oct 2025 00:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KitzhvXd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34531D6BB
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 00:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760832639; cv=none; b=SbmjdY0WnYrZaUNU+EtYMKx8/VwiokUmberhEi4MGC9vyBoHef7D1BSQJUFu/0zZY8gkxcKPvEOs7ZB+8RehvW3XVUzFg0SPWoLVe8U1GJ7a/pf8RXylCYvLpD2waXrG3qRCW/5kPIb4mbxGYkOU+se7SpQKe+mFzE8R+FVUYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760832639; c=relaxed/simple;
	bh=qo6dHqiW4i9kphLzF5rIBcTrS0ept4bxjhc3fjBKJjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1HPSDhJxivgAKck8bDdLFmdCP/VxKnAHE1hLQJ9mJnWqfz+JdDJrseKwVTY/AFnGE2cm8qeIOgDkzAd3nG8rOlivyDCkv+acB0VwOY7qs3HuaI1jEceB5448osiLw+rW3X15IRT/oeEpfCNLyY6iA9pxKDYfmLYKR0/zbmArXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KitzhvXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D94C4CEFE;
	Sun, 19 Oct 2025 00:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760832639;
	bh=qo6dHqiW4i9kphLzF5rIBcTrS0ept4bxjhc3fjBKJjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KitzhvXd86jBZs9iIny2K/ob9fZ0tEC9BDvQ2tIVTc5HvC0HeoEOCFMj2ouxWgP5n
	 GdSnCKe4jcctlYmA90sHy0HF5F09eROlY4iKW0bN4T+buV6+/4RqX1kkeDBsLaS0Qa
	 zuTqj+ht/ROh1tAPglj+9AEkzS8mHK9uVucv5bfliVxUYIu0Zz4ZKWX7JxYunmxv34
	 MR9qsU4rFJ466VvO17LnYpduykyxBN+LGSb/vGam/gsckohzxpKrIX/S/fDdicN+O0
	 kZKfLaO6A5bWeV9tS2EZ3n3hJhYu31GinVzqtOExBEboIaw7v8p8l4Ewa4sEPnrhq2
	 Pk9cFZvGlLPVw==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 2/4] pnfs: Fix TLS logic in _nfs4_pnfs_v4_ds_connect()
Date: Sat, 18 Oct 2025 20:10:34 -0400
Message-ID: <831164796eaa11945f65501326746778e8b47368.1760831906.git.trond.myklebust@hammerspace.com>
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

Fixes: a35518cae4b3 ("NFSv4.1/pnfs: fix NFS with TLS in pnfs")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index ff48056bf750..9976cc16b689 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -884,7 +884,10 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				 u32 minor_version)
 {
 	struct nfs_client *clp = ERR_PTR(-EIO);
+	struct nfs_client *mds_clp = mds_srv->nfs_client;
+	enum xprtsec_policies xprtsec_policy = mds_clp->cl_xprtsec.policy;
 	struct nfs4_pnfs_ds_addr *da;
+	int ds_proto;
 	int status = 0;
 
 	dprintk("--> %s DS %s\n", __func__, ds->ds_remotestr);
@@ -912,12 +915,8 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				.data = &xprtdata,
 			};
 
-			if (da->da_transport != clp->cl_proto &&
-					clp->cl_proto != XPRT_TRANSPORT_TCP_TLS)
-				continue;
-			if (da->da_transport == XPRT_TRANSPORT_TCP &&
-				mds_srv->nfs_client->cl_proto ==
-					XPRT_TRANSPORT_TCP_TLS) {
+			if (xprt_args.ident == XPRT_TRANSPORT_TCP &&
+			    clp->cl_proto == XPRT_TRANSPORT_TCP_TLS) {
 				struct sockaddr *addr =
 					(struct sockaddr *)&da->da_addr;
 				struct sockaddr_in *sin =
@@ -948,7 +947,10 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				xprt_args.ident = XPRT_TRANSPORT_TCP_TLS;
 				xprt_args.servername = servername;
 			}
-			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
+			if (xprt_args.ident != clp->cl_proto)
+				continue;
+			if (xprt_args.dstaddr->sa_family !=
+			    clp->cl_addr.ss_family)
 				continue;
 
 			/**
@@ -962,15 +964,14 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 			if (xprtdata.cred)
 				put_cred(xprtdata.cred);
 		} else {
-			if (da->da_transport == XPRT_TRANSPORT_TCP &&
-				mds_srv->nfs_client->cl_proto ==
-					XPRT_TRANSPORT_TCP_TLS)
-				da->da_transport = XPRT_TRANSPORT_TCP_TLS;
-			clp = nfs4_set_ds_client(mds_srv,
-						&da->da_addr,
-						da->da_addrlen,
-						da->da_transport, timeo,
-						retrans, minor_version);
+			ds_proto = da->da_transport;
+			if (ds_proto == XPRT_TRANSPORT_TCP &&
+			    xprtsec_policy != RPC_XPRTSEC_NONE)
+				ds_proto = XPRT_TRANSPORT_TCP_TLS;
+
+			clp = nfs4_set_ds_client(mds_srv, &da->da_addr,
+						 da->da_addrlen, ds_proto,
+						 timeo, retrans, minor_version);
 			if (IS_ERR(clp))
 				continue;
 
@@ -981,7 +982,6 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				clp = ERR_PTR(-EIO);
 				continue;
 			}
-
 		}
 	}
 
-- 
2.51.0


