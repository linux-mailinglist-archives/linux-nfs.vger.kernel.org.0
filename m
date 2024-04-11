Return-Path: <linux-nfs+bounces-2763-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAFE8A1D1C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 20:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12F01C23DC1
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B41C9EBB;
	Thu, 11 Apr 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMb8Lh5z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D43D0D5;
	Thu, 11 Apr 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854084; cv=none; b=ufDyBEAEZO14bzNJkpEVerjhE/qSRxnrGjvTQor+/bbh4Acu0pW1+gvxfcYUwC2QV4tE+v46ngLQJDIuotkCrWbSIGFfbbzra1dHdruwm8p34xEPl68SmmKqUnY4UjBgzler7Ld42LPtkKQs0h/Xzqw4atUhFgMBjyH2f2n3C1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854084; c=relaxed/simple;
	bh=rDDCCQ40eZkDzhoNQ619aqef9avomHK1F+bGjDUXk/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dobzvig3uEYFVhSu6kfXhLDaqcxNI1g/Ykv6K4f/xelASClRfkMyljrEamorrF4LBBbb3r7F4qE93iSeBe3aXgLQR+o1wFmH07L9xcGnU3DIkE+suG50cfeYNB2O2p72XUBEu0+gAkI1hMgkMxh6z1al47XRY/Rt5rA9IhEE7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMb8Lh5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658FFC072AA;
	Thu, 11 Apr 2024 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712854083;
	bh=rDDCCQ40eZkDzhoNQ619aqef9avomHK1F+bGjDUXk/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMb8Lh5z4KEUgLOM3xDk8v0/097vFoSbt63+2TL1zATKo6t3r945uLlt/lt+iQ+ys
	 a5/+eI0ERVdYHeJAYvaKjwbN50cyjMTgzlD4KEC+y6dzX7Ql1wc/pEnIiDZUhGzvnx
	 Xp5BsCRj6cgyf/J3XUZwWOwJyv0SXurSsDKgBaYp050r0deRA9Fk7HNfpaMmAM8QDf
	 bu56pBwuySMSGUzeJ0OqkxiZ3g5aFf6hyh+5F+a1RynxBFOEKZfYTd58GXZT4jV8QE
	 6YICM7BuBN8kJvq9L9nBkiOAkI5gb6nydUBeHxaYCIyH8mBeW0OUeIKiYxGLtqDQx3
	 5QVi4/oezQgjA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	netdev@vger.kernel.org,
	kuba@kernel.org
Subject: [PATCH v7 3/5] SUNRPC: introduce svc_xprt_create_from_sa utility routine
Date: Thu, 11 Apr 2024 18:47:26 +0200
Message-ID: <9bcdf0764a92db21f8003c526c90bc97984344c2.1712853394.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712853393.git.lorenzo@kernel.org>
References: <cover.1712853393.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add svc_xprt_create_from_sa utility routine and refactor
svc_xprt_create() codebase in order to introduce the capability to
create a svc port from socket address.

Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/sunrpc/svc_xprt.h |   3 +
 net/sunrpc/svc_xprt.c           | 133 ++++++++++++++++++--------------
 2 files changed, 78 insertions(+), 58 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 8e20cd60e2e7..0d9b10dbe07d 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -135,6 +135,9 @@ int	svc_reg_xprt_class(struct svc_xprt_class *);
 void	svc_unreg_xprt_class(struct svc_xprt_class *);
 void	svc_xprt_init(struct net *, struct svc_xprt_class *, struct svc_xprt *,
 		      struct svc_serv *);
+int	svc_xprt_create_from_sa(struct svc_serv *serv, const char *xprt_name,
+				struct net *net, struct sockaddr *sap,
+				int flags, const struct cred *cred);
 int	svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
 			struct net *net, const int family,
 			const unsigned short port, int flags,
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b4a85a227bd7..463fe544ae28 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -211,51 +211,6 @@ void svc_xprt_init(struct net *net, struct svc_xprt_class *xcl,
 }
 EXPORT_SYMBOL_GPL(svc_xprt_init);
 
-static struct svc_xprt *__svc_xpo_create(struct svc_xprt_class *xcl,
-					 struct svc_serv *serv,
-					 struct net *net,
-					 const int family,
-					 const unsigned short port,
-					 int flags)
-{
-	struct sockaddr_in sin = {
-		.sin_family		= AF_INET,
-		.sin_addr.s_addr	= htonl(INADDR_ANY),
-		.sin_port		= htons(port),
-	};
-#if IS_ENABLED(CONFIG_IPV6)
-	struct sockaddr_in6 sin6 = {
-		.sin6_family		= AF_INET6,
-		.sin6_addr		= IN6ADDR_ANY_INIT,
-		.sin6_port		= htons(port),
-	};
-#endif
-	struct svc_xprt *xprt;
-	struct sockaddr *sap;
-	size_t len;
-
-	switch (family) {
-	case PF_INET:
-		sap = (struct sockaddr *)&sin;
-		len = sizeof(sin);
-		break;
-#if IS_ENABLED(CONFIG_IPV6)
-	case PF_INET6:
-		sap = (struct sockaddr *)&sin6;
-		len = sizeof(sin6);
-		break;
-#endif
-	default:
-		return ERR_PTR(-EAFNOSUPPORT);
-	}
-
-	xprt = xcl->xcl_ops->xpo_create(serv, net, sap, len, flags);
-	if (IS_ERR(xprt))
-		trace_svc_xprt_create_err(serv->sv_program->pg_name,
-					  xcl->xcl_name, sap, len, xprt);
-	return xprt;
-}
-
 /**
  * svc_xprt_received - start next receiver thread
  * @xprt: controlling transport
@@ -294,9 +249,8 @@ void svc_add_new_perm_xprt(struct svc_serv *serv, struct svc_xprt *new)
 }
 
 static int _svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
-			    struct net *net, const int family,
-			    const unsigned short port, int flags,
-			    const struct cred *cred)
+			    struct net *net, struct sockaddr *sap,
+			    size_t len, int flags, const struct cred *cred)
 {
 	struct svc_xprt_class *xcl;
 
@@ -312,8 +266,11 @@ static int _svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
 			goto err;
 
 		spin_unlock(&svc_xprt_class_lock);
-		newxprt = __svc_xpo_create(xcl, serv, net, family, port, flags);
+		newxprt = xcl->xcl_ops->xpo_create(serv, net, sap, len, flags);
 		if (IS_ERR(newxprt)) {
+			trace_svc_xprt_create_err(serv->sv_program->pg_name,
+						  xcl->xcl_name, sap, len,
+						  newxprt);
 			module_put(xcl->xcl_owner);
 			return PTR_ERR(newxprt);
 		}
@@ -329,6 +286,48 @@ static int _svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
 	return -EPROTONOSUPPORT;
 }
 
+/**
+ * svc_xprt_create_from_sa - Add a new listener to @serv from socket address
+ * @serv: target RPC service
+ * @xprt_name: transport class name
+ * @net: network namespace
+ * @sap: socket address pointer
+ * @flags: SVC_SOCK flags
+ * @cred: credential to bind to this transport
+ *
+ * Return local xprt port on success or %-EPROTONOSUPPORT on failure
+ */
+int svc_xprt_create_from_sa(struct svc_serv *serv, const char *xprt_name,
+			    struct net *net, struct sockaddr *sap,
+			    int flags, const struct cred *cred)
+{
+	size_t len;
+	int err;
+
+	switch (sap->sa_family) {
+	case AF_INET:
+		len = sizeof(struct sockaddr_in);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		len = sizeof(struct sockaddr_in6);
+		break;
+#endif
+	default:
+		return -EAFNOSUPPORT;
+	}
+
+	err = _svc_xprt_create(serv, xprt_name, net, sap, len, flags, cred);
+	if (err == -EPROTONOSUPPORT) {
+		request_module("svc%s", xprt_name);
+		err = _svc_xprt_create(serv, xprt_name, net, sap, len, flags,
+				       cred);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(svc_xprt_create_from_sa);
+
 /**
  * svc_xprt_create - Add a new listener to @serv
  * @serv: target RPC service
@@ -339,23 +338,41 @@ static int _svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
  * @flags: SVC_SOCK flags
  * @cred: credential to bind to this transport
  *
- * Return values:
- *   %0: New listener added successfully
- *   %-EPROTONOSUPPORT: Requested transport type not supported
+ * Return local xprt port on success or %-EPROTONOSUPPORT on failure
  */
 int svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
 		    struct net *net, const int family,
 		    const unsigned short port, int flags,
 		    const struct cred *cred)
 {
-	int err;
+	struct sockaddr_in sin = {
+		.sin_family		= AF_INET,
+		.sin_addr.s_addr	= htonl(INADDR_ANY),
+		.sin_port		= htons(port),
+	};
+#if IS_ENABLED(CONFIG_IPV6)
+	struct sockaddr_in6 sin6 = {
+		.sin6_family		= AF_INET6,
+		.sin6_addr		= IN6ADDR_ANY_INIT,
+		.sin6_port		= htons(port),
+	};
+#endif
+	struct sockaddr *sap;
 
-	err = _svc_xprt_create(serv, xprt_name, net, family, port, flags, cred);
-	if (err == -EPROTONOSUPPORT) {
-		request_module("svc%s", xprt_name);
-		err = _svc_xprt_create(serv, xprt_name, net, family, port, flags, cred);
+	switch (family) {
+	case PF_INET:
+		sap = (struct sockaddr *)&sin;
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case PF_INET6:
+		sap = (struct sockaddr *)&sin6;
+		break;
+#endif
+	default:
+		return -EAFNOSUPPORT;
 	}
-	return err;
+
+	return svc_xprt_create_from_sa(serv, xprt_name, net, sap, flags, cred);
 }
 EXPORT_SYMBOL_GPL(svc_xprt_create);
 
-- 
2.44.0


