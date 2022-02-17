Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7114BA55F
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 17:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbiBQQGB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 11:06:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242975AbiBQQGA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 11:06:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B59B29C123
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 08:05:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BED8160B80
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 16:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E77C340E8;
        Thu, 17 Feb 2022 16:05:44 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Subject: [PATCH v2 4/8] SUNRPC: Rename svc_create_xprt()
Date:   Thu, 17 Feb 2022 11:05:44 -0500
Message-Id:  <164511394380.1361.15753264922295129414.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
References:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=6634; h=from:subject:message-id; bh=/4n6xjNrTPKewdoaB1BW0UueKaRWf+AnmYjDo7d4Wqg=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiDnJXLiLOkXSA0pBowRdk5ZL5CusNCwUQEL4eT0Ac 8gpGF7WJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYg5yVwAKCRAzarMzb2Z/lwTwD/ 4+wxWYagzFzvuuaBfP9c70aqJ8sgeATHb/e6OWSjz4kk1yxtFymWtZ/Kw2heKz4emMNNuAD0s6B6Am mFpYXXyrnV1G5nqra39zydYWIf/eLs279U8JeEp9XGvbHDDBUuMr/zIDuvJA5PLoF3tB3f/FpXMpli T0S23W8UZ2wGDoUfPzUQJC/lFiZuQLoEs2ztS+B8b+Nld+zvdKfhVrR/7mtUzezv9oaGchyWdZm3gZ THfC6qlI0ZtOrlJrLC7UzvJRe4TiWasReLoNyjNZld13d4H6wfMpTEq4DrTEyrw21KVCkYw7phH2aD qo2yKK5t4+C8En+0La3MfaZjmh3/bAZPXlVcT895xoJW0zLtT7CLkf9UfGIXOkpuVt7Ykr2m6va6h9 7vpbEOT8l8KiuEOP8J319esLnBK/WjCc8NKSuTOc5zSDPj5TnrAyhCDxT0oL3n1e2C65jz8SgF86OM Q1UkJMDQBlNb8jjQWWv0fc0dUS7QjpRroxpenXgeGg4y1aWNuF4S31NJqViXJzsJxnf+w4muVH/9Hu ILk6X7qAsYpWYeCgMLIM6gTIbzLlFPB7JAtrW/TUsPoSRRJrn6zaTtsfv3PquihQNDM6CY3bw4YwYt sdGDigL2j/w2x3KCbZHvsO8Qgwc+tmx1R9CoAqTe+h7BG90VYcngvO0b+AEA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Use the "svc_xprt_<task>" function naming convention as
is used for other external APIs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c                  |    4 ++--
 fs/nfs/callback.c               |   12 ++++++------
 fs/nfsd/nfsctl.c                |    8 ++++----
 fs/nfsd/nfssvc.c                |    8 ++++----
 include/linux/sunrpc/svc_xprt.h |    7 ++++---
 net/sunrpc/svc_xprt.c           |   24 +++++++++++++++++++-----
 6 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index f5b688a844aa..bba6f2b45b64 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -197,8 +197,8 @@ static int create_lockd_listener(struct svc_serv *serv, const char *name,
 
 	xprt = svc_find_xprt(serv, name, net, family, 0);
 	if (xprt == NULL)
-		return svc_create_xprt(serv, name, net, family, port,
-						SVC_SOCK_DEFAULTS, cred);
+		return svc_xprt_create(serv, name, net, family, port,
+				       SVC_SOCK_DEFAULTS, cred);
 	svc_xprt_put(xprt);
 	return 0;
 }
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 7a810f885063..c1a8767100ae 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -45,18 +45,18 @@ static int nfs4_callback_up_net(struct svc_serv *serv, struct net *net)
 	int ret;
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
 
-	ret = svc_create_xprt(serv, "tcp", net, PF_INET,
-				nfs_callback_set_tcpport, SVC_SOCK_ANONYMOUS,
-				cred);
+	ret = svc_xprt_create(serv, "tcp", net, PF_INET,
+			      nfs_callback_set_tcpport, SVC_SOCK_ANONYMOUS,
+			      cred);
 	if (ret <= 0)
 		goto out_err;
 	nn->nfs_callback_tcpport = ret;
 	dprintk("NFS: Callback listener port = %u (af %u, net %x)\n",
 		nn->nfs_callback_tcpport, PF_INET, net->ns.inum);
 
-	ret = svc_create_xprt(serv, "tcp", net, PF_INET6,
-				nfs_callback_set_tcpport, SVC_SOCK_ANONYMOUS,
-				cred);
+	ret = svc_xprt_create(serv, "tcp", net, PF_INET6,
+			      nfs_callback_set_tcpport, SVC_SOCK_ANONYMOUS,
+			      cred);
 	if (ret > 0) {
 		nn->nfs_callback_tcpport6 = ret;
 		dprintk("NFS: Callback listener port = %u (af %u, net %x)\n",
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 68b020f2002b..8fec779994f7 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -772,13 +772,13 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	if (err != 0)
 		return err;
 
-	err = svc_create_xprt(nn->nfsd_serv, transport, net,
-				PF_INET, port, SVC_SOCK_ANONYMOUS, cred);
+	err = svc_xprt_create(nn->nfsd_serv, transport, net,
+			      PF_INET, port, SVC_SOCK_ANONYMOUS, cred);
 	if (err < 0)
 		goto out_err;
 
-	err = svc_create_xprt(nn->nfsd_serv, transport, net,
-				PF_INET6, port, SVC_SOCK_ANONYMOUS, cred);
+	err = svc_xprt_create(nn->nfsd_serv, transport, net,
+			      PF_INET6, port, SVC_SOCK_ANONYMOUS, cred);
 	if (err < 0 && err != -EAFNOSUPPORT)
 		goto out_close;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 0c6b216e439e..ae25b7b3af99 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -293,13 +293,13 @@ static int nfsd_init_socks(struct net *net, const struct cred *cred)
 	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
 		return 0;
 
-	error = svc_create_xprt(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
-					SVC_SOCK_DEFAULTS, cred);
+	error = svc_xprt_create(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
+				SVC_SOCK_DEFAULTS, cred);
 	if (error < 0)
 		return error;
 
-	error = svc_create_xprt(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
-					SVC_SOCK_DEFAULTS, cred);
+	error = svc_xprt_create(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
+				SVC_SOCK_DEFAULTS, cred);
 	if (error < 0)
 		return error;
 
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index a3ba027fb4ba..a7f6f17c3dc5 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -127,9 +127,10 @@ int	svc_reg_xprt_class(struct svc_xprt_class *);
 void	svc_unreg_xprt_class(struct svc_xprt_class *);
 void	svc_xprt_init(struct net *, struct svc_xprt_class *, struct svc_xprt *,
 		      struct svc_serv *);
-int	svc_create_xprt(struct svc_serv *, const char *, struct net *,
-			const int, const unsigned short, int,
-			const struct cred *);
+int	svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
+			struct net *net, const int family,
+			const unsigned short port, int flags,
+			const struct cred *cred);
 void	svc_xprt_received(struct svc_xprt *xprt);
 void	svc_xprt_enqueue(struct svc_xprt *xprt);
 void	svc_xprt_put(struct svc_xprt *xprt);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 1c2295209d08..44be7193cd9b 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -285,7 +285,7 @@ void svc_add_new_perm_xprt(struct svc_serv *serv, struct svc_xprt *new)
 	svc_xprt_received(new);
 }
 
-static int _svc_create_xprt(struct svc_serv *serv, const char *xprt_name,
+static int _svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
 			    struct net *net, const int family,
 			    const unsigned short port, int flags,
 			    const struct cred *cred)
@@ -321,21 +321,35 @@ static int _svc_create_xprt(struct svc_serv *serv, const char *xprt_name,
 	return -EPROTONOSUPPORT;
 }
 
-int svc_create_xprt(struct svc_serv *serv, const char *xprt_name,
+/**
+ * svc_xprt_create - Add a new listener to @serv
+ * @serv: target RPC service
+ * @xprt_name: transport class name
+ * @net: network namespace
+ * @family: network address family
+ * @port: listener port
+ * @flags: SVC_SOCK flags
+ * @cred: credential to bind to this transport
+ *
+ * Return values:
+ *   %0: New listener added successfully
+ *   %-EPROTONOSUPPORT: Requested transport type not supported
+ */
+int svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
 		    struct net *net, const int family,
 		    const unsigned short port, int flags,
 		    const struct cred *cred)
 {
 	int err;
 
-	err = _svc_create_xprt(serv, xprt_name, net, family, port, flags, cred);
+	err = _svc_xprt_create(serv, xprt_name, net, family, port, flags, cred);
 	if (err == -EPROTONOSUPPORT) {
 		request_module("svc%s", xprt_name);
-		err = _svc_create_xprt(serv, xprt_name, net, family, port, flags, cred);
+		err = _svc_xprt_create(serv, xprt_name, net, family, port, flags, cred);
 	}
 	return err;
 }
-EXPORT_SYMBOL_GPL(svc_create_xprt);
+EXPORT_SYMBOL_GPL(svc_xprt_create);
 
 /*
  * Copy the local and remote xprt addresses to the rqstp structure

