Return-Path: <linux-nfs+bounces-3605-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 129F3900691
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9377F1F21A6F
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9BD194C8B;
	Fri,  7 Jun 2024 14:27:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB85196C85
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770442; cv=none; b=BBYgBjZCF1IBTM3pA/kcClxuAJgIOXsgq2xVdc+KXaF+BZwvjRswRGhsVtPTQP1VqWZFWKRXoMt7gOnHvSWLgtyBZuTCjWMcudvdTytPVIaJVn2sJBEXyqQVoGsN5AyADXKvSYC1Jw3acQlSPXxBfmje2T+7xNMUIN6HyR9QsWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770442; c=relaxed/simple;
	bh=cpmD9ZVZclFV9JAZm6ICzgdyGq0tUSrO9GpmjBgCvy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhFZLVmItPKIw1vL0N0FxF30Q//S0TJ5mixlK6d4yhkBx4Hx5vG6CYcg5Cs981ictYW/34hbzJ1l/KylR2vLYD678MKVTo5b2N/PCikFGVtg2zy9pDV75xFU/OZx8rksNY7mlknzg3cFfwCrg7802O7k2Y7DbVjcES9asD6Xufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79525719d8dso243235785a.1
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770439; x=1718375239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9MBNjUspKAZI+xXkHKv7MJU7b9w+ArZQrp5DZdvkjw=;
        b=laq/ZZSC6IY7BK6b0BbyZkPmEmd4q9Z76ovPybB/Vp2lkrPv4H7wJjRuPtr3tN2lVx
         hKozUPkNH0X+/VYj+Zskmw0tZ5Rh8CcC2nq4RGw6/rMK7UKhesIrLSHNuoXgHt1lvXIx
         x43Sz0nAN4pkBw1ylecRqdYUnPao9gZGtSEQIOCKxP33BJKnYyMQWa0B5vljtmzf/3uM
         UDLEPhEYEt8XEXG+1FRXwHFYqJUCKn9pfuc4x4Jz1pyuR+loLICMMEUA+ztlzizlyqy0
         5FINy97F/L/PftWvP4ZW98F350ATJiqPu1j2pfsMKmzVN4WwDxMkFjAw8EcsYNIZwjtA
         tlVw==
X-Gm-Message-State: AOJu0YxfHrFu1ki2DzRq0C5MjbuWY3GY8H4iXO3YHtq59smNbqyOEPyP
	PZuvFSqSsM6dB+Ku1bZoOAyc3v6BzECTMhQC5wpM8+Q2hNFa+TR4p9YdF4YGOgcCVErFAQ7rqnj
	P1GY=
X-Google-Smtp-Source: AGHT+IFEg53q818HnlodCKvoOnQ3mqMWuMrdblgwjAO6VYSUC/TDoJc5uBrXJbF2QDf54fiDBPtnCA==
X-Received: by 2002:a05:6214:3986:b0:6af:2672:c758 with SMTP id 6a1803df08f44-6b05b045fb1mr34598526d6.0.1717770439508;
        Fri, 07 Jun 2024 07:27:19 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f9f8b0asm17520206d6.123.2024.06.07.07.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:17 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 20/29] nfs/localio: discontinue network address based localio setup
Date: Fri,  7 Jun 2024 10:26:37 -0400
Message-ID: <20240607142646.20924-21-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepares for determining localio via client and server handshake.

The primary reason to avoid the current approach of probing all local
network interfaces for the client (during nfs_alloc_client) to use as
the basis for _inferring_ that client's server is local
(in nfs_local_probe) is: matching IP addresses is brittle, especially
so when you have network namespaces (i.e. containers), or when you
play games with NAT or iptables.

This commit also reverts an earlier commit ("sunrpc: add and export
rpc_ntop6_addr_noscopeid") which was only needed/useful in the context
of localio's sockaddr based matching.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c                           |   9 --
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |  21 +---
 fs/nfs/internal.h                         |   7 --
 fs/nfs/localio.c                          | 145 +---------------------
 include/linux/nfs_fs_sb.h                 |   1 -
 include/linux/sunrpc/addr.h               |   9 --
 net/sunrpc/addr.c                         |  19 +--
 7 files changed, 8 insertions(+), 203 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 288de750fd3b..c42faaed508c 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -170,7 +170,6 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	}
 
 	INIT_LIST_HEAD(&clp->cl_superblocks);
-	INIT_LIST_HEAD(&clp->cl_local_addrs);
 	clp->cl_rpcclient = ERR_PTR(-EINVAL);
 
 	clp->cl_flags = cl_init->init_flags;
@@ -184,7 +183,6 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 
 	clp->cl_principal = "*";
 	clp->cl_xprtsec = cl_init->xprtsec;
-	nfs_probe_local_addr(clp);
 	return clp;
 
 error_cleanup:
@@ -238,19 +236,12 @@ static void pnfs_init_server(struct nfs_server *server)
  */
 void nfs_free_client(struct nfs_client *clp)
 {
-	struct nfs_local_addr *addr, *tmp;
-
 	nfs_local_disable(clp);
 
 	/* -EIO all pending I/O */
 	if (!IS_ERR(clp->cl_rpcclient))
 		rpc_shutdown_client(clp->cl_rpcclient);
 
-	list_for_each_entry_safe(addr, tmp, &clp->cl_local_addrs, cl_addrs) {
-		list_del(&addr->cl_addrs);
-		kfree(addr);
-	}
-
 	put_net(clp->cl_net);
 	put_nfs_version(clp->cl_nfs_mod);
 	kfree(clp->cl_hostname);
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index af329d9b7d1e..e58bedfb1dcc 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -348,22 +348,6 @@ ff_layout_init_mirror_ds(struct pnfs_layout_hdr *lo,
 	return false;
 }
 
-static bool ff_layout_ds_is_local(struct nfs4_pnfs_ds *ds)
-{
-	struct nfs_local_addr *addr;
-	struct sockaddr *sap;
-	struct nfs4_pnfs_ds_addr *da;
-
-	list_for_each_entry(da, &ds->ds_addrs, da_node) {
-		sap = (struct sockaddr *)&da->da_addr;
-		list_for_each_entry(addr, &ds->ds_clp->cl_local_addrs, cl_addrs)
-			if (rpc_cmp_addr((struct sockaddr *)&addr->address, sap))
-				return true;
-	}
-
-	return false;
-}
-
 /**
  * nfs4_ff_layout_prepare_ds - prepare a DS connection for an RPC call
  * @lseg: the layout segment we're operating on
@@ -416,10 +400,7 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 		 * keep ds_clp even if DS is local, so that if local IO cannot
 		 * proceed somehow, we can fall back to NFS whenever we want.
 		 */
-		if (ff_layout_ds_is_local(ds)) {
-			dprintk("%s: found local DS\n", __func__);
-			nfs_local_enable(ds->ds_clp);
-		}
+		nfs_local_probe(ds->ds_clp);
 		max_payload =
 			nfs_block_size(rpc_max_payload(ds->ds_clp->cl_rpcclient),
 				       NULL);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 0927a1704bbb..6d75466ad356 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -204,12 +204,6 @@ struct nfs_mount_request {
 	struct net		*net;
 };
 
-struct nfs_local_addr {
-	struct list_head	cl_addrs;
-	struct sockaddr_storage	address;
-	size_t			addrlen;
-};
-
 extern int nfs_mount(struct nfs_mount_request *info, int timeo, int retrans);
 extern void nfs_umount(const struct nfs_mount_request *info);
 
@@ -475,7 +469,6 @@ extern int nfs_local_doio(struct nfs_client *, struct file *,
 extern int nfs_local_commit(struct nfs_client *, struct file *,
 			    struct nfs_commit_data *,
 			    const struct rpc_call_ops *, int);
-extern void nfs_probe_local_addr(struct nfs_client *clnt);
 extern bool nfs_server_is_local(const struct nfs_client *clp);
 
 /* super.c */
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index d724f8d4dd65..96349b6e7585 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -20,8 +20,6 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_xdr.h>
 
-#include <uapi/linux/if_arp.h>
-
 #include "internal.h"
 #include "pnfs.h"
 #include "nfstrace.h"
@@ -216,7 +214,6 @@ nfs_local_enable(struct nfs_client *clp)
 		trace_nfs_local_enable(clp);
 	}
 }
-EXPORT_SYMBOL_GPL(nfs_local_enable);
 
 /*
  * nfs_local_disable - disable local i/o for an nfs_client
@@ -236,50 +233,12 @@ nfs_local_disable(struct nfs_client *clp)
 void
 nfs_local_probe(struct nfs_client *clp)
 {
-	struct sockaddr_in *sin;
-	struct sockaddr_in6 *sin6;
-	struct nfs_local_addr *addr;
-	struct sockaddr *sap;
 	bool enable = false;
 
-	switch (clp->cl_addr.ss_family) {
-	case AF_INET:
-		sin = (struct sockaddr_in *)&clp->cl_addr;
-		if (ipv4_is_loopback(sin->sin_addr.s_addr)) {
-			dprintk("%s: detected IPv4 loopback address\n",
-				__func__);
-			enable = true;
-		}
-		break;
-	case AF_INET6:
-		sin6 = (struct sockaddr_in6 *)&clp->cl_addr;
-		if (memcmp(&sin6->sin6_addr, &in6addr_loopback,
-		    sizeof(struct in6_addr)) == 0) {
-			dprintk("%s: detected IPv6 loopback address\n",
-				__func__);
-			enable = true;
-		}
-		break;
-	default:
-		break;
-	}
-
-	if (enable)
-		goto out;
-
-	list_for_each_entry(addr, &clp->cl_local_addrs, cl_addrs) {
-		sap = (struct sockaddr *)&addr->address;
-		if (rpc_cmp_addr((struct sockaddr *)&clp->cl_addr, sap)) {
-			dprintk("%s: detected local server.\n", __func__);
-			enable = true;
-			break;
-		}
-	}
-
-out:
 	if (enable)
 		nfs_local_enable(clp);
 }
+EXPORT_SYMBOL_GPL(nfs_local_probe);
 
 /*
  * nfs_local_open_fh - open a local filehandle
@@ -880,105 +839,3 @@ nfs_local_commit(struct nfs_client *clp, struct file *filp,
 	nfs_local_fsync_ctx_put(ctx);
 	return 0;
 }
-
-static int
-nfs_client_add_addr(struct nfs_client *clnt, char *buf, gfp_t flags)
-{
-	struct nfs_local_addr *addr;
-	struct sockaddr *sap;
-
-	dprintk("%s: adding new local IP %s\n", __func__, buf);
-	addr = kmalloc(sizeof(*addr), flags);
-	if (!addr) {
-		printk(KERN_WARNING "NFS: cannot alloc new addr\n");
-		return -ENOMEM;
-	}
-	sap = (struct sockaddr *)&addr->address;
-	addr->addrlen = rpc_pton(clnt->cl_net, buf, strlen(buf),
-				sap, sizeof(addr->address));
-	if (!addr->addrlen) {
-		printk(KERN_WARNING "NFS: cannot parse new addr %s\n",
-				buf);
-		kfree(addr);
-		return -EINVAL;
-	}
-	list_add(&addr->cl_addrs, &clnt->cl_local_addrs);
-
-	return 0;
-}
-
-static int
-nfs_client_add_v4_addr(struct nfs_client *clnt, struct in_device *indev,
-		       char *buf, size_t buflen)
-{
-	struct in_ifaddr *ifa;
-	int ret;
-
-	in_dev_for_each_ifa_rtnl(ifa, indev) {
-		snprintf(buf, buflen, "%pI4", &ifa->ifa_local);
-		ret = nfs_client_add_addr(clnt, buf, GFP_KERNEL);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static int
-nfs_client_add_v6_addr(struct nfs_client *clnt, struct inet6_dev *in6dev,
-		       char *buf, size_t buflen)
-{
-	struct inet6_ifaddr *ifp;
-	int ret = 0;
-
-	read_lock_bh(&in6dev->lock);
-	list_for_each_entry(ifp, &in6dev->addr_list, if_list) {
-		rpc_ntop6_addr_noscopeid(&ifp->addr, buf, buflen);
-		ret = nfs_client_add_addr(clnt, buf, GFP_ATOMIC);
-		if (ret < 0)
-			goto out;
-	}
-out:
-	read_unlock_bh(&in6dev->lock);
-	return ret;
-}
-#else /* CONFIG_IPV6 */
-static int
-nfs_client_add_v6_addr(struct nfs_client *clnt, struct inet6_dev *in6dev,
-		       char *buf, size_t buflen)
-{
-	return 0;
-}
-#endif
-
-/* Find out all local IP addresses. Ignore errors
- * because local IO can be optional.
- */
-void
-nfs_probe_local_addr(struct nfs_client *clnt)
-{
-	struct net_device *dev;
-	struct in_device *indev;
-	struct inet6_dev *in6dev;
-	char buf[INET6_ADDRSTRLEN + IPV6_SCOPE_ID_LEN];
-	size_t buflen = sizeof(buf);
-
-	rtnl_lock();
-
-	for_each_netdev(clnt->cl_net, dev) {
-		if (dev->type == ARPHRD_LOOPBACK ||
-		    !(dev->flags & IFF_UP))
-			continue;
-		indev = __in_dev_get_rtnl(dev);
-		if (indev &&
-		    nfs_client_add_v4_addr(clnt, indev, buf, buflen) < 0)
-			break;
-		in6dev = __in6_dev_get(dev);
-		if (in6dev &&
-		    nfs_client_add_v6_addr(clnt, in6dev, buf, buflen) < 0)
-			break;
-	}
-
-	rtnl_unlock();
-}
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 6b603b0247f1..00fe469bc72e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -56,7 +56,6 @@ struct nfs_client {
 	char *			cl_acceptor;	/* GSSAPI acceptor name */
 	struct list_head	cl_share_link;	/* link in global client list */
 	struct list_head	cl_superblocks;	/* List of nfs_server structs */
-	struct list_head	cl_local_addrs;	/* List of local addresses */
 
 	struct rpc_clnt *	cl_rpcclient;
 	const struct nfs_rpc_ops *rpc_ops;	/* NFS protocol vector */
diff --git a/include/linux/sunrpc/addr.h b/include/linux/sunrpc/addr.h
index e1007bddc3c4..07d454873b6d 100644
--- a/include/linux/sunrpc/addr.h
+++ b/include/linux/sunrpc/addr.h
@@ -68,9 +68,6 @@ static inline bool __rpc_copy_addr4(struct sockaddr *dst,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-extern size_t rpc_ntop6_addr_noscopeid(const struct in6_addr *addr,
-				       char *buf, const int buflen);
-
 static inline bool rpc_cmp_addr6(const struct sockaddr *sap1,
 				 const struct sockaddr *sap2)
 {
@@ -97,12 +94,6 @@ static inline bool __rpc_copy_addr6(struct sockaddr *dst,
 	return true;
 }
 #else	/* !(IS_ENABLED(CONFIG_IPV6) */
-static size_t rpc_ntop6_addr_noscopeid(const struct in6_addr *addr,
-				       char *buf, const int buflen)
-{
-	return 0;
-}
-
 static inline bool rpc_cmp_addr6(const struct sockaddr *sap1,
 				   const struct sockaddr *sap2)
 {
diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
index 78a123a7c39b..97ff11973c49 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -25,9 +25,12 @@
 
 #if IS_ENABLED(CONFIG_IPV6)
 
-size_t rpc_ntop6_addr_noscopeid(const struct in6_addr *addr,
-				char *buf, const int buflen)
+static size_t rpc_ntop6_noscopeid(const struct sockaddr *sap,
+				  char *buf, const int buflen)
 {
+	const struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sap;
+	const struct in6_addr *addr = &sin6->sin6_addr;
+
 	/*
 	 * RFC 4291, Section 2.2.2
 	 *
@@ -52,23 +55,13 @@ size_t rpc_ntop6_addr_noscopeid(const struct in6_addr *addr,
 	 */
 	if (ipv6_addr_v4mapped(addr))
 		return snprintf(buf, buflen, "::ffff:%pI4",
-				&addr->s6_addr32[3]);
+					&addr->s6_addr32[3]);
 
 	/*
 	 * RFC 4291, Section 2.2.1
 	 */
 	return snprintf(buf, buflen, "%pI6c", addr);
 }
-EXPORT_SYMBOL_GPL(rpc_ntop6_addr_noscopeid);
-
-static size_t rpc_ntop6_noscopeid(const struct sockaddr *sap,
-				  char *buf, const int buflen)
-{
-	const struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sap;
-	const struct in6_addr *addr = &sin6->sin6_addr;
-
-	return rpc_ntop6_addr_noscopeid(addr, buf, buflen);
-}
 
 static size_t rpc_ntop6(const struct sockaddr *sap,
 			char *buf, const size_t buflen)
-- 
2.44.0


