Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BA29C4CC
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Aug 2019 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfHYQKN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Aug 2019 12:10:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43576 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfHYQKN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Aug 2019 12:10:13 -0400
Received: by mail-io1-f68.google.com with SMTP id 18so31469247ioe.10
        for <linux-nfs@vger.kernel.org>; Sun, 25 Aug 2019 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5zMDIXCw8WdhoFxDWVHYbDm1Io0ZVoKImtP8ITmnFw=;
        b=HjxtpuNZ9TpYHx2hg93Soq4Gnqe2GvjigS3h2qwByTARNnRD17NW+QEgF+ZpRglj+v
         VV2bREgRhnbu7qVr/TiACOw/TiGaIFkeRvPQORytoWd3ddmtXYOQWdvUz1zfxmeuD54p
         JBr7pC5yqKqNQPd1wALcCVsLl3OoABxc9DqAmzRsLS6mdEVooxt/STxXF+6yiKSTvuBh
         ywQoNdzqThkqAV/D6KnfsEFkTZ3NiewTgEXAWQnKgcAHc1axCpwnpsCVan6k3fajwvdB
         L6JmFKgIFOQ86TZh4whJGn1OuSw1KC8ugS1KCuz+s2dxHfGUh6iRcb1pwfnAMuDCNeNP
         Dd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5zMDIXCw8WdhoFxDWVHYbDm1Io0ZVoKImtP8ITmnFw=;
        b=fvx7aRno2sO6LqCD0VTmW5/K5QxJKq52Ng0pUnONPYWTCN764orP6I7XMGpCjiSTXR
         MhLivHz+Lz9K0q/H8UqkMNvMVY5OrJvN3n1FbLLiZvhlY5jK0vf9RJe2O+Wq1P0hivhH
         n9J6e0STluWsrnFiMaqYB6MU6NWnFrqBuM8b47Tg7/3iHlGrl5sS0LhUGIkcI0JQuIXR
         ydnaKESRrkcMfBCY1ngWndsqg3J7Cw+KAO0HfuF6CIBelYgjKvCYEHhugqUIzm4KRFsT
         5H0MGAJgwOmpz+V0gyXuXt1nUPk3/mU9VHkqGggLxDxZ1twcy93p0yEmY+K3eg00Rhmb
         U9wQ==
X-Gm-Message-State: APjAAAVsoNAaIxqJXrKvkCZGK3l9s0FEBvyYDJYW+4+EIi7ldC2lvitC
        Ylj2Eqm7AI6nxcwW6PO3jV8ubXN0PQ==
X-Google-Smtp-Source: APXvYqwfPtY2UEE2WwqwyrJMGUgpF4adtHNddnzF9nwqlrjMAzbQJRtlJMUGpX6ZaLEVNuM7ElJBkQ==
X-Received: by 2002:a02:c64a:: with SMTP id k10mr14674299jan.22.1566749411660;
        Sun, 25 Aug 2019 09:10:11 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id m67sm12477643iof.21.2019.08.25.09.10.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 09:10:10 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix writepage(s) error handling to not report errors twice
Date:   Sun, 25 Aug 2019 12:08:03 -0400
Message-Id: <20190825160803.70038-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If writepage()/writepages() saw an error, but handled it without
reporting it, we should not be re-reporting that error on exit.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index cee9905e419c..5f17f8036710 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -623,8 +623,7 @@ static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
 	/* If there is a fatal error that covers this write, just exit */
 	ret = 0;
 	mapping = page_file_mapping(page);
-	if (test_bit(AS_ENOSPC, &mapping->flags) ||
-	    test_bit(AS_EIO, &mapping->flags))
+	if (nfs_error_is_fatal_on_server(pgio->pg_error))
 		goto out_launder;
 
 	if (!nfs_pageio_add_request(pgio, req)) {
@@ -638,6 +637,7 @@ static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
 		} else
 			ret = -EAGAIN;
 		nfs_redirty_request(req);
+		pgio->pg_error = 0;
 	} else
 		nfs_add_stats(page_file_mapping(page)->host,
 				NFSIOS_WRITEPAGES, 1);
@@ -657,7 +657,7 @@ static int nfs_do_writepage(struct page *page, struct writeback_control *wbc,
 	ret = nfs_page_async_flush(pgio, page);
 	if (ret == -EAGAIN) {
 		redirty_page_for_writepage(wbc, page);
-		ret = 0;
+		ret = AOP_WRITEPAGE_ACTIVATE;
 	}
 	return ret;
 }
@@ -676,10 +676,11 @@ static int nfs_writepage_locked(struct page *page,
 	nfs_pageio_init_write(&pgio, inode, 0,
 				false, &nfs_async_write_completion_ops);
 	err = nfs_do_writepage(page, wbc, &pgio);
+	pgio.pg_error = 0;
 	nfs_pageio_complete(&pgio);
 	if (err < 0)
 		return err;
-	if (pgio.pg_error < 0)
+	if (nfs_error_is_fatal(pgio.pg_error))
 		return pgio.pg_error;
 	return 0;
 }
@@ -689,7 +690,8 @@ int nfs_writepage(struct page *page, struct writeback_control *wbc)
 	int ret;
 
 	ret = nfs_writepage_locked(page, wbc);
-	unlock_page(page);
+	if (ret != AOP_WRITEPAGE_ACTIVATE)
+		unlock_page(page);
 	return ret;
 }
 
@@ -698,7 +700,8 @@ static int nfs_writepages_callback(struct page *page, struct writeback_control *
 	int ret;
 
 	ret = nfs_do_writepage(page, wbc, data);
-	unlock_page(page);
+	if (ret != AOP_WRITEPAGE_ACTIVATE)
+		unlock_page(page);
 	return ret;
 }
 
@@ -724,13 +727,14 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 				&nfs_async_write_completion_ops);
 	pgio.pg_io_completion = ioc;
 	err = write_cache_pages(mapping, wbc, nfs_writepages_callback, &pgio);
+	pgio.pg_error = 0;
 	nfs_pageio_complete(&pgio);
 	nfs_io_completion_put(ioc);
 
 	if (err < 0)
 		goto out_err;
 	err = pgio.pg_error;
-	if (err < 0)
+	if (nfs_error_is_fatal(err))
 		goto out_err;
 	return 0;
 out_err:
-- 
2.21.0

