Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7DE2AE411
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 00:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgKJX30 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 18:29:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732194AbgKJX3Y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 18:29:24 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C202207BB
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 23:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605050963;
        bh=U4K+MAtbIQ8FbgZDcJpUpuzaDQ0jYolkmK4uY10ZvN4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mZDVG2DTB0vQEUQmPAEYloghC4eLVleSt2QbHhLMWYDeMPFeJFgiLLHcjPtVOTx5K
         f55wj5fiF7Ba5lGKNUgXbenyHS3yFY4vpig/PMPMkumYBPAiZyBbuaNeJoGCvRvZzm
         11SLCFuUlgVzDRPynKQQ6ph5tnta7r+SKsPN5A9c=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 08/11] NFSv4/pNFS: Store the transport type in struct nfs4_pnfs_ds_addr
Date:   Tue, 10 Nov 2020 18:19:03 -0500
Message-Id: <20201110231906.863446-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110231906.863446-8-trondmy@kernel.org>
References: <20201110231906.863446-1-trondmy@kernel.org>
 <20201110231906.863446-2-trondmy@kernel.org>
 <20201110231906.863446-3-trondmy@kernel.org>
 <20201110231906.863446-4-trondmy@kernel.org>
 <20201110231906.863446-5-trondmy@kernel.org>
 <20201110231906.863446-6-trondmy@kernel.org>
 <20201110231906.863446-7-trondmy@kernel.org>
 <20201110231906.863446-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We want to enable RDMA and UDP as valid transport methods if a
GETDEVICEINFO call specifies it. Do so by adding a parser for the
netid that translates it to an appropriate argument for the RPC
transport layer.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.h     |  2 ++
 fs/nfs/pnfs_nfs.c | 34 +++++++++++++++++++---------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 2661c44c62db..f618c49697bb 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -51,6 +51,8 @@ struct nfs4_pnfs_ds_addr {
 	size_t			da_addrlen;
 	struct list_head	da_node;  /* nfs4_pnfs_dev_hlist dev_dslist */
 	char			*da_remotestr;	/* human readable addr+port */
+	const char		*da_netid;
+	int			da_transport;
 };
 
 struct nfs4_pnfs_ds {
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 8c5921be41f8..b96ecb395310 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -672,6 +672,7 @@ static struct nfs4_pnfs_ds_addr *nfs4_pnfs_ds_addr_alloc(gfp_t gfp_flags)
 static void nfs4_pnfs_ds_addr_free(struct nfs4_pnfs_ds_addr *da)
 {
 	kfree(da->da_remotestr);
+	kfree(da->da_netid);
 	kfree(da);
 }
 
@@ -867,13 +868,15 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 
 		if (!IS_ERR(clp)) {
 			struct xprt_create xprt_args = {
-				.ident = XPRT_TRANSPORT_TCP,
+				.ident = da->da_transport,
 				.net = clp->cl_net,
 				.dstaddr = (struct sockaddr *)&da->da_addr,
 				.addrlen = da->da_addrlen,
 				.servername = clp->cl_hostname,
 			};
 
+			if (da->da_transport != clp->cl_proto)
+				continue;
 			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
 				continue;
 			/* Add this address as an alias */
@@ -883,7 +886,7 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 		}
 		clp = get_v3_ds_connect(mds_srv,
 				(struct sockaddr *)&da->da_addr,
-				da->da_addrlen, IPPROTO_TCP,
+				da->da_addrlen, da->da_transport,
 				timeo, retrans);
 		if (IS_ERR(clp))
 			continue;
@@ -921,7 +924,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 
 		if (!IS_ERR(clp) && clp->cl_mvops->session_trunk) {
 			struct xprt_create xprt_args = {
-				.ident = XPRT_TRANSPORT_TCP,
+				.ident = da->da_transport,
 				.net = clp->cl_net,
 				.dstaddr = (struct sockaddr *)&da->da_addr,
 				.addrlen = da->da_addrlen,
@@ -936,6 +939,8 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				.data = &xprtdata,
 			};
 
+			if (da->da_transport != clp->cl_proto)
+				continue;
 			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
 				continue;
 			/**
@@ -950,8 +955,9 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 		} else {
 			clp = nfs4_set_ds_client(mds_srv,
 						(struct sockaddr *)&da->da_addr,
-						da->da_addrlen, IPPROTO_TCP,
-						timeo, retrans, minor_version);
+						da->da_addrlen,
+						da->da_transport, timeo,
+						retrans, minor_version);
 			if (IS_ERR(clp))
 				continue;
 
@@ -1042,8 +1048,8 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 	int nlen, rlen;
 	int tmp[2];
 	__be32 *p;
-	char *netid, *match_netid;
-	size_t len, match_netid_len;
+	char *netid;
+	size_t len;
 	char *startsep = "";
 	char *endsep = "";
 
@@ -1125,15 +1131,11 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 	case AF_INET:
 		((struct sockaddr_in *)&da->da_addr)->sin_port = port;
 		da->da_addrlen = sizeof(struct sockaddr_in);
-		match_netid = "tcp";
-		match_netid_len = 3;
 		break;
 
 	case AF_INET6:
 		((struct sockaddr_in6 *)&da->da_addr)->sin6_port = port;
 		da->da_addrlen = sizeof(struct sockaddr_in6);
-		match_netid = "tcp6";
-		match_netid_len = 4;
 		startsep = "[";
 		endsep = "]";
 		break;
@@ -1144,12 +1146,15 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 		goto out_free_da;
 	}
 
-	if (nlen != match_netid_len || strncmp(netid, match_netid, nlen)) {
-		dprintk("%s: ERROR: r_netid \"%s\" != \"%s\"\n",
-			__func__, netid, match_netid);
+	da->da_transport = xprt_find_transport_ident(netid);
+	if (da->da_transport < 0) {
+		dprintk("%s: ERROR: unknown r_netid \"%s\"\n",
+			__func__, netid);
 		goto out_free_da;
 	}
 
+	da->da_netid = netid;
+
 	/* save human readable address */
 	len = strlen(startsep) + strlen(buf) + strlen(endsep) + 7;
 	da->da_remotestr = kzalloc(len, gfp_flags);
@@ -1161,7 +1166,6 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 
 	dprintk("%s: Parsed DS addr %s\n", __func__, da->da_remotestr);
 	kfree(buf);
-	kfree(netid);
 	return da;
 
 out_free_da:
-- 
2.28.0

