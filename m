Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4290F1750F2
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2020 00:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCAXZW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 18:25:22 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45243 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgCAXZV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 18:25:21 -0500
Received: by mail-yw1-f65.google.com with SMTP id d206so9424891ywa.12
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2020 15:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYn9xC5a+w1YWiCL5VqG8RJ0SsGR3kzp0QX7T7SK8Rw=;
        b=Ev5dcINewLEt38Pu1V2O+x8XhtJH02RZ7qa+qdhBveW+G1JYTC7Wk9d9x9cvqrIwRg
         F4GfTfq4TDnUBZ6O73X1GHIppTCT7RFcRDKAq2iK7IIwA2DYPgm3FPks1cg0RvWfU0dV
         XTP1NX5366rYxLvJoReRYL5h+VKN0SfpkaKnzH2UwesWvZWsUfjqotn8UyrF/YQgh3S6
         WjWKyYeT5noiEyqPFYtZcBiTsPqc9jGnp+4Q1q3lw7cK2N3Cpn2RIkB6Mq8lYTMKGjCU
         ANb86mzZ3NXz4CwE5Rac4g8s60xUfy9QuW3e8WRMd/CgLckKXwybEQYVR5exh7XSgEUB
         NHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYn9xC5a+w1YWiCL5VqG8RJ0SsGR3kzp0QX7T7SK8Rw=;
        b=cifecMcq1sGZsM7+j1Rudq6A0Pla618TiYT8HHr1rw/VxkUrxuu3npqj1/3RZ54S0v
         U1umlCzJNIAxGv78XSm1JbwdjZU9i3W5PVw6LAUk9sPMzlfmmxFK5yj7odQvdbEX/N1n
         MKXHiLyE2Mxd0j31fcaua2c4+zvZ/FdInucbYaLzCnbCs6ApjiH6iL9/uKzL0Bhrp3dr
         eFMfQEwlqGJANmOO4Vrmt5cL/SHOLU8UFU9HnGhpcjY9TtH1xkdt1rZzl4+Yk85XTCRm
         G0PMFJdT9ZBeaUU/QhxlXoJULDYEAGDspOZseMM9goYet068rdMHooTE0eGt8NgkbY3o
         P+4A==
X-Gm-Message-State: ANhLgQ2IGFl7jSKl/PiKm4SNjv49kSZis3JQWi+rb2x31dLApZ5CJUAI
        dmSJhsKPNdQhFoQj7RPOYiuhaWSSTg==
X-Google-Smtp-Source: ADFU+vtKhjV8uisotK9qpm4il76KPLKpYk52NLx481hFnOFOjHnMGh7njUvh72ZBz/KEe8e0Fg7lmw==
X-Received: by 2002:a81:5251:: with SMTP id g78mr3131755ywb.5.1583105120552;
        Sun, 01 Mar 2020 15:25:20 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u4sm7167301ywu.26.2020.03.01.15.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:25:20 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/8] sunrpc: Add tracing for cache events
Date:   Sun,  1 Mar 2020 18:21:44 -0500
Message-Id: <20200301232145.1465430-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301232145.1465430-7-trond.myklebust@hammerspace.com>
References: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-4-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-5-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-6-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-7-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add basic tracing for debugging the sunrpc cache events.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/trace/events/sunrpc.h | 33 +++++++++++++++++++++++++++++++++
 net/sunrpc/cache.c            | 35 ++++++++++++++++++++++++++---------
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ee993575d2fa..236d42539c7b 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1292,6 +1292,39 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
 DEFINE_SVC_DEFERRED_EVENT(drop);
 DEFINE_SVC_DEFERRED_EVENT(revisit);
 
+DECLARE_EVENT_CLASS(cache_event,
+	TP_PROTO(
+		const struct cache_detail *cd,
+		const struct cache_head *h
+	),
+
+	TP_ARGS(cd, h),
+
+	TP_STRUCT__entry(
+		__field(const struct cache_head *, h)
+		__string(name, cd->name)
+	),
+
+	TP_fast_assign(
+		__entry->h = h;
+		__assign_str(name, cd->name);
+	),
+
+	TP_printk("cache=%s entry=%p", __get_str(name), __entry->h)
+);
+#define DEFINE_CACHE_EVENT(name) \
+	DEFINE_EVENT(cache_event, name, \
+			TP_PROTO( \
+				const struct cache_detail *cd, \
+				const struct cache_head *h \
+			), \
+			TP_ARGS(cd, h))
+DEFINE_CACHE_EVENT(cache_entry_expired);
+DEFINE_CACHE_EVENT(cache_entry_upcall);
+DEFINE_CACHE_EVENT(cache_entry_update);
+DEFINE_CACHE_EVENT(cache_entry_make_negative);
+DEFINE_CACHE_EVENT(cache_entry_no_listener);
+
 #endif /* _TRACE_SUNRPC_H */
 
 #include <trace/define_trace.h>
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index b7ddb2affb7e..559a61644037 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -32,6 +32,7 @@
 #include <linux/sunrpc/cache.h>
 #include <linux/sunrpc/stats.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
+#include <trace/events/sunrpc.h>
 #include "netns.h"
 
 #define	 RPCDBG_FACILITY RPCDBG_CACHE
@@ -119,6 +120,7 @@ static struct cache_head *sunrpc_cache_add_entry(struct cache_detail *detail,
 		if (test_bit(CACHE_VALID, &tmp->flags) &&
 		    cache_is_expired(detail, tmp)) {
 			sunrpc_begin_cache_remove_entry(tmp, detail);
+			trace_cache_entry_expired(detail, tmp);
 			freeme = tmp;
 			break;
 		}
@@ -175,6 +177,24 @@ static void cache_fresh_unlocked(struct cache_head *head,
 	}
 }
 
+static void cache_make_negative(struct cache_detail *detail,
+				struct cache_head *h)
+{
+	set_bit(CACHE_NEGATIVE, &h->flags);
+	trace_cache_entry_make_negative(detail, h);
+}
+
+static void cache_entry_update(struct cache_detail *detail,
+			       struct cache_head *h,
+			       struct cache_head *new)
+{
+	if (!test_bit(CACHE_NEGATIVE, &new->flags)) {
+		detail->update(h, new);
+		trace_cache_entry_update(detail, h);
+	} else
+		cache_make_negative(detail, h);
+}
+
 struct cache_head *sunrpc_cache_update(struct cache_detail *detail,
 				       struct cache_head *new, struct cache_head *old, int hash)
 {
@@ -187,10 +207,7 @@ struct cache_head *sunrpc_cache_update(struct cache_detail *detail,
 	if (!test_bit(CACHE_VALID, &old->flags)) {
 		spin_lock(&detail->hash_lock);
 		if (!test_bit(CACHE_VALID, &old->flags)) {
-			if (test_bit(CACHE_NEGATIVE, &new->flags))
-				set_bit(CACHE_NEGATIVE, &old->flags);
-			else
-				detail->update(old, new);
+			cache_entry_update(detail, old, new);
 			cache_fresh_locked(old, new->expiry_time, detail);
 			spin_unlock(&detail->hash_lock);
 			cache_fresh_unlocked(old, detail);
@@ -208,10 +225,7 @@ struct cache_head *sunrpc_cache_update(struct cache_detail *detail,
 	detail->init(tmp, old);
 
 	spin_lock(&detail->hash_lock);
-	if (test_bit(CACHE_NEGATIVE, &new->flags))
-		set_bit(CACHE_NEGATIVE, &tmp->flags);
-	else
-		detail->update(tmp, new);
+	cache_entry_update(detail, tmp, new);
 	hlist_add_head(&tmp->cache_list, &detail->hash_table[hash]);
 	detail->entries++;
 	cache_get(tmp);
@@ -253,7 +267,7 @@ static int try_to_negate_entry(struct cache_detail *detail, struct cache_head *h
 	spin_lock(&detail->hash_lock);
 	rv = cache_is_valid(h);
 	if (rv == -EAGAIN) {
-		set_bit(CACHE_NEGATIVE, &h->flags);
+		cache_make_negative(detail, h);
 		cache_fresh_locked(h, seconds_since_boot()+CACHE_NEW_EXPIRY,
 				   detail);
 		rv = -ENOENT;
@@ -459,6 +473,7 @@ static int cache_clean(void)
 				continue;
 
 			sunrpc_begin_cache_remove_entry(ch, current_detail);
+			trace_cache_entry_expired(current_detail, ch);
 			rv = 1;
 			break;
 		}
@@ -1214,6 +1229,7 @@ static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
 	if (test_bit(CACHE_PENDING, &h->flags)) {
 		crq->item = cache_get(h);
 		list_add_tail(&crq->q.list, &detail->queue);
+		trace_cache_entry_upcall(detail, h);
 	} else
 		/* Lost a race, no longer PENDING, so don't enqueue */
 		ret = -EAGAIN;
@@ -1239,6 +1255,7 @@ int sunrpc_cache_pipe_upcall_timeout(struct cache_detail *detail,
 {
 	if (!cache_listeners_exist(detail)) {
 		warn_no_listener(detail);
+		trace_cache_entry_no_listener(detail, h);
 		return -EINVAL;
 	}
 	return sunrpc_cache_pipe_upcall(detail, h);
-- 
2.24.1

