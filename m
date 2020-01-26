Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F31149D65
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2020 23:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgAZWd3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Jan 2020 17:33:29 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43301 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgAZWd2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Jan 2020 17:33:28 -0500
Received: by mail-yw1-f67.google.com with SMTP id v126so3901809ywc.10
        for <linux-nfs@vger.kernel.org>; Sun, 26 Jan 2020 14:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9RDIMLtbcWBx2VkDk/Gm5VggXtsfniEimljSxvmt64=;
        b=raPfpYXhUyVn721GT0PtXDe0UKqvSpmUcd/mqbT+zs7JZLs9Swyi9IENCXQlcVmfwa
         pX9WgIaTR4hFQUgfD/mLN/i22IyM1Pay8puKrECiUbjsYGUPUzYqVeRS6hLIrSfb0GDY
         ovv7d1EkiPvnGaJTMCLyQ5Q97Q2hesjl/2Uxr7MHG/ewI47YoJTxWkUJvDUMe7VT3N7q
         SSm9tWJ24uoxWKzxW1YukU8wiM3XFM9AJYcjye0O2it5FWplJ1BnncPUDtIIyxQffpS+
         Z5hGc9qB2khbSWlkJJesWffiA9cJ/Jgd8zz1g+JYwOEEInaOkCGTR37D7pB3Pp//bYOB
         C7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9RDIMLtbcWBx2VkDk/Gm5VggXtsfniEimljSxvmt64=;
        b=BuygqcK1Fo7G6P8TCIdg6KMwvJHrrRiEgZu9EEhX8fx41bG1LjzleoXpvMWnCgrOwJ
         fb6eLKUmoMQJfqFX9BNryyKLki/pqtE7aGd3omedzvSkcf5dESJNiWzHASN7zTGP9BVz
         jsOAN4jsgB1Cb2f2/EzRfHPBi7pCNwyIA6X0ZCiy5f6sQhz+j4LTt9yJntQsvPqgyRCm
         6oWkYCqEtjVqUkt+1yCeFtjcsa7ZnJ0TP1OITj4QUT0T6PdUWhaFLL4TLv+Pe0fT6Zt6
         0Jq/WlgxDTYAZJjPixc2+WIxFHZX6N2Ma/8+LvZVWXxudbGUKJg3U/tiSgKokuG3tA/B
         2oJQ==
X-Gm-Message-State: APjAAAXGmKCUesf2aJM33nseEIsFYPPE5CNANyWtv8TlOzhbx6XU4ZzA
        y/vd15oQd+HAqpsHOEFOoQ==
X-Google-Smtp-Source: APXvYqx7yl4w7uYCr08OEXeCrYC7wOQKZ3jkptor4XU6voFbc/Uuy8TMZWbRT2OKK1fECrPvnfsAUw==
X-Received: by 2002:a81:a00a:: with SMTP id x10mr9984648ywg.475.1580078007765;
        Sun, 26 Jan 2020 14:33:27 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id d66sm4233951ywc.16.2020.01.26.14.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 14:33:27 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: nfs_find_open_context() should use cred_fscmp()
Date:   Sun, 26 Jan 2020 17:31:15 -0500
Message-Id: <20200126223115.40476-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200126223115.40476-2-trond.myklebust@hammerspace.com>
References: <20200126223115.40476-1-trond.myklebust@hammerspace.com>
 <20200126223115.40476-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We want to find open contexts that match our filesystem access
properties. They don't have to exactly match the cred.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 71dfc9d2fc3d..1309e6f47f3d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1061,7 +1061,7 @@ struct nfs_open_context *nfs_find_open_context(struct inode *inode, const struct
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(pos, &nfsi->open_files, list) {
-		if (cred != NULL && pos->cred != cred)
+		if (cred != NULL && cred_fscmp(pos->cred, cred) != 0)
 			continue;
 		if ((pos->mode & (FMODE_READ|FMODE_WRITE)) != mode)
 			continue;
-- 
2.24.1

