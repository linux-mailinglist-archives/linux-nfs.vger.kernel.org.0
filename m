Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFD21317AE
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgAFSm4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:42:56 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43200 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFSm4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:42:56 -0500
Received: by mail-yb1-f194.google.com with SMTP id v24so22469349ybd.10
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TJwuCyagUq4PhK/D+Qm0Po/EkMJisggurTZpmx1TGTg=;
        b=jR/GCSxBxncz0hQolKp8umBNiMYehf+jrAPFGIjFDTZX7tq2ZYj4vm8sh1t8vhMOu6
         n3j3Z37u//vH6+jH+81TSVu/prhXGNsHPadwcb2b0nIX9F5Frgs93J2LxsEnJYtSSkHa
         bUNv9sh/+fDcYFGDzjQ4xc99zvdKhBMzD79wPO2qKEq98WL6Kuvf+jpBAN+hep0cR/Qx
         wvKHwy/J7TrDmLXHIfIKVtY42f61bPEskF7uzGFNU8mu8tuUhdMIkaXlec0YYsycwPYT
         ZXRGODZwqCD3cKwRm0z9EqzY+cDBS9WKCaQxQKanWCH/mKfPpCP8r2Hf7nWBP1HgqPo2
         ShqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TJwuCyagUq4PhK/D+Qm0Po/EkMJisggurTZpmx1TGTg=;
        b=PPo8+i8RfPiHBUCTe/fTNkU38iwu784W9KiozHk8nT61dALscyFAQQ3lax7BptFSEx
         1Iasu/Ak8tSaTwVMti6ymFAHyb47yREGdpHtEHtuLIG1ZKbDFt43PFdGYkJt2fxyoLh/
         blF+xkxhFdCdeeiAJEutu41dPkKHq/ymGgKxHFgTlCW+wSkTeYPFLwjMIHZXM5YlZHy3
         7IbfhbYf4Hnz5FrQKq0+ZNYnGrBrjwkrBcF5QQUHqs/QBV86jVloFBY4S67JdhYGjgQs
         quuftUlwYp8POz+Pr7ws3t+l63FYGcTQ2PJ/O7FDuCe3/bQk236D7s/kRI4EqgDu2sKb
         du3Q==
X-Gm-Message-State: APjAAAVX8FhWUDTnn8rOskBRe3BvOEo8Zlr5AIJLkXYHvYJc2YYJLCOF
        4i8+Fosqgg7lLyF6SQ7UpxMY6CIq0A==
X-Google-Smtp-Source: APXvYqzNTrsUAhJ0BJEGdNFQ1Wc591nufY/0hO0yBi9ixOLpNWbnRZQ3xMTYeeBZ/FMx0qhX/LOF9Q==
X-Received: by 2002:a25:5543:: with SMTP id j64mr78005302ybb.252.1578336174584;
        Mon, 06 Jan 2020 10:42:54 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm28223497ywf.101.2020.01.06.10.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:42:54 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/9] sunrpc: clean up cache entry add/remove from hashtable
Date:   Mon,  6 Jan 2020 13:40:35 -0500
Message-Id: <20200106184037.563557-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106184037.563557-7-trond.myklebust@hammerspace.com>
References: <20200106184037.563557-1-trond.myklebust@hammerspace.com>
 <20200106184037.563557-2-trond.myklebust@hammerspace.com>
 <20200106184037.563557-3-trond.myklebust@hammerspace.com>
 <20200106184037.563557-4-trond.myklebust@hammerspace.com>
 <20200106184037.563557-5-trond.myklebust@hammerspace.com>
 <20200106184037.563557-6-trond.myklebust@hammerspace.com>
 <20200106184037.563557-7-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/cache.c | 50 ++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 7ede1e52fd81..52d927210d32 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -77,6 +77,22 @@ static struct cache_head *sunrpc_cache_find_rcu(struct cache_detail *detail,
 	return NULL;
 }
 
+static void sunrpc_begin_cache_remove_entry(struct cache_head *ch,
+					    struct cache_detail *cd)
+{
+	/* Must be called under cd->hash_lock */
+	hlist_del_init_rcu(&ch->cache_list);
+	set_bit(CACHE_CLEANED, &ch->flags);
+	cd->entries --;
+}
+
+static void sunrpc_end_cache_remove_entry(struct cache_head *ch,
+					  struct cache_detail *cd)
+{
+	cache_fresh_unlocked(ch, cd);
+	cache_put(ch, cd);
+}
+
 static struct cache_head *sunrpc_cache_add_entry(struct cache_detail *detail,
 						 struct cache_head *key,
 						 int hash)
@@ -100,8 +116,7 @@ static struct cache_head *sunrpc_cache_add_entry(struct cache_detail *detail,
 	hlist_for_each_entry_rcu(tmp, head, cache_list) {
 		if (detail->match(tmp, key)) {
 			if (cache_is_expired(detail, tmp)) {
-				hlist_del_init_rcu(&tmp->cache_list);
-				detail->entries --;
+				sunrpc_begin_cache_remove_entry(tmp, detail);
 				freeme = tmp;
 				break;
 			}
@@ -117,10 +132,8 @@ static struct cache_head *sunrpc_cache_add_entry(struct cache_detail *detail,
 	cache_get(new);
 	spin_unlock(&detail->hash_lock);
 
-	if (freeme) {
-		cache_fresh_unlocked(freeme, detail);
-		cache_put(freeme, detail);
-	}
+	if (freeme)
+		sunrpc_end_cache_remove_entry(freeme, detail);
 	return new;
 }
 
@@ -454,8 +467,7 @@ static int cache_clean(void)
 			if (!cache_is_expired(current_detail, ch))
 				continue;
 
-			hlist_del_init_rcu(&ch->cache_list);
-			current_detail->entries--;
+			sunrpc_begin_cache_remove_entry(ch, current_detail);
 			rv = 1;
 			break;
 		}
@@ -465,11 +477,8 @@ static int cache_clean(void)
 		if (!ch)
 			current_index ++;
 		spin_unlock(&cache_list_lock);
-		if (ch) {
-			set_bit(CACHE_CLEANED, &ch->flags);
-			cache_fresh_unlocked(ch, d);
-			cache_put(ch, d);
-		}
+		if (ch)
+			sunrpc_end_cache_remove_entry(ch, d);
 	} else
 		spin_unlock(&cache_list_lock);
 
@@ -525,13 +534,9 @@ void cache_purge(struct cache_detail *detail)
 	for (i = 0; i < detail->hash_size; i++) {
 		head = &detail->hash_table[i];
 		hlist_for_each_entry_safe(ch, tmp, head, cache_list) {
-			hlist_del_init_rcu(&ch->cache_list);
-			detail->entries--;
-
-			set_bit(CACHE_CLEANED, &ch->flags);
+			sunrpc_begin_cache_remove_entry(ch, detail);
 			spin_unlock(&detail->hash_lock);
-			cache_fresh_unlocked(ch, detail);
-			cache_put(ch, detail);
+			sunrpc_end_cache_remove_entry(ch, detail);
 			spin_lock(&detail->hash_lock);
 		}
 	}
@@ -1886,12 +1891,9 @@ void sunrpc_cache_unhash(struct cache_detail *cd, struct cache_head *h)
 {
 	spin_lock(&cd->hash_lock);
 	if (!hlist_unhashed(&h->cache_list)){
-		hlist_del_init_rcu(&h->cache_list);
-		cd->entries--;
-		set_bit(CACHE_CLEANED, &h->flags);
+		sunrpc_begin_cache_remove_entry(h, cd);
 		spin_unlock(&cd->hash_lock);
-		cache_fresh_unlocked(h, cd);
-		cache_put(h, cd);
+		sunrpc_end_cache_remove_entry(h, cd);
 	} else
 		spin_unlock(&cd->hash_lock);
 }
-- 
2.24.1

