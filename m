Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 073C0131954
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgAFU1b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:31 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45898 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFU1a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:30 -0500
Received: by mail-yb1-f196.google.com with SMTP id y67so12949050yba.12
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+snDxw5LWzA/yVXLyueqvl0AS6uUMQiDPvu/gPn61E=;
        b=m5XZc0jgXttb9Zq5uPrLDFjQcPzkZAapWveMcO20vFNhbisa1WlWibiuwJh0j0+GTp
         un+4VO2p2YczHHbHKwiwAAurfIEBdtDXLpRMy/Rb6MaAeNdtmP9WpMMx3J0BM2Bpdfw8
         9MJBxHvLJTfZhSnpbSOtYKnMHI4kXt+WhlHhyKmYghdCGjI3RHNSxRU3H7o/J00FqSWO
         hod1x4KlvNjrtD32E1Eujc8H4uA1DGJfZeGd6u8Wr8EKHyxOFLVFJwd5pnfoL94NJEkc
         BhYzIERY+NbuYobqy7vgFB5NTfcj8EdL9Dm7I66dXeS9Xc2nVtYzgnim2DHMdb39Ooi8
         iHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+snDxw5LWzA/yVXLyueqvl0AS6uUMQiDPvu/gPn61E=;
        b=j7uYZCGevnJHsKU9mNhSc37rlLQ0dh/sydQPoCrwhp2BcnBYInhWQhSpxyi7v9uM/i
         f5tjU2lhM0DCFC49Z99nEJdEODruY/SGBTcYQ7YKzPzjKUBYlONPt6tgYSVPetu6j5Cr
         Ymh9+/3LF1nlrW5XSK+Viv6xneDbgNI+0jfDucFwJrtLNfER6NLgEOs4stgR0Smb3lVw
         fF3buLoNnqtAA0OUNgwMbLrOmu3tjm/G6cyvsb9+F9vJPWVgMMItS0lMaiNsiMkFNZf4
         ENVEHRuDgp7jY8q1C25Xj7Xo46Rk7KD4oJx7z0VNeJbTO/pPwH42vILTnZHrqbR3S7lI
         8dsQ==
X-Gm-Message-State: APjAAAUqudk7PFgJ8uFsR7nemD+qXlcjcx++GcmzDoMS6WVrXwiEwlIF
        UNutMj/QMY3OJ1hj5nLHLDGM7F+xbQ==
X-Google-Smtp-Source: APXvYqySg5rwx+VwZSiH1zu4p1kXXTBTP2eAUfIbu5cKGZ+eP6uDN/wp2921n3uTNN3SKH/Ophd7bg==
X-Received: by 2002:a25:2d55:: with SMTP id s21mr75247556ybe.521.1578342449248;
        Mon, 06 Jan 2020 12:27:29 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:28 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 03/15] SUNRPC: Remove broken gss_mech_list_pseudoflavors()
Date:   Mon,  6 Jan 2020 15:25:02 -0500
Message-Id: <20200106202514.785483-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-3-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
 <20200106202514.785483-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove gss_mech_list_pseudoflavors() and its callers. This is part of
an unused API, and could leak an RCU reference if it were ever called.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/auth.h           |  2 --
 include/linux/sunrpc/gss_api.h        |  3 --
 net/sunrpc/auth.c                     | 49 ---------------------------
 net/sunrpc/auth_gss/auth_gss.c        |  1 -
 net/sunrpc/auth_gss/gss_mech_switch.c | 29 ----------------
 5 files changed, 84 deletions(-)

diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
index e9ec742796e7..4f6b28487f28 100644
--- a/include/linux/sunrpc/auth.h
+++ b/include/linux/sunrpc/auth.h
@@ -113,7 +113,6 @@ struct rpc_authops {
 	int			(*hash_cred)(struct auth_cred *, unsigned int);
 	struct rpc_cred *	(*lookup_cred)(struct rpc_auth *, struct auth_cred *, int);
 	struct rpc_cred *	(*crcreate)(struct rpc_auth*, struct auth_cred *, int, gfp_t);
-	int			(*list_pseudoflavors)(rpc_authflavor_t *, int);
 	rpc_authflavor_t	(*info2flavor)(struct rpcsec_gss_info *);
 	int			(*flavor2info)(rpc_authflavor_t,
 						struct rpcsec_gss_info *);
@@ -158,7 +157,6 @@ rpc_authflavor_t	rpcauth_get_pseudoflavor(rpc_authflavor_t,
 				struct rpcsec_gss_info *);
 int			rpcauth_get_gssinfo(rpc_authflavor_t,
 				struct rpcsec_gss_info *);
-int			rpcauth_list_flavors(rpc_authflavor_t *, int);
 struct rpc_cred *	rpcauth_lookup_credcache(struct rpc_auth *, struct auth_cred *, int, gfp_t);
 void			rpcauth_init_cred(struct rpc_cred *, const struct auth_cred *, struct rpc_auth *, const struct rpc_credops *);
 struct rpc_cred *	rpcauth_lookupcred(struct rpc_auth *, int);
diff --git a/include/linux/sunrpc/gss_api.h b/include/linux/sunrpc/gss_api.h
index bd691e08be3b..4c4cb087f3e8 100644
--- a/include/linux/sunrpc/gss_api.h
+++ b/include/linux/sunrpc/gss_api.h
@@ -150,9 +150,6 @@ struct gss_api_mech *gss_mech_get_by_name(const char *);
 /* Similar, but get by pseudoflavor. */
 struct gss_api_mech *gss_mech_get_by_pseudoflavor(u32);
 
-/* Fill in an array with a list of supported pseudoflavors */
-int gss_mech_list_pseudoflavors(rpc_authflavor_t *, int);
-
 struct gss_api_mech * gss_mech_get(struct gss_api_mech *);
 
 /* For every successful gss_mech_get or gss_mech_get_by_* call there must be a
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index cdb05b48de44..5748ad0ba1bd 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -221,55 +221,6 @@ rpcauth_get_gssinfo(rpc_authflavor_t pseudoflavor, struct rpcsec_gss_info *info)
 }
 EXPORT_SYMBOL_GPL(rpcauth_get_gssinfo);
 
-/**
- * rpcauth_list_flavors - discover registered flavors and pseudoflavors
- * @array: array to fill in
- * @size: size of "array"
- *
- * Returns the number of array items filled in, or a negative errno.
- *
- * The returned array is not sorted by any policy.  Callers should not
- * rely on the order of the items in the returned array.
- */
-int
-rpcauth_list_flavors(rpc_authflavor_t *array, int size)
-{
-	const struct rpc_authops *ops;
-	rpc_authflavor_t flavor, pseudos[4];
-	int i, len, result = 0;
-
-	rcu_read_lock();
-	for (flavor = 0; flavor < RPC_AUTH_MAXFLAVOR; flavor++) {
-		ops = rcu_dereference(auth_flavors[flavor]);
-		if (result >= size) {
-			result = -ENOMEM;
-			break;
-		}
-
-		if (ops == NULL)
-			continue;
-		if (ops->list_pseudoflavors == NULL) {
-			array[result++] = ops->au_flavor;
-			continue;
-		}
-		len = ops->list_pseudoflavors(pseudos, ARRAY_SIZE(pseudos));
-		if (len < 0) {
-			result = len;
-			break;
-		}
-		for (i = 0; i < len; i++) {
-			if (result >= size) {
-				result = -ENOMEM;
-				break;
-			}
-			array[result++] = pseudos[i];
-		}
-	}
-	rcu_read_unlock();
-	return result;
-}
-EXPORT_SYMBOL_GPL(rpcauth_list_flavors);
-
 struct rpc_auth *
 rpcauth_create(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
 {
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index d75fddca44c9..24ca861815b1 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -2118,7 +2118,6 @@ static const struct rpc_authops authgss_ops = {
 	.hash_cred	= gss_hash_cred,
 	.lookup_cred	= gss_lookup_cred,
 	.crcreate	= gss_create_cred,
-	.list_pseudoflavors = gss_mech_list_pseudoflavors,
 	.info2flavor	= gss_mech_info2flavor,
 	.flavor2info	= gss_mech_flavor2info,
 };
diff --git a/net/sunrpc/auth_gss/gss_mech_switch.c b/net/sunrpc/auth_gss/gss_mech_switch.c
index 30b7de6f3d76..22d4be8e38c8 100644
--- a/net/sunrpc/auth_gss/gss_mech_switch.c
+++ b/net/sunrpc/auth_gss/gss_mech_switch.c
@@ -219,35 +219,6 @@ gss_mech_get_by_pseudoflavor(u32 pseudoflavor)
 	return gm;
 }
 
-/**
- * gss_mech_list_pseudoflavors - Discover registered GSS pseudoflavors
- * @array_ptr: array to fill in
- * @size: size of "array"
- *
- * Returns the number of array items filled in, or a negative errno.
- *
- * The returned array is not sorted by any policy.  Callers should not
- * rely on the order of the items in the returned array.
- */
-int gss_mech_list_pseudoflavors(rpc_authflavor_t *array_ptr, int size)
-{
-	struct gss_api_mech *pos = NULL;
-	int j, i = 0;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(pos, &registered_mechs, gm_list) {
-		for (j = 0; j < pos->gm_pf_num; j++) {
-			if (i >= size) {
-				spin_unlock(&registered_mechs_lock);
-				return -ENOMEM;
-			}
-			array_ptr[i++] = pos->gm_pfs[j].pseudoflavor;
-		}
-	}
-	rcu_read_unlock();
-	return i;
-}
-
 /**
  * gss_svc_to_pseudoflavor - map a GSS service number to a pseudoflavor
  * @gm: GSS mechanism handle
-- 
2.24.1

