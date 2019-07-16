Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89FA6B039
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2019 22:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfGPUGo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Jul 2019 16:06:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38327 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbfGPUGo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Jul 2019 16:06:44 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so9748181ioa.5
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2019 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=atThEGgEE9DrVcla4yIbNh7r1fiMhKX/2srXNZ+dEKM=;
        b=udiWPPpXfZo/G8neCXtUqCvwkxN64QjxvpBe3X1TtU7drVBBAiiW5w7Dz0vxq7wOt6
         4M1w2yo0FGW/qDk+1UVyGSgUlt6AXzF+DMMgCM8F06DqS9X/7VTCM0Mlz6T2nbpwX63C
         yfdPdWHgobYmAOlfnYF0A+TqoGVACxQ1w3Gvvl3f5gm7vFzx7pPLECKcvHzbpaEZSpxa
         0sC/IyldnzSNE0qi9WO65eNUI/ehaLfB7bmKfSgGdwuI+XCwhA0DTqIIuayIHAP7Yy8h
         p/RHVgaZpHXmbSEuKk5QdeustTlkyJ0iEcLe8M4/O81f7h1svHMaFXmMF3pPkT25X6Xi
         oh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atThEGgEE9DrVcla4yIbNh7r1fiMhKX/2srXNZ+dEKM=;
        b=VvpOTGrUoG2tOGbmfrVrdM3LbwpPcWDpMl5NkAl1hcxwi/ReOuJFBOKHt2qWRhKKwn
         wHosYr0C8cl/0LDoB0JU7+9FQ8w5uCC02c591yjbS5ms6cgCg9br2XDsZX0tgjUoAYmS
         JO+qtZukNEg6mPds5GNq2a5P7U9GFEjomiQ00LzcqMesg1NhCvxQTl1Q9V+GRt4ePM4b
         tlGOdnmJeuQaxlhsHtW1UNUnmyfYY6nefLA4mVutwZh83mh3B1D09OJqMsulicvRQwQm
         DS1AQJ3QXkounDAH7LWSK+x18m2+9juDAhstn91j0ev3dsxvMsi00lFoDjuN61kOpH8K
         9FnQ==
X-Gm-Message-State: APjAAAWBBESI+kPhDH/zyrjwdg8vv0WJJucfGHnm2g5khjKyRIv4ZkbV
        rVJx7RpLQDAOJ2PLxUIX1QipaSU=
X-Google-Smtp-Source: APXvYqybv9Ka3oIvXJmSsRrjiquTHlNFy8gYiRKLYO8M/8QxAhFBr+dWVPQmhd3Mk9snwGy3bavocg==
X-Received: by 2002:a02:cb4b:: with SMTP id k11mr36547953jap.109.1563307602833;
        Tue, 16 Jul 2019 13:06:42 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id i3sm18393763ion.9.2019.07.16.13.06.42
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 13:06:42 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] SUNRPC: Fix a hang in xprt_switch_set_next_cursor()
Date:   Tue, 16 Jul 2019 16:04:33 -0400
Message-Id: <20190716200433.38758-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190716200433.38758-2-trond.myklebust@hammerspace.com>
References: <20190716200433.38758-1-trond.myklebust@hammerspace.com>
 <20190716200433.38758-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Apparently we do need the memory barrier.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtmultipath.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index c12778e1235e..852da66cdaec 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -293,18 +293,14 @@ struct rpc_xprt *xprt_switch_set_next_cursor(struct list_head *head,
 		struct rpc_xprt **cursor,
 		xprt_switch_find_xprt_t find_next)
 {
-	struct rpc_xprt *cur, *pos, *old;
+	struct rpc_xprt *pos, *old;
 
-	cur = READ_ONCE(*cursor);
-	for (;;) {
-		old = cur;
+	old = READ_ONCE(*cursor);
+	do {
 		pos = find_next(head, old);
 		if (pos == NULL)
 			break;
-		cur = cmpxchg_relaxed(cursor, old, pos);
-		if (cur == old)
-			break;
-	}
+	} while (!try_cmpxchg(cursor, &old, pos));
 	return pos;
 }
 
-- 
2.21.0

