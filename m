Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6B94796A7
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 22:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhLQV5T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 16:57:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48646 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhLQV5S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 16:57:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A18AC623C1
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 21:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3023C36AE5;
        Fri, 17 Dec 2021 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639778238;
        bh=VfxF6h5GBW4gVLHYvHGPxRlpGOFS1+gmIxfpDZ/JuR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RxlpDBLGmZZDgJkELQH4lrh9WOWdZfr3YqFJ2x+vuFdS58Nqeswx9kY+J9A3CW+rs
         WEsotucATN06RC+4HKd7EBRsVIvG41rwlxYKx6PsOKGu2nhMlfu7eGt+oGv3NruOJg
         YvdLJpYKs6YfEm73GX7EL/RxJ1t0/P3Fq6F1OAzS32KGJ4axOj7o+20CxQAHnrNitS
         NC2nrDTJUVPGC0CpfCyuNTnQZiURocmRu8sAVBOYxHycSnSkGYg9PJwV6oDLEwE2w2
         XBj0lT5hlQw5Fv7jId/SL2p5irWibKEAcPHLQPKrvQo5rtZm2dYKP+tPQBpj8v6cLd
         MXpQy13PKmRPw==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 9/9] nfsd: Ignore rpcbind errors on nfsd startup
Date:   Fri, 17 Dec 2021 16:50:46 -0500
Message-Id: <20211217215046.40316-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217215046.40316-9-trondmy@kernel.org>
References: <20211217215046.40316-1-trondmy@kernel.org>
 <20211217215046.40316-2-trondmy@kernel.org>
 <20211217215046.40316-3-trondmy@kernel.org>
 <20211217215046.40316-4-trondmy@kernel.org>
 <20211217215046.40316-5-trondmy@kernel.org>
 <20211217215046.40316-6-trondmy@kernel.org>
 <20211217215046.40316-7-trondmy@kernel.org>
 <20211217215046.40316-8-trondmy@kernel.org>
 <20211217215046.40316-9-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

NFSv4 doesn't need rpcbind, so let's not refuse to start up just because
the rpcbind registration failed.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfsctl.c               |  7 ++++++-
 fs/nfsd/nfsd.h                 |  1 +
 fs/nfsd/nfssvc.c               | 18 ++++++++++++++++--
 include/linux/sunrpc/svcsock.h |  5 +++--
 net/sunrpc/svcsock.c           | 14 ++++++++------
 5 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index c2c3d9077dc5..50f1db5ce59b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -727,6 +727,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	char *mesg = buf;
 	int fd, err;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	int flags = SVC_SOCK_DEFAULTS;
 
 	err = get_int(&mesg, &fd);
 	if (err != 0 || fd < 0)
@@ -741,7 +742,11 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	if (err != 0)
 		return err;
 
-	err = svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
+	if (!nfsd_rpcbind_error_is_fatal())
+		flags |= SVC_SOCK_RPCBIND_NOERR;
+
+	err = svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT,
+			  flags, cred);
 	if (err < 0) {
 		nfsd_destroy(net);
 		return err;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 9664303afdaf..ebb87e43b965 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -132,6 +132,7 @@ int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
 int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change);
 void nfsd_reset_versions(struct nfsd_net *nn);
 int nfsd_create_serv(struct net *net);
+extern bool nfsd_rpcbind_error_is_fatal(void);
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 7486a6f5fc21..9e27e3c842a6 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -289,17 +289,21 @@ static int nfsd_init_socks(struct net *net, const struct cred *cred)
 {
 	int error;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	int flags = SVC_SOCK_DEFAULTS;
 
 	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
 		return 0;
 
+	if (!nfsd_rpcbind_error_is_fatal())
+		flags |= SVC_SOCK_RPCBIND_NOERR;
+
 	error = svc_create_xprt(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
-					SVC_SOCK_DEFAULTS, cred);
+				flags, cred);
 	if (error < 0)
 		return error;
 
 	error = svc_create_xprt(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
-					SVC_SOCK_DEFAULTS, cred);
+				flags, cred);
 	if (error < 0)
 		return error;
 
@@ -340,6 +344,16 @@ static void nfsd_shutdown_generic(void)
 	nfsd_file_cache_shutdown();
 }
 
+static bool nfsd_rpcbind_error_fatal = false;
+module_param(nfsd_rpcbind_error_fatal, bool, 0644);
+MODULE_PARM_DESC(nfsd_rpcbind_error_fatal,
+		 "rpcbind errors are fatal when starting nfsd.");
+
+bool nfsd_rpcbind_error_is_fatal(void)
+{
+	return nfsd_rpcbind_error_fatal;
+}
+
 /*
  * Allow admin to disable lockd. This would typically be used to allow (e.g.)
  * a userspace NLM server of some sort to be used.
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index bcc555c7ae9c..f34c222cee9d 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -61,8 +61,8 @@ void		svc_drop(struct svc_rqst *);
 void		svc_sock_update_bufs(struct svc_serv *serv);
 bool		svc_alien_sock(struct net *net, int fd);
 int		svc_addsock(struct svc_serv *serv, const int fd,
-					char *name_return, const size_t len,
-					const struct cred *cred);
+			    char *name_return, const size_t len, int flags,
+			    const struct cred *cred);
 void		svc_init_xprt_sock(void);
 void		svc_cleanup_xprt_sock(void);
 struct svc_xprt *svc_sock_create(struct svc_serv *serv, int prot);
@@ -74,5 +74,6 @@ void		svc_sock_destroy(struct svc_xprt *);
 #define SVC_SOCK_DEFAULTS	(0U)
 #define SVC_SOCK_ANONYMOUS	(1U << 0)	/* don't register with pmap */
 #define SVC_SOCK_TEMPORARY	(1U << 1)	/* flag socket as temporary */
+#define SVC_SOCK_RPCBIND_NOERR	(1U << 2)	/* Ignore pmap errors */
 
 #endif /* SUNRPC_SVCSOCK_H */
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 478f857cdaed..7f5b12a50bf9 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1309,14 +1309,15 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 	inet = sock->sk;
 
 	/* Register socket with portmapper */
-	if (pmap_register)
+	if (pmap_register) {
 		err = svc_register(serv, sock_net(sock->sk), inet->sk_family,
 				     inet->sk_protocol,
 				     ntohs(inet_sk(inet)->inet_sport));
 
-	if (err < 0) {
-		kfree(svsk);
-		return ERR_PTR(err);
+		if (err < 0 && !(flags & SVC_SOCK_RPCBIND_NOERR)) {
+			kfree(svsk);
+			return ERR_PTR(err);
+		}
 	}
 
 	svsk->sk_sock = sock;
@@ -1364,6 +1365,7 @@ EXPORT_SYMBOL_GPL(svc_alien_sock);
  * @fd: file descriptor of the new listener
  * @name_return: pointer to buffer to fill in with name of listener
  * @len: size of the buffer
+ * @flags: flags argument for svc_setup_socket()
  * @cred: credential
  *
  * Fills in socket name and returns positive length of name if successful.
@@ -1371,7 +1373,7 @@ EXPORT_SYMBOL_GPL(svc_alien_sock);
  * value.
  */
 int svc_addsock(struct svc_serv *serv, const int fd, char *name_return,
-		const size_t len, const struct cred *cred)
+		const size_t len, int flags, const struct cred *cred)
 {
 	int err = 0;
 	struct socket *so = sockfd_lookup(fd, &err);
@@ -1395,7 +1397,7 @@ int svc_addsock(struct svc_serv *serv, const int fd, char *name_return,
 	err = -ENOENT;
 	if (!try_module_get(THIS_MODULE))
 		goto out;
-	svsk = svc_setup_socket(serv, so, SVC_SOCK_DEFAULTS);
+	svsk = svc_setup_socket(serv, so, flags);
 	if (IS_ERR(svsk)) {
 		module_put(THIS_MODULE);
 		err = PTR_ERR(svsk);
-- 
2.33.1

