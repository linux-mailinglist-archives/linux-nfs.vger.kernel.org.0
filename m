Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCE79C5CD
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Aug 2019 21:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfHYTXR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Aug 2019 15:23:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44638 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfHYTXR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Aug 2019 15:23:17 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so23828718iog.11
        for <linux-nfs@vger.kernel.org>; Sun, 25 Aug 2019 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pKf66uMGnvhegeYA9xjDPx2B87mBdA68f37tCIDpWEY=;
        b=nSvv33RArTnON5O1KjkWoe95IglEX1GFElpITH/nyROwAi3nBPM5UVs3+Sl4kR37et
         n+ACIt7iN/Eu019HiwmhffW+2aJPNyNnmTZff0TVhZzlglirV06nVfZt4PYw9cQUugB0
         SKGhLkiQQ2HFGJVB3trNHTRevqJR+fWX6sfc6L+VQLQD2GJEVgUuqwJtS/hQOzsKMPne
         S7BR+1z4tqOZ0oAgJkhLWv2+QJtuK2ipsXHnUmZdjFEwr1/ATiX0+/5W4io9UsjdR9MJ
         UYMhoD3CKasEdybeJDnuVY5Ahn8p/QDaicGuoMvRV9mKfngDhBSllpJkLmAFk6BdmpRh
         NZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pKf66uMGnvhegeYA9xjDPx2B87mBdA68f37tCIDpWEY=;
        b=dNOj3OBL+/YOwr0/TD75CuxzVTFrY/llIakhYIB0Lvl02ePxYqfCToGE5HNDGRuk/P
         S0ZnzCOUY773JXSc94wEpBR7U3lka5q17TQldZ+SX06LkgHRLXYNyZB5IaFpia0Kl3MJ
         jbDeeSQzqQWgaFUdzDH54CRuAXQYL1zqEAc/C5ID3NPRTKIi6mJ+Z6L99a1u0FQuVjo9
         TyWEfg0gOOtKTInnD6CzkjGz/hPPgxJOYqUfFKSG7vrGkjw8CN+USz1pgNMtmZLmO7aA
         mckAqJOr/fRxMQCA4v4mJLs5vKlBS52x4kxwJoOq74Z4onRGeNyc1nA9yWK30cSeyGJw
         9Uhw==
X-Gm-Message-State: APjAAAXIHPzRAHZ1jigjmzhFfmu+3OdEZcbf1Y+G80bB6gJUjwKFII7t
        6hFkfs8czdTIhkE5M1O6RBcTyUbSNQ==
X-Google-Smtp-Source: APXvYqxquj5y9vSYimIpCOmsuOWxjYxGDvLT9+8PlFpcgrskN36Hj03ZU+BlgH3w47ju5x5doVA89w==
X-Received: by 2002:a05:6638:45:: with SMTP id a5mr14304847jap.61.1566760996050;
        Sun, 25 Aug 2019 12:23:16 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id h18sm7459111iob.80.2019.08.25.12.23.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 12:23:15 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFS: Fix writepage(s) error handling to not report errors twice
Date:   Sun, 25 Aug 2019 15:21:08 -0400
Message-Id: <20190825192108.76409-1-trond.myklebust@hammerspace.com>
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
 fs/nfs/write.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index cee9905e419c..d193042fa228 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -621,12 +621,12 @@ static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
 	WARN_ON_ONCE(test_bit(PG_CLEAN, &req->wb_flags));
 
 	/* If there is a fatal error that covers this write, just exit */
-	ret = 0;
 	mapping = page_file_mapping(page);
-	if (test_bit(AS_ENOSPC, &mapping->flags) ||
-	    test_bit(AS_EIO, &mapping->flags))
+	ret = pgio->pg_error;
+	if (nfs_error_is_fatal_on_server(ret))
 		goto out_launder;
 
+	ret = 0;
 	if (!nfs_pageio_add_request(pgio, req)) {
 		ret = pgio->pg_error;
 		/*
@@ -638,6 +638,7 @@ static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
 		} else
 			ret = -EAGAIN;
 		nfs_redirty_request(req);
+		pgio->pg_error = 0;
 	} else
 		nfs_add_stats(page_file_mapping(page)->host,
 				NFSIOS_WRITEPAGES, 1);
@@ -657,7 +658,7 @@ static int nfs_do_writepage(struct page *page, struct writeback_control *wbc,
 	ret = nfs_page_async_flush(pgio, page);
 	if (ret == -EAGAIN) {
 		redirty_page_for_writepage(wbc, page);
-		ret = 0;
+		ret = AOP_WRITEPAGE_ACTIVATE;
 	}
 	return ret;
 }
@@ -676,10 +677,11 @@ static int nfs_writepage_locked(struct page *page,
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
@@ -689,7 +691,8 @@ int nfs_writepage(struct page *page, struct writeback_control *wbc)
 	int ret;
 
 	ret = nfs_writepage_locked(page, wbc);
-	unlock_page(page);
+	if (ret != AOP_WRITEPAGE_ACTIVATE)
+		unlock_page(page);
 	return ret;
 }
 
@@ -698,7 +701,8 @@ static int nfs_writepages_callback(struct page *page, struct writeback_control *
 	int ret;
 
 	ret = nfs_do_writepage(page, wbc, data);
-	unlock_page(page);
+	if (ret != AOP_WRITEPAGE_ACTIVATE)
+		unlock_page(page);
 	return ret;
 }
 
@@ -724,13 +728,14 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
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

