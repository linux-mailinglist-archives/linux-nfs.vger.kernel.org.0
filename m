Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADA21317AD
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgAFSmy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:42:54 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45625 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFSmy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:42:54 -0500
Received: by mail-yb1-f193.google.com with SMTP id y67so12802482yba.12
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NF+1UccyPrLSTsC6NO843o3LdegAui/9wxtIWyWZc6E=;
        b=tbI88uEgwtSrN+3hlddr5BKBbpg7whwwmaMtwdJA4JFC6/4IW/ECEStEauO/O1M1hR
         P+btUxh4bBK8gw4Imbh0soDS5e95vvroZwLNFL0pHxRJDe8x+JYjxHoaD3D38WlDVUwc
         geFGT/u+ONBCGaGFEJYIFqggmtobRgYYQmW5sk4qBCSJmEVBzrtYfjudHKbT+dpm+iBP
         hFvmLyPf1PqIuAic3VlmiNT6EEbS5FnS/3pvzfRjlYuF+4Cz56nhe/MkApIU1BEPMA8s
         VVGbUacWu3ONVzGILolOU0Aa1aC8iFDLvdCgaLKQVwvXGpcqlDAZditKFITSz1lsPxoq
         p+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NF+1UccyPrLSTsC6NO843o3LdegAui/9wxtIWyWZc6E=;
        b=tfNtxlz92Yyh66uCZIhTcHiUyEx+Ym50VxvgzgJuEsENboEnXxSmYUfkrVCGgn4rPy
         qeOXLiZpZFR+FA7AfnRzGT1iCqgN3u/pleICjcQw1hDT0I4TW5lAxBzCvaqLs9OqpXl0
         hjuH5FNz4PRExthNxM4oTE5WufVQ74VHzjo6nGm+1ndWPRqezvQ4Pc5AbHtMami0qtDv
         0ecjqVMT/GcIyAMrH5+NIBK31+7mkd3n0meDyQxwJr9SVDTPSg5nDcFBCPkyfz++Wyp8
         4cmJrFZwrFAvtuDIrjy5eqMZzaOYuQB6HWFgDjG2wQKIzw7q2yxHZVVJZ76l7KdjfNgP
         LHZQ==
X-Gm-Message-State: APjAAAXuunt3StsWHeIGftdmlP+2oGGB+V50UC292S1oDlGXYz9dcmUO
        U5sxNyFle1cuQ0imd9q/VQ==
X-Google-Smtp-Source: APXvYqxMH5jIgIMrf9dfcpK3C8DgRQy6PK1bHEqVp/Bsoki48NGVjuv8ETiKMhwJfkwGep9tipo8gQ==
X-Received: by 2002:a25:ba8c:: with SMTP id s12mr29117038ybg.115.1578336173511;
        Mon, 06 Jan 2020 10:42:53 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm28223497ywf.101.2020.01.06.10.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:42:52 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/9] sunrpc: Fix potential leaks in sunrpc_cache_unhash()
Date:   Mon,  6 Jan 2020 13:40:34 -0500
Message-Id: <20200106184037.563557-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106184037.563557-6-trond.myklebust@hammerspace.com>
References: <20200106184037.563557-1-trond.myklebust@hammerspace.com>
 <20200106184037.563557-2-trond.myklebust@hammerspace.com>
 <20200106184037.563557-3-trond.myklebust@hammerspace.com>
 <20200106184037.563557-4-trond.myklebust@hammerspace.com>
 <20200106184037.563557-5-trond.myklebust@hammerspace.com>
 <20200106184037.563557-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When we unhash the cache entry, we need to handle any pending upcalls
by calling cache_fresh_unlocked().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index f740cb51802a..7ede1e52fd81 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1888,7 +1888,9 @@ void sunrpc_cache_unhash(struct cache_detail *cd, struct cache_head *h)
 	if (!hlist_unhashed(&h->cache_list)){
 		hlist_del_init_rcu(&h->cache_list);
 		cd->entries--;
+		set_bit(CACHE_CLEANED, &h->flags);
 		spin_unlock(&cd->hash_lock);
+		cache_fresh_unlocked(h, cd);
 		cache_put(h, cd);
 	} else
 		spin_unlock(&cd->hash_lock);
-- 
2.24.1

