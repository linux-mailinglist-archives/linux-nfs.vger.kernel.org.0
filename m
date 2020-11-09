Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836572AC70C
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 22:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgKIVUq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 16:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgKIVUp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 16:20:45 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF0C0613CF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 13:20:45 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id 7so2727992qtp.1
        for <linux-nfs@vger.kernel.org>; Mon, 09 Nov 2020 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3YMYsfzCKFWvDxH+k2fwaV0VgjexShy3TrQPd/Tm0DY=;
        b=kx349ksSm2ScPDE0jPO1MnGkoEwn1kwtF2SgWNGVyU0C9HnBq8gFmHmxsLi15SYVbH
         t41jDcN01FK3MmAtw5KWnti129AT4kTaZV+/I1HcKCQbwVXKXlUeECh3PfCGMCihP+YZ
         6xOygR9UJQgrbBDsViFwmteOkl1p6VDlpA9/liZfWi0aYcxDwnkms/TckApjFj8EEeMp
         1KC3+O59H9Vb7szwT9bgcbW50N7AkivMOpUrERZ0ixmIRs94zw5aGra3hCyRlr11wKVO
         pmRW971VRlDW7ngRh3X+rQKDYSthPKUsQqnGm+EBRqmUCxBbbeXe8P04mz+dVJCcpF6d
         7BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YMYsfzCKFWvDxH+k2fwaV0VgjexShy3TrQPd/Tm0DY=;
        b=eYihF/5uwLm22nlstUljR49OO8vLOEOZyBz1xa62X0qJ8zbn86Clqi6Sud25+4BX1n
         nYoHTUCU5xW8w57IvxlQCVTSsgagw7KcP3azY9gB/F7gIkr9/TKr/xshBJikuGmVwNFe
         CrSJHs0ZL+WfWKkiyuuQ6fHeMP28ibZQVAE59fJNWZS2WfzImWs1CQF5+cYhV0zZtiQp
         6jO5NFkw+WjT9ErkxWLwBvIh7prIJ3j9dtl+cOYdTS8MmIpQ/iRZOxlKdw1T/Kdcqnm7
         OBTzXY2+dp78tFfM7MnHsX2F7tZlhVX4Zt4QwjKgbTUoPCvmrAnp8EcGe72Lt6WR3oTj
         cPUg==
X-Gm-Message-State: AOAM532sQ6LJSZK9W6yadN28FAyGPfJSha006adXmrNLLJKCVpYOs8V4
        q236mEb+FkRQaTZo/wdEhxv10N//hCQF
X-Google-Smtp-Source: ABdhPJxVfBZ7mq5xEFX3bZp0CgU8HNzbqZ44VA10iEb2CsFVS/aSNRKH/gsB3W+1D1bBr7yjjNU+XQ==
X-Received: by 2002:ac8:7555:: with SMTP id b21mr15212480qtr.119.1604956844564;
        Mon, 09 Nov 2020 13:20:44 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id d188sm7025241qkb.10.2020.11.09.13.20.43
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:20:43 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/5] NFSv4/pNFS: Store the transport type in struct nfs4_pnfs_ds_addr
Date:   Mon,  9 Nov 2020 16:10:27 -0500
Message-Id: <20201109211029.540993-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109211029.540993-3-trond.myklebust@hammerspace.com>
References: <20201109211029.540993-1-trond.myklebust@hammerspace.com>
 <20201109211029.540993-2-trond.myklebust@hammerspace.com>
 <20201109211029.540993-3-trond.myklebust@hammerspace.com>
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
 fs/nfs/pnfs.h     |  1 +
 fs/nfs/pnfs_nfs.c | 66 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 2661c44c62db..20ee37b751e3 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -51,6 +51,7 @@ struct nfs4_pnfs_ds_addr {
 	size_t			da_addrlen;
 	struct list_head	da_node;  /* nfs4_pnfs_dev_hlist dev_dslist */
 	char			*da_remotestr;	/* human readable addr+port */
+	int			da_transport;
 };
 
 struct nfs4_pnfs_ds {
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 7027dac41cc7..d00750743100 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -854,13 +854,15 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 
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
@@ -870,7 +872,7 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 		}
 		clp = get_v3_ds_connect(mds_srv,
 				(struct sockaddr *)&da->da_addr,
-				da->da_addrlen, IPPROTO_TCP,
+				da->da_addrlen, da->da_transport,
 				timeo, retrans);
 		if (IS_ERR(clp))
 			continue;
@@ -908,7 +910,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 
 		if (!IS_ERR(clp) && clp->cl_mvops->session_trunk) {
 			struct xprt_create xprt_args = {
-				.ident = XPRT_TRANSPORT_TCP,
+				.ident = da->da_transport,
 				.net = clp->cl_net,
 				.dstaddr = (struct sockaddr *)&da->da_addr,
 				.addrlen = da->da_addrlen,
@@ -923,6 +925,8 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				.data = &xprtdata,
 			};
 
+			if (da->da_transport != clp->cl_proto)
+				continue;
 			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
 				continue;
 			/**
@@ -937,8 +941,9 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
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
 
@@ -1017,6 +1022,41 @@ int nfs4_pnfs_ds_connect(struct nfs_server *mds_srv, struct nfs4_pnfs_ds *ds,
 }
 EXPORT_SYMBOL_GPL(nfs4_pnfs_ds_connect);
 
+struct xprt_lookup_transport {
+	const char *name;
+	sa_family_t protofamily;
+	int type;
+};
+
+static const struct xprt_lookup_transport xl_xprt[] = {
+	{ "tcp", AF_INET, XPRT_TRANSPORT_TCP },
+	{ "tcp6", AF_INET6, XPRT_TRANSPORT_TCP },
+	{ "rdma", AF_INET, XPRT_TRANSPORT_RDMA },
+	{ "rdma6", AF_INET6, XPRT_TRANSPORT_RDMA },
+	{ "udp", AF_INET, XPRT_TRANSPORT_UDP },
+	{ "udp6", AF_INET6, XPRT_TRANSPORT_UDP },
+	{ NULL, 0, -1 },
+};
+
+static int
+nfs4_decode_transport(const char *str, size_t len, sa_family_t protofamily)
+{
+	const struct xprt_lookup_transport *p;
+
+	for (p = xl_xprt; p->name; p++) {
+		if (p->protofamily != protofamily)
+			continue;
+		if (strlen(p->name) != len)
+			continue;
+		if (memcmp(p->name, str, len) != 0)
+			continue;
+		if (xprt_load_transport(p->name) != 0)
+			continue;
+		return p->type;
+	}
+	return -1;
+}
+
 /*
  * Currently only supports ipv4, ipv6 and one multi-path address.
  */
@@ -1029,8 +1069,8 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 	int nlen, rlen;
 	int tmp[2];
 	__be32 *p;
-	char *netid, *match_netid;
-	size_t len, match_netid_len;
+	char *netid;
+	size_t len;
 	char *startsep = "";
 	char *endsep = "";
 
@@ -1114,15 +1154,11 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
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
@@ -1133,9 +1169,11 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 		goto out_free_da;
 	}
 
-	if (nlen != match_netid_len || strncmp(netid, match_netid, nlen)) {
-		dprintk("%s: ERROR: r_netid \"%s\" != \"%s\"\n",
-			__func__, netid, match_netid);
+	da->da_transport = nfs4_decode_transport(netid, nlen,
+						 da->da_addr.ss_family);
+	if (da->da_transport == -1) {
+		dprintk("%s: ERROR: unknown r_netid \"%*s\"\n",
+			__func__, nlen, netid);
 		goto out_free_da;
 	}
 
-- 
2.28.0

