Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4594513B028
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2020 17:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgANQ7s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jan 2020 11:59:48 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37378 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANQ7s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jan 2020 11:59:48 -0500
Received: by mail-yw1-f67.google.com with SMTP id z7so9599422ywd.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2020 08:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWDqkthXpxmKt51JcSaY6XUF1ytD3dBBeBwK1WWW3ng=;
        b=i1jIGrfCcss5yJL2W14+OsqPAV8UgyB24NwVoHLPfKntZiKEvzDTD8PqhGMF4/CQF8
         wFStHG6320Yz0y0SUrarRCIOSqJCIl5nWSZJm2K3RgSZ1rjKH48tD9nQylBV4D7ylTs8
         VD9d+1c8DPjMXbcHe/Xm+eJb/3sz9bv4c6N8CgAN5a2PfKBTYK/+BGrcRSTmNv0KtI7C
         2l3cCMZV3ppgoaJQqMcTONj3Hq8p7UcmVhQeMLxPMApoN+dWLsNNIr0RBfJOEP+hXzZ4
         0GLQS/nJd5fhl1avATwhrlBCOciFI4tUWSsqBrmri/oh9mnDNcJVf8cC+aFVRz77zY2O
         MvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWDqkthXpxmKt51JcSaY6XUF1ytD3dBBeBwK1WWW3ng=;
        b=Zjm0lfVkh4kKJqch+5UMl0zynEsvgsKK6hU3SY+BaAMt6+TTpiw2XBLii1McSfXJOK
         0rpR3A8Vb70C81IE6uSbZEYPYThRn+HBVwobyRsh4FmRFkbiNNZcUsunZfLmF73eHtc1
         xY4ETInMZZuLGkKaO91xhot3oKB8uO7Q2B1lRWFNDR8bvy4PIclwhl7kQGV9v220WV31
         OSqbXSp6IGCHnBI2RPp/dY8g//AmaHwPIhv4evfaLgbEqpp2NOfc+Sn1OsCQ7c8Sc0hC
         +CAeXZVe3HMbteBBxN4bdXc/DlCoAKCvzvcm+BB2DgKeqI8jW+uPqwjQLAk4qjLINCII
         n5Bw==
X-Gm-Message-State: APjAAAX7jHJG+3PeIHH4evb4phGgrsIGqga9qsTqh9N5o9K5WMwHDWNV
        +iTypiPpaFsWF9w4dRh0Zd5res4=
X-Google-Smtp-Source: APXvYqz4opxZYGQITrvG/3qPtQToNvyC/n3lNswt9BPKEIhT626l2LY8DkwOIJaHdz6YQjSzF689jQ==
X-Received: by 2002:a0d:cd45:: with SMTP id p66mr17907840ywd.156.1579021187349;
        Tue, 14 Jan 2020 08:59:47 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id s31sm7109660ywa.30.2020.01.14.08.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 08:59:46 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC/cache: Allow garbage collection of invalid cache entries
Date:   Tue, 14 Jan 2020 11:57:38 -0500
Message-Id: <20200114165738.922961-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the cache entry never gets initialised, we want the garbage
collector to be able to evict it. Otherwise if the upcall daemon
fails to initialise the entry, we end up never expiring it.

Fixes: d6fc8821c2d2 ("SUNRPC/Cache: Always treat the invalid cache as unexpired")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/cache.h |  3 ---
 net/sunrpc/cache.c           | 36 +++++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index f8603724fbee..0428dd23fd79 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -202,9 +202,6 @@ static inline void cache_put(struct cache_head *h, struct cache_detail *cd)
 
 static inline bool cache_is_expired(struct cache_detail *detail, struct cache_head *h)
 {
-	if (!test_bit(CACHE_VALID, &h->flags))
-		return false;
-
 	return  (h->expiry_time < seconds_since_boot()) ||
 		(detail->flush_time >= h->last_refresh);
 }
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 52d927210d32..99d630150af6 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -65,13 +65,14 @@ static struct cache_head *sunrpc_cache_find_rcu(struct cache_detail *detail,
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp, head, cache_list) {
-		if (detail->match(tmp, key)) {
-			if (cache_is_expired(detail, tmp))
-				continue;
-			tmp = cache_get_rcu(tmp);
-			rcu_read_unlock();
-			return tmp;
-		}
+		if (!detail->match(tmp, key))
+			continue;
+		if (test_bit(CACHE_VALID, &tmp->flags) &&
+		    cache_is_expired(detail, tmp))
+			continue;
+		tmp = cache_get_rcu(tmp);
+		rcu_read_unlock();
+		return tmp;
 	}
 	rcu_read_unlock();
 	return NULL;
@@ -114,17 +115,18 @@ static struct cache_head *sunrpc_cache_add_entry(struct cache_detail *detail,
 
 	/* check if entry appeared while we slept */
 	hlist_for_each_entry_rcu(tmp, head, cache_list) {
-		if (detail->match(tmp, key)) {
-			if (cache_is_expired(detail, tmp)) {
-				sunrpc_begin_cache_remove_entry(tmp, detail);
-				freeme = tmp;
-				break;
-			}
-			cache_get(tmp);
-			spin_unlock(&detail->hash_lock);
-			cache_put(new, detail);
-			return tmp;
+		if (!detail->match(tmp, key))
+			continue;
+		if (test_bit(CACHE_VALID, &tmp->flags) &&
+		    cache_is_expired(detail, tmp)) {
+			sunrpc_begin_cache_remove_entry(tmp, detail);
+			freeme = tmp;
+			break;
 		}
+		cache_get(tmp);
+		spin_unlock(&detail->hash_lock);
+		cache_put(new, detail);
+		return tmp;
 	}
 
 	hlist_add_head_rcu(&new->cache_list, head);
-- 
2.24.1

