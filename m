Return-Path: <linux-nfs+bounces-2824-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566828A5B8B
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 21:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A391C20F1E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 19:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B415B98A;
	Mon, 15 Apr 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQa5E2Lj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B315B987;
	Mon, 15 Apr 2024 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210322; cv=none; b=fRA6aBgeJmeC5oYdSB3nWwWTbcAJXBzbjt4/IB1RQqqIJLaIYptvym5hZAoIkDIDqTV/NSDcosc+FdRFe3DrLLMd5y/tpeW8E/mF2wta1rDuZCu5KrTqi32BYTjNDk37xhy+z+yfY1j7PSD5qXCQ/MaWLohR6QZl0+Gw9Hqj2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210322; c=relaxed/simple;
	bh=/DTZXF8udDvRjKg2a8s3S2ZTaSHcPM7bxXD0dLq6SFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqdwwgmQbS0y46E6kUiYFQQmu04LUfd+KAK4jgE06PTge436aGgldZof7BMHmugRTEZWJ/JMpZdJN50RMWuNidYlO/MuftcKbPXQRNP9p9kO2yj3c+4GqMGrDwTYS1e+ZPVNLa93yh9wntu5ftWjF/Kph3l0ZJeb4Rl2y7qDLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQa5E2Lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDCEC113CC;
	Mon, 15 Apr 2024 19:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713210321;
	bh=/DTZXF8udDvRjKg2a8s3S2ZTaSHcPM7bxXD0dLq6SFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQa5E2Lji6HHbdrBWGvxWqSI6Wo0gr+xZj6HSI/7SK5t1PI7JFXLji1VGtnqbsioC
	 wMZxFnq970z1qRjQKRqMofTJ0LNePcY+xJBhYScLBN7MBJq6yLPgjVbKGJCGIg+8zu
	 p5wtlg103x6NAx3e87Fx8Lhs+WkVzFVjKG8hqA7zo2z3D9CKf3dw5za55h1W6nhc1d
	 zg+OM4p+asEvf5jur0/D4hwfa21Em0pNGzeH5173KstWrRYiEpW1mUt1Iew+2MKVkS
	 u8Edi/Oxlf+SFlicjzPlNztMnJP3Yro75Wyaf9UstN8MCtp8F4mW2vkdzs4H/01AoQ
	 epmEKr+jkVUhw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	neilb@suse.de,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v8 4/6] SUNRPC: introduce svc_xprt_create_from_sa utility routine
Date: Mon, 15 Apr 2024 21:44:37 +0200
Message-ID: <cda16835fc28aed2f69e84beebe98c19292a0800.1713209938.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713209938.git.lorenzo@kernel.org>
References: <cover.1713209938.git.lorenzo@kernel.org>
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


