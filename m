Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 745116B038
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2019 22:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfGPUGn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Jul 2019 16:06:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44041 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfGPUGn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Jul 2019 16:06:43 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so41936858iob.11
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2019 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J2yoCGOjg3LPsc8qJBhIU19NmVWweLw6hJOioqM/2FY=;
        b=XGLFgdVgGKJmMki5w+v8kAGcWFGOu3i8nOH4GLlIVnTvAlBbJD2CEkgpoLHYlFgN1w
         0wG9q9KIz/g75wvfebIPWazUWw4ja6xMFXKCzCvCULx59dQ/lK1mjid4gX3x6hLN0MPb
         YUbwUSNyjKpq2TJdriCNgRjS395knGAG9RhL1OfoZ1hD3h0dkSxQOz8+oN88ea00MZCC
         Ajx5mtczA9LiodGPPTnE1JpfF7IQ8XwG8e7UzmFTyFFxgwt+zld0cZgCC3BQdhDhuevN
         GIvurk0e8TUK0qA5W4r0e9nDbXir9mzKjBVARvTMl6l8vECteoedB/VcQJzKZLHRK2yH
         8dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2yoCGOjg3LPsc8qJBhIU19NmVWweLw6hJOioqM/2FY=;
        b=ELeUktq/qjz5yJgUBNLUAWy9WiRRWuITOL3XVOJSPkV972VvXLNhd8E5kayLLTLMw7
         IG9yYBf1sbZhxBJ/0mcsPMyfeTPa10SBnTQXHR7exxqYDTwm4KcHLFTDmdfhyY9BfjoY
         CjEy1U66uKWwFev3w47DS+C2ycCmyQl+LY+yOuaYcCedG5yKm4Nz+uzN/JJPlKMmFKZy
         WpXKnDoFdrJ6gWnKCeBpCVQifc1Q5XFeQk8G1h7Tmy6rt3Ls2WdkslTeJG6zzT9JjRTf
         t6oE2Nc/6Bf7bwG7r8H/IoHXJOFZCjBGKzD71gCz0YMhdE4lBQUNSuTbTFN7DKwxyuQo
         5VNQ==
X-Gm-Message-State: APjAAAUo+nvzh6vNe2zYBOS5L3krT0H28DyfkumfvTJGF1ojyO6HObw3
        rxpvgR7V2+IyFL2astCpiFfcIpA=
X-Google-Smtp-Source: APXvYqzl6bvB/0s2MlrCtWsfxQnC0tKJF7orS1v94L5ScCh3ZJdzuPgo+jkYBtm0TGpU6Mqwj0yTLg==
X-Received: by 2002:a6b:b602:: with SMTP id g2mr32349555iof.54.1563307602067;
        Tue, 16 Jul 2019 13:06:42 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id i3sm18393763ion.9.2019.07.16.13.06.41
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 13:06:41 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] SUNRPC: Skip zero-refcount transports
Date:   Tue, 16 Jul 2019 16:04:32 -0400
Message-Id: <20190716200433.38758-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190716200433.38758-1-trond.myklebust@hammerspace.com>
References: <20190716200433.38758-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When looking for the next transport to use for an RPC call, skip those
that are in the process of being destroyed and that have a zero refcount.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtmultipath.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 5df4e7adedf0..c12778e1235e 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -193,10 +193,22 @@ void xprt_iter_default_rewind(struct rpc_xprt_iter *xpi)
 	WRITE_ONCE(xpi->xpi_cursor, NULL);
 }
 
+static
+bool xprt_is_active(const struct rpc_xprt *xprt)
+{
+	return kref_read(&xprt->kref) != 0;
+}
+
 static
 struct rpc_xprt *xprt_switch_find_first_entry(struct list_head *head)
 {
-	return list_first_or_null_rcu(head, struct rpc_xprt, xprt_switch);
+	struct rpc_xprt *pos;
+
+	list_for_each_entry_rcu(pos, head, xprt_switch) {
+		if (xprt_is_active(pos))
+			return pos;
+	}
+	return NULL;
 }
 
 static
@@ -214,9 +226,12 @@ struct rpc_xprt *xprt_switch_find_current_entry(struct list_head *head,
 		const struct rpc_xprt *cur)
 {
 	struct rpc_xprt *pos;
+	bool found = false;
 
 	list_for_each_entry_rcu(pos, head, xprt_switch) {
 		if (cur == pos)
+			found = true;
+		if (found && xprt_is_active(pos))
 			return pos;
 	}
 	return NULL;
@@ -261,9 +276,12 @@ struct rpc_xprt *xprt_switch_find_next_entry(struct list_head *head,
 		const struct rpc_xprt *cur)
 {
 	struct rpc_xprt *pos, *prev = NULL;
+	bool found = false;
 
 	list_for_each_entry_rcu(pos, head, xprt_switch) {
 		if (cur == prev)
+			found = true;
+		if (found && xprt_is_active(pos))
 			return pos;
 		prev = pos;
 	}
-- 
2.21.0

