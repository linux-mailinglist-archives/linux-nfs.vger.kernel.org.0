Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3749F1191F5
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2019 21:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLJU3v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Dec 2019 15:29:51 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43307 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfLJU3v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Dec 2019 15:29:51 -0500
Received: by mail-yb1-f194.google.com with SMTP id d34so3883991yba.10
        for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2019 12:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t/+PxnQdKAutGXiVSCU+o4iJAihQ69OWMQr+GyxT+TY=;
        b=kbVyuAO4qPzAA6L5vQZxUBorhOQinIRUrPbrR5EYmU5Bh0hNoLC82jzKLQSqtP/l51
         BpgcZ27wYwU12K0KfmxzezSmwhoEcImaVl+sCKlMHXMu1S0BXZ64Vox5NWCV0DbE7OyZ
         1Cm7vKjveEJq8ndyqX60jZcK4tWwB8njFlHdM1ShvJKyo5zFTjmjyggvEu6vK+TIwXez
         XCmB3LbKKOlec6xTyzz9nMRwRhyymIVEe4ew3YU9YLSAKBcdhDqhOi+lN+7wHgwcfbmV
         8exDqqvW65vJ0OI9nseRUVT6jpJU7/peyRymfWNx6s4jXZPdpP+LWzVQL1G7hwowjZRK
         Kw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t/+PxnQdKAutGXiVSCU+o4iJAihQ69OWMQr+GyxT+TY=;
        b=YrpGy8T7aJPQn7gzjuW9NOXv1HRtaSJPkmv9+wYM7JHK0RD0ORiYR16w9NcQ9AK+hM
         xAZNmz0h0FF3C8wKpQ4IMTc7D80E4RlB9XDwVtJld43unAhNK5Cfd1I7kLUbhlqZucLR
         q9on5UqwNDQSSOG8kaPWUtaVCJKKOwKEGUfFMMDr0D+mieaeshncXvtTWJl+VESpfcBD
         cnjp2JvR1fEMSZMcJpuOqrIN0eSNChARCbT/isciF+VABBKn1B9pOnqXLt3AwECvuPm1
         ZIWWD6pcqgLQ8qXvjU1DbWZZk3AIliNKZRs5tMDvBimtVQU/1eFeK+6MRim3jfvQPajx
         H/oQ==
X-Gm-Message-State: APjAAAXkXZ2bGVjgTzMhGrNbZeRXcNrOG0sJrmslaoZxovwH3VFzMyb8
        wm+vmG2zkJ/N9FDpsZ3Bkt0StDI=
X-Google-Smtp-Source: APXvYqw9oUdcmz83UK/oknV/rarujZsU9kiFKk3+jFYvwT5Wn81Kf4xU+0E+tpuwsiRy4BPBYOM6NA==
X-Received: by 2002:a25:2a50:: with SMTP id q77mr25028354ybq.47.1576009789524;
        Tue, 10 Dec 2019 12:29:49 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id x84sm1947508ywg.47.2019.12.10.12.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:29:48 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 4/6] nfsd: Remove unused constant NFSD_FILE_LRU_RESCAN
Date:   Tue, 10 Dec 2019 15:27:33 -0500
Message-Id: <20191210202735.304477-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210202735.304477-4-trond.myklebust@hammerspace.com>
References: <20191210202735.304477-1-trond.myklebust@hammerspace.com>
 <20191210202735.304477-2-trond.myklebust@hammerspace.com>
 <20191210202735.304477-3-trond.myklebust@hammerspace.com>
 <20191210202735.304477-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e71af553c2ed..6b0ab43b0618 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -27,7 +27,6 @@
 #define NFSD_FILE_HASH_SIZE                  (1 << NFSD_FILE_HASH_BITS)
 #define NFSD_LAUNDRETTE_DELAY		     (2 * HZ)
 
-#define NFSD_FILE_LRU_RESCAN		     (0)
 #define NFSD_FILE_SHUTDOWN		     (1)
 #define NFSD_FILE_LRU_THRESHOLD		     (4096UL)
 #define NFSD_FILE_LRU_LIMIT		     (NFSD_FILE_LRU_THRESHOLD << 2)
@@ -440,15 +439,13 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 		goto out_skip;
 
 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags))
-		goto out_rescan;
+		goto out_skip;
 
 	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags))
 		goto out_skip;
 
 	list_lru_isolate_move(lru, &nf->nf_lru, head);
 	return LRU_REMOVED;
-out_rescan:
-	set_bit(NFSD_FILE_LRU_RESCAN, &nfsd_file_lru_flags);
 out_skip:
 	return LRU_SKIP;
 }
-- 
2.23.0

