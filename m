Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 804DD14A6BA
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 16:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgA0PAf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 10:00:35 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37718 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbgA0PAe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 10:00:34 -0500
Received: by mail-yw1-f66.google.com with SMTP id l5so4842117ywd.4
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2020 07:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Q2WASrVeOtQanKwbCvAjhkLhlIJFkVlgCXup/Le3SI=;
        b=XxmVUa4nwhGJxsXDPMOHrYQR+2yURzk/3MbFa/pzKCjN0gqS2EZcVVry6T4xMzPg1W
         7VhWZwPnySx9+Odm6VHwgagoCFKFtsh/oyjhrRdjpbyZ0oMaRekmnI8HGkI+RcvZevgC
         BKG6GWdb6ISz1tYzO6SwwmvZKcnatfNIGA0MGi+TMDaIyaTl/xmLcyQLkYN5B+/pLP3Z
         tynAGF3SH/mYj1kFiit0LQSXuTXYiSM8ne/1L/N+RU+FySKVIJCesgFbnwLDyXdrfAbs
         w15DRe1SrlU8lEGB+5B4TV5a0h/Bu9q6BU1502xKsvc5MzvUQHIKf61uoNZlOq1ugRk3
         fDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Q2WASrVeOtQanKwbCvAjhkLhlIJFkVlgCXup/Le3SI=;
        b=YtCgeheaJseKLoFVWHgX7U5HL4B44pjMI1Kb+69dojdlnLGlPs5M3D4MHXNHbucDuc
         ZYrsesZ2Ow0mJggNjoCg88lCALjHsivUhe2T4I4T9we2pggmJRlcd+8tPM0NZuefPyCq
         bOCKPJK7pCdCHU8RM830nHd+Kf1DxvWSk+FjeQ2aX4CBIcuLKx1kXCOSBEZxn4IcLMD7
         9SnWkDgbUxqBslzT+1hm9Z1iMsz7R90RefdzU5oo9m5C9nb8Y9zHp96yOe4wTCapzqDN
         fwIWKR81nEkXc7TswuPqa+0SwVrTEKaKbixHXEzkxEx6WGKCCqxh/nnwyee7EjecGVce
         n/yg==
X-Gm-Message-State: APjAAAU5sBEi+QzCIFedyNQ5UXKIwwN8sabhA9sYAUHADdzh65vaRrvM
        QcCsg+NzcBQBjPSe8Umlpg==
X-Google-Smtp-Source: APXvYqwW/1WzNPZB77UOO+up1yimSWTM/mzIidW9kBpc5kobc+fzG5dii+GDi/qfZXK3kKy221/bGg==
X-Received: by 2002:a0d:f804:: with SMTP id i4mr13019182ywf.508.1580137233769;
        Mon, 27 Jan 2020 07:00:33 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id d186sm6809096ywe.0.2020.01.27.07.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:00:33 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] NFSv4: Limit the total number of cached delegations
Date:   Mon, 27 Jan 2020 09:58:19 -0500
Message-Id: <20200127145819.350982-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127145819.350982-5-trond.myklebust@hammerspace.com>
References: <20200127145819.350982-1-trond.myklebust@hammerspace.com>
 <20200127145819.350982-2-trond.myklebust@hammerspace.com>
 <20200127145819.350982-3-trond.myklebust@hammerspace.com>
 <20200127145819.350982-4-trond.myklebust@hammerspace.com>
 <20200127145819.350982-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Delegations can be expensive to return, and can cause scalability issues
for the server. Let's therefore try to limit the number of inactive
delegations we hold.
Once the number of delegations is above a certain threshold, start
to return them on close.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index a777b3d0e720..4a841071d8a7 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -25,7 +25,10 @@
 #include "internal.h"
 #include "nfs4trace.h"
 
+#define NFS_DEFAULT_DELEGATION_WATERMARK (5000U)
+
 static atomic_long_t nfs_active_delegations;
+static unsigned nfs_delegation_watermark = NFS_DEFAULT_DELEGATION_WATERMARK;
 
 static void __nfs_free_delegation(struct nfs_delegation *delegation)
 {
@@ -676,7 +679,8 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
 	delegation = nfs4_get_valid_delegation(inode);
 	if (!delegation)
 		goto out;
-	if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags)) {
+	if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags) ||
+	    atomic_long_read(&nfs_active_delegations) >= nfs_delegation_watermark) {
 		spin_lock(&delegation->lock);
 		if (delegation->inode &&
 		    list_empty(&NFS_I(inode)->open_files) &&
@@ -1365,3 +1369,5 @@ bool nfs4_delegation_flush_on_close(const struct inode *inode)
 	rcu_read_unlock();
 	return ret;
 }
+
+module_param_named(delegation_watermark, nfs_delegation_watermark, uint, 0644);
-- 
2.24.1

