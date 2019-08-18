Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA74B918B7
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfHRSVI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39648 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfHRSVI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:08 -0400
Received: by mail-io1-f68.google.com with SMTP id l7so16098817ioj.6
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+gpdn9fZNN3VkUA/IqPYfEafJVfu3nz9lV5DlE2Mk8=;
        b=eiPxiECIE4XOXuvgiaT7YFFTTjNfQhxwD8wm+F49kGv3Pqt8678nRchzii07E65KHo
         MAze+wwXgFc2LzpHFVAeEZo9EVuaAlJ+7yqRT9ecQ7afqufIhP8xoQA6tNm2wymlF4D0
         jkW+kZE29EE61lXWwT3xUtG8psZYPmV3X2cSlMarOJmLE0oA7zecL18zAgOwlB2JLNsr
         o3K0lFdmL8tvj0Fxt9nu/q9JOd+5BMUO4wiFbCY4Kn6Nt/GKHV65ZyEePxKKyFEs+lTB
         Gs6uKRTMgWQKeMBIArS92gTc53ONIsrTo48C5Ht3kBd+M8HR6A68bZvyfCSJNS33oubC
         K42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+gpdn9fZNN3VkUA/IqPYfEafJVfu3nz9lV5DlE2Mk8=;
        b=mwaaveDHqAbHurLRwzq6VG24ySIJev2u26vRrFoSK14z1I4dR10yLv04gCTT4JFlLH
         KwWXXlfGaU/EVd3SzcvCD9TI6s2FH9UHOVKg3wB5rvYInpijh0THi4VvyPMwlJzgonxL
         atmvDufxEXyysh43AhpK//myIF+VSy19bAO7QFw4jp3v18xqRieMySXA+T7tU0br4SUw
         Toa4S18WTavIqVxVcCqXAgdxJ5fjqoCHoBuXyTqFCurwoIIlcay6q0xCZWmHHLRsJh3q
         JGLR6CeTblCCDsNu0WYLE1+/AGGK4GVCYvOB8rnsV2jSYf6GOqcDnN4r0X+KKQVO44ov
         Weeg==
X-Gm-Message-State: APjAAAW8P/kKyfBYFcgdFDlz7U0rF863LaAT564WamMqn3fQn1O0y3H8
        AYTScwVsA80kPUde29rFlg==
X-Google-Smtp-Source: APXvYqz8r5yVFkfHJrkaoHDXeCMlYiX05zaeboD0aNzP6dRumKbKUmXsFuHvRjpZruePR/WL5Ta0hQ==
X-Received: by 2002:a02:a409:: with SMTP id c9mr23314461jal.74.1566152467664;
        Sun, 18 Aug 2019 11:21:07 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:07 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 01/16] sunrpc: add a new cache_detail operation for when a cache is flushed
Date:   Sun, 18 Aug 2019 14:18:44 -0400
Message-Id: <20190818181859.8458-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

When the exports table is changed, exportfs will usually write a new
time to the "flush" file in the nfsd.export cache procfile. This tells
the kernel to flush any entries that are older than that value.

This gives us a mechanism to tell whether an unexport might have
occurred. Add a new ->flush cache_detail operation that is called after
flushing the cache whenever someone writes to a "flush" file.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/cache.h | 1 +
 net/sunrpc/cache.c           | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index c7f38e897174..dfa3ab97564a 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -87,6 +87,7 @@ struct cache_detail {
 					      int has_died);
 
 	struct cache_head *	(*alloc)(void);
+	void			(*flush)(void);
 	int			(*match)(struct cache_head *orig, struct cache_head *new);
 	void			(*init)(struct cache_head *orig, struct cache_head *new);
 	void			(*update)(struct cache_head *orig, struct cache_head *new);
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 6f1528f271ee..f6ff8be07688 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1520,6 +1520,9 @@ static ssize_t write_flush(struct file *file, const char __user *buf,
 	cd->nextcheck = now;
 	cache_flush();
 
+	if (cd->flush)
+		cd->flush();
+
 	*ppos += count;
 	return count;
 }
-- 
2.21.0

