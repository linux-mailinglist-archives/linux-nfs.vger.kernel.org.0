Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651111750F0
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2020 00:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCAXZU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 18:25:20 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33268 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAXZT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 18:25:19 -0500
Received: by mail-yw1-f67.google.com with SMTP id j186so9530099ywe.0
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2020 15:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5JlzuuzfYDgx4k/u4CJVEMHAcaOTaT7l+Jq/zZhDmI=;
        b=N5nGwHCg/le3P4RQXh6rkare/7x0JlLHWCNSz9EcMW3NTWN2bgyIuq6/EfG1mQ+GPf
         SV3p/3eatjtDXoz9jTxcl0EJ0A4bUDVDQAHhSM0HNlEWKo+vQFCPQDhxnOAoWp7QtT84
         BmMx9mPOMOEwsDpvYGcbGzbssiRozjKBmJtwZzaGeICJBD74F9VccPPCQotxkk1bSaj1
         YCL0SCaIj/HBNZbURFwouC4OowWJ5Wqd98LGmhX70ziM77kOgh8Tr3tpZfD9itWe0QmL
         MntR29pUui7MlTeB5ieo1ZfZemybrOZ2OMyGDNwnLTZxIlvZRNuEgX18+SrP89LWkUgi
         1IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5JlzuuzfYDgx4k/u4CJVEMHAcaOTaT7l+Jq/zZhDmI=;
        b=mO2mrTa4UH0rBGg1+1/7B+SBIF6TXjaUesgEXhLh9XjlhHkATfxkCh8iVtTYGT7KnE
         6+r6nsR3zN4LOxO31Pw1YDaYZmAoYteGoffY3wXrgifqUukv8jPLnKfB09zEXC1xZLTI
         +5xJdDsNXf7mejF9er106k3GeWlcnR6nqoeoDuqzL0GigB3NmBxEfFqy7ekotc6SADa3
         1ubrbp1Ufr/zJb+N/X+0IH1tgK71KgqeQlRF9bvG/VwSmdj95MJicC2qPGN8Ga1FoHaZ
         t9ztqv3kq0mGSBh2QpzMNWLkWLEV8pGuUL7LbzNYjEm5FBX7R5Xj1xWHonpHTmgNAgny
         lmdQ==
X-Gm-Message-State: ANhLgQ1CGDhhBnysRhfV54fpitX0X4XYIecdWsi81xN2yoeKTzwoHgAm
        2/oYHMb1i/iYd2QsUpJROg==
X-Google-Smtp-Source: ADFU+vv+BO5XOnejQA0TEhLRaNI+5gaX9u0dSkdqclykQHgUHjkL8ckzdMp7cvuwHWz+1rRFKbX0Cg==
X-Received: by 2002:a25:bc87:: with SMTP id e7mr3682868ybk.412.1583105118824;
        Sun, 01 Mar 2020 15:25:18 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u4sm7167301ywu.26.2020.03.01.15.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:25:18 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/8] nfsd: export upcalls must not return ESTALE when mountd is down
Date:   Sun,  1 Mar 2020 18:21:42 -0500
Message-Id: <20200301232145.1465430-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301232145.1465430-5-trond.myklebust@hammerspace.com>
References: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-4-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the rpc.mountd daemon goes down, then that should not cause all
exports to start failing with ESTALE errors. Let's explicitly
distinguish between the cache upcall cases that need to time out,
and those that do not.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dns_resolve.c              | 11 ++++---
 fs/nfsd/export.c                  | 12 +++++++
 fs/nfsd/nfs4idmap.c               | 14 ++++++++
 include/linux/sunrpc/cache.h      |  3 ++
 net/sunrpc/auth_gss/svcauth_gss.c | 12 +++++++
 net/sunrpc/cache.c                | 53 +++++++++++++++----------------
 net/sunrpc/svcauth_unix.c         | 12 +++++++
 7 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/fs/nfs/dns_resolve.c b/fs/nfs/dns_resolve.c
index 89bd5581f317..963800037609 100644
--- a/fs/nfs/dns_resolve.c
+++ b/fs/nfs/dns_resolve.c
@@ -152,12 +152,13 @@ static int nfs_dns_upcall(struct cache_detail *cd,
 		struct cache_head *ch)
 {
 	struct nfs_dns_ent *key = container_of(ch, struct nfs_dns_ent, h);
-	int ret;
 
-	ret = nfs_cache_upcall(cd, key->hostname);
-	if (ret)
-		ret = sunrpc_cache_pipe_upcall(cd, ch);
-	return ret;
+	if (test_and_set_bit(CACHE_PENDING, &ch->flags))
+		return 0;
+	if (!nfs_cache_upcall(cd, key->hostname))
+		return 0;
+	clear_bit(CACHE_PENDING, &ch->flags);
+	return sunrpc_cache_pipe_upcall_timeout(cd, ch);
 }
 
 static int nfs_dns_match(struct cache_head *ca,
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 6e6cbeb7ac2b..cb777fe82988 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -51,6 +51,11 @@ static void expkey_put(struct kref *ref)
 	kfree_rcu(key, ek_rcu);
 }
 
+static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
+{
+	return sunrpc_cache_pipe_upcall(cd, h);
+}
+
 static void expkey_request(struct cache_detail *cd,
 			   struct cache_head *h,
 			   char **bpp, int *blen)
@@ -254,6 +259,7 @@ static const struct cache_detail svc_expkey_cache_template = {
 	.hash_size	= EXPKEY_HASHMAX,
 	.name		= "nfsd.fh",
 	.cache_put	= expkey_put,
+	.cache_upcall	= expkey_upcall,
 	.cache_request	= expkey_request,
 	.cache_parse	= expkey_parse,
 	.cache_show	= expkey_show,
@@ -335,6 +341,11 @@ static void svc_export_put(struct kref *ref)
 	kfree_rcu(exp, ex_rcu);
 }
 
+static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
+{
+	return sunrpc_cache_pipe_upcall(cd, h);
+}
+
 static void svc_export_request(struct cache_detail *cd,
 			       struct cache_head *h,
 			       char **bpp, int *blen)
@@ -774,6 +785,7 @@ static const struct cache_detail svc_export_cache_template = {
 	.hash_size	= EXPORT_HASHMAX,
 	.name		= "nfsd.export",
 	.cache_put	= svc_export_put,
+	.cache_upcall	= svc_export_upcall,
 	.cache_request	= svc_export_request,
 	.cache_parse	= svc_export_parse,
 	.cache_show	= svc_export_show,
diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index d1f285245af8..9460be8a8321 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -122,6 +122,12 @@ idtoname_hash(struct ent *ent)
 	return hash;
 }
 
+static int
+idtoname_upcall(struct cache_detail *cd, struct cache_head *h)
+{
+	return sunrpc_cache_pipe_upcall_timeout(cd, h);
+}
+
 static void
 idtoname_request(struct cache_detail *cd, struct cache_head *ch, char **bpp,
     int *blen)
@@ -184,6 +190,7 @@ static const struct cache_detail idtoname_cache_template = {
 	.hash_size	= ENT_HASHMAX,
 	.name		= "nfs4.idtoname",
 	.cache_put	= ent_put,
+	.cache_upcall	= idtoname_upcall,
 	.cache_request	= idtoname_request,
 	.cache_parse	= idtoname_parse,
 	.cache_show	= idtoname_show,
@@ -295,6 +302,12 @@ nametoid_hash(struct ent *ent)
 	return hash_str(ent->name, ENT_HASHBITS);
 }
 
+static int
+nametoid_upcall(struct cache_detail *cd, struct cache_head *h)
+{
+	return sunrpc_cache_pipe_upcall_timeout(cd, h);
+}
+
 static void
 nametoid_request(struct cache_detail *cd, struct cache_head *ch, char **bpp,
     int *blen)
@@ -347,6 +360,7 @@ static const struct cache_detail nametoid_cache_template = {
 	.hash_size	= ENT_HASHMAX,
 	.name		= "nfs4.nametoid",
 	.cache_put	= ent_put,
+	.cache_upcall	= nametoid_upcall,
 	.cache_request	= nametoid_request,
 	.cache_parse	= nametoid_parse,
 	.cache_show	= nametoid_show,
diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index 0f64de7caa39..656882a50991 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -179,6 +179,9 @@ sunrpc_cache_update(struct cache_detail *detail,
 
 extern int
 sunrpc_cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h);
+extern int
+sunrpc_cache_pipe_upcall_timeout(struct cache_detail *detail,
+				 struct cache_head *h);
 
 
 extern void cache_clean_deferred(void *owner);
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 65b67b257302..6d698bf1c16e 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -184,6 +184,11 @@ static struct cache_head *rsi_alloc(void)
 		return NULL;
 }
 
+static int rsi_upcall(struct cache_detail *cd, struct cache_head *h)
+{
+	return sunrpc_cache_pipe_upcall_timeout(cd, h);
+}
+
 static void rsi_request(struct cache_detail *cd,
 		       struct cache_head *h,
 		       char **bpp, int *blen)
@@ -282,6 +287,7 @@ static const struct cache_detail rsi_cache_template = {
 	.hash_size	= RSI_HASHMAX,
 	.name           = "auth.rpcsec.init",
 	.cache_put      = rsi_put,
+	.cache_upcall	= rsi_upcall,
 	.cache_request  = rsi_request,
 	.cache_parse    = rsi_parse,
 	.match		= rsi_match,
@@ -428,6 +434,11 @@ rsc_alloc(void)
 		return NULL;
 }
 
+static int rsc_upcall(struct cache_detail *cd, struct cache_head *h)
+{
+	return -EINVAL;
+}
+
 static int rsc_parse(struct cache_detail *cd,
 		     char *mesg, int mlen)
 {
@@ -554,6 +565,7 @@ static const struct cache_detail rsc_cache_template = {
 	.hash_size	= RSC_HASHMAX,
 	.name		= "auth.rpcsec.context",
 	.cache_put	= rsc_put,
+	.cache_upcall	= rsc_upcall,
 	.cache_parse	= rsc_parse,
 	.match		= rsc_match,
 	.init		= rsc_init,
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index bd843a81afa0..5e14513603cb 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -38,7 +38,6 @@
 
 static bool cache_defer_req(struct cache_req *req, struct cache_head *item);
 static void cache_revisit_request(struct cache_head *item);
-static bool cache_listeners_exist(struct cache_detail *detail);
 
 static void cache_init(struct cache_head *h, struct cache_detail *detail)
 {
@@ -224,13 +223,6 @@ struct cache_head *sunrpc_cache_update(struct cache_detail *detail,
 }
 EXPORT_SYMBOL_GPL(sunrpc_cache_update);
 
-static int cache_make_upcall(struct cache_detail *cd, struct cache_head *h)
-{
-	if (cd->cache_upcall)
-		return cd->cache_upcall(cd, h);
-	return sunrpc_cache_pipe_upcall(cd, h);
-}
-
 static inline int cache_is_valid(struct cache_head *h)
 {
 	if (!test_bit(CACHE_VALID, &h->flags))
@@ -303,17 +295,14 @@ int cache_check(struct cache_detail *detail,
 		   (h->expiry_time != 0 && age > refresh_age/2)) {
 		dprintk("RPC:       Want update, refage=%lld, age=%lld\n",
 				refresh_age, age);
-		if (!test_and_set_bit(CACHE_PENDING, &h->flags)) {
-			switch (cache_make_upcall(detail, h)) {
-			case -EINVAL:
-				rv = try_to_negate_entry(detail, h);
-				break;
-			case -EAGAIN:
-				cache_fresh_unlocked(h, detail);
-				break;
-			}
-		} else if (!cache_listeners_exist(detail))
+		switch (detail->cache_upcall(detail, h)) {
+		case -EINVAL:
 			rv = try_to_negate_entry(detail, h);
+			break;
+		case -EAGAIN:
+			cache_fresh_unlocked(h, detail);
+			break;
+		}
 	}
 
 	if (rv == -EAGAIN) {
@@ -1195,20 +1184,12 @@ static bool cache_listeners_exist(struct cache_detail *detail)
  *
  * Each request is at most one page long.
  */
-int sunrpc_cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
+static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
 {
-
 	char *buf;
 	struct cache_request *crq;
 	int ret = 0;
 
-	if (!detail->cache_request)
-		return -EINVAL;
-
-	if (!cache_listeners_exist(detail)) {
-		warn_no_listener(detail);
-		return -EINVAL;
-	}
 	if (test_bit(CACHE_CLEANED, &h->flags))
 		/* Too late to make an upcall */
 		return -EAGAIN;
@@ -1242,8 +1223,26 @@ int sunrpc_cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
 	}
 	return ret;
 }
+
+int sunrpc_cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
+{
+	if (test_and_set_bit(CACHE_PENDING, &h->flags))
+		return 0;
+	return cache_pipe_upcall(detail, h);
+}
 EXPORT_SYMBOL_GPL(sunrpc_cache_pipe_upcall);
 
+int sunrpc_cache_pipe_upcall_timeout(struct cache_detail *detail,
+				     struct cache_head *h)
+{
+	if (!cache_listeners_exist(detail)) {
+		warn_no_listener(detail);
+		return -EINVAL;
+	}
+	return sunrpc_cache_pipe_upcall(detail, h);
+}
+EXPORT_SYMBOL_GPL(sunrpc_cache_pipe_upcall_timeout);
+
 /*
  * parse a message from user-space and pass it
  * to an appropriate cache
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 04aa80a2d752..6c8f802c4261 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -148,6 +148,11 @@ static struct cache_head *ip_map_alloc(void)
 		return NULL;
 }
 
+static int ip_map_upcall(struct cache_detail *cd, struct cache_head *h)
+{
+	return sunrpc_cache_pipe_upcall(cd, h);
+}
+
 static void ip_map_request(struct cache_detail *cd,
 				  struct cache_head *h,
 				  char **bpp, int *blen)
@@ -467,6 +472,11 @@ static struct cache_head *unix_gid_alloc(void)
 		return NULL;
 }
 
+static int unix_gid_upcall(struct cache_detail *cd, struct cache_head *h)
+{
+	return sunrpc_cache_pipe_upcall_timeout(cd, h);
+}
+
 static void unix_gid_request(struct cache_detail *cd,
 			     struct cache_head *h,
 			     char **bpp, int *blen)
@@ -584,6 +594,7 @@ static const struct cache_detail unix_gid_cache_template = {
 	.hash_size	= GID_HASHMAX,
 	.name		= "auth.unix.gid",
 	.cache_put	= unix_gid_put,
+	.cache_upcall	= unix_gid_upcall,
 	.cache_request	= unix_gid_request,
 	.cache_parse	= unix_gid_parse,
 	.cache_show	= unix_gid_show,
@@ -881,6 +892,7 @@ static const struct cache_detail ip_map_cache_template = {
 	.hash_size	= IP_HASHMAX,
 	.name		= "auth.unix.ip",
 	.cache_put	= ip_map_put,
+	.cache_upcall	= ip_map_upcall,
 	.cache_request	= ip_map_request,
 	.cache_parse	= ip_map_parse,
 	.cache_show	= ip_map_show,
-- 
2.24.1

