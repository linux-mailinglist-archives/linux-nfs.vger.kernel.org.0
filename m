Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65113DB36E
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 19:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503075AbfJQRiF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 13:38:05 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:44510 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503079AbfJQRiE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 13:38:04 -0400
Received: by mail-qt1-f171.google.com with SMTP id u40so4742952qth.11
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2019 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VnEbH8L5LvnWiwCCcB3mO2kkaT5bmrMnUS65E8G77Y4=;
        b=CyMIBz/8vRIibBesd5EJDLh7X8OqlOWjVtFJA9A8/1Gj3YVwi/dWBru9tyWSSBLJlV
         zpBLTfZjoZFtaoYX705vVhaZCGBTKtUCsbdeGST5GAD+As1hFIuE+DR+5KhL1Wt8TKGB
         FMpqyzr77NM0lUKCgJ9j7tqXjcI1nhV0F7HrWmO6OAy+Pnma74Er+vLS57mt8WYtzwjn
         OPc3b+U+qrNu2rGFj0E+J+cGDcws9EwIH1DsETKwHKVfrGQMZGpxah3z/o2A4s9UZdlO
         FG/hhaNXVfUFbiQrIWuPc1YvZE15qh892GM6/fzvQVHFVsqsX2WFujbFFdwM82MltsF0
         EMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VnEbH8L5LvnWiwCCcB3mO2kkaT5bmrMnUS65E8G77Y4=;
        b=ArWOj2g0CC3vF8BUy4Kjn9H8WdyuNw3zCyct2JMDxuNOn9H+wie1Pzi6B1NOOJ7Mzn
         Bt6Sr5ka+PJmOOArX1ETWmvh82sPA/KD2xbGIeJoZNOwOcSfUka69vG9LTn4tz006bpV
         0HlRyPWIJ4fZoFogm3d3Q9i0uTSHs2HhLCNWzSq3jwdPq/H3XaJcBoxRejaV1OLmBvnX
         Y1J7GSO3iNeUloWCTfIbcLLBcec1YjNFXCYEojRRKavrSrFYWjnTleVf/7eiK00w/t0B
         6ScQQ+ddVCliYfYIU0HbYni8KGCsGH8G7pN3SLkjpoNrygl8f6GnoRDF63oRf/L2DDni
         ADtA==
X-Gm-Message-State: APjAAAWn8ydoAEP1r9p0YKlm6EKfeVqu4ji1MKVUzNot897EHgtKkU/M
        SsnczNRc+xuNeL+CIvqnJi9iTYA=
X-Google-Smtp-Source: APXvYqycgoTfkLuHz+cObTmp9l69jU6CIuZmByrv8RqnzSfule5dnEnytWB+lh0rnVXvp0ZH19HKmA==
X-Received: by 2002:a0c:e790:: with SMTP id x16mr5124958qvn.13.1571333883084;
        Thu, 17 Oct 2019 10:38:03 -0700 (PDT)
Received: from localhost.localdomain ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id l185sm1768610qkd.20.2019.10.17.10.38.02
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 10:38:02 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] NFSv4.1: Don't rebind to the same source port when reconnecting to the server
Date:   Thu, 17 Oct 2019 13:35:48 -0400
Message-Id: <20191017173548.105111-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017173548.105111-4-trond.myklebust@hammerspace.com>
References: <20191017173548.105111-1-trond.myklebust@hammerspace.com>
 <20191017173548.105111-2-trond.myklebust@hammerspace.com>
 <20191017173548.105111-3-trond.myklebust@hammerspace.com>
 <20191017173548.105111-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFSv2, v3 and NFSv4 servers often have duplicate replay caches that look
at the source port when deciding whether or not an RPC call is a replay
of a previous call. This requires clients to perform strange TCP gymnastics
in order to ensure that when they reconnect to the server, they bind
to the same source port.

NFSv4.1 and NFSv4.2 have sessions that provide proper replay semantics,
that do not look at the source port of the connection. This patch therefore
ensures they can ignore the rebind requirement.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/lockd/host.c             | 3 ++-
 fs/nfs/client.c             | 3 +++
 fs/nfs/nfs4client.c         | 5 ++++-
 include/linux/nfs_fs_sb.h   | 1 +
 include/linux/sunrpc/clnt.h | 1 +
 include/linux/sunrpc/xprt.h | 3 ++-
 net/sunrpc/clnt.c           | 7 ++++++-
 net/sunrpc/xprtsock.c       | 2 +-
 8 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index 7d46fafdbbe5..0afb6d59bad0 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -464,7 +464,8 @@ nlm_bind_host(struct nlm_host *host)
 			.version	= host->h_version,
 			.authflavor	= RPC_AUTH_UNIX,
 			.flags		= (RPC_CLNT_CREATE_NOPING |
-					   RPC_CLNT_CREATE_AUTOBIND),
+					   RPC_CLNT_CREATE_AUTOBIND |
+					   RPC_CLNT_CREATE_REUSEPORT),
 			.cred		= host->h_cred,
 		};
 
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index bd6575ee3b8e..02110a30a49e 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -523,6 +523,8 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 		args.flags |= RPC_CLNT_CREATE_INFINITE_SLOTS;
 	if (test_bit(NFS_CS_NOPING, &clp->cl_flags))
 		args.flags |= RPC_CLNT_CREATE_NOPING;
+	if (test_bit(NFS_CS_REUSEPORT, &clp->cl_flags))
+		args.flags |= RPC_CLNT_CREATE_REUSEPORT;
 
 	if (!IS_ERR(clp->cl_rpcclient))
 		return 0;
@@ -670,6 +672,7 @@ static int nfs_init_server(struct nfs_server *server,
 		.timeparms = &timeparms,
 		.cred = server->cred,
 		.nconnect = data->nfs_server.nconnect,
+		.init_flags = (1UL << NFS_CS_REUSEPORT),
 	};
 	struct nfs_client *clp;
 	int error;
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index ebc960dd89ff..abd5af77fe94 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -879,8 +879,11 @@ static int nfs4_set_client(struct nfs_server *server,
 	};
 	struct nfs_client *clp;
 
-	if (minorversion > 0 && proto == XPRT_TRANSPORT_TCP)
+	if (minorversion == 0)
+		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
+	else if (proto == XPRT_TRANSPORT_TCP)
 		cl_init.nconnect = nconnect;
+
 	if (server->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 	if (server->options & NFS_OPTION_MIGRATION)
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 69e80cef5a81..df61ff8981e8 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -47,6 +47,7 @@ struct nfs_client {
 #define NFS_CS_TSM_POSSIBLE	5		/* - Maybe state migration */
 #define NFS_CS_NOPING		6		/* - don't ping on connect */
 #define NFS_CS_DS		7		/* - Server is a DS */
+#define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
 	char *			cl_hostname;	/* hostname of server */
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index abc63bd1be2b..ec52e78d432b 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -149,6 +149,7 @@ struct rpc_add_xprt_test {
 #define RPC_CLNT_CREATE_NO_IDLE_TIMEOUT	(1UL << 8)
 #define RPC_CLNT_CREATE_NO_RETRANS_TIMEOUT	(1UL << 9)
 #define RPC_CLNT_CREATE_SOFTERR		(1UL << 10)
+#define RPC_CLNT_CREATE_REUSEPORT	(1UL << 11)
 
 struct rpc_clnt *rpc_create(struct rpc_create_args *args);
 struct rpc_clnt	*rpc_bind_new_program(struct rpc_clnt *,
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index d783e15ba898..ccd35cf4fc41 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -207,7 +207,8 @@ struct rpc_xprt {
 	unsigned int		min_reqs;	/* min number of slots */
 	unsigned int		num_reqs;	/* total slots */
 	unsigned long		state;		/* transport state */
-	unsigned char		resvport   : 1; /* use a reserved port */
+	unsigned char		resvport   : 1,	/* use a reserved port */
+				reuseport  : 1; /* reuse port on reconnect */
 	atomic_t		swapper;	/* we're swapping over this
 						   transport */
 	unsigned int		bind_index;	/* bind function index */
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index f7f78566be46..5baf9b9be2e8 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -591,6 +591,9 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 	xprt->resvport = 1;
 	if (args->flags & RPC_CLNT_CREATE_NONPRIVPORT)
 		xprt->resvport = 0;
+	xprt->reuseport = 0;
+	if (args->flags & RPC_CLNT_CREATE_REUSEPORT)
+		xprt->reuseport = 1;
 
 	clnt = rpc_create_xprt(args, xprt);
 	if (IS_ERR(clnt) || args->nconnect <= 1)
@@ -2906,7 +2909,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 	struct rpc_xprt *xprt;
 	unsigned long connect_timeout;
 	unsigned long reconnect_timeout;
-	unsigned char resvport;
+	unsigned char resvport, reuseport;
 	int ret = 0;
 
 	rcu_read_lock();
@@ -2918,6 +2921,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 		return -EAGAIN;
 	}
 	resvport = xprt->resvport;
+	reuseport = xprt->reuseport;
 	connect_timeout = xprt->connect_timeout;
 	reconnect_timeout = xprt->max_reconnect_timeout;
 	rcu_read_unlock();
@@ -2928,6 +2932,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 		goto out_put_switch;
 	}
 	xprt->resvport = resvport;
+	xprt->reuseport = reuseport;
 	if (xprt->ops->set_connect_timeout != NULL)
 		xprt->ops->set_connect_timeout(xprt,
 				connect_timeout,
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 70e52f567b2a..98e2d40b2d6a 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1752,7 +1752,7 @@ static void xs_set_port(struct rpc_xprt *xprt, unsigned short port)
 
 static void xs_set_srcport(struct sock_xprt *transport, struct socket *sock)
 {
-	if (transport->srcport == 0)
+	if (transport->srcport == 0 && transport->xprt.reuseport)
 		transport->srcport = xs_sock_getport(sock);
 }
 
-- 
2.21.0

