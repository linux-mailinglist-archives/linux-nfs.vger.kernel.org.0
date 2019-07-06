Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EA4612BD
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2019 20:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGFSzE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Jul 2019 14:55:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36835 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfGFSzD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 6 Jul 2019 14:55:03 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so10426721iom.3
        for <linux-nfs@vger.kernel.org>; Sat, 06 Jul 2019 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNKKZ9DQ69qLDSKLWz8TSL3a/CBdS6AHJ7I/2YedK+g=;
        b=f0PkK1uGvcYkQDO/OhfPyvOjcaAlIf8km8vnlTbdkFnhBR3bNNoWvhbYyS5jQxmOXf
         YGKHQSiRQwSakdKf9mzawwKZ49UdlyFOzCGVrdYWvX/4DF4i7p5iUCHWJdOFG/vkd8bi
         KZc2FNXQSviDHLhmcaRFzHkXXKwkevT5mtERNR1nMWdFeZyWimnFmVaJx76/6Jiswbpq
         Blk5sEEkbzjWLypXbZ7hc6GdcymsJSovHAOlbU/vxAN39+EMUmHVjdPOm9TntKnYxJgR
         ELZUwgqkDmHjFF+tjOPCtJRA0avLp/+py+ZqP8sDrF6Dswx/jgT/3dVWhCuzU/P0jvWs
         mALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNKKZ9DQ69qLDSKLWz8TSL3a/CBdS6AHJ7I/2YedK+g=;
        b=EhjkkAUu4dXVhQfrCQ2rWWOhLbzV1PQa7aiiEGZSJm2q+1ECynA82viMrbR7q8qKGT
         UpmBwX/mzbtMbHneBIyDTvAyBgN5sBImMgowKzf+jKoUqEDU1a5RpLIga4NC6TvxTtga
         SntE6vrzFl4rq2RD+k3G0NE9F09fWGFJm2I8gUmbefO5awLDN2e39hSoII1asrRPqYr1
         sIlrt5GoL0sm+3gvEEZg5bvJOHK5pgv0uSg7FIXLCFxuzRggt6mS4TeMV8thYXhnLQZi
         giCBjoCCtYJO/vaHYYmSwVchfLjXYraKBWNUOp0GH7IW2cUaL6YcIMSfiKs8W03zwThf
         2OGA==
X-Gm-Message-State: APjAAAXsJ/cW+1asXs+Z4SezBZxB8/JhRd17vTRK7zLQ+b3GcYoFDSu2
        cSqQtLYDfJ6qoQX39GUzQsuvnVY3Cg==
X-Google-Smtp-Source: APXvYqwrw/9QzFQ7FfNFVB5BdPrYNYQhRA9iKwZ2vulYH9eBhaY8Dud3MS6vee/eEjp7jcOJTxB2Kg==
X-Received: by 2002:a5d:9858:: with SMTP id p24mr10705045ios.171.1562439302526;
        Sat, 06 Jul 2019 11:55:02 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id x22sm9117780ioh.87.2019.07.06.11.55.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 11:55:02 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Cc:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH 3/3] NFS: Ensure cached readdir info is NUL terminated
Date:   Sat,  6 Jul 2019 14:52:52 -0400
Message-Id: <20190706185252.32488-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190706185252.32488-2-trond.myklebust@hammerspace.com>
References: <20190706185252.32488-1-trond.myklebust@hammerspace.com>
 <20190706185252.32488-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Strictly speaking, struct qstr does not require a NUL terminated string,
but in practice all dentries are deliberately stored that way.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 6ccf0e6c9c84..7313084424bb 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -189,7 +189,7 @@ static
 int nfs_readdir_make_qstr(struct qstr *string, const char *name, unsigned int len)
 {
 	string->len = len;
-	string->name = kmemdup(name, len, GFP_KERNEL);
+	string->name = kmemdup_nul(name, len, GFP_KERNEL);;
 	if (string->name == NULL)
 		return -ENOMEM;
 	/*
-- 
2.21.0

