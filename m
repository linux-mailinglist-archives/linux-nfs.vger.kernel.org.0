Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E156FE2738
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 01:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404634AbfJWX6P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 19:58:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36239 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404444AbfJWX6P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 19:58:15 -0400
Received: by mail-io1-f67.google.com with SMTP id c16so7350854ioc.3
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GB+oz+E3Tf2emfRr8xrOMGx0H/ELIDQcqTouy4vbLVg=;
        b=W0BVL9ZtR+8T2D+KxXiMSMXIn1iEhCJNMxDWDtHRG0s/PUKDlFCtDvpayOapt7umg1
         1ZpABTrZDX/QezlkJlB5iYK/+EHe5Hs3XLYTxnrPoSirGPZ6kKFn8PpMLUeX5yDeXLV0
         xaOnRTvM2crqCXk5djQHsAh5pnHvJoOW6IwiCZ090QXjo2701K/BeXkSlhYx7pGbevwH
         y6xhA/zjG5q1YWWXmUCWwVdHKwbI8mnUbS1e0joWq0/kIzGqlijWkati3OGdIGs7ELIp
         RhJHacue+JjuXF6gqXn1YoIu2gIzOCIdoJv7o1g9SNR3FcjFQZHnHUlysKuq41VUFt6p
         ikjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GB+oz+E3Tf2emfRr8xrOMGx0H/ELIDQcqTouy4vbLVg=;
        b=gTuYDPeswKyW1SNCrrxWJ6Okp+mSKKys/xZEo1L1KWHwOCZ4AhCyAykRUV/dh5bMJX
         MTkIX8IWsF7L0TcskeXaEV9RawORajJHzgUQqI1wheRuF2FW0KKLh0WFh2Kn0JysqLbh
         gLh2gD1nhuEnp+l5V0gq2uF1nUuUKAkgvdBjv75wCcrEt4GJaUh6xgMrxlaF+j7hFGHF
         Oc5gq8VctHXYvY7VwGttBFt54wLgpKdjGhUrTQ6UDCE9KLCO1x9Kh0nKQbF0HefC3Ztx
         Gjgl4JrqUOtfqb70SAucWxwjjk6T4klGAUGynrbUaDdqaIn4ee+88wbu8wpkU4/ogXTW
         p+/Q==
X-Gm-Message-State: APjAAAWzBHUdMU1N+YqvkRRShe4ojFDStoxX1y5ho0YCjccuY5kNxX4y
        gT5PIsFGGMcCDZaKDAxxs80Otzo=
X-Google-Smtp-Source: APXvYqxqJ+msqRGblyZZXUjrSsGvTRN+Lusx+Fawhz8j4d+mq+sELbNiasyym7qurexF4Mkwf3AQfQ==
X-Received: by 2002:a6b:fa19:: with SMTP id p25mr240132ioh.125.1571875094215;
        Wed, 23 Oct 2019 16:58:14 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id z18sm2405409iob.47.2019.10.23.16.58.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:58:13 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 06/14] NFS: Rename nfs_inode_return_delegation_noreclaim()
Date:   Wed, 23 Oct 2019 19:55:52 -0400
Message-Id: <20191023235600.10880-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023235600.10880-6-trond.myklebust@hammerspace.com>
References: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
 <20191023235600.10880-2-trond.myklebust@hammerspace.com>
 <20191023235600.10880-3-trond.myklebust@hammerspace.com>
 <20191023235600.10880-4-trond.myklebust@hammerspace.com>
 <20191023235600.10880-5-trond.myklebust@hammerspace.com>
 <20191023235600.10880-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rename nfs_inode_return_delegation_noreclaim() to
nfs_inode_evict_delegation(), which better describes what it
does.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 11 +++++++----
 fs/nfs/delegation.h |  2 +-
 fs/nfs/nfs4super.c  |  4 ++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index f90c3cf82f8f..e60737be6f26 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -574,19 +574,22 @@ int nfs_client_return_marked_delegations(struct nfs_client *clp)
 }
 
 /**
- * nfs_inode_return_delegation_noreclaim - return delegation, don't reclaim opens
+ * nfs_inode_evict_delegation - return delegation, don't reclaim opens
  * @inode: inode to process
  *
  * Does not protect against delegation reclaims, therefore really only safe
- * to be called from nfs4_clear_inode().
+ * to be called from nfs4_clear_inode(). Guaranteed to always free
+ * the delegation structure.
  */
-void nfs_inode_return_delegation_noreclaim(struct inode *inode)
+void nfs_inode_evict_delegation(struct inode *inode)
 {
 	struct nfs_delegation *delegation;
 
 	delegation = nfs_inode_detach_delegation(inode);
-	if (delegation != NULL)
+	if (delegation != NULL) {
+		set_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags);
 		nfs_do_return_delegation(inode, delegation, 1);
+	}
 }
 
 /**
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 2b35a99929a0..9a14a7ca1df9 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -43,7 +43,7 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 		fmode_t type, const nfs4_stateid *stateid, unsigned long pagemod_limit);
 int nfs4_inode_return_delegation(struct inode *inode);
 int nfs_async_inode_return_delegation(struct inode *inode, const nfs4_stateid *stateid);
-void nfs_inode_return_delegation_noreclaim(struct inode *inode);
+void nfs_inode_evict_delegation(struct inode *inode);
 
 struct inode *nfs_delegation_find_inode(struct nfs_client *clp, const struct nfs_fh *fhandle);
 void nfs_server_return_all_delegations(struct nfs_server *);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 04c57066a11a..2c9cbade561a 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -92,8 +92,8 @@ static void nfs4_evict_inode(struct inode *inode)
 {
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
-	/* If we are holding a delegation, return it! */
-	nfs_inode_return_delegation_noreclaim(inode);
+	/* If we are holding a delegation, return and free it */
+	nfs_inode_evict_delegation(inode);
 	/* Note that above delegreturn would trigger pnfs return-on-close */
 	pnfs_return_layout(inode);
 	pnfs_destroy_layout(NFS_I(inode));
-- 
2.21.0

