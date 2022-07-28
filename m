Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA5E584675
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 21:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiG1TDi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiG1TDg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 15:03:36 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9CB747B4
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 12:03:35 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id m10so2090504qvu.4
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=3eVYQnyFGXhJ9K4jDdhSxGNf8FlodFBiS95V4AUD5mU=;
        b=y82mf20o1qwPD7il6Noy36vnSSkvgJMPK3UNMYSSvhDcCCylupz5dNhGInkxEGxrMS
         Uz/HD+NQyjHI6rVVaXwHe6pUjYo9VYMvz5Ufo73zNM/edhxMKkn8ergCAff9SeAQ3VmA
         hLKLDttCPsoYk60u4P4ktVSiNYPaLtWSB/tITF8nQsjp24BAZKLFmyL7pdB1MHhDDdAD
         qME5+GVMZBddQfePeLkzmpOe2UTAHRHPMXFA6CQPaESKZQI2oqvLM8YKS4e8ViV1gMRh
         5pIoUl1bhqLsxa4pnSCnNXD2fXq6KP5fctjWT0pYLsVOp/k1eVD7B6i7oKG1Aq8mMjc5
         ea0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3eVYQnyFGXhJ9K4jDdhSxGNf8FlodFBiS95V4AUD5mU=;
        b=sRycpRJkw/ck/iJMHQLFMwmYbDWmCY7rz/ImgPOO8ERQeispJVm3lVxQAKxE0aIM/r
         jc4dtHfq/9zY2Bk1pO00NYRzHaYZvKoRcL/vshUx9PxhRXs0LZEbDZ3k3QTsH3zRRTw4
         UlJQyKvVtOh2y8QwS9jQjNQnj2GsEtkpV2Z1Xnx6j8lcPjJhHWeNE3meTtPSffjnYs7F
         YCrdgBfdOXSGJQOhvDwHB8k0+N7S+y6+bamxQsGK6hzlM3a6gXGENNdz9Qw6QtFXDYu9
         UGM3IGgBOsWlPyiVMN+QtPnpNkFDgAn3mT6ZZG/a3wS1FLT4nfBhoivP3mFfYZsUyeiM
         ZR8Q==
X-Gm-Message-State: ACgBeo0zFDib030H09T2y47IMeGrImOv3pO0uG8xmpWHbWtGuSzw7QlL
        Op7rV1RjXbTP3zyb+z8iPq9cn6mPXHKbPw==
X-Google-Smtp-Source: AA6agR5iGVFJBkOyLxrWH2wO0NWgGIJqDUk7rQMSRjLYnCbBDYeSd3MrlMCYpcpyoZhyWrV88iHk4A==
X-Received: by 2002:a05:6214:3003:b0:462:1c15:772c with SMTP id ke3-20020a056214300300b004621c15772cmr250582qvb.71.1659035014055;
        Thu, 28 Jul 2022 12:03:34 -0700 (PDT)
Received: from pihe (dhcp-131-142-152-103.cfa.harvard.edu. [131.142.152.103])
        by smtp.gmail.com with ESMTPSA id d17-20020a05622a15d100b0031eb215a682sm952766qty.13.2022.07.28.12.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 12:03:33 -0700 (PDT)
Received: from pihe (localhost [127.0.0.1])
        by pihe (8.17.1/8.17.1) with ESMTPS id 26SJ3Wwg224496
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 15:03:32 -0400
Received: (from pumukli@localhost)
        by pihe (8.17.1/8.17.1/Submit) id 26SJ3WBS224408;
        Thu, 28 Jul 2022 15:03:32 -0400
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
To:     Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] SUNRPC: MT-safe overhaul of address cache management in rpcb_clnt.c
Date:   Thu, 28 Jul 2022 15:02:28 -0400
Message-Id: <20220728190228.224400-1-attila.kovacs@cfa.harvard.edu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Attila Kovacs <attipaci@gmail.com>

rpcb_clnt.c was using a read/write lock mechanism to manage the address
cache. This was wrong, because the wrote locked deletion of a cached
entry did not prevent concurrent access by other calls that required
a read lock (e.g. by check_cache()). Thus, the cache could get
corrupted.

Instead of a RW locking mechanist, the cache (a linkedf list) need a
simple mutex to grant access. To avoid deadlocks while accessing a cache
from functions that may recurse, the mutexed part of the cache access
should be isolated more to only the code areas necessary.

Also, cache lookup should return an independent deep copy of the matching
cached element, rather than a pointer to the element in the cache, for
operations that can (and should be) performed outside of the mutexed
areas for cache access.

With the changes, the code is more MT-dafe, more robust, and also
simpler to follow.

Signed-off-by: Attila Kovacs <attila.kovacs@cfa.harvard.edu>
---
 src/mt_misc.c   |   2 +-
 src/rpcb_clnt.c | 199 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 133 insertions(+), 68 deletions(-)

diff --git a/src/mt_misc.c b/src/mt_misc.c
index 5a49b78..3a2bc51 100644
--- a/src/mt_misc.c
+++ b/src/mt_misc.c
@@ -13,7 +13,7 @@ pthread_rwlock_t	svc_lock = PTHREAD_RWLOCK_INITIALIZER;
 pthread_rwlock_t	svc_fd_lock = PTHREAD_RWLOCK_INITIALIZER;
 
 /* protects the RPCBIND address cache */
-pthread_rwlock_t	rpcbaddr_cache_lock = PTHREAD_RWLOCK_INITIALIZER;
+pthread_mutex_t	rpcbaddr_cache_lock = PTHREAD_MUTEX_INITIALIZER;
 
 /* protects authdes cache (svcauth_des.c) */
 pthread_mutex_t	authdes_lock = PTHREAD_MUTEX_INITIALIZER;
diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index 06f4528..0b7271a 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -85,7 +85,7 @@ static int cachesize;
 
 extern int __rpc_lowvers;
 
-static struct address_cache *check_cache(const char *, const char *);
+static struct address_cache *copy_of_cached(const char *, const char *);
 static void delete_cache(struct netbuf *);
 static void add_cache(const char *, const char *, struct netbuf *, char *);
 static CLIENT *getclnthandle(const char *, const struct netconfig *, char **);
@@ -94,6 +94,83 @@ static CLIENT *local_rpcb(void);
 static struct netbuf *got_entry(rpcb_entry_list_ptr, const struct netconfig *);
 #endif
 
+
+/*
+ * Destroys a cached address entry structure.
+ *
+ */
+static void
+destroy_addr(addr)
+	struct address_cache *addr;
+{
+	if (addr == NULL)
+		return;
+	if(addr->ac_host != NULL)
+		free(addr->ac_host);
+	if(addr->ac_netid != NULL)
+		free(addr->ac_netid);
+	if(addr->ac_uaddr != NULL)
+		free(addr->ac_uaddr);
+	if(addr->ac_taddr != NULL) {
+		if(addr->ac_taddr->buf != NULL)
+			free(addr->ac_taddr->buf);
+	}
+	free(addr);
+}
+
+/*
+ * Creates an unlinked copy of an address cache entry. If the argument is NULL
+ * or the new entry cannot be allocated then NULL is returned.
+ */
+static struct address_cache *
+copy_addr(addr)
+	const struct address_cache *addr;
+{
+	struct address_cache *copy;
+
+	if (addr == NULL)
+		return (NULL);
+
+	copy = calloc(1, sizeof(*addr));
+	if (copy == NULL)
+		return (NULL);
+
+	if (addr->ac_host != NULL) {
+		copy->ac_host = strdup(addr->ac_host);
+		if (copy->ac_host == NULL)
+			goto err;
+	}
+	if (addr->ac_netid != NULL) {
+		copy->ac_netid = strdup(addr->ac_netid);
+		if (copy->ac_netid == NULL)
+			goto err;
+	}
+	if (addr->ac_uaddr != NULL) {
+		copy->ac_uaddr = strdup(addr->ac_uaddr);
+		if (copy->ac_uaddr == NULL)
+			goto err;
+	}
+
+	if (addr->ac_taddr == NULL)
+		return (copy);
+
+	copy->ac_taddr = calloc(1, sizeof(*addr->ac_taddr));
+	if (copy->ac_taddr == NULL)
+		goto err;
+
+	memcpy(copy->ac_taddr, addr->ac_taddr, sizeof(*addr->ac_taddr));
+	copy->ac_taddr->buf = malloc(addr->ac_taddr->len);
+	if (copy->ac_taddr->buf == NULL)
+		goto err;
+
+	memcpy(copy->ac_taddr->buf, addr->ac_taddr->buf, addr->ac_taddr->len);
+	return (copy);
+
+err:
+	destroy_addr(copy);
+	return (NULL);
+}
+
 /*
  * This routine adjusts the timeout used for calls to the remote rpcbind.
  * Also, this routine can be used to set the use of portmapper version 2
@@ -125,67 +202,68 @@ __rpc_control(request, info)
 }
 
 /*
- *	It might seem that a reader/writer lock would be more reasonable here.
- *	However because getclnthandle(), the only user of the cache functions,
- *	may do a delete_cache() operation if a check_cache() fails to return an
- *	address useful to clnt_tli_create(), we may as well use a mutex.
- */
-/*
- * As it turns out, if the cache lock is *not* a reader/writer lock, we will
- * block all clnt_create's if we are trying to connect to a host that's down,
- * since the lock will be held all during that time.
+ * Protect against concurrent access to the address cache and modifications
+ * (esp. deletions) of cache entries.
+ *
+ * Previously a bidirectional R/W lock was used. However, R/W locking is
+ * dangerous as it allows concurrent modification (e.g. deletion with write
+ * lock) at the same time as the deleted element is accessed via check_cache()
+ * and a read lock). We absolutely need a single mutex for all access to
+ * prevent cache corruption. If the mutexing is restricted to only the
+ * relevant code sections, deadlocking should be avoided even with recursed
+ * client creation.
  */
-extern rwlock_t	rpcbaddr_cache_lock;
+extern pthread_mutex_t	rpcbaddr_cache_lock;
 
 /*
- * The routines check_cache(), add_cache(), delete_cache() manage the
- * cache of rpcbind addresses for (host, netid).
+ *
  */
-
 static struct address_cache *
-check_cache(host, netid)
+copy_of_cached(host, netid)
 	const char *host, *netid;
 {
-	struct address_cache *cptr;
-
-	/* READ LOCK HELD ON ENTRY: rpcbaddr_cache_lock */
-
+	struct address_cache *cptr, *copy = NULL;
+	mutex_lock(&rpcbaddr_cache_lock);
 	for (cptr = front; cptr != NULL; cptr = cptr->ac_next) {
 		if (!strcmp(cptr->ac_host, host) &&
 		    !strcmp(cptr->ac_netid, netid)) {
 			LIBTIRPC_DEBUG(3, ("check_cache: Found cache entry for %s: %s\n", 
 				host, netid));
-			return (cptr);
+			copy = copy_addr(cptr);
+			break;
 		}
 	}
-	return ((struct address_cache *) NULL);
+	mutex_unlock(&rpcbaddr_cache_lock);
+	return copy;
 }
 
 static void
 delete_cache(addr)
 	struct netbuf *addr;
 {
-	struct address_cache *cptr, *prevptr = NULL;
+	struct address_cache *cptr = NULL, *prevptr = NULL;
+
+	mutex_lock(&rpcbaddr_cache_lock);
 
-	/* WRITE LOCK HELD ON ENTRY: rpcbaddr_cache_lock */
+	/* LOCK HELD ON ENTRY: rpcbaddr_cache_lock */
 	for (cptr = front; cptr != NULL; cptr = cptr->ac_next) {
 		if (!memcmp(cptr->ac_taddr->buf, addr->buf, addr->len)) {
-			free(cptr->ac_host);
-			free(cptr->ac_netid);
-			free(cptr->ac_taddr->buf);
-			free(cptr->ac_taddr);
+			/* Unlink from cache. We'll destroy it after releasing the mutex. */
 			if (cptr->ac_uaddr)
 				free(cptr->ac_uaddr);
 			if (prevptr)
 				prevptr->ac_next = cptr->ac_next;
 			else
 				front = cptr->ac_next;
-			free(cptr);
 			cachesize--;
 			break;
 		}
 		prevptr = cptr;
 	}
+
+	mutex_unlock(&rpcbaddr_cache_lock);
+
+	destroy_addr(cptr);
 }
 
 static void
@@ -217,7 +295,7 @@ add_cache(host, netid, taddr, uaddr)
 
 /* VARIABLES PROTECTED BY rpcbaddr_cache_lock:  cptr */
 
-	rwlock_wrlock(&rpcbaddr_cache_lock);
+	mutex_lock(&rpcbaddr_cache_lock);
 	if (cachesize < CACHESIZE) {
 		ad_cache->ac_next = front;
 		front = ad_cache;
@@ -250,7 +328,7 @@ add_cache(host, netid, taddr, uaddr)
 		}
 		free(cptr);
 	}
-	rwlock_unlock(&rpcbaddr_cache_lock);
+	mutex_unlock(&rpcbaddr_cache_lock);
 	return;
 
 out_free:
@@ -261,6 +339,7 @@ out_free:
 	free(ad_cache);
 }
 
+
 /*
  * This routine will return a client handle that is connected to the
  * rpcbind. If targaddr is non-NULL, the "universal address" of the
@@ -275,11 +354,9 @@ getclnthandle(host, nconf, targaddr)
 	char **targaddr;
 {
 	CLIENT *client;
-	struct netbuf *addr, taddr;
-	struct netbuf addr_to_delete;
+	struct netbuf taddr;
 	struct __rpc_sockinfo si;
 	struct addrinfo hints, *res, *tres;
-	struct address_cache *ad_cache;
 	char *tmpaddr;
 
 	if (nconf == NULL) {
@@ -294,47 +371,35 @@ getclnthandle(host, nconf, targaddr)
 		return NULL;
 	}
 
-/* VARIABLES PROTECTED BY rpcbaddr_cache_lock:  ad_cache */
+
 
 	/* Get the address of the rpcbind.  Check cache first */
 	client = NULL;
 	if (targaddr)
 		*targaddr = NULL;
-	addr_to_delete.len = 0;
-	rwlock_rdlock(&rpcbaddr_cache_lock);
-	ad_cache = NULL;
-
-	if (host != NULL)
-		ad_cache = check_cache(host, nconf->nc_netid);
-	if (ad_cache != NULL) {
-		addr = ad_cache->ac_taddr;
-		client = clnt_tli_create(RPC_ANYFD, nconf, addr,
-		    (rpcprog_t)RPCBPROG, (rpcvers_t)RPCBVERS4, 0, 0);
-		if (client != NULL) {
-			if (targaddr && ad_cache->ac_uaddr)
-				*targaddr = strdup(ad_cache->ac_uaddr);
-			rwlock_unlock(&rpcbaddr_cache_lock);
-			return (client);
-		}
-		addr_to_delete.len = addr->len;
-		addr_to_delete.buf = (char *)malloc(addr->len);
-		if (addr_to_delete.buf == NULL) {
-			addr_to_delete.len = 0;
-		} else {
-			memcpy(addr_to_delete.buf, addr->buf, addr->len);
+
+	if (host != NULL)  {
+		struct address_cache *ad_cache;
+
+		/* Get an MT-safe copy of the cached address (if any) */
+		ad_cache = copy_of_cached(host, nconf->nc_netid);
+		if (ad_cache != NULL) {
+			client = clnt_tli_create(RPC_ANYFD, nconf, ad_cache->ac_taddr,
+							(rpcprog_t)RPCBPROG, (rpcvers_t)RPCBVERS4, 0, 0);
+			if (client != NULL) {
+				if (targaddr && ad_cache->ac_uaddr) {
+					*targaddr = ad_cache->ac_uaddr;
+					ad_cache->ac_uaddr = NULL; /* De-reference before destruction */
+				}
+				destroy_addr(ad_cache);
+				return (client);
+			}
+
+			delete_cache(ad_cache->ac_taddr);
+			destroy_addr(ad_cache);
 		}
 	}
-	rwlock_unlock(&rpcbaddr_cache_lock);
-	if (addr_to_delete.len != 0) {
-		/*
-		 * Assume this may be due to cache data being
-		 *  outdated
-		 */
-		rwlock_wrlock(&rpcbaddr_cache_lock);
-		delete_cache(&addr_to_delete);
-		rwlock_unlock(&rpcbaddr_cache_lock);
-		free(addr_to_delete.buf);
-	}
+
 	if (!__rpc_nconf2sockinfo(nconf, &si)) {
 		rpc_createerr.cf_stat = RPC_UNKNOWNPROTO;
 		assert(client == NULL);
-- 
2.37.1

