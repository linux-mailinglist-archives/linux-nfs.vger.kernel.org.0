Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9582EB53A
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 23:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbhAEWIF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 17:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731579AbhAEWIE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 17:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609884397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3Qv8YxD/NHzN1VV61bmX+Ny39qu4HQxihaLt2goGq4=;
        b=IcT+cdDGjGH7KzRZKoF2xKCPlNX/iYndn2Z1UI82+qFC+NgszOTwXMOrHflTpE58fgwfCe
        OJGvylb6PclPKIoNIoqjdiZGF+GfWlBveWdgenErZT3afYaa9VHqEJvZy+vzFnV+/M/jNR
        mlkc7RV4fiiUVlV/QA/qUibKH3o87OE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-8pQs_ooPPtCsPvdwRQDKIg-1; Tue, 05 Jan 2021 17:06:35 -0500
X-MC-Unique: 8pQs_ooPPtCsPvdwRQDKIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1962A10054FF
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 22:06:35 +0000 (UTC)
Received: from f31-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCDC027C20
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 22:06:34 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] SUNRPC: Move simple_get_bytes and simple_get_netobj into xdr.h
Date:   Tue,  5 Jan 2021 17:06:33 -0500
Message-Id: <20210105220634.27910-2-dwysocha@redhat.com>
In-Reply-To: <20210105220634.27910-1-dwysocha@redhat.com>
References: <20210105220634.27910-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove duplicated helper functions to parse opaque XDR objects
and place inside the xdr.h file.  Also update comment which
is wrong since lockd is not the only user of xdr_netobj.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 include/linux/sunrpc/xdr.h          | 33 +++++++++++++++++++++++++++--
 net/sunrpc/auth_gss/auth_gss.c      | 29 -------------------------
 net/sunrpc/auth_gss/gss_krb5_mech.c | 29 -------------------------
 3 files changed, 31 insertions(+), 60 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 19b6dea27367..8ef788ff80b9 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -25,8 +25,7 @@ struct rpc_rqst;
 #define XDR_QUADLEN(l)		(((l) + 3) >> 2)
 
 /*
- * Generic opaque `network object.' At the kernel level, this type
- * is used only by lockd.
+ * Generic opaque `network object.'
  */
 #define XDR_MAX_NETOBJ		1024
 struct xdr_netobj {
@@ -34,6 +33,36 @@ struct xdr_netobj {
 	u8 *			data;
 };
 
+static inline const void *
+simple_get_bytes(const void *p, const void *end, void *res, size_t len)
+{
+	const void *q = (const void *)((const char *)p + len);
+	if (unlikely(q > end || q < p))
+		return ERR_PTR(-EFAULT);
+	memcpy(res, p, len);
+	return q;
+}
+
+static inline const void *
+simple_get_netobj(const void *p, const void *end, struct xdr_netobj *dest)
+{
+	const void *q;
+	unsigned int len;
+
+	p = simple_get_bytes(p, end, &len, sizeof(len));
+	if (IS_ERR(p))
+		return p;
+	q = (const void *)((const char *)p + len);
+	if (unlikely(q > end || q < p))
+		return ERR_PTR(-EFAULT);
+	dest->data = kmemdup(p, len, GFP_NOFS);
+	if (unlikely(dest->data == NULL))
+		return ERR_PTR(-ENOMEM);
+	dest->len = len;
+	return q;
+}
+
+
 /*
  * Basic structure for transmission/reception of a client XDR message.
  * Features a header (for a linear buffer containing RPC headers
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 4ecc2a959567..228456b22b23 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -125,35 +125,6 @@ gss_cred_set_ctx(struct rpc_cred *cred, struct gss_cl_ctx *ctx)
 	clear_bit(RPCAUTH_CRED_NEW, &cred->cr_flags);
 }
 
-static const void *
-simple_get_bytes(const void *p, const void *end, void *res, size_t len)
-{
-	const void *q = (const void *)((const char *)p + len);
-	if (unlikely(q > end || q < p))
-		return ERR_PTR(-EFAULT);
-	memcpy(res, p, len);
-	return q;
-}
-
-static inline const void *
-simple_get_netobj(const void *p, const void *end, struct xdr_netobj *dest)
-{
-	const void *q;
-	unsigned int len;
-
-	p = simple_get_bytes(p, end, &len, sizeof(len));
-	if (IS_ERR(p))
-		return p;
-	q = (const void *)((const char *)p + len);
-	if (unlikely(q > end || q < p))
-		return ERR_PTR(-EFAULT);
-	dest->data = kmemdup(p, len, GFP_NOFS);
-	if (unlikely(dest->data == NULL))
-		return ERR_PTR(-ENOMEM);
-	dest->len = len;
-	return q;
-}
-
 static struct gss_cl_ctx *
 gss_cred_get_ctx(struct rpc_cred *cred)
 {
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index ae9acf3a7389..99ea36d5eefe 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -143,35 +143,6 @@ get_gss_krb5_enctype(int etype)
 	return NULL;
 }
 
-static const void *
-simple_get_bytes(const void *p, const void *end, void *res, int len)
-{
-	const void *q = (const void *)((const char *)p + len);
-	if (unlikely(q > end || q < p))
-		return ERR_PTR(-EFAULT);
-	memcpy(res, p, len);
-	return q;
-}
-
-static const void *
-simple_get_netobj(const void *p, const void *end, struct xdr_netobj *res)
-{
-	const void *q;
-	unsigned int len;
-
-	p = simple_get_bytes(p, end, &len, sizeof(len));
-	if (IS_ERR(p))
-		return p;
-	q = (const void *)((const char *)p + len);
-	if (unlikely(q > end || q < p))
-		return ERR_PTR(-EFAULT);
-	res->data = kmemdup(p, len, GFP_NOFS);
-	if (unlikely(res->data == NULL))
-		return ERR_PTR(-ENOMEM);
-	res->len = len;
-	return q;
-}
-
 static inline const void *
 get_key(const void *p, const void *end,
 	struct krb5_ctx *ctx, struct crypto_sync_skcipher **res)
-- 
2.25.2

