Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB6D01D0CD
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2019 22:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfENUpY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 May 2019 16:45:24 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54148 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENUpY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 May 2019 16:45:24 -0400
Received: by mail-it1-f196.google.com with SMTP id m141so1140066ita.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2019 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0106F+OIYuqVEg46cY8S9oFV/iyDhlYutv2OgfNUAlo=;
        b=tiCdkSQxIAHKjBLpNf2brYkBehQrE7qKRql2fvJbkxhezbkN5u1/8eMwXisCaHuocN
         eebBlCCOGdF8lLQRj8oQDpRVMyuYptoXBc5hxcv+5bHBvuVbY+f/nezyQZPpExEkKx6C
         WUl0/scGv/3VI0+VUHh1/WgJsyDu2hQs3oKs3i11mv71brk2QaH2rGKNurqBiirOyMIO
         Vl2tGtgPh7ygZnbIpev4gLWuxivqtMY7y7WFvPnH3e52APd2g4yHppbvMs8mvDhSSN5n
         tbVFLf2Oc6pIOQXqIwofgvImvoedOW2WHIHomdMigiRUHcj5dqVtIVF2dASdluKZXjOQ
         T5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0106F+OIYuqVEg46cY8S9oFV/iyDhlYutv2OgfNUAlo=;
        b=dEsLZ9mU+eVU2y+nBOyo7vx3mg5vxII0JLkPLkndSvqKoD+wk1xWXGLKsNSdLvb3wu
         FdubzVSsnMufz6mwWq6awpDKwcXFcdO7vXKuQq5eRUsScYa2XFjMYdp/+8xAExV5YnwC
         MP2MBgmfYZsU9YrHCVTzHRCEXc/3oRShIiZ/al79yMFCtA4ys9n04tk+De/zBUmuAdzi
         OsXXS5to5ZxjQIm8jRc57yLoaPPRgBdErgKA9cgyT9Mi15AgAxUFKKXfS+LX6lQb5oYF
         lmetT2NMfPDqBxw3M3cgnBizb2fFDYEOi1due6SZs03KsTuG7kfkpoGmLCmu77rjP+u6
         23uQ==
X-Gm-Message-State: APjAAAXSIupSmA9Jrk4rFzUeTomN8BVyVKu7yY42KyecEt/3tiyxerxA
        9YIHui94cZYNieJmtpSYvA==
X-Google-Smtp-Source: APXvYqwemRpqtgDEJuTL36NgIoc4zI6W28S37cWk61q7uwiHuY3tcb/0qBaCknczSHFgUe7gBoz/sg==
X-Received: by 2002:a05:660c:552:: with SMTP id w18mr4864150itk.26.1557866723189;
        Tue, 14 May 2019 13:45:23 -0700 (PDT)
Received: from localhost.localdomain ([172.56.10.94])
        by smtp.gmail.com with ESMTPSA id r139sm64943ita.22.2019.05.14.13.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:45:22 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 1/5] mountd: Ensure we don't share cache file descriptors among processes.
Date:   Tue, 14 May 2019 16:41:49 -0400
Message-Id: <20190514204153.79603-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514204153.79603-1-trond.myklebust@hammerspace.com>
References: <20190514204153.79603-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sharing cache descriptors without using locking can be very bad.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 utils/mountd/mountd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index fb7bba4cd390..88a207b3a85a 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -836,8 +836,6 @@ main(int argc, char **argv)
 	if (!foreground)
 		closeall(3);
 
-	cache_open();
-
 	unregister_services();
 	if (version2()) {
 		listeners += nfs_svc_create("mountd", MOUNTPROG,
@@ -888,6 +886,9 @@ main(int argc, char **argv)
 	if (num_threads > 1)
 		fork_workers();
 
+	/* Open files now to avoid sharing descriptors among forked processes */
+	cache_open();
+
 	xlog(L_NOTICE, "Version " VERSION " starting");
 	my_svc_run();
 
-- 
2.21.0

